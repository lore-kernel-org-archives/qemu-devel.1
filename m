Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DE3C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:16:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D1E2078E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmCjtK46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D1E2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSXx-0003C2-MP
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 05:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36936 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <igotti@gmail.com>) id 1jQSWy-00026c-Rt
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:15:57 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <igotti@gmail.com>) id 1jQSWx-000335-71
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:15:56 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:34217)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <igotti@gmail.com>) id 1jQSWw-00030f-OM
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:15:54 -0400
Received: by mail-lj1-x242.google.com with SMTP id m8so9103460lji.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 02:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=XJcCygqyV5dgqVsYnUNUCzeV/UXXZpTi0n/ViOolZUI=;
 b=MmCjtK46F7BLZDfO/EEbGO74n95Ajw9xLYBp8DATO3P9JY83Dqt/Y3UGOPb353PZXK
 UKcimTLUYR01BIBNKy3hDZ84v6kyQzMm7sN+ASqf12IqK2DBdrIYad6+WwySr+h7B72n
 t7Rvzes2yty0M5a1twta8zc6az3fxQUL6OHCqy1ugV8AREzqjt3eFobDHvKBgLVMqueA
 XIuRj5dSpyibOopeGZ5M6et6y8y/ogJ4F3WOKyaluMYMfMGdmyCN/NoeFL/8+mV78Iu7
 IMv/9BOLlY1ePpsqg1XG4VuRu+mBQaD69pSU0YeePaKA+Hyd9d53GGsprBhzhWS6ig+e
 ly8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=XJcCygqyV5dgqVsYnUNUCzeV/UXXZpTi0n/ViOolZUI=;
 b=L91+81pJc3eWK+/8QAb10gSA0LMCa8jqG/uY30gQV8xD01SvxktRcH4O5NGF3ma5Z/
 CYFL8t5xGqRU3GYTykf+QG9Q5uzKwdOI7IWNRZPW/uZXKq2fYPxjo8pFuwe8JDyctpWs
 kYvvdGHSpuN38ccnaFGJxOK7hpt1mlgA18qpm0Y5H/PK8FqnlD1eOsqfnS0o6KBZ0bjt
 im7DbWkeNLU7dU1k7rEjWptlCZEo+eVbRR9tuEP1Eju/uHOSpYY6vmlha8mhCXEuhNRq
 HiMSPmJLpLH0CIS5E87nP7w9JhV9ENljQapwc+XqAYwXGs7wsDCRbGtcUe6mImniKCNq
 8Xzw==
X-Gm-Message-State: AGi0PuYMRKfKsdQh+4YjDJOggXPxsFAE41FXYyRrWCEyfTfFxB6Sac6O
 YoQBmS6MIgXwOY+JsSR7IbvlKUWz61ntZbHoqHB8ztWXWuCpPA==
X-Google-Smtp-Source: APiQypJ2/QRf0sV/cBIFNl8TGocPO32EIQRUgm0TIauUuB18K5Ta7wcsW2iA4P2IuFVog1vIE3C8OOjsJP7lvmYrHIM=
X-Received: by 2002:a2e:800f:: with SMTP id j15mr7304916ljg.27.1587374150484; 
 Mon, 20 Apr 2020 02:15:50 -0700 (PDT)
MIME-Version: 1.0
From: Nikolay Igotti <igotti@gmail.com>
Date: Mon, 20 Apr 2020 12:15:39 +0300
Message-ID: <CAEme+7FPF+inSJSXQPmuv8Up3Eam0N7fT03zqM-RvcvKsxjfVQ@mail.gmail.com>
Subject: [PATCH 3/3] plugins: avoid failing plugin when CPU is inited several
 times
To: laurent@vivier.eu, riku.voipio@iki.fi
Content-Type: multipart/alternative; boundary="0000000000005d851f05a3b558b9"
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=igotti@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::242
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005d851f05a3b558b9
Content-Type: text/plain; charset="UTF-8"

In linux-user multithreaded scenarious CPU could be inited many times with
the same id,

so avoid assertions on already present hashtable entry.


Signed-off-by: Nikolay Igotti <igotti@gmail.com>

---

 plugins/core.c | 5 +----

 1 file changed, 1 insertion(+), 4 deletions(-)


diff --git a/plugins/core.c b/plugins/core.c

index 51bfc94787..889cc6441a 100644

--- a/plugins/core.c

+++ b/plugins/core.c

@@ -196,13 +196,10 @@ plugin_register_cb_udata(qemu_plugin_id_t id, enum
qemu_plugin_event ev,



 void qemu_plugin_vcpu_init_hook(CPUState *cpu)

 {

-    bool success;

-

     qemu_rec_mutex_lock(&plugin.lock);

     plugin_cpu_update__locked(&cpu->cpu_index, NULL, NULL);

-    success = g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,

+    g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,

                                   &cpu->cpu_index);

-    g_assert(success);

     qemu_rec_mutex_unlock(&plugin.lock);



     plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INIT);

-- 

2.24.2 (Apple Git-127)

--0000000000005d851f05a3b558b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">





<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">In linux-user multithreaded sce=
narious CPU could be inited many times with the same id,</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">so avoid assertions on already =
present hashtable entry.</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0);min-height:13px"><span class=3D"gma=
il-s1" style=3D"font-variant-ligatures:no-common-ligatures"></span><br></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">Signed-off-by: Nikolay Igotti &=
lt;<a href=3D"mailto:igotti@gmail.com">igotti@gmail.com</a>&gt;</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">---</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-conv=
erted-space">=C2=A0</span>plugins/core.c | 5 +----</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-conv=
erted-space">=C2=A0</span>1 file changed, 1 insertion(+), 4 deletions(-)</s=
pan></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0);min-height:13px"><span class=3D"gma=
il-s1" style=3D"font-variant-ligatures:no-common-ligatures"></span><br></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">diff --git a/plugins/core.c b/p=
lugins/core.c</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">index 51bfc94787..889cc6441a 10=
0644</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">--- a/plugins/core.c</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">+++ b/plugins/core.c</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">@@ -196,13 +196,10 @@ plugin_re=
gister_cb_udata(qemu_plugin_id_t id, enum qemu_plugin_event ev,</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0);min-height:13px"><span class=3D"gma=
il-s1" style=3D"font-variant-ligatures:no-common-ligatures"><span class=3D"=
gmail-Apple-converted-space">=C2=A0</span></span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-conv=
erted-space">=C2=A0</span>void qemu_plugin_vcpu_init_hook(CPUState *cpu)</s=
pan></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-conv=
erted-space">=C2=A0</span>{</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">-<span class=3D"gmail-Apple-con=
verted-space">=C2=A0 =C2=A0 </span>bool success;</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">-</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-conv=
erted-space">=C2=A0=C2=A0 =C2=A0 </span>qemu_rec_mutex_lock(&amp;plugin.loc=
k);</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-conv=
erted-space">=C2=A0=C2=A0 =C2=A0 </span>plugin_cpu_update__locked(&amp;cpu-=
&gt;cpu_index, NULL, NULL);</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">-<span class=3D"gmail-Apple-con=
verted-space">=C2=A0 =C2=A0 </span>success =3D g_hash_table_insert(plugin.c=
pu_ht, &amp;cpu-&gt;cpu_index,</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">+<span class=3D"gmail-Apple-con=
verted-space">=C2=A0 =C2=A0 </span>g_hash_table_insert(plugin.cpu_ht, &amp;=
cpu-&gt;cpu_index,</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-conv=
erted-space">=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>&amp;=
cpu-&gt;cpu_index);</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">-<span class=3D"gmail-Apple-con=
verted-space">=C2=A0 =C2=A0 </span>g_assert(success);</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-conv=
erted-space">=C2=A0=C2=A0 =C2=A0 </span>qemu_rec_mutex_unlock(&amp;plugin.l=
ock);</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0);min-height:13px"><span class=3D"gma=
il-s1" style=3D"font-variant-ligatures:no-common-ligatures"><span class=3D"=
gmail-Apple-converted-space">=C2=A0</span></span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures"><span class=3D"gmail-Apple-conv=
erted-space">=C2=A0=C2=A0 =C2=A0 </span>plugin_vcpu_cb__simple(cpu, QEMU_PL=
UGIN_EV_VCPU_INIT);</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">--<span class=3D"gmail-Apple-co=
nverted-space">=C2=A0</span></span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span class=3D"gmail-s1" style=3D"=
font-variant-ligatures:no-common-ligatures">2.24.2 (Apple Git-127)</span></=
p></div>

--0000000000005d851f05a3b558b9--


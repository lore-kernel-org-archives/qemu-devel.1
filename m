Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C3BC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7F620767
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 15:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7F620767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCm47-0007Qh-Iq
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 11:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCm3I-0005mf-Q2; Mon, 31 Aug 2020 11:49:01 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:34990)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCm3E-0003Kl-V5; Mon, 31 Aug 2020 11:48:59 -0400
Received: by mail-ej1-f67.google.com with SMTP id a26so9207838ejc.2;
 Mon, 31 Aug 2020 08:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OGAx3Kbu3GbnRr0C3DXNc6izxWEg1if0n+IcTBgmOEw=;
 b=gEWyyzI/890YtXsu277gBp+3MpbpBKSyFfxwEFsQP4daGOVyhrARwKLcjv1s2EDZ0Y
 gbpxyy0zbO73B/TBrGmJAI2KoG8X0Wh65Ehia9TJhRGTcUndahZZE+xJeBmuDTUjRW5G
 KfQyMa7MtORItqtdG5Hd9VeXQnZSUz9r6bK3FhoGhiwU5zJ5zxfr6+lXfjLK5BUiXBrc
 qmFCuaTVYg2n5M8gWBtkcG25kfk9bHXo8txuVSHvWsr9WkgqYHDjSEYUzpwc8FTNF/1v
 JWlu7NWaW1/INTykDT8b9o9V+BZEuLIb5ZL5G6NZ2XyNIJVelBjyTcMHDOXy0gWmqRnO
 bDMg==
X-Gm-Message-State: AOAM532p2Vasr6uUixTDngWf5k6DC/eKI3W6AZYMqggKO9kOIayf4euR
 J8Tu7Ppcj6X26CjkQbsZzoeKQ+qZypUMsBg2qpc=
X-Google-Smtp-Source: ABdhPJyuZmpOcl10FwXpCDc4pbQ4LXlTH2+6RfwSKXzwZsHS8rXZ7qO+mznF/uytW70ry1Ru7XesIGo7peBceA3ahhQ=
X-Received: by 2002:a17:906:640c:: with SMTP id
 d12mr1651900ejm.388.1598888934724; 
 Mon, 31 Aug 2020 08:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200828173248.24556-1-pbonzini@redhat.com>
In-Reply-To: <20200828173248.24556-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 17:47:46 +0200
Message-ID: <CAAdtpL4_fzQ-rC6mf=kueSAUdEik1VbxO7nRd-MgzKvxYj6YcQ@mail.gmail.com>
Subject: Re: [PATCH] block: always link with zlib
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000fd56d305ae2e567b"
Received-SPF: pass client-ip=209.85.218.67;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 11:48:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fd56d305ae2e567b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 28 ao=C3=BBt 2020 19:33, Paolo Bonzini <pbonzini@redhat.com> a =C3=
=A9crit :

> The qcow2 driver needs the zlib dependency.  While emulators
> provided it through the migration code, this is not true of
> the tools.  Move the dependency from the qcow1 rule directly
> into block_ss so that it is included unconditionally.
>
> Fixes build with --disable-qcow1.
>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Cc: qemu-block@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>  block/meson.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block/meson.build b/block/meson.build
> index 4dbbfe60b4..a3e56b7cd1 100644
> --- a/block/meson.build
> +++ b/block/meson.build
> @@ -40,9 +40,9 @@ block_ss.add(files(
>    'vmdk.c',
>    'vpc.c',
>    'write-threshold.c',
> -), zstd)
> +), zstd, zlib)
>
> -block_ss.add(when: [zlib, 'CONFIG_QCOW1'], if_true: files('qcow.c'))
> +block_ss.add(when: 'CONFIG_QCOW1', if_true: files('qcow.c'))
>  block_ss.add(when: 'CONFIG_VDI', if_true: files('vdi.c'))
>  block_ss.add(when: 'CONFIG_CLOOP', if_true: files('cloop.c'))
>  block_ss.add(when: 'CONFIG_BOCHS', if_true: files('bochs.c'))
> --
> 2.26.2
>
>
>

--000000000000fd56d305ae2e567b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Le ven. 28 ao=C3=BBt 2020 19:33, Paolo Bonzini &lt;<a href=
=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; a =C3=A9crit=C2=
=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">The qcow2 driver needs the zli=
b dependency.=C2=A0 While emulators<br>
provided it through the migration code, this is not true of<br>
the tools.=C2=A0 Move the dependency from the qcow1 rule directly<br>
into block_ss so that it is included unconditionally.<br>
<br>
Fixes build with --disable-qcow1.<br>
<br>
Reported-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"=
_blank" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-block@nongnu.org" target=3D"_blank" rel=3D"noref=
errer">qemu-block@nongnu.org</a><br>
Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" tar=
get=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br></blockquo=
te></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"><span style=3D=
"font-family:sans-serif;font-size:13.696px">Reviewed-by: Philippe Mathieu-D=
aud=C3=A9 &lt;</span><a href=3D"mailto:f4bug@amsat.org" style=3D"text-decor=
ation:none;color:rgb(66,133,244);font-family:sans-serif;font-size:13.696px"=
>f4bug@amsat.org</a><span style=3D"font-family:sans-serif;font-size:13.696p=
x">&gt;</span><br></div><div dir=3D"auto"><span style=3D"font-family:sans-s=
erif;font-size:13.696px"><br></span></div><div dir=3D"auto"><div class=3D"g=
mail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
---<br>
=C2=A0block/meson.build | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/block/meson.build b/block/meson.build<br>
index 4dbbfe60b4..a3e56b7cd1 100644<br>
--- a/block/meson.build<br>
+++ b/block/meson.build<br>
@@ -40,9 +40,9 @@ block_ss.add(files(<br>
=C2=A0 =C2=A0&#39;vmdk.c&#39;,<br>
=C2=A0 =C2=A0&#39;vpc.c&#39;,<br>
=C2=A0 =C2=A0&#39;write-threshold.c&#39;,<br>
-), zstd)<br>
+), zstd, zlib)<br>
<br>
-block_ss.add(when: [zlib, &#39;CONFIG_QCOW1&#39;], if_true: files(&#39;qco=
w.c&#39;))<br>
+block_ss.add(when: &#39;CONFIG_QCOW1&#39;, if_true: files(&#39;qcow.c&#39;=
))<br>
=C2=A0block_ss.add(when: &#39;CONFIG_VDI&#39;, if_true: files(&#39;vdi.c&#3=
9;))<br>
=C2=A0block_ss.add(when: &#39;CONFIG_CLOOP&#39;, if_true: files(&#39;cloop.=
c&#39;))<br>
=C2=A0block_ss.add(when: &#39;CONFIG_BOCHS&#39;, if_true: files(&#39;bochs.=
c&#39;))<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000fd56d305ae2e567b--


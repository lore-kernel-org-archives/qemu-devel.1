Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF112C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 20:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C1BB2074D
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 20:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4md/8m1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1BB2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9whm-0003Q1-Nb
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 16:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k9whA-0002zu-Pi
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 16:34:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43753
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k9wh8-0002Rm-5N
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 16:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598214864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DHShKphzB1V8d2I+wZVSLM3VAnMJWyi0KFrWYHFoODw=;
 b=X4md/8m1BiXz62ySKaxSSkmLEBmjnl5F99cpSTBKcLu3DZd8DfwH1Hi5u0gkj402Z8Gs0I
 ExJ10VhetRJoBAcJoQjgEya/KrulPIQ8ODZ0mxrowaMWuZXSgNyjzxWdcsO2bZ13+TKWI+
 KJHtGD8rIKwO6zfsOGU+PSkbtEWo1B8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-RsQPDHxKOlOCkgcHXCCj1w-1; Sun, 23 Aug 2020 16:34:21 -0400
X-MC-Unique: RsQPDHxKOlOCkgcHXCCj1w-1
Received: by mail-ed1-f69.google.com with SMTP id h26so928826edq.20
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2020 13:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DHShKphzB1V8d2I+wZVSLM3VAnMJWyi0KFrWYHFoODw=;
 b=DqPKhzwYewuwgNwb6KO23KSFt6eygEucyWhE13GW1emhmPaEPT5wP7+OC8xl69RE9v
 Ie8MN1VTe0ZrLhQcZh2TxbPo5RGOs5pADKhm27Wzdo+5RFclIqDR1Qmjuchy/wS5OvvG
 v4E8xlVnfjF7NfdTURQri7eS5jIc85UOifTpgtsWokLKDwgVMKhGuxxJiVEZ8+2SJmUZ
 tgtfHvrcv5bJme2vkYKRQnzSn8sE319dkogxnRGmpobtmpZVOGl8kum/JBi/xZ6aAi6v
 ZX8vQlR2hDiKfHFIN1vmVYswgjJPJggxA+bo+7rj7cNmbWQimr05x3WerW3+8t1emt90
 aKFg==
X-Gm-Message-State: AOAM530tS9kNATeouqHZWOHvk1p+5tnS98+TLiAZt4NsCUaWLmOTvMfp
 tP/rmIOna56PfJYzYrTpE7zy/7zDc2Ar7KVQq7vSpdSAFun0NWRh7MMwggMXUSuRStuuiDIp4fc
 89QN4CTsW+sunB1D5pT0fiWKSa+NBQz8=
X-Received: by 2002:aa7:da8e:: with SMTP id q14mr523824eds.359.1598214859900; 
 Sun, 23 Aug 2020 13:34:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCrs6n9aipVyMDFV/2rwK9fn2A495bzyynztJcUJfikm1gqs+OPvguUQG59+7M1hWzukMrs1XV8f4QWxd6Vgs=
X-Received: by 2002:aa7:da8e:: with SMTP id q14mr523808eds.359.1598214859635; 
 Sun, 23 Aug 2020 13:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA-dDW27t7VcV5D=01ckBOD5oerr1XK0an7BemORdyQHHA@mail.gmail.com>
 <CAFEAcA-SmcO2ENZyXpPxxkqwybXP8=m5DXpeqkKw9PdaGnbm0g@mail.gmail.com>
In-Reply-To: <CAFEAcA-SmcO2ENZyXpPxxkqwybXP8=m5DXpeqkKw9PdaGnbm0g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 23 Aug 2020 22:34:08 +0200
Message-ID: <CABgObfbO7pB_7RKH4zrFwNfCppmtEfAhcaqF7rnAVbNR0BVXDQ@mail.gmail.com>
Subject: Re: odd meson failure: Unknown variable "exe_name"
To: Peter Maydell <peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000fbd5eb05ad9164a5"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 16:34:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fbd5eb05ad9164a5
Content-Type: text/plain; charset="UTF-8"

It's a rebase issue from the introduction of fuzzing binaries. I will send
a fix.

Paolo

Il dom 23 ago 2020, 12:54 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> On Sun, 23 Aug 2020 at 11:45, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> >
> > On my x86-64 Linux box, one of my local build trees turned out not
> > to work:
> >
> > $ rm -rf build/x86 && mkdir build/x86 && (cd build/x86 &&
> > '../../configure'
> >
> '--target-list=arm-softmmu,aarch64-softmmu,arm-linux-user,aarch64-linux-user'
> > '--enable-debug' '--cc=ccache gcc' '--audio-drv-list=pa'
> > '--with-pkgversion=pm215' '--enable-trace-backends=log,dtrace'
> > '--enable-docs')
> >
> > fails with
> > [...]
> > Program keycodemapdb/tools/keymap-gen found: YES
> > Program scripts/decodetree.py found: YES
> > Program ../scripts/modules/module_block.py found: YES
> > Program nm found: YES
> > Program scripts/undefsym.sh found: YES
> > Program scripts/feature_to_c.sh found: YES
> >
> > ../../meson.build:1030:14: ERROR: Unknown variable "exe_name".
> >
> > A full log can be found at
> >
> /home/petmay01/linaro/qemu-from-laptop/qemu/build/x86/meson-logs/meson-log.txt
> >
> > ERROR: meson setup failed
> >
> >
> > This is the same box that's worked fine for merge testing, so
> > presumably something about the particular set of configure
> > options is tripping it up.
>
> Dropping the '--enable-trace-backends=...' option lets it pass,
> so that's the area where the problem is.
>
> -- PMM
>
>

--000000000000fbd5eb05ad9164a5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">It&#39;s a rebase issue from the introduction of fuzzing =
binaries. I will send a fix.<div dir=3D"auto"><br></div><div dir=3D"auto">P=
aolo</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">Il dom 23 ago 2020, 12:54 Peter Maydell &lt;<a href=3D"mailto:pet=
er.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; ha scritto:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">On Sun, 23 Aug 2020 at 11:45, Peter Maydel=
l &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_blank" rel=3D"=
noreferrer">peter.maydell@linaro.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On my x86-64 Linux box, one of my local build trees turned out not<br>
&gt; to work:<br>
&gt;<br>
&gt; $ rm -rf build/x86 &amp;&amp; mkdir build/x86 &amp;&amp; (cd build/x86=
 &amp;&amp;<br>
&gt; &#39;../../configure&#39;<br>
&gt; &#39;--target-list=3Darm-softmmu,aarch64-softmmu,arm-linux-user,aarch6=
4-linux-user&#39;<br>
&gt; &#39;--enable-debug&#39; &#39;--cc=3Dccache gcc&#39; &#39;--audio-drv-=
list=3Dpa&#39;<br>
&gt; &#39;--with-pkgversion=3Dpm215&#39; &#39;--enable-trace-backends=3Dlog=
,dtrace&#39;<br>
&gt; &#39;--enable-docs&#39;)<br>
&gt;<br>
&gt; fails with<br>
&gt; [...]<br>
&gt; Program keycodemapdb/tools/keymap-gen found: YES<br>
&gt; Program scripts/decodetree.py found: YES<br>
&gt; Program ../scripts/modules/module_block.py found: YES<br>
&gt; Program nm found: YES<br>
&gt; Program scripts/undefsym.sh found: YES<br>
&gt; Program scripts/feature_to_c.sh found: YES<br>
&gt;<br>
&gt; ../../meson.build:1030:14: ERROR: Unknown variable &quot;exe_name&quot=
;.<br>
&gt;<br>
&gt; A full log can be found at<br>
&gt; /home/petmay01/linaro/qemu-from-laptop/qemu/build/x86/meson-logs/meson=
-log.txt<br>
&gt;<br>
&gt; ERROR: meson setup failed<br>
&gt;<br>
&gt;<br>
&gt; This is the same box that&#39;s worked fine for merge testing, so<br>
&gt; presumably something about the particular set of configure<br>
&gt; options is tripping it up.<br>
<br>
Dropping the &#39;--enable-trace-backends=3D...&#39; option lets it pass,<b=
r>
so that&#39;s the area where the problem is.<br>
<br>
-- PMM<br>
<br>
</blockquote></div>

--000000000000fbd5eb05ad9164a5--



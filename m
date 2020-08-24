Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B4AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 13:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 585D02078D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 13:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGuW2RVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585D02078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kACOM-0003W9-Kn
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 09:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kACN7-00021F-7Z
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 09:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20693)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kACN5-0001SY-I9
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 09:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598275126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=889WtchsoaE0pK5jA6k8qffFJ8WAXal1C6xJbyGJwUA=;
 b=aGuW2RVt1+gTE9dlcV336LPlkZkSgG2w82+TteQUmwLgBMZFIyCf9mxrzYiWYc21Uwj6sE
 D85P8h4jkb6cQZ+mjckIdaCjKSPGpkuCEmH9vRgm+enDzpPSJPgJ+UEjIvhdHpQnOadGZT
 D9ybw2Z2/T4h8mUMyGHFfqpiLRkIJG8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-5dgZzi6BOsunJFo29JOH-A-1; Mon, 24 Aug 2020 09:18:44 -0400
X-MC-Unique: 5dgZzi6BOsunJFo29JOH-A-1
Received: by mail-ed1-f72.google.com with SMTP id y7so2984921edp.8
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 06:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=889WtchsoaE0pK5jA6k8qffFJ8WAXal1C6xJbyGJwUA=;
 b=KTZ6svIDMJeG+yOsjayXDLByhnyHFmpEwat2RmCVcQq7VHpmC74yx4PI+r2uOHsacW
 oOZSPV3yprc9IjpgGkwK/BR9aMOH9G9ERPvrm4t9ObYslFaY00dDkYtS+i9y1nu7bopA
 uHH+q3i21evVkAX2By7mDFFWjKy6xCcIGQ2z+alZ7xsgkfuF2F0fSEOYgJjrPDXsdN7d
 nzHGarquwDxfolh6DdC3LUv8NE3DvtVxXfdi/aj1vSiU2FtRNnuzc75c2IyQV5+AELwi
 GVxwgvfunCPqvd2TnpEQxHr1e2rr+l7UbBM0BIgWLyERgIcwndkrH2akA9G0XF8YNi9e
 XeEw==
X-Gm-Message-State: AOAM531aUBdu2ZpGKkbqfGIiSgVC5JqqagXWEHJLt6osZMt+yJWQPOOH
 Rjdm9fP7BWr1RNmL8564OQiqpaa0Tx8jn90JrUTHGNEeyVM+yysuJfEIF+KYMeNk+OUrlQujrI2
 4f5TU+5c+YtAd3ilA4LyxPJkw8V/DW8k=
X-Received: by 2002:a50:9f0c:: with SMTP id b12mr5084510edf.129.1598275123466; 
 Mon, 24 Aug 2020 06:18:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaTnE8660vK97NprWQjrFRwNBOxEteljqStM361a9GAgkpXbDLwHCeY4oU2p1QSsRBWFkScpLyLjhqF2ArV1k=
X-Received: by 2002:a50:9f0c:: with SMTP id b12mr5084497edf.129.1598275123244; 
 Mon, 24 Aug 2020 06:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <d3adbbd0-fb9e-7f7f-8eaf-857c1d14d233@ilande.co.uk>
In-Reply-To: <d3adbbd0-fb9e-7f7f-8eaf-857c1d14d233@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 24 Aug 2020 15:18:31 +0200
Message-ID: <CABgObfZ13taiRpWxcwjpfUA57+N523yDKcYR4un3=D+FXrxPrg@mail.gmail.com>
Subject: Re: meson: problems building under msys2/mingw-w64 native
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000f986bb05ad9f6cec"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 06:48:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f986bb05ad9f6cec
Content-Type: text/plain; charset="UTF-8"

Il lun 24 ago 2020, 13:06 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
ha scritto:

> Within configure the default location to ninja is overridden via
> "NINJA=$PWD/ninjatool $meson setup ..." and subprocess.Popen() sends the
> filename to
> Win32's CreateProcess() which fails because ninjatool is not a native
> executable but
> a shell script. Any thoughts as to what would be the best solution here?


The simplest stopgap solution is to remove the NINJA= override and install
ninja. It will only be used to build the compile_commands.json file.

Paolo


>
> 2) GTK UI now depends on CONFIG_VTE
>
> This one I spotted on my local Linux setup as I didn't have the libvte-dev
> package
> installed and couldn't understand why I couldn't run QEMU with the GTK UI
> as I always
> do, even though configure reported that it found the GTK library and
> headers.
>
> A quick search showed that the GTK UI was being guarded by "if
> config_host.has_key('CONFIG_GTK') and config_host.has_key('CONFIG_VTE')" in
> ui/meson.build.
>
> For me the easy solution was to install libvte-dev, but since there are no
> VTE
> packages for Windows my guess is this will now make the GTK UI unavailable
> for
> Windows users.
>
>
> ATB,
>
> Mark.
>
>

--000000000000f986bb05ad9f6cec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 24 ago 2020, 13:06 Mark Cave-Ayland &lt;<a href=
=3D"mailto:mark.cave-ayland@ilande.co.uk">mark.cave-ayland@ilande.co.uk</a>=
&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Within configure t=
he default location to ninja is overridden via<br>
&quot;NINJA=3D$PWD/ninjatool $meson setup ...&quot; and subprocess.Popen() =
sends the filename to<br>
Win32&#39;s CreateProcess() which fails because ninjatool is not a native e=
xecutable but<br>
a shell script. Any thoughts as to what would be the best solution here?</b=
lockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">The sim=
plest stopgap solution is to remove the NINJA=3D override and install ninja=
. It will only be used to build the compile_commands.json file.</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></=
div><div dir=3D"auto"></div><div dir=3D"auto"><div class=3D"gmail_quote"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
<br>
<br>
2) GTK UI now depends on CONFIG_VTE<br>
<br>
This one I spotted on my local Linux setup as I didn&#39;t have the libvte-=
dev package<br>
installed and couldn&#39;t understand why I couldn&#39;t run QEMU with the =
GTK UI as I always<br>
do, even though configure reported that it found the GTK library and header=
s.<br>
<br>
A quick search showed that the GTK UI was being guarded by &quot;if<br>
config_host.has_key(&#39;CONFIG_GTK&#39;) and config_host.has_key(&#39;CONF=
IG_VTE&#39;)&quot; in<br>
ui/meson.build.<br>
<br>
For me the easy solution was to install libvte-dev, but since there are no =
VTE<br>
packages for Windows my guess is this will now make the GTK UI unavailable =
for<br>
Windows users.<br>
<br>
<br>
ATB,<br>
<br>
Mark.<br>
<br>
</blockquote></div></div></div>

--000000000000f986bb05ad9f6cec--



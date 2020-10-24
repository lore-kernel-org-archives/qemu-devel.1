Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D8AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 21:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F107520797
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 21:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzFRnLcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F107520797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWQkz-0002Ct-2e
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 17:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1kWQkB-0001in-4O; Sat, 24 Oct 2020 17:06:31 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:39137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1kWQk9-0008Cd-2l; Sat, 24 Oct 2020 17:06:30 -0400
Received: by mail-io1-xd42.google.com with SMTP id p7so6029730ioo.6;
 Sat, 24 Oct 2020 14:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cv/csrfvjXPMAnsqI2gY75KnXVAnfpS//yFqn4WmNtg=;
 b=UzFRnLcAGNdHS2/PdCG9TKvvALGXkuxvHoHich41UDCe12GubrXknjSEJa32p8YR7Y
 TKgfuxY4295xRXcOYC8havmOymqdBSAxB/4BPw/5gr0rPSPq0axwisI8PHcsgsYZ29tB
 ckC7wQsh8Oh3NLrheks8RFsfdYKQl2RHvDF1oKHTpTgnJKAvOopKwoXOShHL70bMcWJk
 mBVQUUXx/EPjbXqOXDDtJaqPWrzkDwFu9TKIg4zN0PhsTDdUnIIp/9nAEJGE6gMNT/g2
 XcXlbDc1CTjbyp+AZkunqnhEwXDbRhIxIOs9Es6BE9xj15xLn/vzoRxs3ntJ/v1cfhn3
 JZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cv/csrfvjXPMAnsqI2gY75KnXVAnfpS//yFqn4WmNtg=;
 b=VP3zYabPly87QaPea/ij1Djjw0MBmG+OMuAIvIGHJbt74i5kKNjuqqe+BHRPAtyVtB
 0r4mjyrcQ5aP3IcQooVrgS1lcVYUPjg+ZeRQICGkkEESeK3OCQf8Yyn0Yp6nD27cdK4c
 MA3MtjM5XD51Z7B6bBZzwS5NnM+f8xbA7Ukf8rdBmbwKbFyFPOR9OhdoQTg8mubQY+t6
 5N8agKv00LdtVGWYsMvuKdKoiqMFfpwFlgy8hI2hn2xYfROhQ8x5FdtOXSmELFlCABrA
 wfkOplB2VIO5Cs2Fm6nlt6KqIaypgSkwtv895m65H1OTEWQa/xEbyJ0/+eumvJCuXZM8
 rHkA==
X-Gm-Message-State: AOAM533AoI+wV0US8Lz6hcf1CEU5ILbbVGKboBYSMrEvQaXRjJP3VQAj
 FrWxFJtSVtNJ5h/mchaobZUq3UsQhCDYmWLrlho=
X-Google-Smtp-Source: ABdhPJxlv2j1zoSw2lpLnF6+xHYbRKbjje+AqifoACYWkTTFl6ctOpFdH0Gd1NbiV8HMmLkJhSIrH1Udo8BBOe8aP9o=
X-Received: by 2002:a6b:2cc5:: with SMTP id s188mr5993047ios.63.1603573587245; 
 Sat, 24 Oct 2020 14:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201023131808.3198005-1-f4bug@amsat.org>
 <20201023131808.3198005-3-f4bug@amsat.org>
In-Reply-To: <20201023131808.3198005-3-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sat, 24 Oct 2020 23:06:16 +0200
Message-ID: <CAPan3WrQd6x-L4tfApdd37WUKRx5jVRsTKPiPkGGsGbJG_XY4Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] tests/acceptance: Allow running Orange Pi test
 using cached artifacts
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="00000000000009fee405b27112fc"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Qemu-block <qemu-block@nongnu.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Bin Meng <bin.meng@windriver.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000009fee405b27112fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As a temporary solution this should be fine, until we have decided on which
reliable storage location to use.

Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

On Fri, Oct 23, 2020 at 3:18 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> Unfortunately the Armbian 19.11.3 image has been removed from the
> dl.armbian.com file server. Developers having the artifact cached
> can still run the test. Allow them to, until we find a proper
> solution to share binaries with the whole community.
>
> This avoids (when file manually added to cache):
>
>   BootLinuxConsole.test_arm_orangepi_bionic_19_11: CANCEL: Missing asset
> https://dl.armbian.com/orangepipc/archive/Armbian_19.11.3_Orangepipc_bion=
ic_current_5.3.9.7z
> (1.06 s)
>
> Reported-by: Bin Meng <bmeng.cn@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tests/acceptance/boot_linux_console.py
> b/tests/acceptance/boot_linux_console.py
> index 0118ed59156..032ac85978c 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -780,6 +780,8 @@ def test_arm_orangepi_sd(self):
>          # Wait for VM to shut down gracefully
>          self.vm.wait()
>
> +    @skipUnless(os.getenv('ARMBIAN_ARTIFACTS_CACHED'),
> +                'Test artifacts fetched from unreliable dl.armbian.com')
>      @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage
> limited')
>      @skipUnless(P7ZIP_AVAILABLE, '7z not installed')
>      def test_arm_orangepi_bionic(self):
> --
> 2.26.2
>
>

--=20
Niek Linnenbank

--00000000000009fee405b27112fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>As a temporary solution this should be fine, until we=
 have decided on which reliable storage location to use.<br></div><div><br>=
</div><div>Reviewed-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenban=
k@gmail.com">nieklinnenbank@gmail.com</a>&gt;<br></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 23, 2020 at 3:=
18 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4=
bug@amsat.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Unfortunately the Armbian 19.11.3 image has been removed from =
the<br>
<a href=3D"http://dl.armbian.com" rel=3D"noreferrer" target=3D"_blank">dl.a=
rmbian.com</a> file server. Developers having the artifact cached<br>
can still run the test. Allow them to, until we find a proper<br>
solution to share binaries with the whole community.<br>
<br>
This avoids (when file manually added to cache):<br>
<br>
=C2=A0 BootLinuxConsole.test_arm_orangepi_bionic_19_11: CANCEL: Missing ass=
et <a href=3D"https://dl.armbian.com/orangepipc/archive/Armbian_19.11.3_Ora=
ngepipc_bionic_current_5.3.9.7z" rel=3D"noreferrer" target=3D"_blank">https=
://dl.armbian.com/orangepipc/archive/Armbian_19.11.3_Orangepipc_bionic_curr=
ent_5.3.9.7z</a> (1.06 s)<br>
<br>
Reported-by: Bin Meng &lt;<a href=3D"mailto:bmeng.cn@gmail.com" target=3D"_=
blank">bmeng.cn@gmail.com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0tests/acceptance/boot_linux_console.py | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py<br>
index 0118ed59156..032ac85978c 100644<br>
--- a/tests/acceptance/boot_linux_console.py<br>
+++ b/tests/acceptance/boot_linux_console.py<br>
@@ -780,6 +780,8 @@ def test_arm_orangepi_sd(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Wait for VM to shut down gracefully<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.vm.wait()<br>
<br>
+=C2=A0 =C2=A0 @skipUnless(os.getenv(&#39;ARMBIAN_ARTIFACTS_CACHED&#39;),<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;Test artifact=
s fetched from unreliable <a href=3D"http://dl.armbian.com" rel=3D"noreferr=
er" target=3D"_blank">dl.armbian.com</a>&#39;)<br>
=C2=A0 =C2=A0 =C2=A0@skipUnless(os.getenv(&#39;AVOCADO_ALLOW_LARGE_STORAGE&=
#39;), &#39;storage limited&#39;)<br>
=C2=A0 =C2=A0 =C2=A0@skipUnless(P7ZIP_AVAILABLE, &#39;7z not installed&#39;=
)<br>
=C2=A0 =C2=A0 =C2=A0def test_arm_orangepi_bionic(self):<br>
-- <br>
2.26.2<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--00000000000009fee405b27112fc--


Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837E9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458EE206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ld1/ECFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458EE206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixAye-00084F-Hg
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 09:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1ixAxp-0007fG-LG
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1ixAxo-00005p-Fc
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:38:37 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:42154)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1ixAxo-0008UC-7a
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:38:36 -0500
Received: by mail-lj1-x243.google.com with SMTP id d10so3574331ljl.9
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 06:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=bte+U5hvAJg2xcd11J1oajKusvE7zl/o79kFbLT7zhs=;
 b=ld1/ECFNcEX6a3cP2D/RSRNbksrYh4PCzuT1gfBlcR7yyh+hcrHFeBJxSiLwLfhzHW
 gtASh286B4PuEnsa8y4lMZ4JtvQjBDNIcw9FT03P/oCh8oROy9DFvn5MlQkA2qFs3me0
 cxniODjxcK4IMReDmPA2qI0NuUWd+cyqNh2pkK+K2g1tm6dcTcrZvU5IGBddQRLveoPO
 jNIOu+I2bvAimVaHWEGCmVvs2NHXzeppA0yG0yvXr1Dx9Yyz+yM7by0nRpXWmEi+JejQ
 UqBNYCUzxVdN//OEv5p9Lmhie4hlag2H2mX2njUBbdAYmxSvC0AB5/9w+iK7jSJ2IaRR
 Vm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=bte+U5hvAJg2xcd11J1oajKusvE7zl/o79kFbLT7zhs=;
 b=Nn4SFbjhJCG2J3Y6HaqxoN5UWkrzB0eKonFe3Kp0VOkRKJAH0jYCUiYBOzAXYHWfd8
 0q/DGz/qJsez1GQcVcon+lZQVSf3leB0tLtqsWuAe9/+hTN1IZkZbjPGdNM5nZsz96FG
 WqfWdv8TdRTAF5cl4WC9H05keIYClWO1LcpEVyrSqU5BBqMGx57RTGB82P8ZJS+sdgtn
 uoqmoRCliee3HcHpFJ/Cdf/D0eADsG79szOx26oEj9DxssIo8A7FnPrfUQHt0CoE7sQv
 zPGDVcCbKOiFf6Kzq0TUEYp85XMTbdUZY16GUc8pgnUAIjYEVA3rJbjErYNPl8v/ena6
 QmSw==
X-Gm-Message-State: APjAAAU0eN+CTjB+k76Begy64c8EkF4YAnhOoay1BlTJnoVmFwyYr2nA
 Q3Bp9hPueBIDiDiJQqoviiyGbI3qIzAnuAkz7iYBhA==
X-Google-Smtp-Source: APXvYqwM016/CqaTTsz69vTRc25vz73o9q6DfIU/Ya55gST7QNYfdrx5fl0naUq9iaW+9nPzFqCMyEPDj739NpCf46c=
X-Received: by 2002:a2e:884d:: with SMTP id z13mr3113533ljj.116.1580395114143; 
 Thu, 30 Jan 2020 06:38:34 -0800 (PST)
MIME-Version: 1.0
From: Robert Foley <robert.foley@linaro.org>
Date: Thu, 30 Jan 2020 09:37:58 -0500
Message-ID: <CAEyhzFugFgAuy=r+JsoTxzqYWxTB6LAnETBWS4ubMOmbjrFP3w@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] tests/docker: better handle symlinked libs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 Richard Henderson <richard.henderson@linaro.org>, f4bug@amsat.org,
 qemu-devel@nongnu.org, cota@braap.org, stefanha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,
I was looking at this patch and have a comment about the number of
groups that are expected to be found by this regex.
It seems like the old code expected two groups to be found otherwise
it will not append the library to the found libs.
def _get_so_libs(executable):
    libs =3D []
    ldd_re =3D re.compile(r"(/.*/)(\S*)")
    try:
        ldd_output =3D subprocess.check_output(["ldd",
executable]).decode('utf-8')
        for line in ldd_output.split("\n"):
            search =3D ldd_re.search(line)
            if search and len(search.groups()) =3D=3D 2:  <<<<<<<<<<<<<<<
                so_path =3D search.groups()[0]
                so_lib =3D search.groups()[1]
                libs.append("%s/%s" % (so_path, so_lib))

I did a bit of experimenting with output from ldd and found a few
strings where the new regex seems
to generate only one group for the entire path+lib rather than one group
for the path and another group for the lib.

$ ldd build/aarch64-softmmu/qemu-system-aarch64
__snip__
      /lib/ld-linux-aarch64.so.1 (0x0000ffff9c41f000)
      libgmodule-2.0.so.0 =3D>
/usr/lib/aarch64-linux-gnu/libgmodule-2.0.so.0 (0x0000ffff9a96e000)
__snip
$ python3
Python 3.6.8 (default, Oct  7 2019, 12:59:55)
[GCC 8.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import re
>>> ldd_re =3D re.compile(r"(?:\S+ =3D> )?(\S*) \(:?0x[0-9a-f]+\)")
>>> a =3D "/lib/ld-linux-aarch64.so.1 (0x0000ffff9c41f000)"
>>> b =3D "libgmodule-2.0.so.0 =3D> /usr/lib/aarch64-linux-gnu/libgmodule-2=
.0.so.0 (0x0000ffff9a96e000)"
>>> ldd_re.search(a).groups()
('/lib/ld-linux-aarch64.so.1',)
>>> ldd_re.search(b).groups()
('/usr/lib/aarch64-linux-gnu/libgmodule-2.0.so.0',)
>>> len(ldd_re.search(a).groups())
1
>>> len(ldd_re.search(b).groups())
1
>>> ldd_re_old =3D re.compile('(/.*/)(\S*)')
>>> ldd_re_old.search(a).groups()
('/lib/', 'ld-linux-aarch64.so.1')
>>> ldd_re_old.search(b).groups()
('/usr/lib/aarch64-linux-gnu/', 'libgmodule-2.0.so.0')
>>> len(ldd_re_old.search(a).groups())
2
>>> len(ldd_re_old.search(b).groups())
2
>>>

Thanks & Regards,
-Rob

On Thu, 30 Jan 2020 at 06:40, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> When we are copying we want to ensure we grab the first
> resolution (the found in path section). However even that binary might
> be a symlink so lets make sure we chase the symlinks to copy the right
> binary to where it can be found.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/docker/docker.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 31d8adf836..7dfca63fe4 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -109,7 +109,7 @@ def _get_so_libs(executable):
>      ensure theright data is copied."""
>
>      libs =3D []
> -    ldd_re =3D re.compile(r"(/.*/)(\S*)")
> +    ldd_re =3D re.compile(r"(?:\S+ =3D> )?(\S*) \(:?0x[0-9a-f]+\)")
>      try:
>          ldd_output =3D subprocess.check_output(["ldd", executable]).deco=
de('utf-8')
>          for line in ldd_output.split("\n"):
> @@ -145,7 +145,8 @@ def _copy_binary_with_libs(src, bin_dest, dest_dir):
>      if libs:
>          for l in libs:
>              so_path =3D os.path.dirname(l)
> -            _copy_with_mkdir(l, dest_dir, so_path)
> +            real_l =3D os.path.realpath(l)
> +            _copy_with_mkdir(real_l, dest_dir, so_path)
>  def _check_binfmt_misc(executable):
> --
> 2.20.1
>


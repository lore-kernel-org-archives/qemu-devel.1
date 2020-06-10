Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480E1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19547206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCgEygny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19547206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj75J-0007sY-Bp
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 16:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jj72O-0003Z3-20
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:09:28 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51623)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jj72M-0001jc-UW
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:09:27 -0400
Received: by mail-wm1-x341.google.com with SMTP id u13so3001060wml.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OuImIXZfAqdri/39NYTHBQIUuRxN8apZAJQnIHXZMJk=;
 b=SCgEygny8psCnfEHp5lVGmp2Nw/P0KfNyglgkmZUW9al/3//dOsyIU/b4iCofsi9TL
 aAjo4E81eJoH+nGlmmOtnNXpZu0VIFFqMab1luSR+jrINAIhCEHc+c4ZMi5PfYH7BgG8
 Y8AdJears9z28TS1OcsJS4E6Lt4aZLJmm8gqTxd2qlk23Qc8DXwUJ9QtpkdL3rdf/YoS
 QUB8Ot2q/hO+5VU2M3ZdpLGYn8TIJ+3g25DpWZeqBCKX35mVoWG6fBVnlAoJockhGcYX
 zd6Bk/+7Rdr5+UQpCRWyOf2/PI3gYgtPP0NMdlE1NnjFgBWLrrVnxtgt2XJuh5MnBAqt
 3h1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OuImIXZfAqdri/39NYTHBQIUuRxN8apZAJQnIHXZMJk=;
 b=j+Mn6C2D0lnbEAPAioftcRWBYVEGhC0+bdDtTJDte/ohrx+npQFzuii7OAGzZtIFSK
 oCzeMbvjvCPuFTEnuQHsMVwMQRY1ZPbJXygWus2UdnxCZ8z2QVSPvl9yMnnbR+wk5gM6
 Wj5mtDR4qeVAn5z0ffg1ngeQiSW/eVyXW0v/eHq67usb62meVBm84pMzjShxDYBuGgQI
 eDE4cdynPZWv2w1IkaW2+7WvFVqO6ShF5lmOvMDz2ofEFXf+FjWA1ixnvuIFW2McjQtw
 dUEdP81RgxY2jSTu453pv5Ey2yco2uw7EJ11tuY0RPHEBHU/cT79NWsOEcE0lDDiVIDy
 QeJA==
X-Gm-Message-State: AOAM533P0tu5awMKev98McbVdfF0HNCQl9spKvJqFhnTWl+1GvZcRUuL
 EH9hLoOTelMQd3sAzZ0UD8IdrY9fiWUBvZPVTVM=
X-Google-Smtp-Source: ABdhPJyVFVRKlAMqLHH3REmfpZrrqwem35qpSdBQsxJpK25omGBtHfYHEdEgZrMRydKohP/nz4yXS5JE4KQhV4uaeEA=
X-Received: by 2002:a05:600c:2259:: with SMTP id
 a25mr4945467wmm.32.1591819759397; 
 Wed, 10 Jun 2020 13:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200610200247.21378-1-philmd@redhat.com>
In-Reply-To: <20200610200247.21378-1-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 11 Jun 2020 00:09:07 +0400
Message-ID: <CAJ+F1CLwLqTCKbUw_xrVax1zctE3Q68ZbaM_Tydn7ZqELp8vnw@mail.gmail.com>
Subject: Re: [PATCH 0/8] tpm: Split hw/ vs backends/
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004e33b105a7c06b35"
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004e33b105a7c06b35
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jun 11, 2020 at 12:03 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com>
wrote:

> Hi,
>
> Today I started to review some vTPM patches and got very
> confused by the files under hw/tpm/. In particular after
> running:
>
>   $ git grep TYPE_TPM_BACKEND
>   backends/tpm.c:188:    .name =3D TYPE_TPM_BACKEND,
>   hw/tpm/tpm_emulator.c:985:    .parent =3D TYPE_TPM_BACKEND,
>   hw/tpm/tpm_passthrough.c:393:    .parent =3D TYPE_TPM_BACKEND,
>   include/sysemu/tpm_backend.h:21:#define TYPE_TPM_BACKEND "tpm-backend"
>
> As there is no particular reason to keep this mixed, clean it up.
>

While at it, why not start to organize backends/ ?  I would move that under
backends/tpm/


> Philippe Mathieu-Daud=C3=A9 (8):
>   hw/tpm: Do not include 'qemu/osdep.h' in header
>   hw/tpm: Include missing 'qemu/option.h' header
>   hw/tpm: Move 'hw/acpi/tpm.h' inclusion from header to sources
>   hw/tpm: Remove unnecessary 'tpm_int.h' header inclusion
>   hw/tpm: Move few declarations from 'tpm_util.h' to 'tpm_int.h'
>   hw/tpm: Move DEFINE_PROP_TPMBE() macro to 'tmp_prop.h' local header
>   hw/tpm: Make 'tpm_util.h' publicly accessible as "sysemu/tpm_util.h"
>   tpm: Move backend code under the 'backends/' directory
>
>  Makefile                               |  2 +-
>  {hw/tpm =3D> backends}/tpm_int.h         | 19 +++++++++++---
>  {hw/tpm =3D> backends}/tpm_ioctl.h       |  0
>  hw/tpm/tpm_ppi.h                       |  1 -
>  hw/tpm/tpm_prop.h                      | 31 +++++++++++++++++++++++
>  hw/tpm/tpm_tis.h                       |  1 -
>  {hw/tpm =3D> include/sysemu}/tpm_util.h  | 19 +++-----------
>  {hw/tpm =3D> backends}/tpm_emulator.c    |  2 +-
>  {hw/tpm =3D> backends}/tpm_passthrough.c |  2 +-
>  {hw/tpm =3D> backends}/tpm_util.c        |  2 +-
>  hw/tpm/tpm_crb.c                       |  4 +--
>  hw/tpm/tpm_spapr.c                     |  4 +--
>  hw/tpm/tpm_tis_common.c                |  4 +--
>  hw/tpm/tpm_tis_isa.c                   |  3 ++-
>  hw/tpm/tpm_tis_sysbus.c                |  3 ++-
>  tests/qtest/tpm-emu.c                  |  2 +-
>  MAINTAINERS                            |  2 +-
>  backends/Kconfig                       | 14 +++++++++++
>  backends/Makefile.objs                 |  3 +++
>  backends/trace-events                  | 32 ++++++++++++++++++++++++
>  hw/tpm/Kconfig                         | 15 ------------
>  hw/tpm/Makefile.objs                   |  3 ---
>  hw/tpm/trace-events                    | 34 +-------------------------
>  23 files changed, 116 insertions(+), 86 deletions(-)
>  rename {hw/tpm =3D> backends}/tpm_int.h (81%)
>  rename {hw/tpm =3D> backends}/tpm_ioctl.h (100%)
>  create mode 100644 hw/tpm/tpm_prop.h
>  rename {hw/tpm =3D> include/sysemu}/tpm_util.h (80%)
>  rename {hw/tpm =3D> backends}/tpm_emulator.c (99%)
>  rename {hw/tpm =3D> backends}/tpm_passthrough.c (99%)
>  rename {hw/tpm =3D> backends}/tpm_util.c (99%)
>  create mode 100644 backends/Kconfig
>
> --
> 2.21.3
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000004e33b105a7c06b35
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 11, 2020 at 12:03 AM Ph=
ilippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@r=
edhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi,<br>
<br>
Today I started to review some vTPM patches and got very<br>
confused by the files under hw/tpm/. In particular after<br>
running:<br>
<br>
=C2=A0 $ git grep TYPE_TPM_BACKEND<br>
=C2=A0 backends/tpm.c:188:=C2=A0 =C2=A0 .name =3D TYPE_TPM_BACKEND,<br>
=C2=A0 hw/tpm/tpm_emulator.c:985:=C2=A0 =C2=A0 .parent =3D TYPE_TPM_BACKEND=
,<br>
=C2=A0 hw/tpm/tpm_passthrough.c:393:=C2=A0 =C2=A0 .parent =3D TYPE_TPM_BACK=
END,<br>
=C2=A0 include/sysemu/tpm_backend.h:21:#define TYPE_TPM_BACKEND &quot;tpm-b=
ackend&quot;<br>
<br>
As there is no particular reason to keep this mixed, clean it up.<br></bloc=
kquote><div><br></div><div>While at it, why not start to organize backends/=
 ?=C2=A0 I would move that under backends/tpm/</div><div><br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<br>
Philippe Mathieu-Daud=C3=A9 (8):<br>
=C2=A0 hw/tpm: Do not include &#39;qemu/osdep.h&#39; in header<br>
=C2=A0 hw/tpm: Include missing &#39;qemu/option.h&#39; header<br>
=C2=A0 hw/tpm: Move &#39;hw/acpi/tpm.h&#39; inclusion from header to source=
s<br>
=C2=A0 hw/tpm: Remove unnecessary &#39;tpm_int.h&#39; header inclusion<br>
=C2=A0 hw/tpm: Move few declarations from &#39;tpm_util.h&#39; to &#39;tpm_=
int.h&#39;<br>
=C2=A0 hw/tpm: Move DEFINE_PROP_TPMBE() macro to &#39;tmp_prop.h&#39; local=
 header<br>
=C2=A0 hw/tpm: Make &#39;tpm_util.h&#39; publicly accessible as &quot;sysem=
u/tpm_util.h&quot;<br>
=C2=A0 tpm: Move backend code under the &#39;backends/&#39; directory<br>
<br>
=C2=A0Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0{hw/tpm =3D&gt; backends}/tpm_int.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| 19 +++++++++++---<br>
=C2=A0{hw/tpm =3D&gt; backends}/tpm_ioctl.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 0<br>
=C2=A0hw/tpm/tpm_ppi.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 -<br>
=C2=A0hw/tpm/tpm_prop.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 31 +++++++++++++++++++++++<br>
=C2=A0hw/tpm/tpm_tis.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 -<br>
=C2=A0{hw/tpm =3D&gt; include/sysemu}/tpm_util.h=C2=A0 | 19 +++-----------<=
br>
=C2=A0{hw/tpm =3D&gt; backends}/tpm_emulator.c=C2=A0 =C2=A0 |=C2=A0 2 +-<br=
>
=C2=A0{hw/tpm =3D&gt; backends}/tpm_passthrough.c |=C2=A0 2 +-<br>
=C2=A0{hw/tpm =3D&gt; backends}/tpm_util.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 2 +-<br>
=C2=A0hw/tpm/tpm_crb.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 +--<br>
=C2=A0hw/tpm/tpm_spapr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 +--<br>
=C2=A0hw/tpm/tpm_tis_common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 4 +--<br>
=C2=A0hw/tpm/tpm_tis_isa.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 3 ++-<br>
=C2=A0hw/tpm/tpm_tis_sysbus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 3 ++-<br>
=C2=A0tests/qtest/tpm-emu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0backends/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 14 +++++++++++<br>
=C2=A0backends/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 3 +++<br>
=C2=A0backends/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | 32 ++++++++++++++++++++++++<br>
=C2=A0hw/tpm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 15 ------------<br>
=C2=A0hw/tpm/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 3 ---<br>
=C2=A0hw/tpm/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | 34 +-------------------------<br>
=C2=A023 files changed, 116 insertions(+), 86 deletions(-)<br>
=C2=A0rename {hw/tpm =3D&gt; backends}/tpm_int.h (81%)<br>
=C2=A0rename {hw/tpm =3D&gt; backends}/tpm_ioctl.h (100%)<br>
=C2=A0create mode 100644 hw/tpm/tpm_prop.h<br>
=C2=A0rename {hw/tpm =3D&gt; include/sysemu}/tpm_util.h (80%)<br>
=C2=A0rename {hw/tpm =3D&gt; backends}/tpm_emulator.c (99%)<br>
=C2=A0rename {hw/tpm =3D&gt; backends}/tpm_passthrough.c (99%)<br>
=C2=A0rename {hw/tpm =3D&gt; backends}/tpm_util.c (99%)<br>
=C2=A0create mode 100644 backends/Kconfig<br>
<br>
-- <br>
2.21.3<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000004e33b105a7c06b35--


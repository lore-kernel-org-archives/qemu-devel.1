Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248F0C4740C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:12:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F161620882
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F161620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCKOg-00026Y-Vb
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 05:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iCJyw-0005a6-33
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iCJyu-00087O-KL
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:46:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37298)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iCJys-00085q-F0
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 04:46:03 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3ED763DE05
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 08:45:59 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id 4so4681885wmj.6
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 01:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=AT8+uhMVeY+mvWoSfheeycvU0NulLDTjhfvstu4jndg=;
 b=J1lgH7c3MTlQsUHoIzXghfjkTxLgfSnuxfPp7Q+/OUtpYv+/hbCidPZtRXkrv4VdjZ
 GzzvLjTR43qdWBwRn1VhAA6zFwxoOSFqGUmcjzqzSWqko+ILBCAHJa56Kt4xl/ETmas9
 YSKeKrBebmkOG2xJ2miu6no8Glc+Bx+P3P7w+oVJxQJt5CBKBGCSswS7nDMVJ2Jfpfak
 IiWjcKodT1anK+VA/iozSvKjobGRH3mDPjXkCRv/rA2XCu8iWgwB6UlkfiliXsxyZCXj
 9HEUxA9QTKTIigdFjO8UOV6Oi6PRwygpmJ/RwXiNRMY4LrD5brGdoJuJV1LszUMW1GfZ
 KOhg==
X-Gm-Message-State: APjAAAUjjQ+/kSy5yN2SAJPz3IAYiuPwzNnglZogNcRV7HExqvHZjBdv
 +M/fdJDhyZGtgf1U7jHQYVuI1upTd93oAXv1PWBOxJs2W6A4FhxuGTMen+WvOBonp/NHyrhGTAo
 AUjitMs58CrNypaA=
X-Received: by 2002:a5d:4350:: with SMTP id u16mr20167383wrr.289.1569228357992; 
 Mon, 23 Sep 2019 01:45:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy/becRa2NJ/Xtke1YOtggYa6AF3BQABAyI6BA5QqN/5QXNKHf6ipTj9d3VNo5iY7Soq2PEQw==
X-Received: by 2002:a5d:4350:: with SMTP id u16mr20167369wrr.289.1569228357747; 
 Mon, 23 Sep 2019 01:45:57 -0700 (PDT)
Received: from steredhat (host170-61-dynamic.36-79-r.retail.telecomitalia.it.
 [79.36.61.170])
 by smtp.gmail.com with ESMTPSA id x5sm19339895wrg.69.2019.09.23.01.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 01:45:57 -0700 (PDT)
Date: Mon, 23 Sep 2019 10:45:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] hw/arm/boot: Use the IEC binary prefix definitions
Message-ID: <20190923084554.6faurhnaage7t5kp@steredhat>
References: <20190921103405.19623-1-philmd@redhat.com>
 <20190923082919.y2fjn2y6t7lire3z@steredhat>
 <75b5eaec-5e00-6dd0-1a67-b0dafd2d5622@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <75b5eaec-5e00-6dd0-1a67-b0dafd2d5622@redhat.com>
User-Agent: NeoMutt/20180716
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 23, 2019 at 10:43:12AM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 9/23/19 10:29 AM, Stefano Garzarella wrote:
> > On Sat, Sep 21, 2019 at 12:34:04PM +0200, Philippe Mathieu-Daud=E9 wr=
ote:
> >> IEC binary prefixes ease code review: the unit is explicit.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> >> ---
> >>  hw/arm/boot.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> >> index bf97ef3e33..59bb2fa0d3 100644
> >> --- a/hw/arm/boot.c
> >> +++ b/hw/arm/boot.c
> >=20
> > Very appreciated!
> >=20
> > What about fixing also this other line?
> >=20
> > @@ -575,7 +575,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_bo=
ot_info *binfo,
> >          goto fail;
> >      }
> > =20
> > -    if (scells < 2 && binfo->ram_size >=3D (1ULL << 32)) {
> > +    if (scells < 2 && binfo->ram_size >=3D 4 * GiB) {
>=20
> Good idea!
>=20
> >          /* This is user error so deserves a friendlier error message
> >           * than the failure of setprop_sized_cells would provide
> >=20
> >=20
> >> @@ -1095,7 +1095,7 @@ static void arm_setup_direct_kernel_boot(ARMCP=
U *cpu,
> >>       * we might still make a bad choice here.
> >>       */
> >>      info->initrd_start =3D info->loader_start +
> >> -        MIN(info->ram_size / 2, 128 * 1024 * 1024);
> >> +        MIN(info->ram_size / 2, 128 * MiB);
> >>      if (image_high_addr) {
> >>          info->initrd_start =3D MAX(info->initrd_start, image_high_a=
ddr);
> >>      }
> >> @@ -1155,13 +1155,13 @@ static void arm_setup_direct_kernel_boot(ARM=
CPU *cpu,
> >>                   *
> >>                   * Let's play safe and prealign it to 2MB to give u=
s some space.
> >>                   */
> >> -                align =3D 2 * 1024 * 1024;
> >> +                align =3D 2 * MiB;
> >>              } else {
> >>                  /*
> >>                   * Some 32bit kernels will trash anything in the 4K=
 page the
> >>                   * initrd ends in, so make sure the DTB isn't caugh=
t up in that.
> >>                   */
> >> -                align =3D 4096;
> >> +                align =3D 4 * KiB;
> >>              }
> >> =20
> >>              /* Place the DTB after the initrd in memory with alignm=
ent. */
> >> @@ -1178,7 +1178,7 @@ static void arm_setup_direct_kernel_boot(ARMCP=
U *cpu,
> >>                  info->loader_start + KERNEL_ARGS_ADDR;
> >>              fixupcontext[FIXUP_ARGPTR_HI] =3D
> >>                  (info->loader_start + KERNEL_ARGS_ADDR) >> 32;
> >> -            if (info->ram_size >=3D (1ULL << 32)) {
> >> +            if (info->ram_size >=3D 4 * GiB) {
> >>                  error_report("RAM size must be less than 4GB to boo=
t"
> >>                               " Linux kernel using ATAGS (try passin=
g a device tree"
> >>                               " using -dtb)");
> >=20
> > With or without the new line fix:
> >=20
> > Acked-by: Stefano Garzarella <sgarzare@redhat.com>
>=20
> Did you mean Reviewed-by?

Yes, sorry! :-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>



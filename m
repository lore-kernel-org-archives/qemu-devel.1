Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7230C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 14:13:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 956B720848
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 14:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/iacg1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956B720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in1E7-00088P-NU
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 09:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1in1DH-0007dl-Iz
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:12:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1in1DE-0007HD-Hv
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:12:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28053
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1in1DE-0007Fy-6p
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577974351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yFUgxZe050gfK6RjsB2eUkJw5N7IPWyk16B3l/O0EXU=;
 b=W/iacg1sSFcOA6FLQeOMwsXKGwCSBgR//iMV6WvJ5TX9Jli1wvB6aTmUN89TWz3j37/Ro2
 peVEqmPSX4h4WbySL1iOGb8zdmUGdT0modem8hrwDQuli6d6OxgCO3xqQU31uYixxe/PVK
 dsqkoO0MNP/qyT9Rr/383bB/Ur5xhn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-9148UQ1sP96wb-6jmUmubg-1; Thu, 02 Jan 2020 09:12:30 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AFBF100550E;
 Thu,  2 Jan 2020 14:12:28 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 887C4675AE;
 Thu,  2 Jan 2020 14:12:24 +0000 (UTC)
Date: Thu, 2 Jan 2020 15:12:23 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH 43/86] hppa: drop RAM size fixup
Message-ID: <20200102151223.73e1448b@redhat.com>
In-Reply-To: <7cc361d0-300f-a8a1-3650-9358e815c070@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-44-git-send-email-imammedo@redhat.com>
 <bc7bac60-0d20-d0e3-b9ac-2c9ff62c2c15@redhat.com>
 <8cb7bd0f-7841-7e60-8de6-708515b81b00@gmx.de>
 <7cc361d0-300f-a8a1-3650-9358e815c070@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 9148UQ1sP96wb-6jmUmubg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Jan 2020 13:06:33 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 1/2/20 12:31 PM, Helge Deller wrote:
> > On 31.12.19 16:44, Philippe Mathieu-Daud=C3=A9 wrote: =20
> >> On 12/31/19 2:03 PM, Igor Mammedov wrote: =20
> >>> If user provided non-sense RAM size, board will complain and
> >>> continue running with max RAM size supported.
> >>> Also RAM is going to be allocated by generic code, so it won't be
> >>> possible for board to fix things up for user.
> >>>
> >>> Make it error message and exit to force user fix CLI,
> >>> instead of accepting non-sense CLI values.
> >>>
> >>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >>> ---
> >>>  =C2=A0 hw/hppa/machine.c | 3 ++-
> >>>  =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> >>> index 5d0de26..25f5afc 100644
> >>> --- a/hw/hppa/machine.c
> >>> +++ b/hw/hppa/machine.c
> >>> @@ -92,7 +92,8 @@ static void machine_hppa_init(MachineState *machine=
)
> >>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Limit main memory. */
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ram_size > FIRMWARE_START) {
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine->ram_size =3D ram=
_size =3D FIRMWARE_START;
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("RAM size mo=
re than %d is not supported", FIRMWARE_START);
> >>> +        exit(EXIT_FAILURE); =20
> >>
> >> $ qemu-system-hppa -m 3841m
> >> qemu-system-hppa: invalid accelerator kvm
> >> qemu-system-hppa: falling back to tcg
> >> qemu-system-hppa: RAM size more than -268435456 is not supported
> >>
> >> Instead of using qemu_strtosz_MiB on FIRMWARE_START or unsigned format=
, we can simply use "RAM size more than 3840m is not supported". Is that OK=
 with you? =20
> >=20
> > I don't really like that change.
> >=20
> > We currently only emulate a 32-bit system, and for those 4GB is the max=
imum.
> > So, if I start my machine with "qemu-system-hppa -m 4G", the current co=
de
> > then automatically uses the maximum possible of 3841MB (which is limite=
d by
> > firmware start address).
> > I don't expect users to know the excact 3841MB number.
> > Even on a phyiscal machine you can only add DIMMs of sizes 2GB, 3GB or =
4GB,
> > but not "3841MB". =20
>=20
> Thanks for the explanation. This deserves a comment in the source file=20
> IMHO (and displaying a warning to the user that the behavior is changed).
>=20
> I understand the CPU can't access this DRAM area because the ROM is=20
> mapped there. What about other devices, can they do DMA access to it?
>=20
> Igor: If this complicates your series too much, I think we can directly=
=20
> allocate up-to 4GiB and not worry about the 256MiB lost.

Do you mean
s/"RAM size more than %d is not supported"/"RAM size more than 4Gb is not s=
upported"/

> > So, I think that patch is - although it's more correct - not a
> > benefit for the end user.
> >=20
> > Helge
> >  =20
>=20
>=20



Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D379C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 14:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7841215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 14:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FC8XJYA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7841215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in1mK-0003dg-T2
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 09:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1in1lM-0002nk-OS
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:47:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1in1lL-0004d0-Hz
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:47:48 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30380
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1in1lL-0004bt-Df
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577976466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oERDlXY0wp808zSy+S2S6agc1WjSlm03s58t2QHS10M=;
 b=FC8XJYA9WirhPcF1MrPFZ4kD5PMJMzNJ49s80Y1jobqKsLqaczhDXVvRe5EyHRSkf3PyYr
 aH8eJkvBKOKRoz3pOhZzBv6GLX8Z2jiT09+LS5M1fVRC+W57mQZAePDIfCIoNfI0RaAD82
 8AZkoLSfiABBYQvFu94oSfL4lquMIaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-KYW7zn5IO1uOPVAcQdls3g-1; Thu, 02 Jan 2020 09:47:45 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B814B107B790;
 Thu,  2 Jan 2020 14:47:44 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EAAF5C545;
 Thu,  2 Jan 2020 14:47:41 +0000 (UTC)
Date: Thu, 2 Jan 2020 15:47:39 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 43/86] hppa: drop RAM size fixup
Message-ID: <20200102154739.5fd87c2f@redhat.com>
In-Reply-To: <c6362789-579a-29ee-6947-7597eeda6515@gmx.de>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-44-git-send-email-imammedo@redhat.com>
 <bc7bac60-0d20-d0e3-b9ac-2c9ff62c2c15@redhat.com>
 <8cb7bd0f-7841-7e60-8de6-708515b81b00@gmx.de>
 <7cc361d0-300f-a8a1-3650-9358e815c070@redhat.com>
 <c6362789-579a-29ee-6947-7597eeda6515@gmx.de>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: KYW7zn5IO1uOPVAcQdls3g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Jan 2020 14:02:01 +0100
Helge Deller <deller@gmx.de> wrote:

> On 02.01.20 13:06, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 1/2/20 12:31 PM, Helge Deller wrote: =20
> >> On 31.12.19 16:44, Philippe Mathieu-Daud=C3=A9 wrote: =20
> >>> On 12/31/19 2:03 PM, Igor Mammedov wrote: =20
> >>>> If user provided non-sense RAM size, board will complain and
> >>>> continue running with max RAM size supported.
> >>>> Also RAM is going to be allocated by generic code, so it won't be
> >>>> possible for board to fix things up for user.
> >>>>
> >>>> Make it error message and exit to force user fix CLI,
> >>>> instead of accepting non-sense CLI values.
> >>>>
> >>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >>>> ---
> >>>> =C2=A0=C2=A0 hw/hppa/machine.c | 3 ++-
> >>>> =C2=A0=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> >>>> index 5d0de26..25f5afc 100644
> >>>> --- a/hw/hppa/machine.c
> >>>> +++ b/hw/hppa/machine.c
> >>>> @@ -92,7 +92,8 @@ static void machine_hppa_init(MachineState *machin=
e)
> >>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Limit main memory. */
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ram_size > FIRMWARE_START) =
{
> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine->ram_size =3D ra=
m_size =3D FIRMWARE_START;
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("RAM size m=
ore than %d is not supported", FIRMWARE_START);
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(EXIT_FAILURE); =20
> >>>
> >>> $ qemu-system-hppa -m 3841m
> >>> qemu-system-hppa: invalid accelerator kvm
> >>> qemu-system-hppa: falling back to tcg
> >>> qemu-system-hppa: RAM size more than -268435456 is not supported
> >>>
> >>> Instead of using qemu_strtosz_MiB on FIRMWARE_START or unsigned forma=
t, we can simply use "RAM size more than 3840m is not supported". Is that O=
K with you? =20
> >>
> >> I don't really like that change.
> >>
> >> We currently only emulate a 32-bit system, and for those 4GB is the ma=
ximum.
> >> So, if I start my machine with "qemu-system-hppa -m 4G", the current c=
ode
> >> then automatically uses the maximum possible of 3841MB (which is limit=
ed by
> >> firmware start address).
> >> I don't expect users to know the excact 3841MB number.
> >> Even on a phyiscal machine you can only add DIMMs of sizes 2GB, 3GB or=
 4GB,
> >> but not "3841MB". =20
> >
> > Thanks for the explanation. This deserves a comment in the source
> > file IMHO (and displaying a warning to the user that the behavior is
> > changed). =20
>=20
> If you put 4GB physically in the box, you wouldn't get a warning either..=
.
> It will simply use just 3841MB.
>=20
> > I understand the CPU can't access this DRAM area because the ROM is
> > mapped there. What about other devices, can they do DMA access to
> > it? =20
>=20
> Yes, I think so.

Question is if is it supported/used in current impl?

If it's not then lets keep a hard error providing the exact max value,
instead of complicating code for unclear benefit.

>=20
> > Igor: If this complicates your series too much, I think we can
> > directly allocate up-to 4GiB and not worry about the 256MiB lost. =20
>=20
> Sounds like the best solution.
>=20
> Helge
>=20



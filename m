Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FA1C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 14:42:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B582215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 14:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5HzsGEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B582215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in1gf-0000Lq-7q
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 09:42:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40822)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1in1fu-0008B8-1y
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:42:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1in1fr-000227-4z
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:42:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47802
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1in1fq-00021f-LA
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:42:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577976125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8jFCH1Pu0aVNTizRRUKXTy66iAQBxu4wBtxvAnPNhM=;
 b=P5HzsGEBwOVaTljCZvlgSpQ+U6soHDuEFbhwKfE2FVIFb8jpxG82oLkZABodjvjqlIo3Kf
 dJ6LkCSZX+HS15BeEnj6Lx+m+vQ69a5KPyVuGSR93/w3YpGFRMPpMT8VdRuwsPeyh+oMiQ
 VJqkplA9qCEdduOh51Q2oxdmy2QUDCw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-W10f11iOMQCrbaTkcNeR0w-1; Thu, 02 Jan 2020 09:42:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55242800A02;
 Thu,  2 Jan 2020 14:42:03 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BFAE5C28D;
 Thu,  2 Jan 2020 14:41:59 +0000 (UTC)
Date: Thu, 2 Jan 2020 15:41:58 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 43/86] hppa: drop RAM size fixup
Message-ID: <20200102154158.460b2da6@redhat.com>
In-Reply-To: <8cb7bd0f-7841-7e60-8de6-708515b81b00@gmx.de>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-44-git-send-email-imammedo@redhat.com>
 <bc7bac60-0d20-d0e3-b9ac-2c9ff62c2c15@redhat.com>
 <8cb7bd0f-7841-7e60-8de6-708515b81b00@gmx.de>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: W10f11iOMQCrbaTkcNeR0w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

On Thu, 2 Jan 2020 12:31:58 +0100
Helge Deller <deller@gmx.de> wrote:

> On 31.12.19 16:44, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 12/31/19 2:03 PM, Igor Mammedov wrote: =20
> >> If user provided non-sense RAM size, board will complain and
> >> continue running with max RAM size supported.
> >> Also RAM is going to be allocated by generic code, so it won't be
> >> possible for board to fix things up for user.
> >>
> >> Make it error message and exit to force user fix CLI,
> >> instead of accepting non-sense CLI values.
> >>
> >> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >> ---
> >> =C2=A0 hw/hppa/machine.c | 3 ++-
> >> =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> >> index 5d0de26..25f5afc 100644
> >> --- a/hw/hppa/machine.c
> >> +++ b/hw/hppa/machine.c
> >> @@ -92,7 +92,8 @@ static void machine_hppa_init(MachineState *machine)
> >> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Limit main memory. */
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ram_size > FIRMWARE_START) {
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine->ram_size =3D ram_=
size =3D FIRMWARE_START;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("RAM size mor=
e than %d is not supported", FIRMWARE_START);
> >> +        exit(EXIT_FAILURE); =20
> >
> > $ qemu-system-hppa -m 3841m
> > qemu-system-hppa: invalid accelerator kvm
> > qemu-system-hppa: falling back to tcg
> > qemu-system-hppa: RAM size more than -268435456 is not supported
> >
> > Instead of using qemu_strtosz_MiB on FIRMWARE_START or unsigned format,=
 we can simply use "RAM size more than 3840m is not supported". Is that OK =
with you? =20
>=20
> I don't really like that change.
>=20
> We currently only emulate a 32-bit system, and for those 4GB is the maxim=
um.
> So, if I start my machine with "qemu-system-hppa -m 4G", the current code
> then automatically uses the maximum possible of 3841MB (which is limited =
by
> firmware start address).
> I don't expect users to know the excact 3841MB number.
It's annoying to see a error where it used to work before
with no matter what -m value user have used.

But error message tells exact max size one could use,
so user doesn't have to know max, just fix CLI with provided value.

> Even on a phyiscal machine you can only add DIMMs of sizes 2GB, 3GB or 4G=
B,
> but not "3841MB".
>=20
> So, I think that patch is - although it's more correct - not a
> benefit for the end user.
Sure thing that users dislike when we do breaking changes (removing legacy =
CLI
options, fixups or adding error checks that weren't there before).
But I'd choose correctness (and consistent codebase) vs convenience.
(it's no like we are hiding max from user)


> Helge
>=20



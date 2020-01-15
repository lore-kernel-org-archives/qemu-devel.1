Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861E0C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA5F214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA5F214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irnJ9-0005Sq-0m
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 13:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1irnGV-0002Zl-Fa
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:19:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1irnGU-0005ah-4U
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:19:39 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:63952)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1irnGT-0005a8-UO
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:19:38 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id ADE7E7482D3;
 Wed, 15 Jan 2020 19:19:36 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8C1CE7482D2; Wed, 15 Jan 2020 19:19:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8AC747482D0;
 Wed, 15 Jan 2020 19:19:36 +0100 (CET)
Date: Wed, 15 Jan 2020 19:19:36 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 53/86] mips:mips_fulong2e: drop RAM size fixup
In-Reply-To: <1579100861-73692-54-git-send-email-imammedo@redhat.com>
Message-ID: <alpine.BSF.2.21.99999.352.2001151916040.24151@zero.eik.bme.hu>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-54-git-send-email-imammedo@redhat.com>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-728709106-1579112376=:24151"
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: amarkovic@wavecomp.com, aleksandar.rikalo@rt-rk.com, philmd@redhat.com,
 qemu-devel@nongnu.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-728709106-1579112376=:24151
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jan 2020, Igor Mammedov wrote:
> If user provided non-sense RAM size, board will complain and
> continue running with max RAM size supported.
> Also RAM is going to be allocated by generic code, so it won't be
> possible for board to fix things up for user.
>
> Make it error message and exit to force user fix CLI,
> instead of accepting non-sense CLI values.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
> * fix format string cousing build failure on 32-bit host
>   (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
>
> CC: philmd@redhat.com
> CC: amarkovic@wavecomp.com
> CC: aurelien@aurel32.net
> CC: aleksandar.rikalo@rt-rk.com
> ---
> hw/mips/mips_fulong2e.c | 13 ++++++++-----
> 1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 9eaa6e2..7e7dcd6 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -296,7 +296,6 @@ static void mips_fulong2e_init(MachineState *machin=
e)
>     MemoryRegion *address_space_mem =3D get_system_memory();
>     MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>     MemoryRegion *bios =3D g_new(MemoryRegion, 1);
> -    ram_addr_t ram_size =3D machine->ram_size;
>     long bios_size;
>     uint8_t *spd_data;
>     Error *err =3D NULL;
> @@ -315,10 +314,14 @@ static void mips_fulong2e_init(MachineState *mach=
ine)
>     qemu_register_reset(main_cpu_reset, cpu);
>
>     /* TODO: support more than 256M RAM as highmem */
> -    ram_size =3D 256 * MiB;
> +    if (machine->ram_size !=3D 256 * MiB) {
> +        error_report("Invalid RAM size, should be %" PRIu64, 256 * MiB=
);

Should this just print 256M without any format string or print it in MiB=20
instead of bytes like for mips_r4k (considering that default for -m optio=
n=20
is value as postfixed by M so it makes more sense for the user to print=20
that what they can easily specify in the option).

Regards,
BALATON Zoltan
--3866299591-728709106-1579112376=:24151--


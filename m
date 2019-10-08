Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CF1C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9612070B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9612070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHpvD-0000dq-6M
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 09:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iHpuX-0000CM-FT
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iHpuU-0001No-IY
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:52:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53008)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>)
 id 1iHpuU-0001Mq-Cb; Tue, 08 Oct 2019 09:52:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 19B07308C383;
 Tue,  8 Oct 2019 13:52:17 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF85260606;
 Tue,  8 Oct 2019 13:52:10 +0000 (UTC)
Date: Tue, 8 Oct 2019 15:52:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH 0/3] eliminate remaining places that abuse
 memory_region_allocate_system_memory()
Message-ID: <20191008155208.59b22535@redhat.com>
In-Reply-To: <3b7466af-2c05-f47e-f218-30a8b5ed5663@redhat.com>
References: <20191008113318.7012-1-imammedo@redhat.com>
 <3b7466af-2c05-f47e-f218-30a8b5ed5663@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 08 Oct 2019 13:52:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: deller@gmx.de, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, hpoussin@reactos.org, david@gibson.dropbear.id.au,
 atar4qemu@gmail.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 8 Oct 2019 14:41:25 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Hi Igor,
>=20
> On 10/8/19 1:33 PM, Igor Mammedov wrote:
> > Series cleans up remaining boards that call memory_region_allocate_syst=
em_memory()
> > multiple times, violating interface contract (the function should be ca=
lled only
> > once).
> >=20
> > With that cleaned up, it should be possible to switch from adhoc RAM al=
location
> > in memory_region_allocate_system_memory()->allocate_system_memory_nonnu=
ma() to
> > memory-backend based allocation, remaining roadblock for doing it is de=
precated
> > -mem-path fallback to RAM allocation, which is scheduled for removal at=
 4.3
> > merge window. So remaining patches to consolidate system RAM allocation=
 around
> > memory-backends and aliasing -mem-path/mem-prealloc to it are postponed=
 till
> > then. =20
>=20
> How do we protect the codebase for new boards to not make the same mistak=
e?
>=20
> What about some code like this snippet (or nicer, but since this is a=20
> developer error, and assert is enough IMO):
probably it's not worth effort (it's not too long till 4.2 softfreeze).

Like cover letter say, I'm planing to finish refactoring of
memory_region_allocate_system_memory() and I hope this function
will be gone during 4.3 and most boards will only need to map
pre-created (by common code) memory-backend wherever they used to
map RAM memory region.

> -- >8 -- =20
>=20
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 4dfec5c95b..a487677672 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -484,6 +484,11 @@ static void=20
> allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
>                                              const char *name,
>                                              uint64_t ram_size)
>   {
> +    static bool nonnuma_system_memory_allocated;
> +
> +    g_assert(!nonnuma_system_memory_allocated);
> +    nonnuma_system_memory_allocated =3D true;
> +
>       if (mem_path) {
>   #ifdef __linux__
>           Error *err =3D NULL;
> ---
>=20
> $ hppa-softmmu/qemu-system-hppa
> **
> ERROR:/home/phil/source/qemu/hw/core/numa.c:489:allocate_system_memory_no=
nnuma:=20
> assertion failed: (!nonnuma_system_memory_allocated)
> Aborted (core dumped)



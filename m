Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C933C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:59:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9394820818
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9394820818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36198 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvmN-0000Q3-Gl
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:59:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEvOv-0003a6-Rb
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:35:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEvOu-0001OQ-T2
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:35:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hEvOo-0001Gj-Tv; Fri, 12 Apr 2019 08:35:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 38945308CEB2;
	Fri, 12 Apr 2019 12:35:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E01C2CFAA;
	Fri, 12 Apr 2019 12:35:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 133161138648; Fri, 12 Apr 2019 14:35:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190411135602.21725-1-armbru@redhat.com>
	<20190411135602.21725-3-armbru@redhat.com>
	<95f2e6d2-5bd0-a9dc-ab4b-dc172e7f1ad1@redhat.com>
Date: Fri, 12 Apr 2019 14:35:12 +0200
In-Reply-To: <95f2e6d2-5bd0-a9dc-ab4b-dc172e7f1ad1@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu,
	11 Apr 2019 16:35:13 +0200")
Message-ID: <87mukvo0zj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Fri, 12 Apr 2019 12:35:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/arm/virt: Support firmware
 configuration with -blockdev
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-block@nongnu.org,
	qemu-devel@nongnu.org, mreitz@redhat.com, qemu-arm@nongnu.org,
	lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412123512.SOrQB23alk3Ng66koxoteR9Do_O90uH1GFHRJ5OZaZ4@z>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 4/11/19 3:56 PM, Markus Armbruster wrote:
>> The ARM virt machines put firmware in flash memory.  To configure it,
>> you use -drive if=3Dpflash,unit=3D0,... and optionally -drive
>> if=3Dpflash,unit=3D1,...
>>=20
>> Why two -drive?  This permits setting up one part of the flash memory
>> read-only, and the other part read/write.  It also makes upgrading
>> firmware on the host easier.  Below the hood, we get two separate
>> flash devices, because we were too lazy to improve our flash device
>> models to support sector protection.
>>=20
>> The problem at hand is to do the same with -blockdev somehow, as one
>> more step towards deprecating -drive.
>>=20
>> We recently solved this problem for x86 PC machines, in commit
>> ebc29e1beab.  See the commit message for design rationale.
>>=20
>> This commit solves it for ARM virt basically the same way: new machine
>> properties pflash0, pflash1 forward to the onboard flash devices'
>> properties.  Requires creating the onboard devices in the
>> .instance_init() method virt_instance_init().  The existing code to
>> pick up drives defined with -drive if=3Dpflash is replaced by code to
>> desugar into the machine properties.
>>=20
>> There are a few behavioral differences, though:
>>=20
>> * The flash devices are always present (x86: only present if
>>   configured)
>>=20
>> * Flash base addresses and sizes are fixed (x86: sizes depend on
>>   images, mapped back to back below a fixed address)
>>=20
>> * -bios configures contents of first pflash (x86: -bios configures ROM
>>    contents)
>>=20
>> * -bios is rejected when first pflash is also configured with -machine
>>    pflash0=3D... (x86: bios is silently ignored then)
>
> Can we start deprecating the -bios command line option?
>
> Maybe on a per-architecture basis first.

I have no idea.

Perhaps we want to keep it as syntactic sugar for convenience.  Right
now it's something else: an ugly special case.

Of course, the name -bios is a bit PC-centric.  And even there it makes
less sense than it used to.

[...]


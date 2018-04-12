Received: from eggs.gnu.org ([2001:4830:134:3::10]:53752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f6cU4-0002Mt-V5
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 09:41:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f6cU1-0006dj-QK
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 09:41:52 -0400
Received: from 4.mo4.mail-out.ovh.net ([178.32.98.131]:53043)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f6cU1-0006b0-Hb
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 09:41:49 -0400
Received: from player773.ha.ovh.net (unknown [10.109.105.37])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id EE65516635A
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 15:41:46 +0200 (CEST)
References: <20180412101858.21304-1-clg@kaod.org>
	<CAFEAcA8wJCSwtpypvH+3HKvv39o9bPC1vXJ_Co4VwiZTOt78ZA@mail.gmail.com>
	<20180412115326.GF2704@work-vm>
	<CAFEAcA9-LzsfBpnYJUVc7j6j4ePUyiQYqGv3EaGjvAgw-3nyKw@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3432d654-c562-505e-e341-afe9d8fdf6cb@kaod.org>
Date: Thu, 12 Apr 2018 15:41:30 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9-LzsfBpnYJUVc7j6j4ePUyiQYqGv3EaGjvAgw-3nyKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: discard RAMBlocks of type
 ram_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Yulei Zhang <yulei.zhang@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, Kirti Wankhede <kwankhede@nvidia.com>, zhi.a.wang@intel.com, Eric Blake <eblake@redhat.com>

On 04/12/2018 02:08 PM, Peter Maydell wrote:
> On 12 April 2018 at 12:53, Dr. David Alan Gilbert <dgilbert@redhat.com>=
 wrote:
>> * Peter Maydell (peter.maydell@linaro.org) wrote:
>>> David suggested on IRC that we would want a flag on the ramblock
>>> for "not migratable", because there are other uses for "don't
>>> migrate this" than just "is this a ram device".
>>
>> My original suggestion to your series was with a flag, but I'd forgott=
en
>> about that by the time I'd made the suggestion to C=C3=A9dric.
>> In your case would just adding an extra term to the
>> ram_block_is_migratable function work, or do you really need a flag?
>=20
> I don't see how else you would identify the ram block that needs
> to be skipped. Also I think it's just better design to decouple
> the decision about "should we migrate this ram block" from the
> migration code itself, and push it up to the code layer that knows
> it's creating ram blocks that shouldn't be migrated.

Do you mean adding a new RAMBlock flag RAM_NON_MIGRATABLE=20
in exec.c ? That would require to add an extra bool to the=20
following functions :

	memory_region_init_ram_ptr()
	qemu_ram_alloc_from_ptr()
	qemu_ram_alloc_internal()

Would that be ok ?=20

Thanks,

C.=20

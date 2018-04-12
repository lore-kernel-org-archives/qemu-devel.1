Received: from eggs.gnu.org ([2001:4830:134:3::10]:51463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6b2I-0005tc-MW
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:09:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6b2H-0005iZ-PZ
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:09:06 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:40053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6b2H-0005iP-Ko
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:09:05 -0400
Received: by mail-oi0-x236.google.com with SMTP id x9-v6so4882198oig.7
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 05:09:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180412115326.GF2704@work-vm>
References: <20180412101858.21304-1-clg@kaod.org>
	<CAFEAcA8wJCSwtpypvH+3HKvv39o9bPC1vXJ_Co4VwiZTOt78ZA@mail.gmail.com>
	<20180412115326.GF2704@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Apr 2018 13:08:44 +0100
Message-ID: <CAFEAcA9-LzsfBpnYJUVc7j6j4ePUyiQYqGv3EaGjvAgw-3nyKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Yulei Zhang <yulei.zhang@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, Kirti Wankhede <kwankhede@nvidia.com>, zhi.a.wang@intel.com, Eric Blake <eblake@redhat.com>

On 12 April 2018 at 12:53, Dr. David Alan Gilbert <dgilbert@redhat.com> wro=
te:
> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> David suggested on IRC that we would want a flag on the ramblock
>> for "not migratable", because there are other uses for "don't
>> migrate this" than just "is this a ram device".
>
> My original suggestion to your series was with a flag, but I'd forgotten
> about that by the time I'd made the suggestion to C=C3=A9dric.
> In your case would just adding an extra term to the
> ram_block_is_migratable function work, or do you really need a flag?

I don't see how else you would identify the ram block that needs
to be skipped. Also I think it's just better design to decouple
the decision about "should we migrate this ram block" from the
migration code itself, and push it up to the code layer that knows
it's creating ram blocks that shouldn't be migrated.

thanks
-- PMM

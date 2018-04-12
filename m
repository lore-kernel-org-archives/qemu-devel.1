Received: from eggs.gnu.org ([2001:4830:134:3::10]:45757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6Y8c-0008Ut-AI
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6Y8Y-0005Ak-E1
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:03:26 -0400
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:41025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6Y8Y-00059Q-8j
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:03:22 -0400
Received: by mail-ot0-x229.google.com with SMTP id m22-v6so5156384otf.8
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 02:03:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b7df24c5-311d-41b1-6304-a52ef8c28732@kaod.org>
References: <20180411172014.24711-1-clg@kaod.org>
	<20180411192136.GL2667@work-vm>
	<b7df24c5-311d-41b1-6304-a52ef8c28732@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Apr 2018 10:03:00 +0100
Message-ID: <CAFEAcA-20krHUG9XreYz+EcxB4WWcn5CqrxxP-AKYrMmRDg_hA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] migration: discard RAMBlocks of type
 ram_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jiangshanlai@gmail.com, Alex Williamson <alex.williamson@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>

On 12 April 2018 at 08:02, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 04/11/2018 09:21 PM, Dr. David Alan Gilbert wrote:
>> Interestingly, your patch comes less than 2 weeks after Lai Jiangshan's
>>  'add capability to bypass the shared memory'
>>    https://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg07511.htm=
l
>
> I missed that.
>
>> which is the only other case I think we've got of someone trying to
>> avoid transmitting a block.
>>
>> We should try and merge the two sets to make them consistent; you've
>> covered some more cases (the other patch wasn't expected to work with
>> Postcopy anyway).
>> (At this rate then we can expect another 20 for the year....)
>>
>> We should probably have:
>>    1) A     bool is_migratable_block(RAMBlock *)
>>    2) A RAMBLOCK_FOREACH_MIGRATABLE(block)  macro that is like
>> RAMBLOCK_FOREACH but does the call to is_migratable_block
>>
>> then the changes should be mostly pretty tidy.

We also want this so we can enable migration when the
"mmio-exec" feature is being used without accidentally
trying to migrate the ramblock used for execute-from-device:
 http://lists.gnu.org/archive/html/qemu-devel/2017-07/msg05237.html

thanks
-- PMM

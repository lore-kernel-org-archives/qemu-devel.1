Received: from eggs.gnu.org ([2001:4830:134:3::10]:33389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fBy6d-00045T-Pu
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fBy6a-00011K-Nj
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:47:47 -0400
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:55030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fBy6a-00010k-Gd
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 03:47:44 -0400
Received: from player697.ha.ovh.net (unknown [10.109.122.92])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id B358EAC910
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 09:47:42 +0200 (CEST)
References: <CAJhGHyAMGjZe+QR3BQtA1cVxkz=isQbx6kWjNR6fa5LmW3rQUg@mail.gmail.com>
	<20180416150011.55916-1-jiangshanlai@gmail.com>
	<20180419163852.GE2730@work-vm>
	<CAJhGHyDqj32nKZq--aho5OTZSYr0N6r0d-5WWtpgacACWMWLBQ@mail.gmail.com>
	<20180426190523.GR2631@work-vm>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7ff588d8-c9a0-b608-357a-8b8cc02407e3@kaod.org>
Date: Fri, 27 Apr 2018 09:47:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180426190523.GR2631@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V5] migration: add capability to bypass the
 shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, "James O . D . Hunt" <james.o.hunt@intel.com>, Xu Wang <gnawux@gmail.com>, Peng Tao <bergwolf@gmail.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-devel@nongnu.org

On 04/26/2018 09:05 PM, Dr. David Alan Gilbert wrote:
>>> Can you please rework this to combine with C=C3=A9dric Le Goater's
>>> 'discard non-migratable RAMBlocks' - it's quite similar to what you'r=
e
>>> trying to do but for a different reason;  If you look at the v2 from
>>> April 13, I think you can  just find somewhere to clear the
>>> RAM_MIGRATABLE flag.
>> Hello Dave:
>>
>> It seems we need to add new qmp/hmp command to clear/add
>> RAM_MIGRATABLE flag which is overkill for such a simple feature.
>> Please point out if there is any simple way to do so.
> I'm fine with you still using a capability to enable/disable it - I
> think that part of your patch is fine;  but then I think you just
> need to check that capability somewhere in Cedric's code; perhaps in hi=
s
> qemu_ram_is_migratable?
>=20

I have a v3 for this patch but it only adds an error_report(). Working
on the v2 should be fine.

Thanks,

C.

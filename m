Received: from eggs.gnu.org ([2001:4830:134:3::10]:60174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1d1EYC-0004lX-6w
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashmit602@gmail.com>) id 1d1EYA-0003wn-VL
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:03:20 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:35226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashmit602@gmail.com>) id 1d1EYA-0003wS-Pd
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:03:18 -0400
Received: by mail-io0-x242.google.com with SMTP id d203so17942702iof.2
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 09:03:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170420150339.GH15762@localhost.localdomain>
References: <1491277689-24949-1-git-send-email-Ashish.Mittal@veritas.com>
	<20170420150339.GH15762@localhost.localdomain>
From: ashish mittal <ashmit602@gmail.com>
Date: Thu, 20 Apr 2017 09:03:16 -0700
Message-ID: <CAAo6VWM4dQejaZPK+MttASTD2S7=GNWcO5R59xifme-HokWHdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v11 0/2] block/vxhs.c: Add support for a
 new block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <ashish.mittal@veritas.com>, Stefan Hajnoczi <stefanha@gmail.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, John Ferlan <jferlan@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Peter Maydell <peter.maydell@linaro.org>, "Venkatesha M.G." <venkatesha.mg@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>, Eric Blake <eblake@redhat.com>, Abhijit Dey <Abhijit.Dey@veritas.com>

Thanks Jeff!

On Thu, Apr 20, 2017 at 8:03 AM, Jeff Cody <jcody@redhat.com> wrote:
> On Mon, Apr 03, 2017 at 08:48:07PM -0700, Ashish Mittal wrote:
>> - Veritas HyperScale block driver in QEMU is designed to provide an accelerated
>>   IO path from KVM virtual machines to Veritas HyperScale storage service.
>>
>> - A network IO transfer library that translates block IO from HyperScale block
>>   driver to a network IO format to send it to Veritas HyperScale storage
>>   service. This library (libvxhs) has been open sourced and is available on
>>   github here:  https://github.com/VeritasHyperScale/libqnio.git
>>
>> Ashish Mittal (2):
>>   block/vxhs.c: Add support for a new block device type called "vxhs"
>>   block/vxhs.c: Add qemu-iotests for new block device type "vxhs"
>>
>>  block/Makefile.objs              |   2 +
>>  block/trace-events               |  17 ++
>>  block/vxhs.c                     | 575 +++++++++++++++++++++++++++++++++++++++
>>  configure                        |  39 +++
>>  qapi/block-core.json             |  23 +-
>>  tests/qemu-iotests/common        |   6 +
>>  tests/qemu-iotests/common.config |  13 +
>>  tests/qemu-iotests/common.filter |   1 +
>>  tests/qemu-iotests/common.rc     |  19 ++
>>  9 files changed, 693 insertions(+), 2 deletions(-)
>>  create mode 100644 block/vxhs.c
>>
>> --
>> 2.5.5
>>
>
> Thanks,
>
> Applied to my block branch:
>
> git://github.com/codyprime/qemu-kvm-jtc block
>
> -Jeff

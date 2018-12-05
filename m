Received: from eggs.gnu.org ([2001:4830:134:3::10]:56127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gUSp8-0002HA-Vn
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 03:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gUSp8-0003B6-Al
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 03:46:26 -0500
Date: Wed, 5 Dec 2018 09:46:14 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181205084614.GA4018@dhcp-200-186.str.redhat.com>
References: <20181203165810.14509-1-kwolf@redhat.com>
	<20181203165810.14509-3-kwolf@redhat.com>
	<dc86835f-65d9-cada-dc9b-1f2c708521f9@de.ibm.com>
	<75f7e3cc-bd46-c743-84ab-cd68bcb1dcfb@de.ibm.com>
	<d0966d94-87d4-0f25-f2e0-846a1d338be7@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0966d94-87d4-0f25-f2e0-846a1d338be7@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PULL 2/2] iotests: simple mirror
 test with kvm on 1G image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-block@nongnu.org, peter.maydell@linaro.org, qemu-s390x <qemu-s390x@nongnu.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

Am 05.12.2018 um 09:23 hat Christian Borntraeger geschrieben:
> >>> +# prepare source image
> >>> +qemu_img_create('-f', iotests.imgfmt, '-o', 'preallocation=metadata', disk,
> >>> +                str(size))
> >>> +
> >>> +vm = QEMUMachine(iotests.qemu_prog)
> >>> +vm.add_args('-machine', 'pc,accel=kvm')
> 
> This (pc) clearly does not work on other architectures.
> In addition to that, I also need to add -no-shutdown on s390 (see 068 for a similar case)

Leaving out pc definitely makes sense, and the bug still reproduces for
me without it.

I don't understand the -no-shutdown, though. Already for 068, neither
the code nor the commit message when it was added explain why this is
needed.

Can you turn this into a proper patch and add a comment why -no-shutdown
is needed?

Kevin

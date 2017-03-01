Received: from eggs.gnu.org ([2001:4830:134:3::10]:51545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cj71f-0000n0-DU
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:22:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cj71c-0008Us-Pk
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:22:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cj71c-0008UW-KR
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:22:48 -0500
Date: Wed, 1 Mar 2017 18:22:45 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170301181146-mutt-send-email-mst@kernel.org>
References: <575E92DB.3080904@linux.vnet.ibm.com>
	<20160615193019.GB7300@work-vm>
	<5761C092.5070702@linux.vnet.ibm.com>
	<20160616080520.GA2249@work-vm> <20160616082517.GC11426@redhat.com>
	<5075d390-a1d1-b707-6b57-deb0154c2e37@linux.vnet.ibm.com>
	<20170301125414.GD10160@redhat.com>
	<OF00CA88E0.A7212243-ON002580D6.00498E3C-852580D6.0049CA7A@notes.na.collabserv.com>
	<CAJ+F1C+h7iyCSxE6p91NtEoTZSLtLBuF53=6yuWH+n-tBdV5=A@mail.gmail.com>
	<05b271a3-4bf9-729b-d662-c9886951f26d@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05b271a3-4bf9-729b-d662-c9886951f26d@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/4] Provide support for the CUSE TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Stefan Berger <stefanb@us.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "hagen.lauer@huawei.com" <hagen.lauer@huawei.com>, "Xu, Quan" <quan.xu@intel.com>, "silviu.vlasceanu@gmail.com" <silviu.vlasceanu@gmail.com>, "SERBAN, CRISTINA" <cs1731@att.com>, "SHIH, CHING C" <cs1815@att.com>

On Wed, Mar 01, 2017 at 09:50:38AM -0500, Stefan Berger wrote:
> I had already proposed a linked-in version before I went to the out-of-process
> design. Anthony's concerns back then were related to the code not being trusted
> and a segfault in the code could bring down all of QEMU. That we have test
> suites running over it didn't work as an argument. Some of the test suite are
> private, though.

Given how bad the alternative is maybe we should go back to that one.
Same argument can be made for any device and we aren't making
them out of process right now.

IIMO it's less the in-process question (modularization
of QEMU has been on the agenda since years and I don't
think anyone is against it) it's more a code control/community question.

It doesn't look like userspace swtpm bits have a large community of
developers around it, and the only user appears to be QEMU, so depending
on that externally does not make sense, we should just have them
in-tree. This way we don't need to worry about versioning etc.

-- 
MST

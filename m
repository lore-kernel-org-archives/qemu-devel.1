Received: from eggs.gnu.org ([2001:4830:134:3::10]:33905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eMppb-0007Vv-V4
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 01:38:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eMppX-0000Uo-1c
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 01:38:51 -0500
References: <20171108165422.46267-1-pasic@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2ada83cf-1eb6-87c0-7597-13dc11ab09c0@redhat.com>
Date: Thu, 7 Dec 2017 07:38:39 +0100
MIME-Version: 1.0
In-Reply-To: <20171108165422.46267-1-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [RFC PATCH v2 0/3] tests for CCW IDA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: qemu-s390x@nongnu.org, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>

On 08.11.2017 17:54, Halil Pasic wrote:
> I've keept the title althogh the scope shifted a bit: it's
> more about introducing ccw-testdev than about IDA. The goal
> is to facilitate testing the virtual channel subsystem
> implementation, and the ccw interpretation.
> 
> The first patch is the interesting one. See it's cover letter
> for details. The RFC is about discussing some technical issues
> with this patch.
> 
> The other two patches are an out of source kernel module which
> is basically only there so you can try out the first patch. The
> tests there should probably be ported to something else. I don't
> know what: maybe kvm-unit-tests, maybe qtest+libqos, or maybe some
> bios based test image. We still have to figure out that. 

I think both, kvm-unit-tests or qtest+libqos would be good candidates.
Please don't invent a new bios base test image, since kvm-unit-tests
should be very similar already and we really don't need to duplicate
work here.

Anyway, you'd need to add some CSS infracture there first (in both
kvm-unit-tests and the qtest environments), so it's likely a similar
amount of work. qtest has the advantage that it gets checked
automatically during "make check" each time, so I'd have a weak
preference for that one.

 Thomas

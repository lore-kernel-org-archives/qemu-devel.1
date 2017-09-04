Received: from eggs.gnu.org ([2001:4830:134:3::10]:39785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dorkg-0006Ai-6F
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:49:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dorkb-00012S-7p
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:49:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dorkb-00011b-1i
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:49:17 -0400
Date: Mon, 4 Sep 2017 15:49:02 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170904154902.5a9c5927.cohuck@redhat.com>
In-Reply-To: <f19573ba-30c2-2c2b-5f05-8d9372fec583@redhat.com>
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
	<1502951113-4246-4-git-send-email-thuth@redhat.com>
	<f19573ba-30c2-2c2b-5f05-8d9372fec583@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/6] tests: Enable the drive_del test also
 on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Fan Zhang <zhangfan@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Marc Mari <markmb@redhat.com>, Michael S Tsirkin <mst@redhat.com>

On Wed, 30 Aug 2017 17:41:01 -0400
Cleber Rosa <crosa@redhat.com> wrote:

> On 08/17/2017 02:25 AM, Thomas Huth wrote:
> > By using the "virtio-xxx" device name aliases instead of the
> > "virtio-xxx-pci" names, we can use this test on s390x, too,
> > to check that adding and deleting also works fine with the
> > virtio-ccw bus.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  tests/Makefile.include |  1 +
> >  tests/drive_del-test.c | 13 +++++++------
> >  2 files changed, 8 insertions(+), 6 deletions(-)

(...)

> I honestly can't comment on the device to be used on this test (as
> others have commented).  Putting that aside, and given the fact  that I
> went through the lengths of testing it on the s390x target:
> 
> Tested-by: Cleber Rosa <crosa@redhat.com>

Do you want to test v2 of this patch as well? There's still time to add
your tag :)

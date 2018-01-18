Received: from eggs.gnu.org ([2001:4830:134:3::10]:51476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ecA2i-0005W4-Lw
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ecA2d-0003E4-Ke
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 08:15:44 -0500
Date: Thu, 18 Jan 2018 14:15:30 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180118141530.17faabd1.cohuck@redhat.com>
In-Reply-To: <06e97f00-710a-c893-101f-0a1c6aaa5575@de.ibm.com>
References: <20180118085628.40798-1-borntraeger@de.ibm.com>
	<20180118125322.252929dc.cohuck@redhat.com>
	<06e97f00-710a-c893-101f-0a1c6aaa5575@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] s390x/kvm: implement new
 hardware/firmware features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

On Thu, 18 Jan 2018 13:47:54 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Have the x86 features been marked as stable? If the answer is yes,
> shall we mark these patches for stable as well?

Doesn't look like it.

TBH, I'm not quite sure whether this should go into stable as I'm a bit
unclear what our use case for stable is. It seems to be mostly "don't
let people run into known crashes" or something like that.

These patches are not very useful on their own unless you run on a z
with updated microcode and an updated host kernel. OTOH, the patches
should be low risk.

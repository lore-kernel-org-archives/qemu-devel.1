Received: from eggs.gnu.org ([2001:4830:134:3::10]:53308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dPtln-0007wp-Ic
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dPsU5-0005or-6w
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:33:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dPsU5-0005iE-0k
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:32:57 -0400
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
	<1498564100-10045-2-git-send-email-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9526df82-1ad5-8947-0643-7c99e215ed5a@redhat.com>
Date: Tue, 27 Jun 2017 17:32:52 +0200
MIME-Version: 1.0
In-Reply-To: <1498564100-10045-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 01/14] pc-bios/s390-ccw: Add the libc
 from the SLOF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, Jens Freimann <jfreiman@redhat.com>, Eric Farman <farman@linux.vnet.ibm.com>

On 27.06.2017 13:48, Thomas Huth wrote:
> To be able to use some more advanced libc functions in the s390-ccw
> firmware, like printf() and malloc(), we need a better libc here.
> This patch adds the C library from the SLOF firmware (taken from
> the SLOF commit ID 62674aabe20612a9786fa03e87cf6916ba97a99a). The
> files are copied without modifications here and will be adapted for
> the s390-ccw firmware by the next patch. I just removed the getopt()
> and scanf()-like functions from the libc since we likely do not need
> them in the s390-ccw firmware.
> 

We have SLOF as a git submodule in roms/SLOF.

I wonder if there would a way to avoid duplicating files.

E.g. build s390x-ccw.img only if roms/SLOF is checked out and link/copy
the right folder.

Then, also the question regarding coding style is gone.

Would something like that work?


-- 

Thanks,

David

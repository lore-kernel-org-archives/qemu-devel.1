Received: from eggs.gnu.org ([2001:4830:134:3::10]:50634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkqwW-00005k-7C
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkqwR-0004Zu-64
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:09:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dkqwQ-0004ZU-WB
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:08:55 -0400
Date: Thu, 24 Aug 2017 14:08:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170824140848.52ea0c2a.cohuck@redhat.com>
In-Reply-To: <7ff28ad9-d2be-6bab-09a8-cbc3bd6ed003@redhat.com>
References: <20170818114353.13455-1-david@redhat.com>
	<20170818114353.13455-9-david@redhat.com>
	<dc191b37-68f4-dc69-dfce-7a64437ba74d@redhat.com>
	<7ff28ad9-d2be-6bab-09a8-cbc3bd6ed003@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11 08/18] target/s390x: move
 gtod_*() declarations to s390-virtio.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, borntraeger@de.ibm.com, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>

On Fri, 18 Aug 2017 19:28:31 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 18.08.2017 18:11, Thomas Huth wrote:
> > Suggesting to add a patch description like: "The functions are not used
> > in target/s390x/ so a header in hw/s390x/ is a better place" ?  
> 
> Sure, I will include that, thanks!

No worries, I'm including that on applying.

> 
> > 
> > On 18.08.2017 13:43, David Hildenbrand wrote:  
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  hw/s390x/s390-virtio.h | 2 ++
> >>  target/s390x/cpu.h     | 3 ---
> >>  2 files changed, 2 insertions(+), 3 deletions(-)  
> > 
> > Anyway:
> > 
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> >   
> 
> 

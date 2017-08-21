Received: from eggs.gnu.org ([2001:4830:134:3::10]:48739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1djjOO-0007RH-8R
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1djjOL-0003cM-6a
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:53:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1djjOK-0003by-W8
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 05:53:05 -0400
Date: Mon, 21 Aug 2017 11:52:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170821115258.4f94ff12.cohuck@redhat.com>
In-Reply-To: <2b685ad1-fc58-e68d-51ee-32128b5b1555@redhat.com>
References: <20170818114353.13455-1-david@redhat.com>
	<20170818114353.13455-8-david@redhat.com>
	<65be761f-752a-d63c-8654-d333bfb4bd08@redhat.com>
	<2b685ad1-fc58-e68d-51ee-32128b5b1555@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11 07/18] s390x: drop inclusion of
 sysemu/kvm.h from some files
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

On Fri, 18 Aug 2017 19:28:34 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 18.08.2017 18:08, Thomas Huth wrote:
> > On 18.08.2017 13:43, David Hildenbrand wrote:  
> >> s390-stattrib.c needs definition of TARGET_PAGE_SIZE, solve it via cpu.h.  
> > 
> > Why not simply #include "exec/cpu-all.h" ? If cpu.h is not really needed
> > here...
> > 
> >  Thomas
> > 
> >   
> 
> Git grep showed me that this is a very rare thing to do, so I went for
> cpu.h. If you prefer cpu-all.h, I can use that.

Is there any target that does not include cpu-all.h in its cpu.h? We
probably can remove all includes of cpu-all.h in .c files, as all of
them include cpu.h as well...

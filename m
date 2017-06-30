Received: from eggs.gnu.org ([2001:4830:134:3::10]:45169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQu45-0003gb-Ui
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQu41-0008Qy-W9
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:26:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQu41-0008QB-Q2
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:26:17 -0400
Date: Fri, 30 Jun 2017 12:26:10 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170630112610.GA2437@work-vm>
References: <CAGKXQyfO-yu3qZf7RHiUPXQZDSZwn6N_48Ji8adPHozkpK9JBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGKXQyfO-yu3qZf7RHiUPXQZDSZwn6N_48Ji8adPHozkpK9JBQ@mail.gmail.com>
Subject: Re: [Qemu-devel] DIRTY_MEMORY_BLOCK_SIZE;
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ali saeedi <ali.saeedi56@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

* ali saeedi (ali.saeedi56@gmail.com) wrote:
> Hello
> what does 'DIRTY_MEMORY_BLOCK_SIZE' mean?
> is it the number of words in a block? or number of pages in a block? or
> number of bytes in a block?
> thanks a lot

(cc'ing Stefan)
I think that DIRTY_MEMORY_BLOCK_SIZE is the number of TARGET_PAGEs
within one DIRTY_MEMORY_BLOCK
So with the common 4k target page that's 4k*256k*8=8GB/dirty memory
block - note these are just the size of structure sin qemu, it's still
got the ranularity ot mark individual target pages as dirty.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

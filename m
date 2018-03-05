Received: from eggs.gnu.org ([2001:4830:134:3::10]:33053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eslTu-0000BP-LM
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:28:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eslTq-0008HP-Jc
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:28:26 -0500
Date: Mon, 5 Mar 2018 09:28:18 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180305092818.0daf58ee.cohuck@redhat.com>
In-Reply-To: <255a75ec-5603-3438-cdef-a6784eb5464c@de.ibm.com>
References: <20180304134548.19498-1-nia.alarie@gmail.com>
	<255a75ec-5603-3438-cdef-a6784eb5464c@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/sclpconsole: Remove dead code - make
 _error functions void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Nia Alarie <nia.alarie@gmail.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, stefanha@gmail.com, jim@groklearning.com, joel@jms.id.au

On Mon, 5 Mar 2018 09:07:17 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 03/04/2018 02:45 PM, Nia Alarie wrote:
> > These functions always return 0. By changing their return type to
> > void, some dead code can be removed.  
> 
> the event facility part looks ok, but I am asking myself if we should
> go a step further.
> Do we need the exit callback at all? We can certainly keep it for reasons of symmetry
> but it looks like the other event handlers (quiesce and cpu) do not define it at all.
> I addition to that, I have a hard time imagine a usecase for such an exit handler.

Agreed. I think we should just remove them.

[I dimly remember having that discussion before...]

Received: from eggs.gnu.org ([2001:4830:134:3::10]:55884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1db3Tk-00048N-Es
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1db3Tf-0008FM-Qm
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:30:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1db3Tf-0008Ej-F3
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:30:43 -0400
Date: Fri, 28 Jul 2017 13:30:35 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170728133035.4eb78e5a@gondolin>
In-Reply-To: <f4ae26f2-fd4f-1b38-e20a-1d6ff4844b64@virtuozzo.com>
References: <20170728085547.13947-1-vsementsov@virtuozzo.com>
	<20170728114159.519eacf4@gondolin>
	<f4ae26f2-fd4f-1b38-e20a-1d6ff4844b64@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] trace-events: print 0x before hex numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com

On Fri, 28 Jul 2017 13:01:15 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> 28.07.2017 12:41, Cornelia Huck wrote:
> > On Fri, 28 Jul 2017 11:55:47 +0300
> > Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> >  
> >> To make logs more readable prefix all hex values with '0x' mark.
> >> This is needed for consistency too, as a lot of hex values are already
> >> prefixed with '0x'. Also, bring all hex outputs to the common form -
> >> use '%#', not '0x%'.  
> > This is problematic if you try to match up things in the trace with
> > things that don't have the leading 0x elsewhere. See my comments on the
> > s390x changes below.  
> 
> Hmm, not so easy..
> 
> All your remarks satisfy the following criteria (and it seems logical 
> anyway):
> 
> hex numbers grouped into patterns like NUM.NUM.NUM (several numbers 
> splitted by period) are allowed to be printed without 0x prefixes.

Works for me. There might be other similar patterns, though.

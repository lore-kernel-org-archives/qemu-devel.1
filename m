Received: from eggs.gnu.org ([2001:4830:134:3::10]:47900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cUaZY-0002z0-LK
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:53:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cUaZT-0000VI-Ss
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:53:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cUaZT-0000Uo-MR
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:53:43 -0500
Date: Fri, 20 Jan 2017 14:53:38 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170120145337.GK2658@work-vm>
References: <1484859998-25074-1-git-send-email-mst@redhat.com>
	<1484859998-25074-3-git-send-email-mst@redhat.com>
	<20170120094124.GB2658@work-vm>
	<7af547e6-8758-388a-17e9-9f749e927da2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7af547e6-8758-388a-17e9-9f749e927da2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/4] compiler: rework BUG_ON using a
 struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

* Eric Blake (eblake@redhat.com) wrote:
> On 01/20/2017 03:41 AM, Dr. David Alan Gilbert wrote:
> 
> >> -#define QEMU_BUILD_BUG_ON(x) \
> >> -    typedef char glue(qemu_build_bug_on__, __LINE__)[(x) ? -1 : 1] \
> >> -        __attribute__((unused))
> >> +#define QEMU_BUILD_BUG_ON_STRUCT(x) \
> >> +    struct { \
> >> +        int qemu_build_bug_on : (x) ? -1 : 1; \
> >> +    }
> > 
> > The problem with this is it can't be used as an expression, where as
> > your previous version could.
> > I've got a similar case (see previous reply) that needed an expression
> > bug-on that would evaluate to zero.
> 
> Keep reading the series - the version usable in an expression is
> QEMU_BUILD_BUG_ON_ZERO, introduced in 3/4.  Patch 2/4 is just rewriting
> the existing check, with no change in the fact that it is still a
> declaration.

Ah hmm, yeh that's OK.

Dave

> 
> -- 
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

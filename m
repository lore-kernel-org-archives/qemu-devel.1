Received: from eggs.gnu.org ([2001:4830:134:3::10]:56986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSCmg-00011Y-4t
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSCmb-0005Im-9N
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:42:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46910 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fSCmb-0005Hp-3r
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:42:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2AC9401EF03
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 02:42:11 +0000 (UTC)
Date: Mon, 11 Jun 2018 10:42:01 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180611024201.GH7736@xz-mi>
References: <20180608035511.7439-1-peterx@redhat.com>
	<20180608035511.7439-6-peterx@redhat.com>
	<8736xxq1mk.fsf@dusky.pond.sub.org> <20180608062439.GB7736@xz-mi>
	<87vaat4uuy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87vaat4uuy.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v10 5/7] monitor: remove event_clock_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Jun 08, 2018 at 09:09:57AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Jun 08, 2018 at 07:38:11AM +0200, Markus Armbruster wrote:
> >
> > [...]
> >
> >> > +/*
> >> > + * This should never be called before configure_accelerator() since
> >> > + * only until then could we know whether qtest was enabled or not.
> >> 
> >> Uh, we know it after then, not until then.  What about
> >> 
> >>    /*
> >>     * Return the clock to use for recording an event's time.
> >>     * Beware: result is invalid before configure_accelerator().
> >
> > Oh, another Chinglish from me. :(
> 
> Useful code, occasional Chinglish, the humility to go with it, and a
> sense of humor --- you're doing fine.

Very high evaluation. Thank you. :)

-- 
Peter Xu

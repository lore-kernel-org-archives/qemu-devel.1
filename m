Received: from eggs.gnu.org ([2001:4830:134:3::10]:47780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fRApM-0006HP-JA
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fRApJ-00030K-Gk
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:24:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57552 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fRApJ-0002zW-Cv
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:24:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C51FA40200A4
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 06:24:44 +0000 (UTC)
Date: Fri, 8 Jun 2018 14:24:39 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180608062439.GB7736@xz-mi>
References: <20180608035511.7439-1-peterx@redhat.com>
	<20180608035511.7439-6-peterx@redhat.com>
	<8736xxq1mk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8736xxq1mk.fsf@dusky.pond.sub.org>
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
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Fri, Jun 08, 2018 at 07:38:11AM +0200, Markus Armbruster wrote:

[...]

> > +/*
> > + * This should never be called before configure_accelerator() since
> > + * only until then could we know whether qtest was enabled or not.
> 
> Uh, we know it after then, not until then.  What about
> 
>    /*
>     * Return the clock to use for recording an event's time.
>     * Beware: result is invalid before configure_accelerator().

Oh, another Chinglish from me. :(

> 
> > + */
> > +static inline QEMUClockType monitor_get_clock(void)
> 
> Suggest to rename to monitor_get_event_clock(), or just
> get_event_clock().
> 
> Happy to apply touch-ups on commit.

That'll be appreciated.  Both changes work for me.

[...]

> With at least a suitable fix for the comment:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks!

-- 
Peter Xu

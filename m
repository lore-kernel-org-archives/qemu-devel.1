Received: from eggs.gnu.org ([2001:4830:134:3::10]:43849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cHDcR-0006Ax-7h
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:45:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cHDcO-00039O-5Z
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:45:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cHDcO-00039G-01
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:45:28 -0500
Date: Wed, 14 Dec 2016 15:45:23 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161214174523.GM3808@thinpad.lan.raisama.net>
References: <1481567461-2341-1-git-send-email-ehabkost@redhat.com>
	<87zijyfyq5.fsf@dusky.pond.sub.org>
	<20161214134841.GG3808@thinpad.lan.raisama.net>
	<b5cf13d0-d03f-d477-20ce-211948b315ee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5cf13d0-d03f-d477-20ce-211948b315ee@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] qom: Make all interface types
 abstract
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, qemu-devel@nongnu.org, Lin Ma <lma@suse.com>

On Wed, Dec 14, 2016 at 06:07:48PM +0100, Paolo Bonzini wrote:
> 
> 
> On 14/12/2016 14:48, Eduardo Habkost wrote:
> >> How do you find all abstract TypeInfo in the source?  The uninitiated
> >> might grep for .abstract = true, and be misled.  The initiated will be
> >> annoyed instead, because grepping for *absence* of .instance_size = is
> >> bothersome.
> >>
> >> I suspect life could be easier going forward if we instead required
> >> .abstract = true for interfaces, and enforced it with
> >> assert(ti->instance_size || ti->abstract) here.
> > I was doing that before deciding to change type_initialize(). I
> > think I still have the commit in my git reflog, I will recover it
> > and submit it as v3.
> 
> I think it's worse.
> 
> Interfaces are abstract by definition.  Requiring ".abstract = true"
> makes things less intuitive.  v2 seems good.

I don't think that making the type declaration more explicit
would cause any real problems, and it would help people grepping
the code. Anybody forgetting to add .abstract=true to new
interfaces would immediatly see an assertion error and would just
be annoyed for 1 minute.

I will submit v3 and let the maintainers decide.

-- 
Eduardo

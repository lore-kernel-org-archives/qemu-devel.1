Received: from eggs.gnu.org ([2001:4830:134:3::10]:49711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecIqo-0001ln-DQ
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 17:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecIql-0000Y7-BC
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 17:40:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecIql-0000Xt-3V
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 17:39:59 -0500
Date: Thu, 18 Jan 2018 20:39:47 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180118223947.GK5292@localhost.localdomain>
References: <20180118025245.13042-1-famz@redhat.com>
	<d1dd1750-c487-be35-05eb-ffb12f18e805@redhat.com>
	<a81a812f-065c-e8be-0d6d-92525a379a82@amsat.org>
	<cf2b427d-a8a0-a124-16dd-598d4f7eea46@redhat.com>
	<CAAdtpL4kR9qWjWHBuYYbZXv=FBoKXRgLE5tzaaC1nZyJZNHXNA@mail.gmail.com>
	<59cde1ab-cf5f-b40a-4377-b33091b593a2@redhat.com>
	<20180118213805.GI5292@localhost.localdomain>
	<800158468.913862.1516313996908.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <800158468.913862.1516313996908.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scsi-generic: Simplify error handling code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Thu, Jan 18, 2018 at 05:19:56PM -0500, Paolo Bonzini wrote:
> 
> ----- Eduardo Habkost <ehabkost@redhat.com> ha scritto:
> > We can do some effort to document the preferred convention to
> > return success/failure, but I don't think we will be able to
> > convert the existing void/ret/bool functions to a single style
> > (whatever it is) in a reasonable time.
> > 
> > That said, IMO returning 0/-1 or true/false is always preferred
> > to returning void, so there's no need to add more local_err
> > boilerplate code.
> 
> I strongly prefer having one way to say things, and having return value and Error*
> (with no clear winner for return value) is a disadvantage. [...]


I sympathize with this argument.

...wait, now we're repeating the discussion from the previous
thread:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg461702.html


>                                                      [...] Your solution is
> slightly more verbose in that it makes it harder to use && and ||, but I am not
> even sure it is a disadvantage.  And the clear advantage that a full conversion
> is mandatory and can be automated...

Well, even if we don't decide about void vs non-void right now,
we would still need something better to live with until a
conversion to non-void is finished.  I think I should rebase and
resubmit my ERR_IS_SET series.

-- 
Eduardo

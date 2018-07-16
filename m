Received: from eggs.gnu.org ([2001:4830:134:3::10]:60588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1feySe-0004au-CF
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 04:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1feySZ-0002Nl-OS
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 04:02:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52048 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1feySZ-0002NR-K0
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 04:02:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1789E7DAC6
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 08:02:19 +0000 (UTC)
Date: Mon, 16 Jul 2018 10:02:13 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180716100213.25c44c16.cohuck@redhat.com>
In-Reply-To: <c2d21b05-0065-80ae-6863-c06f27b448bf@redhat.com>
References: <20180716073226.21127-1-armbru@redhat.com>
	<20180716073226.21127-3-armbru@redhat.com>
	<c2d21b05-0065-80ae-6863-c06f27b448bf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] MAINTAINERS: New section "Incompatible
 changes", copy libvir-list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, pkrempa@redhat.com, berrange@redhat.com

On Mon, 16 Jul 2018 09:54:12 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 16.07.2018 09:32, Markus Armbruster wrote:
> > Libvirt developers would like to be copied on patches to qemu-doc
> > appendix "Deprecated features".  Do them the favor.
> > 
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >  MAINTAINERS | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 20eef3cb61..666e936812 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2194,6 +2194,10 @@ M: Daniel P. Berrange <berrange@redhat.com>
> >  S: Odd Fixes
> >  F: docs/devel/build-system.txt
> >  
> > +Incompatible changes
> > +R: libvir-list@redhat.com
> > +F: qemu-deprecated.texi  
> 
> Should we have a maintainer for the file, too? (I guess not, because
> deprecation patches should go through the specific subsystems...)

I don't think adding a maintainer makes sense for this file.

> And what about a "S:" line?

I don't think that makes too much sense, either.

If anything, qemu-deprecated.texi should be in a category 'maintained
by everybody', i.e. qemu-devel. Just like qemu-doc.texi, which does not
have an entry in MAINTAINERS at all.

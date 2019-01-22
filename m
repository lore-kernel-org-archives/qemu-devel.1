Received: from eggs.gnu.org ([209.51.188.92]:34079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1glu9t-00050g-03
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 06:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1glu9s-0006Uk-2b
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 06:23:56 -0500
Date: Tue, 22 Jan 2019 11:18:21 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20190122111821.GA18917@redhat.com>
References: <20190102140535.11512-1-cfergeau@redhat.com>
	<20190102180158.GA6015@natto.ory.fergeau.eu>
	<4ff5eb04-e1e0-7126-c08d-58d1f28b4f27@redhat.com>
	<87o98sii5b.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o98sii5b.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Christophe Fergeau <cfergeau@redhat.com>, qemu-stable@nongnu.org

On Mon, Jan 07, 2019 at 04:47:44PM +0100, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
> > On 1/2/19 12:01 PM, Christophe Fergeau wrote:
> >> Adding Markus to cc: list, I forgot to do it when sending the patch.
> >
> > Also worth backporting via qemu-stable, now in cc.
> >
> >> 
> >> Christophe
> >> 
> >> On Wed, Jan 02, 2019 at 03:05:35PM +0100, Christophe Fergeau wrote:
> >>> commit 8bca4613 added support for %% in json strings when interpolating,
> >>> but in doing so, this broke handling of % when not interpolating as the
> >>> '%' is skipped in both cases.
> >>> This commit ensures we only try to handle %% when interpolating.
> 
> Impact?
> 
> If you're unable to assess, could you give us at least a reproducer?

This affects the block/curl.c driver.  Here's a simple reproducer:

https://bugzilla.redhat.com/show_bug.cgi?id=1668244#c3

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW

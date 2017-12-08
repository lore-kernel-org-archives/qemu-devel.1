Received: from eggs.gnu.org ([2001:4830:134:3::10]:60555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eNDU1-00019d-3g
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 02:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eNDU0-0004CT-5G
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 02:54:09 -0500
Date: Fri, 8 Dec 2017 15:53:59 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171208075359.GD15798@lemon>
References: <20171207084453.23773-1-famz@redhat.com>
	<20171207105827.5bqrsqbv7ljgmwc6@eukaryote>
	<c49bb9b8-a314-88d2-841e-8748d32c6777@redhat.com>
	<20171208014131.GA15798@lemon> <874lp1k6n8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874lp1k6n8.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-img: Document
 --force-share / -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Kashyap Chamarthy <kchamart@redhat.com>

On Fri, 12/08 08:42, Markus Armbruster wrote:
> Fam Zheng <famz@redhat.com> writes:
> 
> > On Thu, 12/07 10:53, Eric Blake wrote:
> >> On 12/07/2017 04:58 AM, Kashyap Chamarthy wrote:
> >> > On Thu, Dec 07, 2017 at 04:44:53PM +0800, Fam Zheng wrote:
> [...]
> >> >> +it less likely to conflict with a running guest's permissions due to image
> >> >> +locking. For example, this can be used to get the image information (with
> >> >> +'info' subcommand) when the image is used by a running guest. Note that this
> >> >> +could produce inconsistent result because of concurrent metadata changes, etc..
> >> > 
> >> > Super nit-pick:  an ellipsis[*] is three dots :-), so, when applying you
> >> > might want to: s/../.../
> >> > 
> >> > [*] https://dictionary.cambridge.org/dictionary/english/ellipsis
> >> 
> >> Except that both "etc." and "..." independently convey a sense of
> >> continuation, which means that using both at once is both redundant
> >> (just one will do) and difficult to argue how to typeset (since 'etc.'
> >> is often written with an explicit '.' to emphasize that is an
> >> abbreviation, does that mean you have to write 'etc.''...' for a total
> >> of 4 dots?).
> >
> > I have the impression that "etc." is more correct than "etc"
> 
> It is.
> 
> >                                                              so I used even at
> > the end of the sensence where there is another period '.', making it "etc..".
> 
> That's wrong all the same :)
> 
> https://en.wikipedia.org/wiki/Period_(punctuation)#Abbreviations
> 
> > If ending the paragraph with "etc." is enough, we can drop one ".".
> 
> Please do.

Yes, thanks, v2 sent.

Fam

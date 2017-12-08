Received: from eggs.gnu.org ([2001:4830:134:3::10]:57890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eNDIm-0008ND-8x
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 02:42:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eNDIl-0002iy-D7
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 02:42:32 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171207084453.23773-1-famz@redhat.com>
	<20171207105827.5bqrsqbv7ljgmwc6@eukaryote>
	<c49bb9b8-a314-88d2-841e-8748d32c6777@redhat.com>
	<20171208014131.GA15798@lemon>
Date: Fri, 08 Dec 2017 08:42:19 +0100
In-Reply-To: <20171208014131.GA15798@lemon> (Fam Zheng's message of "Fri, 8
	Dec 2017 09:41:31 +0800")
Message-ID: <874lp1k6n8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Fam Zheng <famz@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Kashyap Chamarthy <kchamart@redhat.com>

Fam Zheng <famz@redhat.com> writes:

> On Thu, 12/07 10:53, Eric Blake wrote:
>> On 12/07/2017 04:58 AM, Kashyap Chamarthy wrote:
>> > On Thu, Dec 07, 2017 at 04:44:53PM +0800, Fam Zheng wrote:
[...]
>> >> +it less likely to conflict with a running guest's permissions due to image
>> >> +locking. For example, this can be used to get the image information (with
>> >> +'info' subcommand) when the image is used by a running guest. Note that this
>> >> +could produce inconsistent result because of concurrent metadata changes, etc..
>> > 
>> > Super nit-pick:  an ellipsis[*] is three dots :-), so, when applying you
>> > might want to: s/../.../
>> > 
>> > [*] https://dictionary.cambridge.org/dictionary/english/ellipsis
>> 
>> Except that both "etc." and "..." independently convey a sense of
>> continuation, which means that using both at once is both redundant
>> (just one will do) and difficult to argue how to typeset (since 'etc.'
>> is often written with an explicit '.' to emphasize that is an
>> abbreviation, does that mean you have to write 'etc.''...' for a total
>> of 4 dots?).
>
> I have the impression that "etc." is more correct than "etc"

It is.

>                                                              so I used even at
> the end of the sensence where there is another period '.', making it "etc..".

That's wrong all the same :)

https://en.wikipedia.org/wiki/Period_(punctuation)#Abbreviations

> If ending the paragraph with "etc." is enough, we can drop one ".".

Please do.

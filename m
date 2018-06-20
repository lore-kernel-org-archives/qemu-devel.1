Received: from eggs.gnu.org ([2001:4830:134:3::10]:49161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVXPu-0007Pb-2r
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:20:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVXPs-0006m5-Qk
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:20:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53294 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fVXPs-0006ld-IL
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 03:20:32 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180619053426.13065-1-peterx@redhat.com>
	<20180619053426.13065-7-peterx@redhat.com>
	<8736xioo8e.fsf@dusky.pond.sub.org> <20180620031529.GD18985@xz-mi>
Date: Wed, 20 Jun 2018 09:20:30 +0200
In-Reply-To: <20180620031529.GD18985@xz-mi> (Peter Xu's message of "Wed, 20
	Jun 2018 11:15:29 +0800")
Message-ID: <87in6dkjpd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 6/7] monitor: remove "x-oob",
 turn oob on by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, John Snow <jsnow@redhat.com>, "Dr . David
	Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Tue, Jun 19, 2018 at 04:16:49PM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > There was a regression reported by Eric Auger before with OOB:
>> >
>> >   http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06231.html
>> >
>> > It is fixed in 951702f39c ("monitor: bind dispatch bh to iohandler
>> > context", 2018-04-10).
>> >
>> > For the bug, we turned Out-Of-Band feature of monitors off for 2.12
>> > release.  Now we turn that on again after the 2.12 release.
>> 
>> Relating what happened in the order it happened could be easier to
>> understand.  Perhaps:
>> 
>>   OOB commands were introduced in commit cf869d53172.  Unfortunately, we
>>   ran into a regression, and had to disable them by default for 2.12
>>   (commit be933ffc23).
>> 
>>   The regression has since been fixed (commit 951702f39c7 "monitor: bind
>>   dispatch bh to iohandler context").  Time to re-enable OOB.
>
> This indeed looks much nicer.
>
>> 
>> > This patch partly reverts be933ffc23 (monitor: new parameter "x-oob"),
>> > meanwhile turn it on again by default for non-MUX QMPs.  Note that we
>> 
>> "by default"?
>
> Did I mis-spell somewhere?

I was too terse, sorry.  Let me try again.

"By default" suggests there's a way for the user to switch it off.
That's not the case.  I guess you mean something like

    This patch partly reverts be933ffc23 (monitor: new parameter "x-oob"),
    and turns OOB on again for non-MUX QMPs.

[...]

Received: from eggs.gnu.org ([209.51.188.92]:56051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3SH0-0005FS-Iu
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 17:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3SGz-0007uV-9W
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 17:15:50 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190311165017.32247-1-kwolf@redhat.com>
	<20190311165017.32247-11-kwolf@redhat.com>
	<2f72f4e8-879a-62a5-d131-8c6562bd4043@redhat.com>
	<20190311195925.GA21327@angien.pipo.sk>
	<74cc34ed-a60b-75fd-3cf1-122ba485917e@redhat.com>
	<20190311202534.GB21327@angien.pipo.sk>
Date: Mon, 11 Mar 2019 22:15:32 +0100
In-Reply-To: <20190311202534.GB21327@angien.pipo.sk> (Peter Krempa's message
	of "Mon, 11 Mar 2019 21:25:34 +0100")
Message-ID: <87tvg96rkb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 10/10] file-posix: Make auto-read-only
 dynamic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, berto@igalia.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, "stefanha@redhat.com" <stefanha@redhat.com>

Peter Krempa <pkrempa@redhat.com> writes:

> On Mon, Mar 11, 2019 at 15:10:36 -0500, Eric Blake wrote:
>> On 3/11/19 2:59 PM, Peter Krempa wrote:
>> 
>> >> auto-read-only was introduced in 3.1, at which point we intentionally
>> >> had sufficiently loose wording to permit (but not require) dynamic state
>> >> checking; so you are not breaking the interface.  On the other hand, is
>> >> libvirt going to have problems introspecting whether it can use
>> >> auto-read-only and get the dynamic behavior it needs?  Or is there
>> >> enough else in the way of libvirt's switch to -blockdev that it won't
>> >> attempt anything that needs auto-read-only without other 4.0 interfaces
>> >> anyway, at which point detecting the presence of the field (but not
>> >> whether the field has a guarantee of dynamic behavior) on 3.1 doesn't
>> >> matter?
>> > 
>> > I think we can use Stefan's capability detection mechanism he introduced
>> > for the migration with cache enabled for local files to add a flag for
>> > this as well.
>> 
>> Except I thought we decided that the most recent version of his QMP
>> changes was now fully-introspectible, thanks to using conditional
>> compilation.
>> 
>> https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02510.html
>
> Oh, bummer, I missed that it was no longer needed. I still think it's
> worth adding that for future use once it will be necessary to detect
> that certain things were patched and require libvirt to change behaviour
> if that's the case.

We'll add it when we have a compelling use for it.

>> Well, that may prove to be a short-lived hiatus, if libvirt would
>> happily attempt to use qemu 3.1 and fail without some other
>> introspectible hook to know whether auto-read-only has required semantics.

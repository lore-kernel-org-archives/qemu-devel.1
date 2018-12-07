Received: from eggs.gnu.org ([2001:4830:134:3::10]:40514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVFc8-0002Lj-Pw
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVFc7-0004Zh-Ux
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:52:16 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181206151304.8388-1-kwolf@redhat.com>
	<20181206151304.8388-2-kwolf@redhat.com>
	<871s6t4z65.fsf@dusky.pond.sub.org>
	<20181207102425.GA5119@linux.fritz.box>
Date: Fri, 07 Dec 2018 13:52:00 +0100
In-Reply-To: <20181207102425.GA5119@linux.fritz.box> (Kevin Wolf's message of
	"Fri, 7 Dec 2018 11:24:25 +0100")
Message-ID: <87ftv9xzwv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/4] vmdk: Refactor vmdk_create_extent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Kevin Wolf <kwolf@redhat.com> writes:

> Am 07.12.2018 um 07:40 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> 
>> > From: Fam Zheng <famz@redhat.com>
>> >
>> > The extracted vmdk_init_extent takes a BlockBackend object and
>> > initializes the format metadata. It is the common part between "qemu-img
>> > create" and "blockdev-create".
>> >
>> > Add a "BlockBackend *pbb" parameter to vmdk_create_extent, to return the
>> > opened BB to the caller in the next patch.
>> 
>> I'd do this part in the next patch, when it has a user.  Matter of
>> taste.
>
> I kept Fam as the author of the patches (except for the test case which
> is effectively a rewrite with Fam's test as the spec), so I'd like to
> do only the minimal editing necessary to make the patches mergeable. If
> it's a matter of taste, I'll leave it as it is.

That's fine.  Matter of taste means I'm stating mine without demanding
you change the patch to conform to it.

> The same goes for code changes that are a matter of taste: If you
> _really_ care about taste in the vmdk code, feel free to send a
> follow-up and I'll merge it on top, but I'll leave Fam's patches alone
> as much as I can.

Makes sense.

>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> Thanks!
>
> Kevin

Received: from eggs.gnu.org ([2001:4830:134:3::10]:56842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dc6b3-0004Vy-33
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:02:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dc6b0-0005fl-8v
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:02:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dc6b0-0005fJ-2b
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:02:38 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1501249552-788-1-git-send-email-armbru@redhat.com>
	<1501249552-788-3-git-send-email-armbru@redhat.com>
	<20170728171731.GB3008@work-vm>
	<c246b4bf-cb19-3348-9bdc-83409162abfc@redhat.com>
Date: Mon, 31 Jul 2017 11:02:34 +0200
In-Reply-To: <c246b4bf-cb19-3348-9bdc-83409162abfc@redhat.com> (Eric Blake's
	message of "Fri, 28 Jul 2017 13:07:43 -0500")
Message-ID: <87lgn59dxx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/3] COLO: Define COLOMode without QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, zhanghailiang <zhang.zhanghailiang@huawei.com>

Eric Blake <eblake@redhat.com> writes:

> On 07/28/2017 12:17 PM, Dr. David Alan Gilbert wrote:
>> * Markus Armbruster (armbru@redhat.com) wrote:
>>> COLOMode is defined in the QAPI schema, but not used there.  Of the
>>> stuff QAPI generates for it only the typedef is actually used.  Use of
>>> QAPI is pointless and only complicates things, so don't.
>> 
>> Hmm, in one of the old COLO worlds I have, there's code to emit an event
>> on exiting from COLO and that event includes the mode it was in.
>> 
>> If the intent is to bring that or similar back then it would be worth
>> keeping.
>
> We can always revert the removal once there is a user.

I assume YAGNI until proven otherwise.

Posting patches putting COLOMode to use could serve as proof.

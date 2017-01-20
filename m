Received: from eggs.gnu.org ([2001:4830:134:3::10]:42301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cUTQa-0003aS-Nd
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:16:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cUTQX-0005LC-JN
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:16:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cUTQX-0005KN-DN
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:16:01 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5192483F3F
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 07:15:59 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170118161653.19296-1-eblake@redhat.com>
	<20170118161653.19296-7-eblake@redhat.com>
	<8737gffkhy.fsf@dusky.pond.sub.org>
	<f5618def-ca46-72e7-c872-85e6d79a17b5@redhat.com>
Date: Fri, 20 Jan 2017 08:15:56 +0100
In-Reply-To: <f5618def-ca46-72e7-c872-85e6d79a17b5@redhat.com> (Eric Blake's
	message of "Thu, 19 Jan 2017 08:42:42 -0600")
Message-ID: <87h94u42xf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 6/6] qapi: Promote
 blockdev-change-medium arguments to QAPI type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 01/19/2017 03:48 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> Having a named rather than anonymous C type will make it easier
>>> to improve the testsuite in a later patch.
>> 
>> Post it together with said later patch then.
>
> It was that way in the v1 series, but I had enough else going on with
> removal of dynamic JSON parsing that I thought I could pick this one
> early.  But I have no problems omitting it in a v3 respin, and saving it
> for the dynamic JSON work (if we even want to revisit that discussion).
>
>
>>    # @format:          #optional, format to open the new image with (defaults to
>>    #                   the probed format)
>>    #
>>    # @read-only-mode:  #optional, change the read-only mode of the device; defaults
>>    #                   to 'retain'
>>    #
>>    # Since: 2.5
>> 
>> Isn't Since: 2.5 misleading?  The anonymous type goes back to 2.5, but
>> the name doesn't.
>
> It matches what we've done elsewhere - when refactoring .json files to
> create a new type, but where the new type doesn't represent anything
> different over the wire than what was previously sent, we've documented
> the new struct name as of the older release where the wire format was
> introduced.  But as long as the command says 'since 2.5', I'm okay if we
> want to mark the struct as 'since 2.9', if that's easier to think about.

Sticking to established practice is better than inconsistent practice.

That said, I wonder why we bother to track "since" for types.  "Since"
is important information for external interfaces.  Why is it useful for
purely internal ones?

External visible are commands, events, and members of types used by
commands or events.

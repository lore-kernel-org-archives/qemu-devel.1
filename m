Received: from eggs.gnu.org ([2001:4830:134:3::10]:34255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1frfo0-00085C-H3
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1frfnz-0004UT-EI
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:44:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57696 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1frfnz-0004Tq-49
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:44:55 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180817150559.16243-1-armbru@redhat.com>
	<20180817150559.16243-26-armbru@redhat.com>
	<58df6e5a-a25a-6a98-2fdb-abf50bd4e5f8@redhat.com>
Date: Mon, 20 Aug 2018 10:44:50 +0200
In-Reply-To: <58df6e5a-a25a-6a98-2fdb-abf50bd4e5f8@redhat.com> (Eric Blake's
	message of "Fri, 17 Aug 2018 11:32:28 -0500")
Message-ID: <87k1ols9z1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 25/60] json: Leave rejecting invalid
 escape sequences to parser
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 08/17/2018 10:05 AM, Markus Armbruster wrote:
>> Both lexer and parser reject invalid escape sequences in strings.  The
>> parser's check is useless.
>>
>
>> While there, fix parse_string()'s inaccurate function comment.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
>> + * From RFC 7159 "The JavaScript Object Notation (JSON) Data
>> + * Interchange Format":
>
> You did point out in the cover letter that you intend to rewrite this
> to point to 8259. (That's saying something - when portions of these
> patches have been around on our mailing list prior to the point of the
> RFC being updated).

I spotted the "Obsoleted by: 8259" in RFC 7159 pretty much by chance
during development of this series, but neglected to work in the update
right away.

>                     Here, and elsewhere in the series, that's minor
> enough that I don't see it invalidating any of my R-b.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

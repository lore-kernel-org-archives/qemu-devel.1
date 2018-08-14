Received: from eggs.gnu.org ([2001:4830:134:3::10]:41913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpSod-0007K9-6U
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fpSoc-00089V-AV
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:28:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55840 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fpSoc-00089P-4j
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:28:26 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-37-armbru@redhat.com>
	<136beab4-6228-d267-5cfe-e3946020b276@redhat.com>
Date: Tue, 14 Aug 2018 08:28:24 +0200
In-Reply-To: <136beab4-6228-d267-5cfe-e3946020b276@redhat.com> (Eric Blake's
	message of "Mon, 13 Aug 2018 10:34:55 -0500")
Message-ID: <87zhxp31iv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 36/56] json: Rename token JSON_ESCAPE &
 friends to JSON_INTERPOL
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

> On 08/08/2018 07:03 AM, Markus Armbruster wrote:
>> The JSON parser optionally supports interpolation.  The code calls it
>> "escape".  Awkward, because it uses the same term for escape sequences
>> within strings.  The latter usage is consistent with RFC 7159 "The
>> JavaScript Object Notation (JSON) Data Interchange Format" and ISO C.
>> Call the former "interpolation" instead.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   include/qapi/qmp/json-lexer.h |  2 +-
>>   qobject/json-lexer.c          | 64 +++++++++++++++++------------------
>>   qobject/json-parser.c         |  8 ++---
>>   3 files changed, 37 insertions(+), 37 deletions(-)
>
> Mechanical, and a worthwhile name change.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> Bike-shedding: Would INTERP (short for interpolate) be any more
> legible than INTERPOL (which I first read as short for 'international
> police')?

Ah, where's the fun in that!

When I read INTERP, I associate "interpreter".  On the other hand, there
appears to be precedence for abbreviating "interpolate" /
"interpolation" to "interp" in numpy and MATLAB.

Another possible abbreviation would be IPOLATE.

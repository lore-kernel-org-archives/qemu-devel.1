Received: from eggs.gnu.org ([2001:4830:134:3::10]:50221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co3X9-0007qP-BQ
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:39:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co3X5-0005jW-G7
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:39:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co3X5-0005jO-A2
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:39:43 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-33-git-send-email-armbru@redhat.com>
	<63740e61-afee-ced9-3f14-c4918238d3b4@redhat.com>
Date: Wed, 15 Mar 2017 08:39:40 +0100
In-Reply-To: <63740e61-afee-ced9-3f14-c4918238d3b4@redhat.com> (Eric Blake's
	message of "Tue, 14 Mar 2017 15:43:30 -0500")
Message-ID: <87lgs7q98j.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 32/47] qapi: Move detection of doc
 / expression name mismatch
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

> On 03/13/2017 01:18 AM, Markus Armbruster wrote:
>> Move the check whether the doc matches the expression name from
>> check_definition_doc() to check_exprs().  This changes the error
>> location from the comment to the expression.  Makes sense as the
>> message talks about the expresion: "Definition of '%s' follows
>
> s/expresion/expression/

Will fix.

>> documentation for '%s'".  It's also a step towards getting rid of
>> check_docs().
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi.py                      | 28 ++++++++++++++++++----------
>>  tests/qapi-schema/doc-bad-symbol.err |  2 +-
>>  2 files changed, 19 insertions(+), 11 deletions(-)
>> 
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

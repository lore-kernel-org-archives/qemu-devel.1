Received: from eggs.gnu.org ([2001:4830:134:3::10]:51202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co3c1-0001Mn-2Z
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1co3by-0007uq-2m
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:44:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1co3bx-0007ug-TI
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:44:46 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-35-git-send-email-armbru@redhat.com>
	<8737ehlmog.fsf@dusky.pond.sub.org>
	<04ef49b9-938c-7b6f-f811-710c6611b42d@redhat.com>
Date: Wed, 15 Mar 2017 08:44:42 +0100
In-Reply-To: <04ef49b9-938c-7b6f-f811-710c6611b42d@redhat.com> (Eric Blake's
	message of "Tue, 14 Mar 2017 20:40:07 -0500")
Message-ID: <87fuifq905.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 34/47] qapi: Move empty doc section
 checking to doc parser
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

> On 03/13/2017 01:23 AM, Markus Armbruster wrote:
>> Markus Armbruster <armbru@redhat.com> writes:
>> 
>>> Results in a more precise error location, but the real reason is
>>> emptying out check_docs() step by step.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> 
>> Perhaps we should simply drop this error condition.  Are empty sections
>> this a mistake users make accidentally?
>
> Parse error; did you mean "empty sections _like_ this"?

Yes.

> I'm okay with keeping the error; especially if we can't guarantee that
> the generator copes gracefully with an empty section (different than an
> omitted section).

We'd have to verify it does.

>                    On the other hand, even if we remove the error,
> you're probably right that anyone proposing a patch for incorporation
> that adds an empty section will have to explain themselves, whether or
> not the parser flagged it, and if the error is cheap to maintain in the
> parser, then it saves some review cycles.

The patch adds two methods and changes three existing ones just to catch
empty sections.  I can't help to ask: why bother?

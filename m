Received: from eggs.gnu.org ([2001:4830:134:3::10]:55408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPCuV-0001d5-81
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:46:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPCuR-0000lI-13
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:46:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gPCuO-0000fF-Uy
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:46:10 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181120092542.13102-1-david@redhat.com>
	<20181120092542.13102-6-david@redhat.com>
	<27cfb4e6-b4db-10de-02c7-691f011d5f99@redhat.com>
	<f5dd77c5-8d40-fe95-4fc8-69aa96fa4f13@redhat.com>
	<0a72b07b-3620-7728-4248-8cd7c0112489@redhat.com>
Date: Tue, 20 Nov 2018 21:46:01 +0100
In-Reply-To: <0a72b07b-3620-7728-4248-8cd7c0112489@redhat.com> (Eric Blake's
	message of "Tue, 20 Nov 2018 11:26:39 -0600")
Message-ID: <87efbf7a0m.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/9] test-string-input-visitor: Add more
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Eric Blake <eblake@redhat.com> writes:

> On 11/20/18 11:20 AM, Eric Blake wrote:
>> On 11/20/18 11:06 AM, Eric Blake wrote:
>>> On 11/20/18 3:25 AM, David Hildenbrand wrote:
>>>> Test that very big/small values are not accepted and that ranges with
>>>> only one element work. Also test that ranges are ascending and cannot
>>>> have more than 65536 elements.
>>>>
>>>> Rename expect4 to expect5, as we will be moving that to a separate uli=
st
>>>> test after the rework.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>> =C2=A0 tests/test-string-input-visitor.c | 41 ++++++++++++++++++++++++=
+++++--
>>>> =C2=A0 1 file changed, 39 insertions(+), 2 deletions(-)
>>>>
>>>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>> Do we also want to test garbage strings like:
>>
>> "1-" (incomplete range)
>> "1X-2" (garbage suffix on first element)
>> "1-2X" (garbage suffix on second element)
>>
>> and/or
>>
>> "-2--1" (valid range of signed integers)
>> "-1--2" (questionable whether this is valid for the two largest
>> unsigned integers)
>
> Or even " 1- 2" (we permit leading whitespace for plain integers - do
> we also permit it in both sides of a range)?  Also, if we permit
> whitespace after the range '-', should we permit it beforehand?

For what it's worth, the tests for integers (as opposed to ranges)
aren't that thorough, either.  test-cutils.c already provides cover for
them, but not for ranges.

> These sorts of questions may be fine in followup patches.

David is doing me a favor with these patches.  The tests feel good
enough, I don't want to hold these patches hostage to extort more.

Reviewed-by: Markus Armbruster <armbru@redhat.com>

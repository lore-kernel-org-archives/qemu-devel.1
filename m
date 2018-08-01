Received: from eggs.gnu.org ([2001:4830:134:3::10]:34807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fkkuR-0001Uz-7r
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 02:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fkkuN-0004tj-Bf
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 02:46:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57188 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fkkuN-0004pM-5a
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 02:46:55 -0400
Reply-To: thuth@redhat.com
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-22-armbru@redhat.com>
	<55305ddb-0551-6296-c98a-c3af1228b2d5@redhat.com>
	<9244e265-82fe-42b4-330c-9005bde0a983@redhat.com>
	<87in4x1bfb.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3f3d6599-0b3c-8a2f-88a7-895d5dfe35ed@redhat.com>
Date: Wed, 1 Aug 2018 08:46:46 +0200
MIME-Version: 1.0
In-Reply-To: <87in4x1bfb.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 21/23] libqtest: Remove
 qtest_qmp_discard_response() & friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org

On 07/30/2018 08:32 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> On 07/27/2018 11:46 AM, Thomas Huth wrote:
>>> On 07/27/2018 05:13 PM, Markus Armbruster wrote:
>>>> qtest_qmp_discard_response(...) is shorthand for
>>>> qobject_unref(qtest_qmp(...), except it's not actually shorter.
>>>
>>> But the latter is IMHO harder to read.
> 
> Doing things sloppily looks a bit uglier now.  That's a feature.
> 
>> Maybe, but then it lends itself well to:
>>
>> QObject *rsp = qtest_qmp(...);
>> qobject_unref(rsp);
>>
>> which is where you do insert tests for valid responses.
>>
>>> And it might be shorter in the compiled binary (one function call vs. two).
> 
> I'd be quite sympathetic to this argument...
> 
>> The size of the test binaries is not our biggest concern.
> 
> ... outside tests/.
> 
>>>> Moreover, the presence of these functions encourage sloppy testing.
>>>
>>> Shouldn't we then rather fix the tests to check for valid responses
>>> instead of replacing this function with harder-to-read code?
> 
> I'd welcome such patches, but this series is already pretty long.

Then maybe rather drop this patch from this series, and fix the issues
in a separate series instead?

 Thomas

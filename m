Received: from eggs.gnu.org ([2001:4830:134:3::10]:44153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk1j3-0004rc-Rq
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 02:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk1j0-0001pf-Lw
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 02:32:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53158 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fk1j0-0001p7-Gy
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 02:32:10 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-22-armbru@redhat.com>
	<55305ddb-0551-6296-c98a-c3af1228b2d5@redhat.com>
	<9244e265-82fe-42b4-330c-9005bde0a983@redhat.com>
Date: Mon, 30 Jul 2018 08:32:08 +0200
In-Reply-To: <9244e265-82fe-42b4-330c-9005bde0a983@redhat.com> (Eric Blake's
	message of "Fri, 27 Jul 2018 12:03:25 -0500")
Message-ID: <87in4x1bfb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Eric Blake <eblake@redhat.com>
Cc: thuth@redhat.com, qemu-devel@nongnu.org, f4bug@amsat.org

Eric Blake <eblake@redhat.com> writes:

> On 07/27/2018 11:46 AM, Thomas Huth wrote:
>> On 07/27/2018 05:13 PM, Markus Armbruster wrote:
>>> qtest_qmp_discard_response(...) is shorthand for
>>> qobject_unref(qtest_qmp(...), except it's not actually shorter.
>>
>> But the latter is IMHO harder to read.

Doing things sloppily looks a bit uglier now.  That's a feature.

> Maybe, but then it lends itself well to:
>
> QObject *rsp = qtest_qmp(...);
> qobject_unref(rsp);
>
> which is where you do insert tests for valid responses.
>
>> And it might be shorter in the compiled binary (one function call vs. two).

I'd be quite sympathetic to this argument...

> The size of the test binaries is not our biggest concern.

... outside tests/.

>>> Moreover, the presence of these functions encourage sloppy testing.
>>
>> Shouldn't we then rather fix the tests to check for valid responses
>> instead of replacing this function with harder-to-read code?

I'd welcome such patches, but this series is already pretty long.

> I think such fixes are now easier to make, but can be separate
> followup patches. The mechanical conversion is fine to me.

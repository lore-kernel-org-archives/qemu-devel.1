Received: from eggs.gnu.org ([2001:4830:134:3::10]:45129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fjJT3-0006HN-Dp
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 03:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fjJT2-0007n7-Hp
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 03:16:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39122 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fjJT2-0007mo-Dc
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 03:16:44 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180727155602.10148-1-armbru@redhat.com>
	<CAFEAcA8pkdr7Rsh+XMNbWrFpue26LGeHL5KpD8X+djiSVjpbwg@mail.gmail.com>
Date: Sat, 28 Jul 2018 09:16:42 +0200
In-Reply-To: <CAFEAcA8pkdr7Rsh+XMNbWrFpue26LGeHL5KpD8X+djiSVjpbwg@mail.gmail.com>
	(Peter Maydell's message of "Fri, 27 Jul 2018 18:19:34 +0100")
Message-ID: <87bmar6d9h.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 0/3] QObject patches for 2018-07-27
 (3.0.0-rc3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 27 July 2018 at 16:55, Markus Armbruster <armbru@redhat.com> wrote:
>> The following changes since commit 18a398f6a39df4b08ff86ac0d38384193ca5f4cc:
>>
>>   Update version for v3.0.0-rc2 release (2018-07-24 22:06:31 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://repo.or.cz/qemu/armbru.git tags/pull-qobject-2018-07-27
>>
>> for you to fetch changes up to 307fb894ce0608aede990ec40ce84eaeb358c8ec:
>>
>>   qstring: Move qstring_from_substr()'s @end one to the right (2018-07-27 17:16:03 +0200)
>>
>> ----------------------------------------------------------------
>> QObject patches for 2018-07-27 (3.0.0-rc3)
>>
>> This pull request fixes an integer overflow bug, and hardens the code
>> in question a bit.  Abuse of QMP can make the bug crash QEMU, so it
>> seems worth fixing at this late stage.
>>
>> ----------------------------------------------------------------
>> Markus Armbruster (2):
>>       qstring: Assert size calculations don't overflow
>>       qstring: Move qstring_from_substr()'s @end one to the right
>>
>> liujunjie (1):
>>       qstring: Fix qstring_from_substr() not to provoke int overflow
>
>
> Hi -- this passes my buildtests, but the commit from liujunjie
> seems to be missing your maintainer signed-off-by (and possibly
> a reviewed-by tag ?) Can I ask you to fix that up and resend,
> please?

My apologies.  v2 sent.

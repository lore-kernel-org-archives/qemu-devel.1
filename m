Received: from eggs.gnu.org ([2001:4830:134:3::10]:44969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVTZ-0005Mp-9p
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:12:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXVTV-0000S0-7u
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:12:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXVTV-0000Re-0b
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:12:41 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181212101145.3496-1-armbru@redhat.com>
	<CAFEAcA9iE_3p6_JKj1tcFqNfQXr_aEk2PqEnhmLTEc0Ei0jiWQ@mail.gmail.com>
Date: Thu, 13 Dec 2018 19:12:38 +0100
In-Reply-To: <CAFEAcA9iE_3p6_JKj1tcFqNfQXr_aEk2PqEnhmLTEc0Ei0jiWQ@mail.gmail.com>
	(Peter Maydell's message of "Thu, 13 Dec 2018 17:50:28 +0000")
Message-ID: <874lbhjnxl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 00/11] Monitor patches for 2018-12-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 12 Dec 2018 at 10:13, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> The following changes since commit bb9bf94b3e8926553290bc9a7cb84315af422086:
>>
>>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-12-11 19:18:58 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2018-12-12
>>
>> for you to fetch changes up to c55f070b7195cee4e06998c10f57f13c7df98dbd:
>>
>>   tests: add oob functional test for test-qmp-cmds (2018-12-12 10:28:27 +0100)
>>
>> ----------------------------------------------------------------
>> Monitor patches for 2018-12-12
>>
>> * Fixes related to running the monitor in an I/O thread
>> * Change how OOB-enabled QMP monitors handle flow control: suspend
>>   monitor instead dropping commands
>> * Offer QMP capability "oob" unconditionally, remove "x-oob"
>>
>
> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
> for any user-visible changes.

Done.  Thanks for the reminder!

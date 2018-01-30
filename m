Received: from eggs.gnu.org ([2001:4830:134:3::10]:45618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1egPQS-0007Ai-4k
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 01:29:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1egPQO-0000Lm-2p
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 01:29:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1egPQN-0000KS-Sx
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 01:29:44 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <CAFEAcA_DrUj0MdJVRMst91k--Cvc9j+QKy-tscp0R526cEttdQ@mail.gmail.com>
	(Peter Maydell's message of "Mon, 29 Jan 2018 18:53:56 +0000")
References: <20180129120932.12874-1-quintela@redhat.com>
	<CAFEAcA_DrUj0MdJVRMst91k--Cvc9j+QKy-tscp0R526cEttdQ@mail.gmail.com>
Reply-To: quintela@redhat.com
Date: Tue, 30 Jan 2018 07:29:43 +0100
Message-ID: <87d11r3lm0.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 00/13] Migration PULL request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On 29 January 2018 at 12:09, Juan Quintela <quintela@redhat.com> wrote:
>> Hi
>>
>> - migrate_fd_connect cleanup (dave)
>> - use MAX_VM_PACKAGED_SIZE
>>   have to change (1<<32) for UINT32_MAX to get no warnings on win32
>> - Use right s->threashord_size(wei)
>> - patches reviewed from info/migrate, migration tests and multifd (me)
>>
>> Later, Juan.
>>
>> The following changes since commit 6233b4a8c2a32ef6955a921246fa08705bbb3676:
>>
>>   Merge remote-tracking branch
>> 'remotes/ericb/tags/pull-nbd-2018-01-26' into staging (2018-01-26
>> 17:29:14 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/juanquintela/qemu.git tags/migration/20180129
>>
>> for you to fetch changes up to 4b6bb0a77761b8a906a540e927c7a9dde99bc10f:
>>
>>   tests: Adjust sleeps for migration test (2018-01-29 12:10:22 +0100)
>>
>> ----------------------------------------------------------------
>> migration/next for 20180129
>
> Hi. On aarch32 host I get this assert in the tests:
>
> TEST: tests/migration-test... (pid=605)
>   /ppc64/migration/deprecated:                                         OK
>   /ppc64/migration/precopy/unix:                                       OK
>   /ppc64/migration/postcopy/unix:                                      OK
>   /ppc64/migration/xbzrle/unix:
> Unexpected 32 on dest_serial serial
> **
> ERROR:/home/peter.maydell/qemu/tests/migration-test.c:218:wait_for_serial:
> code should not be reached

1st time I see a problem on the xbzrle test.  I can resent the pull
without that patch, but that is a *test*, the problem is that we have a
xbzrle problem on aarch32 that we didn't know about yet.

So I will just try to do the PULL request anyways.  I will try to get
access to an arm32 system tomorrow and see what is going on.

Thanks for checking it.

Later, Juan.


> FAIL
> GTester: last random seed: R02S31c8250adcdb12a122a1c5c0ab62d01e
> (pid=639)
> FAIL: tests/migration-test
>
> thanks
> -- PMM

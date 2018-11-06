Received: from eggs.gnu.org ([2001:4830:134:3::10]:48872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gK3it-0001UP-Tn
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:57:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gK3io-0002FN-UO
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:56:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gK3io-0002EB-Os
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:56:54 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181030191620.32168-1-armbru@redhat.com>
	<CAFEAcA8RdNrbCLL7tXY=e95N2Y0LcZdCPr3EuQo1_hu08qJuaQ@mail.gmail.com>
Date: Tue, 06 Nov 2018 16:56:51 +0100
In-Reply-To: <CAFEAcA8RdNrbCLL7tXY=e95N2Y0LcZdCPr3EuQo1_hu08qJuaQ@mail.gmail.com>
	(Peter Maydell's message of "Thu, 1 Nov 2018 11:50:59 +0000")
Message-ID: <87sh0eyzb0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 0/8] Monitor patches for 2018-10-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 30 October 2018 at 19:16, Markus Armbruster <armbru@redhat.com> wrote:
>> The following changes since commit 3f3285491dd52014852a56135c90e428c8b507ea:
>>
>>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2018-10-30 14:09:25 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2018-10-30
>>
>> for you to fetch changes up to 1a8de278dd3c93a7aa40f88486509fe0e2de04da:
>>
>>   vl: Avoid crash when -mon is underspecified (2018-10-30 20:13:52 +0100)
>>
>> ----------------------------------------------------------------
>> Monitor patches for 2018-10-30
>>
>> * Fix crash on shutdown with --daemonize
>> * Change out-of-band execution to stop reading instead of dropping
>>   commands
>> * Enable out-of-band execution by default
>> * Avoid crash when -mon lacks chardev=...
>>
>> ----------------------------------------------------------------
>
> Hi; I get test failures on FreeBSD host:
>
> TEST: tests/qmp-test... (pid=18305)
>   /sparc64/qmp/protocol:                                               OK
>   /sparc64/qmp/oob:                                                    FAIL
> GTester: last random seed: R02Se36038cab4c051a2cd47374ec9718e98
> (pid=18337)
>   /sparc64/qmp/preconfig:                                              OK
> FAIL: tests/qmp-test
>
> ERROR:tests/qmp-test.c:211:recv_cmd_id: assertion failed
> (qdict_get_try_str(resp, "id") == id): ("oob-1" == "queue-blocks-1")
> gmake: *** [/var/tmp/qemu-test.2n2tBU/tests/Makefile.include:805:
> check-qtest-sparc] Error 1
>
> and similarly with i386/qmp/oob and sparc/qmp/oob.

I haven't been able to reproduce, yet.  I'm going to respin with fewer
patches, to get the other stuff in while I debug.

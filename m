Received: from eggs.gnu.org ([2001:4830:134:3::10]:49880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb9sE-0003D8-3a
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:48:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb9sD-0005xQ-3r
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:48:14 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:38867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cb9sC-0005wB-RW
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:48:13 -0500
Received: by mail-wm0-x22e.google.com with SMTP id r141so161784547wmg.1
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 09:48:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87lgti1lta.fsf@emacs.mitica>
References: <1486399909-16338-1-git-send-email-quintela@redhat.com>
	<CAFEAcA-yFVYzwxt4FG9D3g3BwEJFPnmNrr-pJOzYV-h5Y6bu7A@mail.gmail.com>
	<87lgti1lta.fsf@emacs.mitica>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Feb 2017 17:47:50 +0000
Message-ID: <CAFEAcA9RXeubPXZhTS+FHyYVARvb=gVFOQxK8ZYt8OQnhe9WXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/6] Migration pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Amit Shah <amit.shah@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 7 February 2017 at 07:50, Juan Quintela <quintela@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 6 February 2017 at 16:51, Juan Quintela <quintela@redhat.com> wrote:
>
>
>> I get a test failure on aarch64 host on one of the ppc guest tests:
>>
>> TEST: tests/prom-env-test... (pid=26435)
>>   /ppc64/prom-env/mac99:                                               OK
>>   /ppc64/prom-env/g3beige:                                             OK
>>   /ppc64/prom-env/pseries:                                             **
>> ERROR:/home/petmay01/qemu/tests/prom-env-test.c:42:check_guest_memory:
>> assertion failed (signature == MAGIC): (0x7c7f1b78 == 0xcafec0de)
>> FAIL
>> GTester: last random seed: R02Sbd97cf9617f5dd55ba90b08765cfa0d0
>> (pid=26445)
>> FAIL: tests/prom-env-test
>>
>>
>> This might just be the test having an overzealous timeout (I
>> think I've seen this before a while back, when I was trying
>> to do a 'make -j2 check' on this slow board); but on the other
>> hand it's been fine recently but it failed twice trying to test
>> this pullreq.
>
> I don't have n aarch64 host, all I can say is that make check worked on
> x86_64.
>
> I would expect that this didn't change anything for prom enviroment, but
> one never knows :p
>
> I will wait to see if ppc folks can take a look at this.

I tried this pull again, and got two good test runs in a row,
so I suspect this is just the host being a bit slow and the
timeout being a bit enthusiastic.

Applied to master.

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1erYwQ-0007oE-IY
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 19:52:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1erYwM-0007sN-P1
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 19:52:54 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:45109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1erYwM-0007qz-J8
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 19:52:50 -0500
Received: by mail-vk0-f66.google.com with SMTP id k187so4848535vke.12
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 16:52:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9i+kAt4HgT-sfzJ+R491r5wjJwGkBRsPKwzoE2ZT5ibA@mail.gmail.com>
References: <20180301112403.12487-1-peter.maydell@linaro.org>
	<151990924540.1290.18181910407458585370@bdbb90650ae5>
	<CAFEAcA9i+kAt4HgT-sfzJ+R491r5wjJwGkBRsPKwzoE2ZT5ibA@mail.gmail.com>
From: Fam Zheng <famz@redhat.com>
Date: Fri, 2 Mar 2018 08:52:08 +0800
Message-ID: <CAK1Eb9nWGBxFvXrKKktbm0RcrKWFcgGKDUh97ag1-VtJ_45BCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/42] target-arm queue
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

On Thu, Mar 1, 2018 at 10:45 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 1 March 2018 at 13:00,  <no-reply@patchew.org> wrote:
>> Hi,
>>
>> This series seems to have some coding style problems. See output below for
>> more information:
>>
>> Type: series
>> Message-id: 20180301112403.12487-1-peter.maydell@linaro.org
>> Subject: [Qemu-devel] [PULL 00/42] target-arm queue
>
> Fam -- any idea why patchew sent two checkpatch-issues emails for
> this patchset ? The Message-IDs are:
> <151990924540.1290.18181910407458585370@bdbb90650ae5>
> <151990926291.1290.9842237231347453757@bdbb90650ae5>

A bug in patchew. The server dispatched the checkpatch task to two testers
when they asked for more work to do. One of them shouldn't happen.
I've worked around this in the config
(filtering the task into only one tester) now.

I created an issue.

https://github.com/patchew-project/patchew/issues/63

Fam

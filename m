Received: from eggs.gnu.org ([2001:4830:134:3::10]:56756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eD50R-0001nj-F9
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 03:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eD4zq-00036I-GK
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 03:49:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eD4zq-00035M-9K
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 03:49:06 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1508443483-5429-1-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA-R-3F8US1RGJVNyVnC81z9+1dd3Liq0tmVSNz1eDszbA@mail.gmail.com>
	<3d46d0f4463f337593b7347812f2de7e@codeaurora.org>
	<ae32fdee-2233-a99a-1fc9-0da58cf4d846@weilnetz.de>
	<CAFEAcA_KQyBAQ_cjTr8-pqSAibJOFc1mQF0yFgNyQNyzn8NzGg@mail.gmail.com>
Date: Fri, 10 Nov 2017 09:48:56 +0100
In-Reply-To: <CAFEAcA_KQyBAQ_cjTr8-pqSAibJOFc1mQF0yFgNyQNyzn8NzGg@mail.gmail.com>
	(Peter Maydell's message of "Sat, 21 Oct 2017 11:19:42 +0100")
Message-ID: <878tfe5xjb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] build: Don't force preserving permissions
 on config-devices.mak.old
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Weil <sw@weilnetz.de>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Paul Brook <paul@codesourcery.com>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 20 October 2017 at 20:08, Stefan Weil <sw@weilnetz.de> wrote:
>> Am 20.10.2017 um 20:24 schrieb alindsay@codeaurora.org:
>>> On 2017-10-20 05:27, Peter Maydell wrote:
>>>> Do we even need this code at all? As far as I can tell from
>>>> the git logs, the idea is to support users who hand-modify
>>>> config-devices.mak. But do we want to support that? I would
>>>> think of config-devices.mak as an internal part of the build
>>>> machinery, and the bit you can edit as a user is the stuff
>>>> in default-configs/.
>>
>> It's a long time since I wrote that code, but when I look at
>> the commit message for my commit 012f0879234, it was written
>> for users who do _not_ hand-modify config-devices.mak. They
>> had a problem when they updated the code from git and the
>> new version had changed some of the device configurations
>> which were used to build config-devices.mak.
>
> Right, but it's only this complicated set of conditions
> because we seem to be also trying to support the hand-modify
> case. Otherwise we could just generate the new version
> and copy it into place if it's changed, unconditionally...

So, do we need this patch?  If yes, who's going to merge it?  If no, do
we need some other patch?

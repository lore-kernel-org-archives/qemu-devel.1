Received: from eggs.gnu.org ([2001:4830:134:3::10]:35653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5qsv-00048H-60
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 06:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5qsu-0008GJ-8h
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 06:20:05 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:45721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5qsu-0008G8-2v
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 06:20:04 -0400
Received: by mail-wr0-x22b.google.com with SMTP id y9so1006460wrb.2
	for <qemu-devel@nongnu.org>; Sat, 21 Oct 2017 03:20:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ae32fdee-2233-a99a-1fc9-0da58cf4d846@weilnetz.de>
References: <1508443483-5429-1-git-send-email-alindsay@codeaurora.org>
	<CAFEAcA-R-3F8US1RGJVNyVnC81z9+1dd3Liq0tmVSNz1eDszbA@mail.gmail.com>
	<3d46d0f4463f337593b7347812f2de7e@codeaurora.org>
	<ae32fdee-2233-a99a-1fc9-0da58cf4d846@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 21 Oct 2017 11:19:42 +0100
Message-ID: <CAFEAcA_KQyBAQ_cjTr8-pqSAibJOFc1mQF0yFgNyQNyzn8NzGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Stefan Weil <sw@weilnetz.de>
Cc: Aaron Lindsay <alindsay@codeaurora.org>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paul Brook <paul@codesourcery.com>

On 20 October 2017 at 20:08, Stefan Weil <sw@weilnetz.de> wrote:
> Am 20.10.2017 um 20:24 schrieb alindsay@codeaurora.org:
>> On 2017-10-20 05:27, Peter Maydell wrote:
>>> Do we even need this code at all? As far as I can tell from
>>> the git logs, the idea is to support users who hand-modify
>>> config-devices.mak. But do we want to support that? I would
>>> think of config-devices.mak as an internal part of the build
>>> machinery, and the bit you can edit as a user is the stuff
>>> in default-configs/.
>
> It's a long time since I wrote that code, but when I look at
> the commit message for my commit 012f0879234, it was written
> for users who do _not_ hand-modify config-devices.mak. They
> had a problem when they updated the code from git and the
> new version had changed some of the device configurations
> which were used to build config-devices.mak.

Right, but it's only this complicated set of conditions
because we seem to be also trying to support the hand-modify
case. Otherwise we could just generate the new version
and copy it into place if it's changed, unconditionally...

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1da1P1-0005M5-Fo
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1da1Ox-0004gD-GM
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:05:39 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:37365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1da1Ox-0004ft-72
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:05:35 -0400
Received: by mail-wm0-x22f.google.com with SMTP id c184so58931429wmd.0
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 08:05:35 -0700 (PDT)
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-35-f4bug@amsat.org>
	<87k22weh78.fsf@linaro.org>
	<658ad40d-4bef-0da8-f7ea-88ae1bec3f12@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <658ad40d-4bef-0da8-f7ea-88ae1bec3f12@amsat.org>
Date: Tue, 25 Jul 2017 16:05:31 +0100
Message-ID: <87d18oeev8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.10 34/35] docker: add debian
 'bleeding' image with gcc7 and clang5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> On 07/25/2017 11:15 AM, Alex Bennée wrote:
>>> +++ b/tests/docker/dockerfiles/debian-bleeding-dev.docker
>>> @@ -0,0 +1,94 @@
>>> +#
>>> +# Docker x86_64 bleeding image
>>> +#
>>> +# This docker target builds on the debian unstable base image. Further
>>> +# libraries which are not widely available are installed by hand.
>>> +#
>>
>> Not for 2.10 please.
>
> Surely not ;) Also unlikely to get merged in mainline...
>
> [...]
>> There are a lot of moving parts basing this in debian unstable and
>> compiling extra bleeding edge stuff. What does this buy that the clang
>> and toolchain builds in Travis don't already cover?
>
> Bleeding is bleeding :) This is an implicit No Warranty clause...
> It might trigger something useful or give you slow death.
>
> https://wiki.debian.org/DebianUnstable
> "If you are a hardcore developer or tester you should use this release."
>
> https://www.debian.org/doc/manuals/securing-debian-howto/ch10.en.html#s10.1.3
> "you should not use Debian's unstable branch for production-level systems"

Quite but from a QEMU point of view these are being used for CI loops
and proving a known state of something for users to test on. As I said
in reply elsewhere I think to get the benefit of recent Clang and GCCs
it would be best to base of some sort of stable base.

--
Alex Bennée

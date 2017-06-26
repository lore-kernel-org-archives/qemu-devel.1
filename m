Received: from eggs.gnu.org ([2001:4830:134:3::10]:39337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPZWn-0001kn-UQ
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 15:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dPZWj-0006QR-Sn
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 15:18:29 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:33549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dPZWj-0006Pv-K9
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 15:18:25 -0400
Received: by mail-wr0-x22b.google.com with SMTP id r103so149280966wrb.0
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 12:18:23 -0700 (PDT)
References: <20170621024831.26019-1-rth@twiddle.net>
	<871sq6y9qh.fsf@linaro.org>
	<27cf9824-ee96-3a42-eefc-5a082267d708@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <27cf9824-ee96-3a42-eefc-5a082267d708@twiddle.net>
Date: Mon, 26 Jun 2017 20:19:12 +0100
Message-ID: <87zicuwo9b.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/16] Cleanups within TCG middle-end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, aurelien@aurel32.net


Richard Henderson <rth@twiddle.net> writes:

> On 06/26/2017 09:49 AM, Alex Bennée wrote:
>> Hmm it compile tested fine on mine but:
>>
>> qemu-system-sparc: /home/alex/lsrc/qemu/qemu.git/tcg/tcg.h:725: temp_arg: Assertion `n < tcg_ctx.nb_temps' failed.
>
> Bah.  I fixed this, and then lost it while rebasing.
> It's an uninitialized structure member.
>
>> And also Travis is quite un-happy:
>>
>>    https://travis-ci.org/stsquad/qemu/builds/247099991
>
> The only real failure I see in here is also GTESTER for sparc.
> Or am I missing something?

There is also a compile failure on Travis:

  https://travis-ci.org/stsquad/qemu/jobs/247099992#L3021
  https://travis-ci.org/stsquad/qemu/jobs/247099995#L3020

I hadn't actually clicked through all the failures because I assumed
they are mostly the same. I'll re-check on v2 ;-)

>
>
> r~


--
Alex Bennée

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPY6k-0004S7-Th
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 13:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPY6g-0000v4-3M
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 13:47:30 -0400
Received: from mail-qk0-x22b.google.com ([2607:f8b0:400d:c09::22b]:33852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPY6f-0000uQ-Uu
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 13:47:26 -0400
Received: by mail-qk0-x22b.google.com with SMTP id d78so7205653qkb.1
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 10:47:23 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170621024831.26019-1-rth@twiddle.net>
	<871sq6y9qh.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <27cf9824-ee96-3a42-eefc-5a082267d708@twiddle.net>
Date: Mon, 26 Jun 2017 10:47:19 -0700
MIME-Version: 1.0
In-Reply-To: <871sq6y9qh.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, aurelien@aurel32.net

On 06/26/2017 09:49 AM, Alex Bennée wrote:
> Hmm it compile tested fine on mine but:
> 
> qemu-system-sparc: /home/alex/lsrc/qemu/qemu.git/tcg/tcg.h:725: temp_arg: Assertion `n < tcg_ctx.nb_temps' failed.

Bah.  I fixed this, and then lost it while rebasing.
It's an uninitialized structure member.

> And also Travis is quite un-happy:
> 
>    https://travis-ci.org/stsquad/qemu/builds/247099991

The only real failure I see in here is also GTESTER for sparc.
Or am I missing something?


r~

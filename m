Received: from eggs.gnu.org ([2001:4830:134:3::10]:33016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBGT5-0000ce-5O
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:12:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBGT2-0003gG-IL
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:12:03 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:45751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fBGT2-0003fr-BP
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:12:00 -0400
Received: by mail-wr0-x242.google.com with SMTP id p5-v6so24796573wre.12
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 02:12:00 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-37-alex.bennee@linaro.org>
	<58540476-c2fc-81b7-d806-bad0db73e440@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <58540476-c2fc-81b7-d806-bad0db73e440@twiddle.net>
Date: Wed, 25 Apr 2018 10:11:58 +0100
Message-ID: <87d0ynlkf5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 36/46] tests/tcg/alpha: add Alpha
 specific tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org


Richard Henderson <rth@twiddle.net> writes:

> On 04/24/2018 05:23 AM, Alex Benn=C3=A9e wrote:
>> These tests are a little strange as they use their own crt.o stub
>> instead of the system supplied one. We also disable the multiarch
>> testthread test as that requires a dynamically linked build.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/tcg/alpha/Makefile         | 35 --------------------------------
>>  tests/tcg/alpha/Makefile.target  | 32 +++++++++++++++++++++++++++++
>>  tests/tcg/alpha/{crt.s =3D> crt.S} |  0
>>  3 files changed, 32 insertions(+), 35 deletions(-)
>>  delete mode 100644 tests/tcg/alpha/Makefile
>>  create mode 100644 tests/tcg/alpha/Makefile.target
>>  rename tests/tcg/alpha/{crt.s =3D> crt.S} (100%)
>
> Now that you have a cross-environment, you could simply drop the crt.o.
>
> There's nothing special in there at all; it was just someone's attempt to
> produce tests *without* a fill cross-environment.

Fair enough, I'll fix it up to be more normal.

--
Alex Benn=C3=A9e

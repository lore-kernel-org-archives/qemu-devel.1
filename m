Received: from eggs.gnu.org ([2001:4830:134:3::10]:35059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJQPF-0004Ga-Vz
	for qemu-devel@nongnu.org; Thu, 17 May 2018 17:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJQPB-0006JS-3v
	for qemu-devel@nongnu.org; Thu, 17 May 2018 17:25:50 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:43285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJQPA-0006Ia-TE
	for qemu-devel@nongnu.org; Thu, 17 May 2018 17:25:45 -0400
Received: by mail-wr0-x244.google.com with SMTP id v15-v6so7067915wrm.10
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 14:25:44 -0700 (PDT)
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-32-alex.bennee@linaro.org>
	<0f3f1135-79fd-ba0e-080d-5366eb99093f@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <0f3f1135-79fd-ba0e-080d-5366eb99093f@linaro.org>
Date: Thu, 17 May 2018 22:25:42 +0100
Message-ID: <87lgcidlex.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 31/49] tests/tcg/aarch64: add
 Makefile.target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 05/17/2018 10:47 AM, Alex Benn=C3=A9e wrote:
>> Nothing much here yet.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/tcg/aarch64/Makefile.target | 5 +++++
>>  1 file changed, 5 insertions(+)
>>  create mode 100644 tests/tcg/aarch64/Makefile.target
>>
>> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makef=
ile.target
>> new file mode 100644
>> index 0000000000..4ac8fbe73f
>> --- /dev/null
>> +++ b/tests/tcg/aarch64/Makefile.target
>> @@ -0,0 +1,5 @@
>> +# -*- Mode: makefile -*-
>> +#
>> +# AArch64 specific tweaks
>> +
>> +fcvt: LDFLAGS+=3D-lm
>>
>
> Merge this with adding fcvt, surely.

Yeah... too much shuffling around.
>
>
> r~


--
Alex Benn=C3=A9e

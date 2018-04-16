Received: from eggs.gnu.org ([2001:4830:134:3::10]:55278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f7zuF-00016T-Os
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:54:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f7zuC-0006La-Fv
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:54:35 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:45847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f7zuC-0006Kz-8w
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:54:32 -0400
Received: by mail-wr0-x242.google.com with SMTP id u11so23638201wri.12
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 01:54:32 -0700 (PDT)
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-22-alex.bennee@linaro.org>
	<52d9d0b8-6586-874a-1673-a1bf76ade9e3@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <52d9d0b8-6586-874a-1673-a1bf76ade9e3@amsat.org>
Date: Mon, 16 Apr 2018 09:54:29 +0100
Message-ID: <87d0yzbkfu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 21/24] tests/tcg: enable building for
 ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, famz@redhat.com, cota@braap.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi Alex,
>
> On 04/10/2018 04:39 PM, Alex Benn=C3=A9e wrote:
>> Currently this just enables building the multiarch tests.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> "make tcg-tests-ppc64-linux-user" works indeed.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Do we care about ppc[32]?

Yes, certainly I'll get anything working that we can reasonably do with
our docker images.

>
>> ---
>>  tests/tcg/ppc64/Makefile.include | 2 ++
>>  1 file changed, 2 insertions(+)
>>  create mode 100644 tests/tcg/ppc64/Makefile.include
>>=20
>> diff --git a/tests/tcg/ppc64/Makefile.include b/tests/tcg/ppc64/Makefile=
.include
>> new file mode 100644
>> index 0000000000..d71cfc9aa7
>> --- /dev/null
>> +++ b/tests/tcg/ppc64/Makefile.include
>> @@ -0,0 +1,2 @@
>> +DOCKER_IMAGE=3Ddebian-ppc64el-cross
>> +DOCKER_CROSS_COMPILER=3Dpowerpc64le-linux-gnu-gcc


--=20
Alex Benn=C3=A9e

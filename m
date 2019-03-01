Received: from eggs.gnu.org ([209.51.188.92]:46402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzcd5-0001sH-Ta
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 02:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzcd5-0007v5-0v
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 02:30:47 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzcd4-0007so-Nx
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 02:30:46 -0500
Received: by mail-wr1-x443.google.com with SMTP id f14so24719463wrg.1
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 23:30:46 -0800 (PST)
References: <20190228202537.4638-1-alex.bennee@linaro.org>
	<20190228202537.4638-8-alex.bennee@linaro.org>
	<CAMo8BfKw-ewHXQPfz6XDFBqoxPk1vTGaEhjVEdKLm3-diuTUmg@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAMo8BfKw-ewHXQPfz6XDFBqoxPk1vTGaEhjVEdKLm3-diuTUmg@mail.gmail.com>
Date: Fri, 01 Mar 2019 07:30:44 +0000
Message-ID: <87woljjbkr.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/16] tests/tcg/xtensa: enable system
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>


Max Filippov <jcmvbkbc@gmail.com> writes:

> Hi Alex,
>
> On Thu, Feb 28, 2019 at 12:25 PM Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
>
> [...]
>
>> diff --git a/tests/tcg/xtensa/Makefile.softmmu-target b/tests/tcg/xtensa=
/Makefile.softmmu-target
>> new file mode 100644
>> index 0000000000..1a4014506f
>> --- /dev/null
>> +++ b/tests/tcg/xtensa/Makefile.softmmu-target
>> @@ -0,0 +1,40 @@
>> +#
>> +# Xtensa softmmu tests
>> +#
>> +
>> +ifneq ($(TARGET_WORDS_BIGENDIAN),y)
>
> I've recently posted a series that makes it possible to run
> TCG tests on wider variety of xtensa cores, including
> big-endian cores:
> http://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg04843.html

Ahh I missed that, will have a look.

--
Alex Benn=C3=A9e

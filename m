Received: from eggs.gnu.org ([209.51.188.92]:52606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLu8k-00049g-PG
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLu8j-0003za-Rf
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:39:34 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:33044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLu8i-0003sk-0d
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:39:33 -0400
Received: by mail-pg1-x533.google.com with SMTP id k19so8664416pgh.0
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 11:39:30 -0700 (PDT)
References: <20190430165234.32272-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9a538ea2-358a-dc61-b2f3-f8155c1a2283@linaro.org>
Date: Wed, 1 May 2019 11:39:26 -0700
MIME-Version: 1.0
In-Reply-To: <20190430165234.32272-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 00/15] demacro softmmu (plus
 tests/coverage)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org

On 4/30/19 9:52 AM, Alex Bennée wrote:
> I've also moved the existing system memory test and made it multiarch
> and added the bootstrapping for aarch64 system tests. I would like to
> add support for Big Endian as well but I didn't want to delay the
> posting of the series. It would also be nice to exercise the
> ioread/write paths and other handling but I leave this as an exercise
> for later.

Somewhere in there you're adding

  -chardev file,path=hello.out,id=output

but there's no corresponding use of the chardev.
Which, somehow doesn't seem to matter to your aarch64
testcase, but when I try this for alpha I truly get
no output at all.  I needed

  -serial chardev:output

to populate the file.


r~

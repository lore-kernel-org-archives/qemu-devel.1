Received: from eggs.gnu.org ([209.51.188.92]:52024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hNOWj-00061A-9s
	for qemu-devel@nongnu.org; Sun, 05 May 2019 17:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hNOWg-0003aq-71
	for qemu-devel@nongnu.org; Sun, 05 May 2019 17:18:28 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hNOWd-00036Z-0D
	for qemu-devel@nongnu.org; Sun, 05 May 2019 17:18:24 -0400
Received: by mail-wr1-x443.google.com with SMTP id a12so4595511wrn.4
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 14:18:19 -0700 (PDT)
References: <20190502143409.59600-1-ysato@users.sourceforge.jp>
	<20190502143409.59600-13-ysato@users.sourceforge.jp>
	<87muk34kym.fsf@zen.linaroharston>
	<3d73dc0e-dd08-9900-481c-232ad303a6f0@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <3d73dc0e-dd08-9900-481c-232ad303a6f0@linaro.org>
Date: Sun, 05 May 2019 22:18:17 +0100
Message-ID: <875zqobnxi.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v8 12/12] hw/registerfields.h: Add 8bit
 and 16bit register macros.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Yoshinori Sato <ysato@users.sourceforge.jp>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 5/3/19 8:27 AM, Alex Benn=C3=A9e wrote:
>>
>> Yoshinori Sato <ysato@users.sourceforge.jp> writes:
>>
>>> Some RX peripheral using 8bit and 16bit registers.
>>> Added 8bit and 16bit APIs.
>>
>> Doesn't this mean the build breaks at some point? Features used by other
>> patches should be introduced first so the build remains bisectable.
>
> The only bug I would fix in the ordering is to make the change to configu=
re
> last, so that the target/rx is not enabled while the patches are
> staging.

That will do - the key thing is each interim position in the commit log
can build on it's own.

--
Alex Benn=C3=A9e

Received: from eggs.gnu.org ([209.51.188.92]:59167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMDXm-0004mX-SZ
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMDXl-0004cr-Tv
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:22:42 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMDXl-0004XS-Md
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:22:41 -0400
Received: by mail-wr1-x443.google.com with SMTP id f7so3963489wrs.2
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 08:22:41 -0700 (PDT)
References: <20190501223819.8584-1-richard.henderson@linaro.org>
	<20190502040459.GE13618@umbus.fritz.box>
	<5aca63b1-72e9-9402-8828-d2dd054b3313@linaro.org>
	<87h8ad5e0h.fsf@zen.linaroharston>
	<e7318909-cae9-eef5-7f59-c9a2992fffeb@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <e7318909-cae9-eef5-7f59-c9a2992fffeb@linaro.org>
Date: Thu, 02 May 2019 16:22:37 +0100
Message-ID: <875zqs6fuq.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] configure: Fix make check-tcg for
 ppc64le
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> On 5/2/19 3:47 AM, Alex Benn=C3=A9e wrote:
>>> This needs a different set of cleanups.  ;-)
>>
>> I guess this is another use case for softmmu support in linux-user where
>> HOST_PAGE !=3D TARGET_PAGE?
>
> Well, yes, but I was thinking more short-term, wherein we do not test thi=
ngs
> that we know will not work.  E.g. testing 4k pages on a 64k page host.

I guess we could add something to configure to emit the host page size
so we can conditionalise the tests. Or just fix mmap to take advantage
of the fact that getpagesize() reports the host page size and nope out
when that is greater than test-mmap -p....

>
>
> r~


--
Alex Benn=C3=A9e

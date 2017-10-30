Received: from eggs.gnu.org ([2001:4830:134:3::10]:40921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e91Lp-0006wh-Vh
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 00:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e91Lm-00067i-Qv
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 00:07:01 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:43918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e91Lm-00067P-BC
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 00:06:58 -0400
Received: by mail-qk0-x241.google.com with SMTP id w134so14624590qkb.0
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 21:06:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20171026135814.20773-1-richard.henderson@linaro.org>
	<CAFEAcA8mVtira5AMwwASg9+eRx=nge-SR2YEnNnEoxF86wNHqA@mail.gmail.com>
	<16b4f2f3-28ee-7e5b-d477-547e02fc6a94@amsat.org>
Message-ID: <31631654-b18b-edbd-d94e-281010b53f9f@amsat.org>
Date: Mon, 30 Oct 2017 01:06:49 -0300
MIME-Version: 1.0
In-Reply-To: <16b4f2f3-28ee-7e5b-d477-547e02fc6a94@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg: Avoid setting tcg_initialize if
 !CONFIG_TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>

>>> Fix the build for --disable-tcg.
>>>
>>> Fixes: 55c3ceef61fcf06fc98ddc752b7cce788ce7680b
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>
>> Applied to master as a buildfix, thanks.
> 
> I couldn't see this buildfix merged in /master so I provided another
> version using stubs and details about offending commits there:
> 
> http://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg06530.html
> 
> In case you didn't pushed to /master you might consider this series instead.

Oops sorry I missed it in commit 74d7fc7f6385  and the conflicting merge
6e6430a821a1.

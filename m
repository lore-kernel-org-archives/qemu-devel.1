Received: from eggs.gnu.org ([2001:4830:134:3::10]:35974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e90hS-0000Pu-Ha
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 23:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e90hP-0003AW-CQ
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 23:25:18 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:47855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e90hP-0003AC-39
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 23:25:15 -0400
Received: by mail-qt0-x243.google.com with SMTP id z50so14754627qtj.4
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 20:25:15 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171026135814.20773-1-richard.henderson@linaro.org>
	<CAFEAcA8mVtira5AMwwASg9+eRx=nge-SR2YEnNnEoxF86wNHqA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <16b4f2f3-28ee-7e5b-d477-547e02fc6a94@amsat.org>
Date: Mon, 30 Oct 2017 00:25:03 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8mVtira5AMwwASg9+eRx=nge-SR2YEnNnEoxF86wNHqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

Hi Peter,

On 10/27/2017 04:03 AM, Peter Maydell wrote:
> On 26 October 2017 at 14:58, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Fix the build for --disable-tcg.
>>
>> Fixes: 55c3ceef61fcf06fc98ddc752b7cce788ce7680b
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
> 
> Applied to master as a buildfix, thanks.

I couldn't see this buildfix merged in /master so I provided another
version using stubs and details about offending commits there:

http://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg06530.html

In case you didn't pushed to /master you might consider this series instead.

I didn't include ARM/MIPS/PPC since they don't support building without
TCG (yet).

Regards,

Phil.

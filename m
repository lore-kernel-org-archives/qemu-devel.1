Received: from eggs.gnu.org ([2001:4830:134:3::10]:34296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drrd8-0006T4-Tw
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 16:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drrd5-0006gK-Ih
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 16:17:58 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drrd5-0006fa-DA
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 16:17:55 -0400
Received: by mail-qk0-x242.google.com with SMTP id d70so7831677qkc.1
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 13:17:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170912162513.21694-1-richard.henderson@linaro.org>
	<20170912162513.21694-8-richard.henderson@linaro.org>
	<CAFEAcA_wFNHcHtQYpv1GyQDUF9LU95kw2RrboYB0J0LCiMZi4A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ac7c2fe2-be97-bea9-e7d9-4c17afd1fa1e@amsat.org>
Date: Tue, 12 Sep 2017 17:17:51 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_wFNHcHtQYpv1GyQDUF9LU95kw2RrboYB0J0LCiMZi4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 07/16] target/arm: Align vector registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 09/12/2017 03:55 PM, Peter Maydell wrote:
> I notice we have a QEMU_ALIGNED() macro to wrap the __attribute__,
> though we use it less often than not at the moment...

Aesthetic aside, I find it useful to deal with the 80 characters style 
limit.

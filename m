Received: from eggs.gnu.org ([209.51.188.92]:40447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goEye-0001G0-Oj
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:02:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goEyd-0000ac-Vw
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:02:00 -0500
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:33003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1goEyd-0000aE-CF
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:01:59 -0500
Received: by mail-yb1-xb42.google.com with SMTP id m132so5647439ybf.0
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:01:59 -0800 (PST)
References: <20190110121736.23448-1-richard.henderson@linaro.org>
	<20190110121736.23448-9-richard.henderson@linaro.org>
	<CAFEAcA9+8XBXDqL8JfTpS8q05XwaZ+Ck1nqAhTLsyN_=WCjXNA@mail.gmail.com>
	<13b8c253-d3da-3bca-de83-ea9422d5f30f@linaro.org>
	<CAFEAcA8rzNDhgqrzei7L3X=WbnZV-1jVUcob50orPmw8twjjpg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5b34e426-36d0-eebf-2742-2997d551e7fe@linaro.org>
Date: Mon, 28 Jan 2019 14:01:55 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8rzNDhgqrzei7L3X=WbnZV-1jVUcob50orPmw8twjjpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/11] target/arm: Add guarded_pages cpu
 property for user-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1/22/19 8:57 AM, Peter Maydell wrote:
>>> This is OK code-wise but I'm a bit wary of committing it
>>> because then we're stuck with the property forever even
>>> if it turns out to be irrelevant to whatever the userland
>>> ABI eventually is.
>>
>> That's surely simply a matter of documentation.
>> "Don't rely on this property: it will go away."
> 
> Convention is that those should be prefixed with "x-".

Ok, done.


r~

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddOFA-0001Pu-Q1
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 18:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddOF7-00029a-1c
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 18:05:24 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-10-git-send-email-peter.maydell@linaro.org>
	<20170803153800.GR4859@toto>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <854126f3-84da-087c-f35b-480165871e7f@twiddle.net>
Date: Thu, 3 Aug 2017 15:05:17 -0700
MIME-Version: 1.0
In-Reply-To: <20170803153800.GR4859@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 09/15] target/arm: Don't store M
 profile PRIMASK and FAULTMASK in daif
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

On 08/03/2017 08:38 AM, Edgar E. Iglesias wrote:
>> +        uint32_t primask;
>> +        uint32_t faultmask;
> It seems like these could be booleans?

I was thinking the same thing until I read the v8m description as a 32-bit
register.  This makes qemu match the spec, which has value.


r~

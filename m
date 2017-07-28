Received: from eggs.gnu.org ([2001:4830:134:3::10]:34371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1db7o3-0007LK-F2
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1db7ny-000296-Hc
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:08:03 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-13-alex.bennee@linaro.org>
	<4d6ac494-d606-ebaf-6498-7c526467ac62@twiddle.net>
	<87y3r8d8de.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f69bce67-6458-9a95-3abe-a91564ac46b8@twiddle.net>
Date: Fri, 28 Jul 2017 09:07:52 -0700
MIME-Version: 1.0
In-Reply-To: <87y3r8d8de.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11 12/23]
 target/arm/translate-a64.c: add FP16 FAGCT to AdvSIMD 3 Same
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 07/28/2017 06:00 AM, Alex Bennée wrote:
>      uint_fast8_t *old_fpst = softfloat_exceptionFlags;
>      softfloat_exceptionFlags = (uint_fast8t *) fpstp;

Better, but not best.  We still need to collect all of the different variables 
that are currently members of float_status, of which this is but one.

For QEMU purposes, I wonder if resetting this to NULL when leaving the 
softfloat helper would be best.


r~

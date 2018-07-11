Received: from eggs.gnu.org ([2001:4830:134:3::10]:56998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fdLOc-0000eo-8g
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fdLOZ-0008Pp-4J
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:07:30 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:52317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fdLOY-0008PC-UJ
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:07:27 -0400
Received: by mail-it0-x241.google.com with SMTP id p4-v6so4373669itf.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 13:07:26 -0700 (PDT)
References: <20180711103957.3040-1-richard.henderson@linaro.org>
	<CABoDooMcGmex9s58D=bH-GTM0jkCUTNyx5A+JXE_Hyd--kBgbg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5f346b0d-f3e9-c32c-393f-b5f62b176cd5@linaro.org>
Date: Wed, 11 Jul 2018 06:23:59 -0700
MIME-Version: 1.0
In-Reply-To: <CABoDooMcGmex9s58D=bH-GTM0jkCUTNyx5A+JXE_Hyd--kBgbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0] target/arm: Fix LD1W and LDFF1W
 (scalar plus vector)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Desnogues <laurent.desnogues@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 07/11/2018 04:04 AM, Laurent Desnogues wrote:
> Hello,
> 
> On Wed, Jul 11, 2018 at 12:39 PM, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> 'I' was being double-incremented; correctly within the inner loop
>> and incorrectly within the outer loop.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> I didn't try to apply the patch but line numbers look wrong.
> 
> I guess this should apply to DO_LD1_ZPZ_S and DO_LDFF1_ZPZ macros, in
> which case you get my review:

The patch was pulled out of the middle of a branch,
so the line numbers might be off.  I probably should
have cherry-picked it to master before posting...


r~

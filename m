Received: from eggs.gnu.org ([209.51.188.92]:33834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMDkj-0001SC-DV
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMDki-0006Gh-8c
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:36:05 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:42982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMDki-0006GR-1i
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:36:04 -0400
Received: by mail-pf1-x429.google.com with SMTP id 13so998455pfw.9
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 08:36:03 -0700 (PDT)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-13-richard.henderson@linaro.org>
	<87ef5h56nx.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7db35187-c7c8-a95e-2d26-efc0339acad6@linaro.org>
Date: Thu, 2 May 2019 08:35:59 -0700
MIME-Version: 1.0
In-Reply-To: <87ef5h56nx.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 12/29] tcg/aarch64: Implement
 tcg_out_dupm_vec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On 5/2/19 6:26 AM, Alex Bennée wrote:
>> +    /* AdvSIMD load/store single structure.  */
>> +    I3303_LD1R      = 0x0d40c000,
>> +
> 
> I can't recall where these magic numbers come from again? The (moving)
> section numbers of the ARM ARM?

They come from the A_a version of the ARM ARM.

The current D_a version has now even removed the section numbers, instead of
slowly modifying them as they did through B and C revisions.

> I was hoping the XML had a bit more guidance on the encoding names but
> we get:

Yeah, ARM doesn't name these at all.

I have wondered if they are adverse to naming encodings, because if they had to
name them all they would feel constrained to not invent so many strange
encodings.  ;-)

> The above is basically a winge as to what do we really get out of this
> "type checking"?

Well, ignore the "type checking" for a moment.

How would you distinguish all of the different encoding functions?
Or would you just open-code every single instruction like we do in
tcg/arm/ and tcg/ppc/?

Let me know if you come up with a scheme that works better than this.



r~

Received: from eggs.gnu.org ([2001:4830:134:3::10]:41188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gH6iz-0000A4-M4
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gH6iv-0001E9-O3
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:32:53 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:37281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gH6iv-0001Ag-F6
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:32:49 -0400
Received: by mail-wr1-x436.google.com with SMTP id g9-v6so8492901wrq.4
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 05:32:49 -0700 (PDT)
References: <CAFEAcA-=Wqxp1GOtBOZpck9J-LUgDhthP5u9PQuT-2fGdz9mwQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <27ed2a56-987d-677b-1457-3428aca19d49@linaro.org>
Date: Mon, 29 Oct 2018 12:32:45 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-=Wqxp1GOtBOZpck9J-LUgDhthP5u9PQuT-2fGdz9mwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] a64 simd decode in handle_vec_simd_shli()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 10/29/18 12:06 PM, Peter Maydell wrote:
> I'm having difficulty figuring out where this check has come from;
> it doesn't seem to match up with the pseudocode and in any case
> I don't think size can ever be > 3. We calculate:
> 
>     int size = 32 - clz32(immh) - 1;
> where immh is a 4 bit field which we know cannot be all-zeroes.
> So the clz32() return must be in {28,29,30,31} and the resulting
> size is in {0,1,2,3}, so the check above can't ever fire.

Correct.

The check appeared with the initial commit for aa64 support, so perhaps Alex
just trying to be defensive in his coding?

> Am I missing something? As far as I can see we should simply delete
> the can't-happen condition, which will probably satisfy coverity.

Agreed.


r~

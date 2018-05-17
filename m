Received: from eggs.gnu.org ([2001:4830:134:3::10]:54528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJPY3-0004IA-3h
	for qemu-devel@nongnu.org; Thu, 17 May 2018 16:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJPY0-00047i-0o
	for qemu-devel@nongnu.org; Thu, 17 May 2018 16:30:51 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:39871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJPXz-00047O-Qk
	for qemu-devel@nongnu.org; Thu, 17 May 2018 16:30:47 -0400
Received: by mail-pf0-x243.google.com with SMTP id a22-v6so2631085pfn.6
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 13:30:47 -0700 (PDT)
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-33-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9ef2bc85-cead-080c-8313-bf0113d5019e@linaro.org>
Date: Thu, 17 May 2018 13:30:44 -0700
MIME-Version: 1.0
In-Reply-To: <20180517174718.10107-33-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 32/49] tests/tcg/arm: add fcvt test
 cases for AArch32/64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 05/17/2018 10:47 AM, Alex Bennée wrote:
> This runs through the usual float to float conversions and crucially
> also runs with ARM Alternative Half Precision Format.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> [rth: tweak vcvtb.f16.f32/vctb.f32.f16 code and regen]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> ---
> v4
>   - add fcvt.ref and check results against it
>   - fix single_to_half, single_to_double conversions
>   - properly toggle AHP mode (fpsr->fpcr)
>   - more values around the AHP margins
>   - add INF/NAN/SNAN inputs
>   - build for ARM and AArch64
>   - fix bug for hex literals
>   - add float-to-int
>   - checkpatch fix
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

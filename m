Received: from eggs.gnu.org ([2001:4830:134:3::10]:55641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSqNA-0001jL-0k
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 16:58:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSqN5-0001pE-7d
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 16:58:36 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:42177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSqN5-0001p6-1C
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 16:58:31 -0400
Received: by mail-pl0-x241.google.com with SMTP id w17-v6so170826pll.9
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 13:58:30 -0700 (PDT)
References: <20180611171007.4165-1-peter.maydell@linaro.org>
	<20180611171007.4165-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c804c5dd-aa13-982e-df73-f18e3b010aa6@linaro.org>
Date: Tue, 12 Jun 2018 10:58:26 -1000
MIME-Version: 1.0
In-Reply-To: <20180611171007.4165-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] exec.c: Don't accidentally sign-extend
 4-byte loads in subpage_read()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, patches@linaro.org

On 06/11/2018 07:10 AM, Peter Maydell wrote:
> In subpage_read() we perform a load of the data into a local buffer
> which we then access using ldub_p(), lduw_p(), ldl_p() or ldq_p()
> depending on its size, storing the result into the uint64_t *data.
> Since ldl_p() returns an 'int', this means that for the 4-byte
> case we will sign-extend the data, whereas for 1 and 2 byte
> reads we zero-extend it.
> 
> This ought not to matter since the caller will likely ignore values in
> the high bytes of the data, but add a cast so that we're consistent.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

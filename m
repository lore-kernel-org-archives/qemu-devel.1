Received: from eggs.gnu.org ([2001:4830:134:3::10]:55624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSqMx-0001e6-Sa
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 16:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSqMt-0001m1-1d
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 16:58:23 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSqMs-0001lb-Pg
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 16:58:18 -0400
Received: by mail-pg0-x244.google.com with SMTP id q4-v6so153967pgr.1
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 13:58:18 -0700 (PDT)
References: <20180611171007.4165-1-peter.maydell@linaro.org>
	<20180611171007.4165-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a94723d8-d510-428e-ebf4-2bc6072e5900@linaro.org>
Date: Tue, 12 Jun 2018 10:58:12 -1000
MIME-Version: 1.0
In-Reply-To: <20180611171007.4165-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] exec.c: Use stn_p() and ldn_p()
 instead of explicit switches
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
> Now we have stn_p() and ldn_p() we can use them in various
> functions in exec.c that used to have their own switch-on-size code.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

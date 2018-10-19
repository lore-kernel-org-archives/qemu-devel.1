Received: from eggs.gnu.org ([2001:4830:134:3::10]:47261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDY56-0000jQ-FZ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:57:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gDY52-0008Ud-3s
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:57:00 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gDY50-0008Si-Q7
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:56:55 -0400
Received: by mail-pg1-x543.google.com with SMTP id o14-v6so297381pgv.7
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 09:56:54 -0700 (PDT)
References: <20181019104326.28052-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <692a2123-e247-5c45-23a3-99c4d3b7c0d4@linaro.org>
Date: Fri, 19 Oct 2018 09:56:50 -0700
MIME-Version: 1.0
In-Reply-To: <20181019104326.28052-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] configure: set cross_cc_FOO from cc,
 not host_cc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On 10/19/18 3:43 AM, Alex Bennée wrote:
> The purpose of the code is to use the designated compiler for building
> the targets test cases. This is not actually host_cc which will still
> be cc even when we are cross compiling. As the tests for $cpu all use
> $cc we should do the same.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  configure | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Tested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

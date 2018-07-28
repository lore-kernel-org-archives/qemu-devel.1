Received: from eggs.gnu.org ([2001:4830:134:3::10]:41105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fjSLi-0004FA-58
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 12:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fjSLf-0002s7-2h
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 12:45:46 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fjSLe-0002rg-SH
	for qemu-devel@nongnu.org; Sat, 28 Jul 2018 12:45:42 -0400
Received: by mail-pf1-x441.google.com with SMTP id e13-v6so2794556pff.7
	for <qemu-devel@nongnu.org>; Sat, 28 Jul 2018 09:45:42 -0700 (PDT)
References: <20180726132947.28538-1-alex.bennee@linaro.org>
	<20180726132947.28538-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1b17d5a4-52be-58ac-8f19-862261451e50@linaro.org>
Date: Sat, 28 Jul 2018 09:45:39 -0700
MIME-Version: 1.0
In-Reply-To: <20180726132947.28538-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 for 3.0 2/2] tests: add
 check_invalid_maps to test-mmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: umarcor <1783362@bugs.launchpad.net>

On 07/26/2018 06:29 AM, Alex Bennée wrote:
> This adds a test to make sure we fail properly for a 0 length mmap.
> There are most likely other failure conditions we should also check.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: umarcor <1783362@bugs.launchpad.net>
> ---
>  tests/tcg/multiarch/test-mmap.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Might want to test length of e.g. -4 as well, which should get ENOMEM.


r~

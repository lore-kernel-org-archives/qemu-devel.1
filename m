Received: from eggs.gnu.org ([209.51.188.92]:39519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwWuE-0000tt-Go
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwWqY-0008Tv-47
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:43:55 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwWqW-0008TM-NG
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:43:53 -0500
Received: by mail-pg1-x544.google.com with SMTP id y1so12290109pgk.11
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 10:43:52 -0800 (PST)
References: <20190220172811.10588-1-alex.bennee@linaro.org>
	<20190220172811.10588-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b78e8478-8a5b-de50-75c6-154ccc35bb52@linaro.org>
Date: Wed, 20 Feb 2019 10:43:48 -0800
MIME-Version: 1.0
In-Reply-To: <20190220172811.10588-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 8/8] tests/softfloat: always do quick
 softfloat tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org

On 2/20/19 9:28 AM, Alex Bennée wrote:
> Some operations take a long time and enabling "-l 2 -r all" can take
> more than a day which is stretching the definition of a "slow" test.
> Lets default to the quick test and leave a note for those who wish to
> run by hand.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/Makefile.include | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

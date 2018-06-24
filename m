Received: from eggs.gnu.org ([2001:4830:134:3::10]:56921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXDjM-00062s-Ls
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 18:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXDjI-000380-3H
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 18:43:36 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:42398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXDjH-00037e-Tj
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 18:43:32 -0400
Received: by mail-pg0-x244.google.com with SMTP id c10-v6so5202024pgu.9
	for <qemu-devel@nongnu.org>; Sun, 24 Jun 2018 15:43:31 -0700 (PDT)
References: <20180622141205.16306-1-alex.bennee@linaro.org>
	<20180622141205.16306-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5a93b198-081b-590b-5080-0e493dbc5456@linaro.org>
Date: Sun, 24 Jun 2018 15:43:27 -0700
MIME-Version: 1.0
In-Reply-To: <20180622141205.16306-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v4 07/22] risugen: add --sve support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 06/22/2018 07:11 AM, Alex Bennée wrote:
> This is similar to the approach used by the FP/simd data in so far as
> we generate a block of random data and then load into it. The loading
> is actually done by the current vector length but that is implicit in
> the run anyway.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - only one SIMD/FP/SVE block as they alias
>   - move efficient loading as suggested by Dave
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

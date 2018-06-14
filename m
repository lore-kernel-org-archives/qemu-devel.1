Received: from eggs.gnu.org ([2001:4830:134:3::10]:47712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTYjx-0000h9-9i
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTYjt-0002lM-Gh
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:21:05 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:38858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTYjt-0002kb-AD
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:21:01 -0400
Received: by mail-pl0-x242.google.com with SMTP id b14-v6so4126476pls.5
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 13:21:01 -0700 (PDT)
References: <20180613125601.14371-1-alex.bennee@linaro.org>
	<20180613125601.14371-14-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0238382a-6265-789f-0b0a-256357366613@linaro.org>
Date: Thu, 14 Jun 2018 10:20:55 -1000
MIME-Version: 1.0
In-Reply-To: <20180613125601.14371-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v3 13/22] risu: move optional args to
 each architecture
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

On 06/13/2018 02:55 AM, Alex Bennée wrote:
> The key variables here are: *arch_long_opts and *arch_extra_help. If
> they are not NULL then we concatenate the extra options to appropriate
> structure to enable the support. Adding architecture short options is
> not supported.
> 
> This also includes moving the ARM specific test_fp_exc/test-fp-exc
> into ARM specific code.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - better concatenation of default and extra opts

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

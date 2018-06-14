Received: from eggs.gnu.org ([2001:4830:134:3::10]:36188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTL2z-0000gK-75
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 01:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTL2w-0002pb-7x
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 01:43:49 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:39136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTL2w-0002pN-37
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 01:43:46 -0400
Received: by mail-pl0-x242.google.com with SMTP id f1-v6so2875078plt.6
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 22:43:45 -0700 (PDT)
References: <20180613125601.14371-1-alex.bennee@linaro.org>
	<20180613125601.14371-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6006f5da-f3ae-be22-71f4-4beb12ceb4bd@linaro.org>
Date: Wed, 13 Jun 2018 19:43:40 -1000
MIME-Version: 1.0
In-Reply-To: <20180613125601.14371-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v3 04/22] build-all-arches: do a
 distclean $(SRC) configured
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
> This can cause much confusion when you have been building in your
> source tree. I've added a distclean so we don't unexpectedly drop the
> config for normal make clean invocations.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  Makefile        |  3 +++
>  build-all-archs | 10 ++++++++++
>  2 files changed, 13 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

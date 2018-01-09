Received: from eggs.gnu.org ([2001:4830:134:3::10]:56055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYxXl-0000WV-GT
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYxXi-00037t-Ck
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:18:33 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eYxXi-00037K-6E
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:18:30 -0500
Received: by mail-pf0-x244.google.com with SMTP id y89so9010466pfk.0
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 09:18:30 -0800 (PST)
References: <20180109122252.17670-1-alex.bennee@linaro.org>
	<20180109122252.17670-21-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fc6481a6-4270-b465-9747-566eef246d0f@linaro.org>
Date: Tue, 9 Jan 2018 09:18:26 -0800
MIME-Version: 1.0
In-Reply-To: <20180109122252.17670-21-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 20/20] fpu/softfloat: re-factor compare
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 01/09/2018 04:22 AM, Alex Bennée wrote:
> The compare function was already expanded from a macro. I keep the
> macro expansion but move most of the logic into a compare_decomposed.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - minor re-factor for better inf handling
> ---
>  fpu/softfloat.c         | 134 +++++++++++++++++++++++++++++-------------------
>  include/fpu/softfloat.h |   2 +
>  2 files changed, 82 insertions(+), 54 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

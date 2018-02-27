Received: from eggs.gnu.org ([2001:4830:134:3::10]:54910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqmCm-0000ps-BM
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:50:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqmCh-0006A0-Ep
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:50:32 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:37776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eqmCh-00069m-9M
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:50:27 -0500
Received: by mail-pl0-x242.google.com with SMTP id ay8-v6so113990plb.4
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 12:50:27 -0800 (PST)
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4f53d440-550d-a665-2c84-490c8b90720d@linaro.org>
Date: Tue, 27 Feb 2018 12:50:23 -0800
MIME-Version: 1.0
In-Reply-To: <20180220180325.29818-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/19] hw/misc/unimp: Move struct to header
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 02/20/2018 10:03 AM, Peter Maydell wrote:
> Move the definition of the struct for the unimplemented-device
> from unimp.c to unimp.h, so that users can embed the struct
> in their own device structs if they prefer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/misc/unimp.h | 10 ++++++++++
>  hw/misc/unimp.c         | 10 ----------
>  2 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

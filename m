Received: from eggs.gnu.org ([2001:4830:134:3::10]:48797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g08Ao-0000CQ-Ms
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g08Ak-0005k9-Lt
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:39:26 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g08Ak-0005jb-6z
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:39:22 -0400
Received: by mail-pf1-x443.google.com with SMTP id d4-v6so1295438pfn.0
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 09:39:21 -0700 (PDT)
References: <20180910185859.27917-1-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dce7a159-4a8b-f942-ecc1-f2d4be7ca96b@linaro.org>
Date: Wed, 12 Sep 2018 09:39:17 -0700
MIME-Version: 1.0
In-Reply-To: <20180910185859.27917-1-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/12] qht improvements for 3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 09/10/2018 11:58 AM, Emilio G. Cota wrote:
> v1: https://github.com/cota/qemu/tree/qht-for-3.1-v2
> 
> Changes since v1:
> 
> - Added Alex's R-b tags to patches 1-6
> - Added a patch to drop *ht from qht_iter and qht_iter_remove,
>   as suggested by Alex.
> - Added some constification patches
> - Added a flag to qht-bench to precompute the hashes, which
>   allows us to spend more time accessing the hash table
>   thereby yielding higher throughput.
> 
> You can fetch this series from:
>   https://github.com/cota/qemu/tree/qht-for-3.1-v2

Applied to tcg-next.


r~

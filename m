Received: from eggs.gnu.org ([2001:4830:134:3::10]:48031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTrKD-0003fg-U8
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gTrK9-0004Ny-RM
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:44:01 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:32977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gTrK9-0004Nb-9c
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:43:57 -0500
Received: by mail-ot1-x343.google.com with SMTP id i20so12216838otl.0
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 08:43:57 -0800 (PST)
References: <1543848532-12604-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1543848532-12604-3-git-send-email-lizhijian@cn.fujitsu.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b5498579-41af-a51c-4256-5b337e7df281@linaro.org>
Date: Mon, 3 Dec 2018 10:43:53 -0600
MIME-Version: 1.0
In-Reply-To: <1543848532-12604-3-git-send-email-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 2/4] refactor load_image_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-devel@nongnu.org, mst@redhat.com, peter.maydell@linaro.org
Cc: philip.li@intel.com, zhijianx.li@intel.com

On 12/3/18 8:48 AM, Li Zhijian wrote:
> Don't expect read(2) can always read as many as it's told.
> 
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  hw/core/loader.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

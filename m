Received: from eggs.gnu.org ([2001:4830:134:3::10]:53491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9w8V-0005H1-B5
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:49:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9w8Q-0000Me-AC
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:49:35 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g9w8P-0000KF-Pd
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:49:30 -0400
Received: by mail-pl1-x642.google.com with SMTP id c8-v6so1184114plo.9
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 10:49:29 -0700 (PDT)
References: <20181009172501.17353-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <806d9a66-78bb-ab15-dbcf-b48a0ca777c4@linaro.org>
Date: Tue, 9 Oct 2018 10:49:25 -0700
MIME-Version: 1.0
In-Reply-To: <20181009172501.17353-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] block/qcow*: Don't take address of
 fields in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 10/9/18 10:24 AM, Peter Maydell wrote:
> Peter Maydell (3):
>   block/qcow2: Don't take address of fields in packed structs
>   block/qcow: Don't take address of fields in packed structs
>   block/qcow2-bitmap: Don't take address of fields in packed structs

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Although I do think you should put the script you used into
scripts/coccinelle/, so that it may be used for the rest of the files in the
tree.  We can delete the script after those pointer-based functions are removed.


r~

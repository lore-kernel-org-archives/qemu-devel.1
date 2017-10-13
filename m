Received: from eggs.gnu.org ([2001:4830:134:3::10]:60575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e30Ts-00068I-6W
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e30Tp-00024m-5W
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:58:28 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:56230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e30To-00021u-Ui
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 09:58:25 -0400
Received: by mail-pf0-x22b.google.com with SMTP id 17so10320144pfn.12
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 06:58:24 -0700 (PDT)
References: <20171013134930.32547-1-shorne@gmail.com>
	<20171013134930.32547-3-shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <068db9d2-2805-2dac-4c19-efc6d187db44@linaro.org>
Date: Fri, 13 Oct 2017 06:58:21 -0700
MIME-Version: 1.0
In-Reply-To: <20171013134930.32547-3-shorne@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] target/openrisc: Make coreid and
 numcores variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Openrisc <openrisc@lists.librecores.org>

On 10/13/2017 06:49 AM, Stafford Horne wrote:
> Previously coreid and numcores were hard coded as 0 and 1 respectively
> as OpenRISC QEMU did not have multicore support.
> 
> Multicore support is now being added so these registers need to have
> configured values.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  target/openrisc/sys_helper.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

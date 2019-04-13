Received: from eggs.gnu.org ([209.51.188.92]:43403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBb0-0000bg-QY
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBb0-0001B5-2B
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:52:58 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:42239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFBaz-0001Ag-Oi
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:52:58 -0400
Received: by mail-pg1-x533.google.com with SMTP id p6so6156572pgh.9
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 22:52:57 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-37-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <99a8edde-faea-144e-63dc-fdc4826e47e5@linaro.org>
Date: Fri, 12 Apr 2019 19:52:51 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-37-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 36/41] s390x/tcg: Implement VECTOR
 SUBTRACT WITH BORROW INDICATION
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> Fairly easy as only 128-bit handling is required. Simply perform the
> subtraction and then subtract the borrow.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 27 +++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

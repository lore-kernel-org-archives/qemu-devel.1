Received: from eggs.gnu.org ([2001:4830:134:3::10]:34968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fsWCC-0005sV-Bv
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fsWC9-0001oo-7c
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:41:24 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fsWC8-0001oB-PB
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:41:21 -0400
Received: by mail-pg1-x544.google.com with SMTP id y5-v6so1180045pgv.1
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 09:41:20 -0700 (PDT)
References: <20180822075750.12399-1-david@redhat.com>
	<20180822075750.12399-3-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d7dc3e58-14de-1d4d-2486-c688fd251e78@linaro.org>
Date: Wed, 22 Aug 2018 09:41:17 -0700
MIME-Version: 1.0
In-Reply-To: <20180822075750.12399-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/8] s390x/tcg: store in the TB flags if
 AFP is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>

On 08/22/2018 12:57 AM, David Hildenbrand wrote:
> We exit the TB when changing the control registers, so just like PSW
> bits, this should always be consistent for a TB.
> 
> Using the PSW bit semantic makes things a lot easier compared to
> manually defining the sapre, shifted bits.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dg9n8-00068P-Vj
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dg9n5-000754-QL
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:15:54 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:35581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dg9n5-0006u9-CZ
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:15:51 -0400
Received: by mail-pg0-x236.google.com with SMTP id v189so15525793pgd.2
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 06:15:49 -0700 (PDT)
References: <20170811074652.31474-1-david@redhat.com>
	<20170811074652.31474-2-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bba66a1f-9f66-fd07-a04b-ac61c94b9f37@linaro.org>
Date: Fri, 11 Aug 2017 06:15:45 -0700
MIME-Version: 1.0
In-Reply-To: <20170811074652.31474-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/5] target/s390x: introduce internal.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com

On 08/11/2017 12:46 AM, David Hildenbrand wrote:
> +
> +static const char *cc_names[] = {
> +    [CC_OP_CONST0]    = "CC_OP_CONST0",

This should get moved out of the header to the c file that uses it.
(Why it's ever there in the first place is a mystery...)

Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

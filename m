Received: from eggs.gnu.org ([2001:4830:134:3::10]:44192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dg9pM-0007WT-Ax
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dg9pI-0003WP-CI
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:18:12 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:37597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dg9pI-0003Tz-7K
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:18:08 -0400
Received: by mail-pg0-x243.google.com with SMTP id 83so3126101pgb.4
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 06:18:06 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170811074652.31474-1-david@redhat.com>
	<20170811074652.31474-4-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <83e6ab35-88d8-bced-04d2-f643bbc3148c@twiddle.net>
Date: Fri, 11 Aug 2017 06:18:03 -0700
MIME-Version: 1.0
In-Reply-To: <20170811074652.31474-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 3/5] s390x: avoid calling kvm_
 functions outside of target/s390x/
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
>  }
> +void s390_enable_css_support(S390CPU *cpu)

Spacing.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

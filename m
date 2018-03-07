Received: from eggs.gnu.org ([2001:4830:134:3::10]:49764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eta6S-0006yJ-Os
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eta6P-0008WB-KP
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:31:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43216 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eta6P-0008W3-G1
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:31:33 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 198F58D6FB
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 14:31:33 +0000 (UTC)
References: <20180306194600.9650-1-pbonzini@redhat.com>
	<20180306194600.9650-2-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b7da5bff-bf88-b3f6-6581-06bc49020a2d@redhat.com>
Date: Wed, 7 Mar 2018 15:31:30 +0100
MIME-Version: 1.0
In-Reply-To: <20180306194600.9650-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] qom: introduce
 object_class_get_list_sorted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

On 06.03.2018 20:45, Paolo Bonzini wrote:
> Unify half a dozen copies of very similar code (the only difference being
> whether comparisons were case-sensitive) and use it also in Tricore,
> which did not do any sorting of CPU model names.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
[...]
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index 969f628f0a..c261b6b090 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -110,18 +110,6 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
>  #endif
>  }
>  
> -/* Sort hppabetically by type name. */

Oh, what a pity to see that "hppabetically" go away, that looked like a
really neat search-and-replace bug :-)

Anyway, patch looks fine to me:

Reviewed-by: Thomas Huth <thuth@redhat.com>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:51085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecTnx-0006k3-Kp
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:21:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecTnu-000296-Jb
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:21:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ecTnu-00027t-DG
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:21:46 -0500
References: <20180119084219.31187-1-peterx@redhat.com>
	<20180119084219.31187-2-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <88a39fec-67d6-5b60-ad70-2c14c4f2fffe@redhat.com>
Date: Fri, 19 Jan 2018 11:21:36 +0100
MIME-Version: 1.0
In-Reply-To: <20180119084219.31187-2-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 1/2] memory: do explicit cleanup when remove
 listeners
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alex Williamson <alex.williamson@redhat.com>

On 19/01/2018 09:42, Peter Xu wrote:
> +    FOR_EACH_FLAT_RANGE(fr, view) {

listener->begin is missing before the loop.

Paolo

> +        MemoryRegionSection section = section_from_flat_range(fr, view);
> +
> +        if (fr->dirty_log_mask && listener->log_stop) {
> +            listener->log_stop(listener, &section, fr->dirty_log_mask, 0);
> +        }
> +        if (listener->region_del) {
> +            listener->region_del(listener, &section);
> +        }
> +    }
> +    if (listener->commit) {
> +        listener->commit(listener);
> +    }
> +    flatview_unref(view);

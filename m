Received: from eggs.gnu.org ([209.51.188.92]:34579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gz1nh-0006TT-U8
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:11:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gz1nf-0002no-V1
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:11:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gz1nf-0002aX-Ih
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:11:15 -0500
References: <155128177405.1544.2035274805815542420@49fa7ef69f7b>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c8018156-b5f5-8574-c071-fa5168ec567f@redhat.com>
Date: Wed, 27 Feb 2019 17:10:49 +0100
MIME-Version: 1.0
In-Reply-To: <155128177405.1544.2035274805815542420@49fa7ef69f7b>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] include/exec/helper-head.h: support
 "const void *" in helper calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, pbonzini@redhat.com, rth@twiddle.net

On 27.02.19 16:36, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190221093459.22547-1-david@redhat.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Message-id: 20190221093459.22547-1-david@redhat.com
> Subject: [Qemu-devel] [PATCH v1] include/exec/helper-head.h: support "const void *" in helper calls
> Type: series
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  * [new tag]               patchew/20190221093459.22547-1-david@redhat.com -> patchew/20190221093459.22547-1-david@redhat.com
>  * [new tag]               patchew/20190225012530.28225-1-richardw.yang@linux.intel.com -> patchew/20190225012530.28225-1-richardw.yang@linux.intel.com
>  * [new tag]               patchew/20190225162325.24008-1-maxiwell@linux.ibm.com -> patchew/20190225162325.24008-1-maxiwell@linux.ibm.com
> Switched to a new branch 'test'
> 
> === OUTPUT BEGIN ===
> checkpatch.pl: no revisions returned for revlist '1'

While patchew seems to be broken right now, I wonder why patches are
tested that are long upstream? Is this some leftover from fixing patchew?

-- 

Thanks,

David / dhildenb

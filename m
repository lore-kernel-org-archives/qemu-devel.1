Received: from eggs.gnu.org ([2001:4830:134:3::10]:45310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eA48R-0003uL-8K
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 21:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eA48O-000884-4b
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 21:17:31 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:53774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eA48N-000873-TW
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 21:17:28 -0400
Received: by mail-pf0-x242.google.com with SMTP id t188so3298530pfd.10
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 18:17:26 -0700 (PDT)
References: <cover.1509368614.git.jcody@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <95a430ed-53ea-1ed5-da69-66ef6337f51f@ozlabs.ru>
Date: Thu, 2 Nov 2017 12:17:20 +1100
MIME-Version: 1.0
In-Reply-To: <cover.1509368614.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Don't write headers if BDS is
 INACTIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, stefanha@redhat.com

On 31/10/17 00:10, Jeff Cody wrote:
> Changes from v1->v2:
> 
> * Drop previous parallels patches, just check BDRV_O_INACTIVE now
>   (Kevin)
> 
> git-backport-diff -r qemu/master.. -u github/master
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream patch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
> 
> 001/3:[----] [--] 'block/vhdx.c: Don't blindly update the header'
> 002/3:[down] 'block/parallals: Do not update header or truncate image when INMIGRATE'
> 003/3:[----] [--] 'qemu-iotests: update unsupported image formats in 194'



Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> 
> v1:
> 
> VHDX and Parallels both blindly write headers to the image file
> if the images are opened R/W.  This causes an assert if the QEMU run
> state is INMIGRATE.
> 
> Jeff Cody (3):
>   block/vhdx.c: Don't blindly update the header
>   block/parallals: Do not update header or truncate image when INMIGRATE
>   qemu-iotests: update unsupported image formats in 194
> 
>  block/parallels.c      | 7 ++-----
>  block/vhdx.c           | 7 -------
>  tests/qemu-iotests/194 | 2 +-
>  3 files changed, 3 insertions(+), 13 deletions(-)
> 


-- 
Alexey

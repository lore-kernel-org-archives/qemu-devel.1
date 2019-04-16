Received: from eggs.gnu.org ([209.51.188.92]:47241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hGOTS-0004YJ-E3
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hGOTR-0003W0-HZ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:50:10 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:36850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hGOTR-0003U0-AW
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:50:09 -0400
Received: by mail-wm1-f44.google.com with SMTP id h18so25577934wml.1
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 06:50:09 -0700 (PDT)
References: <20190415135746.7571-1-mlevitsk@redhat.com>
	<20190415135746.7571-6-mlevitsk@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5dcf9e5b-f715-142b-63f7-566facb12263@redhat.com>
Date: Tue, 16 Apr 2019 15:50:06 +0200
MIME-Version: 1.0
In-Reply-To: <20190415135746.7571-6-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 5/5] block/nvme: add support
 for discard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org

On 15/04/19 15:57, Maxim Levitsky wrote:
>      .bdrv_co_pwrite_zeroes    = nvme_co_pwrite_zeroes,
> +    .bdrv_co_pdiscard         = nvme_co_pdiscard,
> +
>  
>      .bdrv_co_flush_to_disk    = nvme_co_flush,

Extra blank line.

Paolo

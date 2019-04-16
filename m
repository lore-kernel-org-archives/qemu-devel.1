Received: from eggs.gnu.org ([209.51.188.92]:47166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hGOTE-0004P4-9B
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hGOTD-0003MW-Ez
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:49:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hGOTD-0003GO-7B
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:49:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id q16so25472724wmj.3
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 06:49:48 -0700 (PDT)
References: <20190415135746.7571-1-mlevitsk@redhat.com>
	<20190415135746.7571-5-mlevitsk@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <db949b72-40f1-137e-42a0-2682ff79f64b@redhat.com>
Date: Tue, 16 Apr 2019 15:49:45 +0200
MIME-Version: 1.0
In-Reply-To: <20190415135746.7571-5-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 4/5] block/nvme: add support
 for write zeros
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
> +#define NVME_ID_NS_DLFEAT_READ_BEHAVIER(dlfeat)     ((dlfeat) & 0x3)
> +#define NVME_ID_NS_DLFEAT_READ_BEHAVIER_UNDEFINED  0
> +#define NVME_ID_NS_DLFEAT_READ_BEHAVIER_ZEROS  1
> +#define NVME_ID_NS_DLFEAT_READ_BEHAVIER_ONES   2
> +
> +

s/BEHAVIER/BEHAVIOR/

Paolo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSqGx-0008TL-7q
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 16:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSqGs-0007XJ-DF
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 16:52:11 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:46828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSqGs-0007We-6b
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 16:52:06 -0400
Received: by mail-pg0-x22e.google.com with SMTP id d2-v6so130773pga.13
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 13:52:05 -0700 (PDT)
References: <20180611011501.10235-1-f4bug@amsat.org>
	<20180611011501.10235-12-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <15d222dd-d2e9-4855-62c6-f89f2ee59c52@linaro.org>
Date: Tue, 12 Jun 2018 10:51:59 -1000
MIME-Version: 1.0
In-Reply-To: <20180611011501.10235-12-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 11/40] hw/xen: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, "open list:X86" <xen-devel@lists.xenproject.org>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Richard Henderson <rth@twiddle.net>

On 06/10/2018 03:14 PM, Philippe Mathieu-Daudé wrote:
>      xen_pv_printf(xendev, 1, "type \"%s\", fileproto \"%s\", filename \"%s\","
> -                  " size %" PRId64 " (%" PRId64 " MB)\n",
> +                  " size %" PRId64 " (%llu MB)\n",
>                    blkdev->type, blkdev->fileproto, blkdev->filename,
> -                  blkdev->file_size, blkdev->file_size >> 20);
> +                  blkdev->file_size, blkdev->file_size / MiB);

Having to change printf markup is exactly why you shouldn't use ULL in MiB.


r~

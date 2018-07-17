Received: from eggs.gnu.org ([2001:4830:134:3::10]:52795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ffT7F-0001Rq-Ay
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ffT7C-000878-6L
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:46:21 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ffT7B-00084f-Um
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 12:46:18 -0400
Received: by mail-pg1-x544.google.com with SMTP id z8-v6so685116pgu.8
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 09:46:17 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1531809130-31088-1-git-send-email-junyan.he@gmx.com>
	<1531809130-31088-5-git-send-email-junyan.he@gmx.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c2c301a7-759a-00ad-97fe-8b04e2718971@twiddle.net>
Date: Tue, 17 Jul 2018 09:46:14 -0700
MIME-Version: 1.0
In-Reply-To: <1531809130-31088-5-git-send-email-junyan.he@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7 V10] hostmem-file: add the 'pmem' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: junyan.he@gmx.com, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, xiaoguangrong.eric@gmail.com, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, yi.z.zhang@intel.com, Junyan He <junyan.he@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>

On 07/16/2018 11:32 PM, junyan.he@gmx.com wrote:
> @@ -34,6 +35,7 @@ struct HostMemoryBackendFile {
>      bool discard_data;
>      char *mem_path;
>      uint64_t align;
> +    bool is_pmem;
>  };

Sort all the bool's to the end?


> +    /* Just support these ram flags by now. */
> +    assert(ram_flags == 0 || (ram_flags & (RAM_SHARED | RAM_PMEM)));

Surely assert((ram_flags & ~(RAM_SHARED | RAM_PMEM)) == 0).

> +If the vNVDIMM backend is on the host persistent memory that can be

Grammar nit: "is in host persistent memory".

> +++ b/qemu-options.hx
> @@ -4070,6 +4070,13 @@ requires an alignment different than the default one used by QEMU, eg
>  the device DAX /dev/dax0.0 requires 2M alignment rather than 4K. In
>  such cases, users can specify the required alignment via this option.
>  
> +The @option{pmem} option specifies whether the backing file specified
> +by @option{mem-path} is on the persistent memory that can be accessed

Likewise.


r~

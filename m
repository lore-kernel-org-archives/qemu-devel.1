Received: from eggs.gnu.org ([209.51.188.92]:38056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjDoO-0003Lu-DK
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 20:46:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjDoN-00062e-Lk
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 20:46:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjDoN-00062J-G2
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 20:46:39 -0500
Date: Mon, 14 Jan 2019 20:46:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190114204414-mutt-send-email-mst@kernel.org>
References: <1547197071-14504-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1547197071-14504-5-git-send-email-lizhijian@cn.fujitsu.com>
	<20190114175348.GY4500@habkost.net>
	<6a1206be-d363-ff73-595c-fde52a3dab66@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a1206be-d363-ff73-595c-fde52a3dab66@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v5 4/4] i386: allow to load initrd below 4G
 for recent linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@redhat.com, zhijianx.li@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On Tue, Jan 15, 2019 at 09:35:09AM +0800, Li Zhijian wrote:
> Hi Eduardo
> 
> 
> On 1/15/19 01:53, Eduardo Habkost wrote:
> 
>         +    if (protocol >= 0x20c &&
>         +        lduw_p(header+0x236) & XLF_CAN_BE_LOADED_ABOVE_4G) {
>         +        /*
>         +         * Linux has supported initrd up to 4 GB for a very long time (2007,
>         +         * long before XLF_CAN_BE_LOADED_ABOVE_4G which was added in 2013),
>         +         * though it only sets initrd_max to 2 GB to "work around bootloader
>         +         * bugs". Luckily, QEMU firmware(which does something like bootloader)
>         +         * has supported this.
>         +         *
>         +         * It's believed that if XLF_CAN_BE_LOADED_ABOVE_4G is set, initrd can
>         +         * be loaded into any address.
>         +         *
>         +         * In addition, initrd_max is uint32_t simply because QEMU doesn't
>         +         * support the 64-bit boot protocol (specifically the ext_ramdisk_image
>         +         * field).
>         +         *
>         +         * Therefore here just limit initrd_max to UINT32_MAX simply as well.
>         +         *
>         +         * FIXME: it's possible that linux protocol within [0x208, 0x20c]
>         +         * supports up to 4G initrd as well.
> 
>     I don't understand what exactly this FIXME comment is
>     documenting.  What exactly needs to be fixed?
> 
> 
> XLF_CAN_BE_LOADED_ABOVE_4G is one of the indicators, actually as comments said,
> linux has supported up to 4 GB initrd since linux-2.26(protocol version 0x208).
> 
> 
> I just want to comment that linux with protocol within [0x208, 0x20c] supports up to 4 GB initrd as well.
> 
> Is documenting with FIXME appropriate?
> 
> 
> Thanks
> 
> 


Fixme should say what is missing in the qemu implementation.
E.g.

/*
 * Bar 2010 and up can actually be supported using foo.
 * FIXME: make use of foo to support bar.
 */


-- 
MST

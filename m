Received: from eggs.gnu.org ([2001:4830:134:3::10]:50034)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<BATV+f1a9c63dd9d55f86c0ec+5205+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1eHsd9-0006h0-Or
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 09:37:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<BATV+f1a9c63dd9d55f86c0ec+5205+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1eHsd7-0002UE-6h
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 09:37:31 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:50750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from
	<BATV+f1a9c63dd9d55f86c0ec+5205+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1eHsd6-0001jN-Uv
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 09:37:29 -0500
Date: Thu, 23 Nov 2017 06:36:57 -0800
From: Christoph Hellwig <hch@infradead.org>
Message-ID: <20171123143657.GA19971@infradead.org>
References: <20171123140206.3911-1-marcandre.lureau@redhat.com>
	<20171123140206.3911-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171123140206.3911-5-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 4/5] crash: export
 paddr_vmcoreinfo_note()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: linux-kernel@vger.kernel.org, somlo@cmu.edu, xiaolong.ye@intel.com, qemu-devel@nongnu.org, mst@redhat.com, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Hari Bathini <hbathini@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Nov 23, 2017 at 03:02:05PM +0100, Marc-André Lureau wrote:
> The following patch is going to use the symbol from the fw_cfg module,
> to call the function and write the note location details in the
> vmcoreinfo entry, so qemu can produce dumps with the vmcoreinfo note.

Sounds like fw_cfg should be moved to be built in only instead of
exporting such a symbol address.

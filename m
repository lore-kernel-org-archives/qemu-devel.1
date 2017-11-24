Received: from eggs.gnu.org ([2001:4830:134:3::10]:59350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eI5Tv-0001Gu-SU
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 23:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eI5Ts-00047h-IR
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 23:20:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eI5Ts-00046z-C2
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 23:20:48 -0500
Date: Fri, 24 Nov 2017 06:20:35 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171124061759-mutt-send-email-mst@kernel.org>
References: <20171123140206.3911-1-marcandre.lureau@redhat.com>
	<20171123140206.3911-5-marcandre.lureau@redhat.com>
	<20171123143657.GA19971@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171123143657.GA19971@infradead.org>
Content-Transfer-Encoding: quoted-printable
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
To: Christoph Hellwig <hch@infradead.org>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, linux-kernel@vger.kernel.org, somlo@cmu.edu, xiaolong.ye@intel.com, qemu-devel@nongnu.org, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Hari Bathini <hbathini@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Nov 23, 2017 at 06:36:57AM -0800, Christoph Hellwig wrote:
> On Thu, Nov 23, 2017 at 03:02:05PM +0100, Marc-Andr=E9 Lureau wrote:
> > The following patch is going to use the symbol from the fw_cfg module=
,
> > to call the function and write the note location details in the
> > vmcoreinfo entry, so qemu can produce dumps with the vmcoreinfo note.
>=20
> Sounds like fw_cfg should be moved to be built in only instead of
> exporting such a symbol address.

Point is, all fw cfg does is export it on to the hypervisor, so it will
have to be supported forever.  If it's safe to export it to the
hypervisor then for sure it's also safe to export it to modules.

--=20
MST

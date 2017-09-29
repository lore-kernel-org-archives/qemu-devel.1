Received: from eggs.gnu.org ([2001:4830:134:3::10]:60550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dy13m-0003Lg-CU
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dy13h-0008BI-Fb
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:34:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8107)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dy13h-0008Ad-9k
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:34:49 -0400
Date: Fri, 29 Sep 2017 22:34:45 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170929223152-mutt-send-email-mst@kernel.org>
References: <69fd8746-b2bd-31d0-4d70-792f40ef2d79@amd.com>
	<20170926170901-mutt-send-email-mst@kernel.org>
	<2fb6e86d-5afa-d7f0-6f62-8f81db5a5419@amd.com>
	<20170927190724-mutt-send-email-mst@kernel.org>
	<927fedc3-a2c8-d37c-930e-11cecb7b0149@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <927fedc3-a2c8-d37c-930e-11cecb7b0149@amd.com>
Subject: Re: [Qemu-devel] libvirt/QEMU/SEV interaction
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Richard Relph <richard.relph@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
List-ID: <qemu-devel.nongnu.org>

On Wed, Sep 27, 2017 at 02:06:10PM -0500, Richard Relph wrote:
> Whether the "BIOS" is a "static shim" as Michael suggests, or a full BIOS,
> or even a BIOS+kernel+initrd is really not too significant. What is
> significant is that the GO has a basis for trusting all code that is
> imported in to their VM by the CP. And that NONE of the code provided by the
> CP is "unknown" and unauditable by the GO. If the CP has a way to inject
> code unknown to the GO in to the guest VM, the trust model is broken and
> both GO and CP suffer the consequences.

Absolutely.

> When the CP needs to update the BIOS image, they will have to inform the GO
> and allow the GO to establish trust in the CP's new BIOS image somehow.

This GO update on every BIOS change is imho is not a workable model. You
want something like checking the BIOS signature instead. And since
hardware is all hash based, you need the shim to do it in software.

-- 
MST

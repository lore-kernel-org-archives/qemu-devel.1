Received: from eggs.gnu.org ([2001:4830:134:3::10]:39877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dyUOR-0002oU-Te
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 22:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dyUON-0001hS-Dp
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 22:54:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dyUON-0001fi-8q
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 22:54:07 -0400
Date: Sun, 1 Oct 2017 05:54:02 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170930010405-mutt-send-email-mst@kernel.org>
References: <69fd8746-b2bd-31d0-4d70-792f40ef2d79@amd.com>
	<20170926170901-mutt-send-email-mst@kernel.org>
	<2fb6e86d-5afa-d7f0-6f62-8f81db5a5419@amd.com>
	<20170927190724-mutt-send-email-mst@kernel.org>
	<927fedc3-a2c8-d37c-930e-11cecb7b0149@amd.com>
	<20170929223152-mutt-send-email-mst@kernel.org>
	<05b3c915-d7c1-2d73-1579-68d5f3bcc3d7@amd.com>
	<151eedf4-6861-c4be-e6f8-6b33c226b298@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151eedf4-6861-c4be-e6f8-6b33c226b298@amd.com>
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

On Fri, Sep 29, 2017 at 03:07:40PM -0500, Richard Relph wrote:
> Depending on your level of paranoia,
> that may require advance notice of BIOS changes, or even allowing the GO to
> provide the BIOS themselves, written to a spec supported by the CP's HV,
> and/or based on BIOS code provided by the CP.

BTW this last most secure option is easy to implement with the shim
because the shim is using very little in terms of the HV interface.

User can then easily build it from source.

-- 
MST

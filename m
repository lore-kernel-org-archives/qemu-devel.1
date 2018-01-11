Received: from eggs.gnu.org ([2001:4830:134:3::10]:39496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eZj7M-0001On-4r
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eZj7K-0004pX-2W
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:06:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eZj7J-0004on-Sf
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:06:25 -0500
Date: Thu, 11 Jan 2018 22:06:22 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180111220533-mutt-send-email-mst@kernel.org>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
	<CAFEAcA_pt7XhXOhL2jSxwH9ooL7xjShmp6eBAYpRLc=dY-=TXQ@mail.gmail.com>
	<20171221223704-mutt-send-email-mst@kernel.org>
	<CAAdtpL74ZyVsLwgBjpbsdSHbWdY_Uq6ouRAvgo00UdVevTKq8A@mail.gmail.com>
	<20171222014258-mutt-send-email-mst@kernel.org>
	<CAFEAcA8eKTEh3zSOPNm1WgUujNOU+zcNSgBAE5G68QcObQd8sA@mail.gmail.com>
	<20180109060920-mutt-send-email-mst@kernel.org>
	<CAFEAcA_Xhm45N5U8aWZv=geVQMShv13FOEodS7HvPTz3fa9-+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_Xhm45N5U8aWZv=geVQMShv13FOEodS7HvPTz3fa9-+A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/25] pc, pci, virtio: features, fixes,
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philippe@mathieu-daude.net>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Jan 11, 2018 at 03:31:08PM +0000, Peter Maydell wrote:
> On 9 January 2018 at 04:11, Michael S. Tsirkin <mst@redhat.com> wrote:
> > So it's an existing bug exposed by the test.
> > I've reverted the test for now but I didn't rebase
> > as there are downstream trees based on this pull req.
> 
> Hi -- I'm afraid this seems to have conflicts with the sparc
> pullreq. I tried the simple textual merge resolution for
> hw/pci-host/apb.c, but that then fails to compile.
> Can you fix up and resend, please?
> 
> thanks
> -- PMM

Pushed what I think is the fix. Testing it, but I saw
some changes in submodules and I screwed them up in
the past - could you pls help check and make sure
I didn't do anything wrong?

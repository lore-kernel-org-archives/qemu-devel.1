Received: from eggs.gnu.org ([2001:4830:134:3::10]:55161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fXa02-0005ct-2L
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fXZzy-0006cl-Kv
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:30:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49984 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fXZzy-0006bZ-Ed
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:30:14 -0400
Date: Tue, 26 Jun 2018 01:30:12 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180626012948-mutt-send-email-mst@kernel.org>
References: <152976906812.26719.4060539263907295716.malonedeb@gac.canonical.com>
	<152992401182.25608.13015767721800507585.malone@soybean.canonical.com>
	<b630869a-c995-e59d-49c3-897d68bae9b2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b630869a-c995-e59d-49c3-897d68bae9b2@redhat.com>
Subject: Re: [Qemu-devel] [Bug 1778350] Re: Android-x86 4.4-r5 won't boot on
 QEMU since v2.11.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Bug 1778350 <1778350@bugs.launchpad.net>, qemu-devel@nongnu.org

On Mon, Jun 25, 2018 at 01:46:16PM -0400, John Snow wrote:
> CC Michael Tsirkin
> 
> On 06/25/2018 06:53 AM, navicrej wrote:
> > After 'git bisect' -ing it I found the commit that is responsible for
> > this:
> > 
> > https://git.qemu.org/?p=qemu.git;a=commitdiff;h=9fa99d2519cbf71f871e46871df12cb446dc1c3e
> > 

Can you pls try to set x-pci-hole64-fix=off and see whether that helps?

-- 
MST

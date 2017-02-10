Received: from eggs.gnu.org ([2001:4830:134:3::10]:45211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ccDsi-0000Hz-Hx
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 11:17:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ccDsd-0000FI-Ic
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 11:17:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ccDsd-0000F4-Br
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 11:17:03 -0500
Date: Fri, 10 Feb 2017 17:16:59 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170210171659.111aedda@nial.brq.redhat.com>
In-Reply-To: <20170210172107-mutt-send-email-mst@kernel.org>
References: <cover.1486285434.git.ben@skyportsystems.com>
	<88aaebda-29dd-a77a-1b78-7d0d6f911a76@redhat.com>
	<20170210172107-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 00/10] Add support for VM Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, ben@skyportsystems.com, Peter Maydell <peter.maydell@linaro.org>, Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>

On Fri, 10 Feb 2017 17:31:33 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Feb 10, 2017 at 11:12:13AM +0100, Laszlo Ersek wrote:
> > On 02/05/17 10:11, ben@skyportsystems.com wrote:  
> > > From: Ben Warren <ben@skyportsystems.com>
[...]

> > 
> > - or else, add another boolean property to vmgenid, one that parallels
> > "dma-enabled" of "fw-cfg" precisely, in HW_COMPAT*. Then simply fail
> > realize() when this property is false.  
> 
> That's probably the easiest way. x-fw-cfg-dma-enabled.
> Won't delay merging because of this, can be done with
> patch on top.
(not related to this series)

I've thought that there still were no consensus on x-foo prefix,
not to mention that x- might be legitimate prefix for some properties.

Maybe we should add a flag to property like INTERNAL_PROPERTY
and then set it explicitly on for internal stuff.

That way we could cleanly exclude internal properties from
 -device foo,help and make sure that user won't set them from CLI.
I'd even volunteer to add this API to Object

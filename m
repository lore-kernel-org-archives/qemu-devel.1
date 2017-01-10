Received: from eggs.gnu.org ([2001:4830:134:3::10]:49958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cQlKZ-00023U-97
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 20:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cQlKU-000614-Dn
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 20:34:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cQlKU-00060C-83
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 20:34:26 -0500
Date: Tue, 10 Jan 2017 09:34:20 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170110013420.GA2033@lemon>
References: <1481922841-4324-1-git-send-email-mst@redhat.com>
	<148192392306.37.10111381964118487672@790289a7ca88>
	<20170109184252-mutt-send-email-mst@kernel.org>
	<CAFEAcA-Puj_RJCnyAsGp7gTQZW2+3PECjf8zOiym0gVyfGWB0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-Puj_RJCnyAsGp7gTQZW2+3PECjf8zOiym0gVyfGWB0A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL for-2.9 0/9] virtio, vhost, pc: fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, 01/09 17:28, Peter Maydell wrote:
> On 9 January 2017 at 16:48, Michael S. Tsirkin <mst@redhat.com> wrote:
> > The strange thing here is that this actually seems to apply patches
> > from list instead of getting the tag from the tree.
> 
> That's because it's really supposed to be working on patches sent
> to the list -- it only checks pull requests because it can't
> tell them apart from patches, I think.

It can be taught not to check pull requests but I don't see a reason to, maybe
it's better to let patchew pull the tag instead of applying, but on the other
hand it's a bit odd to assume they two differ, that's why I haven't done it.

Fam

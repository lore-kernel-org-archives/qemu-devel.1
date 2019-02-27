Received: from eggs.gnu.org ([209.51.188.92]:57559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gyrra-0003Rl-78
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 00:34:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gyrrZ-0007Bp-KV
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 00:34:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gyrrZ-0006zO-Dn
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 00:34:37 -0500
Date: Wed, 27 Feb 2019 06:27:55 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190227052755.3lgo3265kaa6bzmi@sirius.home.kraxel.org>
References: <CAKyx-3Paa6_RreGZw3sT+qmwu1=_DLnR_RDxa_gN20vwD1EnLw@mail.gmail.com>
	<20190225152618.r3epnypkpu6fyokt@sirius.home.kraxel.org>
	<A17B6D30-F428-48E5-B9D0-6F6E7DEE3778@gmail.com>
	<20190226064347.i5kvwazmz3xcupkj@sirius.home.kraxel.org>
	<CAKyx-3OOkkdSQ=UAucP_ZpormrEczwNhEpAnVtFeQOSOrnD7Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKyx-3OOkkdSQ=UAucP_ZpormrEczwNhEpAnVtFeQOSOrnD7Vg@mail.gmail.com>
Subject: Re: [Qemu-devel] Questions about EDID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

On Tue, Feb 26, 2019 at 04:11:06PM -0500, G 3 wrote:
> When I use edid=on, I do see a lot of extra resolutions available in Mac OS
> 9 and Mac OS X, just not the resolution I want to use. Is there some kind
> of rule like the resolution value has to be divisible by a certain number?

qemu doesn't have such a requirement.
Might be the guest drivers have.
Try making width/height multiple of 8 or 16.

cheers,
  Gerd

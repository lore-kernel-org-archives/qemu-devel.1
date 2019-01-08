Received: from eggs.gnu.org ([209.51.188.92]:34704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggpip-0001nz-97
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:39:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggpio-0000Yz-Md
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:39:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ggpio-0000VU-Cl
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:39:02 -0500
Date: Tue, 8 Jan 2019 12:38:58 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190108113858.bclhtcosanp7pwyv@sirius.home.kraxel.org>
References: <20190107175117.23769-1-jonathan.davies@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107175117.23769-1-jonathan.davies@nutanix.com>
Subject: Re: [Qemu-devel] [PATCH] usb: drop unnecessary usb_device_post_load
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jonathan Davies <jonathan.davies@nutanix.com>
Cc: Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Mon, Jan 07, 2019 at 05:51:40PM +0000, Jonathan Davies wrote:
> In usb_device_post_load, certain values of dev->setup_len or
> dev->setup_index can cause -EINVAL to be returned. One example is when
> setup_len exceeds 4096, the hard-coded value of sizeof(dev->data_buf).
> This can happen through legitimate guest activity and will cause all
> subsequent attempts to migrate the guest to fail in vmstate_load_state.

Added to usb queue.

thanks,
  Gerd

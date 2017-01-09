Received: from eggs.gnu.org ([2001:4830:134:3::10]:56915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cQR8U-0004em-DN
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 23:00:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cQR8R-0000xK-5W
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 23:00:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cQR8Q-0000wy-W3
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 23:00:39 -0500
References: <1483876315-10678-1-git-send-email-huth@tuxfamily.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <667916b8-567d-f4cc-c5b4-aa7ab89600a6@redhat.com>
Date: Mon, 9 Jan 2017 12:00:30 +0800
MIME-Version: 1.0
In-Reply-To: <1483876315-10678-1-git-send-email-huth@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] m68k: QOMify the MCF Fast Ethernet
 Controller device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>



On 2017=E5=B9=B401=E6=9C=8808=E6=97=A5 19:51, Thomas Huth wrote:
> When running qemu-system-m68k with the "-net" parameter (for example
> simply "-net nic -net user"), there is currently a confusing warning
> message saying:
>
>   Warning: requested NIC (anonymous, model mcf_fec) was not created
>   (not supported by this machine?)
>
> This seems to happen because the MCF NIC has never been adapted to
> the currently expected QEMU device behavior. Thus let's QOMify the
> NIC now to get rid of the warning message.
>
> Signed-off-by: Thomas Huth<huth@tuxfamily.org>
> ---
>   v2:
>   - Add the mcf_fec.h header file for the shared #defines
>   - Use qemu_check_nic_model() to verify the NIC model
>
>   hw/m68k/mcf5208.c         | 25 ++++++++++++++++-
>   hw/net/mcf_fec.c          | 71 +++++++++++++++++++++++++++++++++++---=
---------
>   include/hw/m68k/mcf.h     |  4 ---
>   include/hw/m68k/mcf_fec.h | 13 +++++++++
>   4 files changed, 90 insertions(+), 23 deletions(-)
>   create mode 100644 include/hw/m68k/mcf_fec.h

Looks good, applied to -net.

Thanks

Received: from eggs.gnu.org ([209.51.188.92]:47862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guKAP-00017f-E9
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:47:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guKAO-00021k-Ny
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:47:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1guKAO-0001zq-C0
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:47:16 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-43-git-send-email-pbonzini@redhat.com>
	<a67e6380-daf5-62d1-0f37-45f7015cc0fa@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b6cfc7bf-3eb0-3211-a008-0e891908a15c@redhat.com>
Date: Thu, 14 Feb 2019 17:47:08 +0100
MIME-Version: 1.0
In-Reply-To: <a67e6380-daf5-62d1-0f37-45f7015cc0fa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 42/52] i386: express dependencies with
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: yang.zhong@intel.com, thuth@redhat.com

On 01/02/19 16:05, Philippe Mathieu-Daud=C3=A9 wrote:
> This lacks a DISPLAY dependency?
>=20
> $ i386-softmmu/qemu-system-i386 -M q35
> qemu-system-i386: Unknown device 'VGA' for bus 'PCIE'
> Aborted (core dumped)

If you got this with --without-default-devices, then it's intended behavi=
or.

VGA_PCI is selected via CONFIG_PCI_DEVICES.

Paolo

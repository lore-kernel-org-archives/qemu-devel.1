Received: from eggs.gnu.org ([209.51.188.92]:52818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gpKYe-00045I-B9
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gpKYd-0001ta-N6
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:11:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gpKYd-0001rr-Eu
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:11:39 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-41-git-send-email-pbonzini@redhat.com>
	<b9589c65-57c5-f9e1-e6a2-2970f6070eee@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f7a57a6b-8cab-ce7a-04be-f7c799b0043e@redhat.com>
Date: Thu, 31 Jan 2019 23:11:21 +0100
MIME-Version: 1.0
In-Reply-To: <b9589c65-57c5-f9e1-e6a2-2970f6070eee@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 40/52] scsi: express dependencies with
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com

On 31/01/19 22:23, Philippe Mathieu-Daud=C3=A9 wrote:
> You missed:
>=20
> -common-obj-y +=3D scsi-disk.o emulation.o
> -common-obj-y +=3D scsi-generic.o scsi-bus.o
> +common-obj-$(CONFIG_SCSI) +=3D scsi-disk.o emulation.o
> +common-obj-$(CONFIG_SCSI) +=3D scsi-generic.o scsi-bus.o
>=20

I didn't: :)

devices-dirs-$(CONFIG_SCSI) +=3D scsi/

Paolo

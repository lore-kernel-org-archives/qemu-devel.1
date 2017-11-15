Received: from eggs.gnu.org ([2001:4830:134:3::10]:43373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEvmG-00081G-3e
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 06:22:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEvmD-0003zO-Gg
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 06:22:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eEvmD-0003z1-9s
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 06:22:41 -0500
References: <1510625498-4821-1-git-send-email-jasowang@redhat.com>
	<1510625498-4821-8-git-send-email-jasowang@redhat.com>
	<e84e4b9f-8a88-5c68-8440-96df5bef1ad5@weilnetz.de>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1e12f490-54b5-8739-df63-db260248e048@redhat.com>
Date: Wed, 15 Nov 2017 19:22:32 +0800
MIME-Version: 1.0
In-Reply-To: <e84e4b9f-8a88-5c68-8440-96df5bef1ad5@weilnetz.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 7/8] Add new PCI ID for i82559a
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>, "Michael S. Tsirkin" <mst@redhat.com>



On 2017=E5=B9=B411=E6=9C=8815=E6=97=A5 14:43, Stefan Weil wrote:
> Hi,
>
> I currently think that this patch is wrong and should be reverted.
>
> It fixes a certain use case by hacking the PCI device id, but does
> not model the way how that device id is set on the real hardware
> correctly.
>
> As far as I know, all i82559 have a default PCI device id of 0x1229.
> It can be changed by the EEPROM configuration, but not all network
> cards do have an EEPROM.
>
> See for example this URL for more information:
> http://zoo.cs.yale.edu/classes/cs422/2010/ref/82559_eeprom.pdf
>
> The correct solution is modeling the EEPROM and allowing QEMU
> users to provide an EEPROM=E2=80=8C file.

Yes and unless there's new version of sepc that has different ID, I tend=20
to revert this.

Thanks

>
> Cheers
> Stefan

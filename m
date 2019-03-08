Received: from eggs.gnu.org ([209.51.188.92]:60618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h2BIz-0001n4-5H
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 03:56:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h2BIy-0000qf-CS
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 03:56:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h2BIy-0000q6-3u
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 03:56:36 -0500
References: <CAEt6vxELvT1gadPihazzmKDsGgFDa1whxnKAVMEwsf_e7ycGdg@mail.gmail.com>
	<d856dc98-018b-3eec-fe05-26035a64e9bb@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5109bd99-ab78-ef32-b900-15896dc00d1f@redhat.com>
Date: Fri, 8 Mar 2019 09:56:25 +0100
MIME-Version: 1.0
In-Reply-To: <d856dc98-018b-3eec-fe05-26035a64e9bb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu bluetooth support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Daryl Oliver <gen.dr.aireagoirdragesteam@gmail.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>

On 05/03/19 09:05, Thomas Huth wrote:
> On 02/03/2019 13.46, Daryl Oliver wrote:
>> Hello there I don't know if this is till valid but I thought I should
>> mention my use cases for the bluetooth option in qemu.
>>
>> Use case would be using Bluetooth controllers for gaming on kvm qemu s=
ince
>> I don't know if kvm would be able to use my hosts Bluetooth chip or em=
ulate
>> one. since I manily use the windows port of qemu.
>> But my other use case would be using Bluetooth speakers or headphones.
>=20
>  Hi!
>=20
> Thanks for your report! Do you mean you are already using bluetooth for
> your KVM guest, or you just would like to use it (since you wrote "woul=
d
> be" and not "is")?
> In the first case, could you please elaborate on your set up? Which
> hardware are you exactly passing through to the guest, which parameters
> are you using for starting QEMU, which version of QEMU are you using, i=
s
> it working without problems, etc. ?

I suspect he wants to pass something like an XBox controller.  It would
actually be a very good usecase for Bluetooth passthrough.

If he is using Linux guests, he could use virtio-input-host-pci.

For Windows, we could also pass it through as an HID device, using
something like virtio-input-host-pci but for USB.  It wouldn't be hard
to implement, but you'd have to write a converter from Linux evdev
descriptors to USB HID descriptors.

Paolo

> I ask because currently, I don't know anybody who is still using
> bluetooth passthrough with a recent version of QEMU, so it would be ver=
y
> interesting to know whether this still works at all or not...
>=20
>  Thanks,
>   Thomas
>=20

Received: from eggs.gnu.org ([209.51.188.92]:53935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1553-0008WD-PZ
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 03:05:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1552-0001m1-Vm
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 03:05:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h1552-0001ko-MR
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 03:05:40 -0500
References: <CAEt6vxELvT1gadPihazzmKDsGgFDa1whxnKAVMEwsf_e7ycGdg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d856dc98-018b-3eec-fe05-26035a64e9bb@redhat.com>
Date: Tue, 5 Mar 2019 09:05:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAEt6vxELvT1gadPihazzmKDsGgFDa1whxnKAVMEwsf_e7ycGdg@mail.gmail.com>
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
To: Daryl Oliver <gen.dr.aireagoirdragesteam@gmail.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>

On 02/03/2019 13.46, Daryl Oliver wrote:
> Hello there I don't know if this is till valid but I thought I should
> mention my use cases for the bluetooth option in qemu.
>=20
> Use case would be using Bluetooth controllers for gaming on kvm qemu si=
nce
> I don't know if kvm would be able to use my hosts Bluetooth chip or emu=
late
> one. since I manily use the windows port of qemu.
> But my other use case would be using Bluetooth speakers or headphones.

 Hi!

Thanks for your report! Do you mean you are already using bluetooth for
your KVM guest, or you just would like to use it (since you wrote "would
be" and not "is")?
In the first case, could you please elaborate on your set up? Which
hardware are you exactly passing through to the guest, which parameters
are you using for starting QEMU, which version of QEMU are you using, is
it working without problems, etc. ?
I ask because currently, I don't know anybody who is still using
bluetooth passthrough with a recent version of QEMU, so it would be very
interesting to know whether this still works at all or not...

 Thanks,
  Thomas

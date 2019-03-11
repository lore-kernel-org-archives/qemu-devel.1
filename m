Received: from eggs.gnu.org ([209.51.188.92]:41413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3Kor-0003qE-Uv
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h3KZn-0001Ls-SQ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:02:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h3KZn-0001L0-J1
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:02:43 -0400
References: <CAEt6vxELvT1gadPihazzmKDsGgFDa1whxnKAVMEwsf_e7ycGdg@mail.gmail.com>
	<d856dc98-018b-3eec-fe05-26035a64e9bb@redhat.com>
	<5109bd99-ab78-ef32-b900-15896dc00d1f@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <31ebd782-64b3-3ddb-6a40-2f606c4654d0@redhat.com>
Date: Mon, 11 Mar 2019 14:02:38 +0100
MIME-Version: 1.0
In-Reply-To: <5109bd99-ab78-ef32-b900-15896dc00d1f@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, Daryl Oliver <gen.dr.aireagoirdragesteam@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

On 08/03/2019 09.56, Paolo Bonzini wrote:
> On 05/03/19 09:05, Thomas Huth wrote:
>> On 02/03/2019 13.46, Daryl Oliver wrote:
>>> Hello there I don't know if this is till valid but I thought I should
>>> mention my use cases for the bluetooth option in qemu.
>>>
>>> Use case would be using Bluetooth controllers for gaming on kvm qemu =
since
>>> I don't know if kvm would be able to use my hosts Bluetooth chip or e=
mulate
>>> one. since I manily use the windows port of qemu.
>>> But my other use case would be using Bluetooth speakers or headphones=
.
>>
>>  Hi!
>>
>> Thanks for your report! Do you mean you are already using bluetooth fo=
r
>> your KVM guest, or you just would like to use it (since you wrote "wou=
ld
>> be" and not "is")?
>> In the first case, could you please elaborate on your set up? Which
>> hardware are you exactly passing through to the guest, which parameter=
s
>> are you using for starting QEMU, which version of QEMU are you using, =
is
>> it working without problems, etc. ?
>=20
> I suspect he wants to pass something like an XBox controller.  It would
> actually be a very good usecase for Bluetooth passthrough.

For the records: I recently found an old bluetooth headset in my rack,
and was now curious whether it could be used for passthrough in QEMU. It
was quite easy to pair it on the host, but when I then tried to pass it
through to the guest, I was not able to make it work. I tried for a
couple of hours, but apart from a fake HCI, the guest did not see
anything bluetooth related. So I really doubt that the current bluetooth
code in QEMU is still usable at all...

 Thomas

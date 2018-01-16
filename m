Received: from eggs.gnu.org ([2001:4830:134:3::10]:60981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry.fleytman@gmail.com>) id 1ebMDW-0001D2-HA
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 03:03:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry.fleytman@gmail.com>) id 1ebMDT-0002FL-CV
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 03:03:34 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry.fleytman@gmail.com>)
	id 1ebMDT-0002Dk-20
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 03:03:31 -0500
Received: by mail-wr0-x242.google.com with SMTP id g38so11043133wrd.2
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 00:03:30 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
From: Dmitry Fleytman <dmitry.fleytman@gmail.com>
In-Reply-To: <84d463e9-1cd6-f3aa-7554-f1ef95bdebc9@redhat.com>
Date: Tue, 16 Jan 2018 10:03:26 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <1E9A8998-E3A8-4D00-AB60-23D0E13BFB88@gmail.com>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
	<CAFEAcA_pt7XhXOhL2jSxwH9ooL7xjShmp6eBAYpRLc=dY-=TXQ@mail.gmail.com>
	<20171221223704-mutt-send-email-mst@kernel.org>
	<CAAdtpL74ZyVsLwgBjpbsdSHbWdY_Uq6ouRAvgo00UdVevTKq8A@mail.gmail.com>
	<20171222014258-mutt-send-email-mst@kernel.org>
	<CAFEAcA8eKTEh3zSOPNm1WgUujNOU+zcNSgBAE5G68QcObQd8sA@mail.gmail.com>
	<20180108200725-mutt-send-email-mst@kernel.org>
	<20180109011010.GI2131@umbus.fritz.box>
	<20180116044747-mutt-send-email-mst@kernel.org>
	<84d463e9-1cd6-f3aa-7554-f1ef95bdebc9@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/25] pc, pci, virtio: features, fixes,
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philippe@mathieu-daude.net>, QEMU Developers <qemu-devel@nongnu.org>



> On 16 Jan 2018, at 8:28, Jason Wang <jasowang@redhat.com> wrote:
>=20
>=20
>=20
> On 2018=E5=B9=B401=E6=9C=8816=E6=97=A5 10:48, Michael S. Tsirkin =
wrote:
>> On Tue, Jan 09, 2018 at 12:10:10PM +1100, David Gibson wrote:
>>> On Mon, Jan 08, 2018 at 08:10:23PM +0200, Michael S. Tsirkin wrote:
>>>> On Mon, Jan 08, 2018 at 09:14:41AM +0000, Peter Maydell wrote:
>>>>> On 21 December 2017 at 23:43, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>>>>> you also need to drop "hw/pci: remove obsolete =
PCIDevice->init()"
>>>>>>> (applied in your tree as =
18951fce55d5aa58cd1629b4cb704ee51bab4420)
>>>>>>> else the not-yet-QOM'ified NVME won't work anymore.
>>>>>> Done that too, thanks a lot
>>>>> Hi. I'm afraid this pullreq (merge of 880b1ff) has new runtime
>>>>> errors from the clang sanitizer:
>>>>>=20
>>>>> /home/petmay01/linaro/qemu-for-merges/hw/net/net_tx_pkt.c:201:27:
>>>>> runtime error: member access within misaligned address =
0x55b4ffee8246
>>>>> for type 'struct ip_header', which requires 4 byte alignment
>>>>> 0x55b4ffee8246: note: pointer points here
>>>>>  01 00 00 00 45 00  01 a9 01 00 00 00 40 11  78 45 00 00 00 00 ff =
ff
>>>>> ff ff 00 00 00 00 00 00  00 00
>>>>>              ^
>>>>> /home/petmay01/linaro/qemu-for-merges/hw/net/net_tx_pkt.c:201:27:
>>>>> runtime error: load of misaligned address 0x55b4ffee8246 for type
>>>>> 'uint8_t' (aka 'unsigned char'), which requires 4 byte alignment
>>>>> 0x55b4ffee8246: note: pointer points here
>>>>>  01 00 00 00 45 00  01 a9 01 00 00 00 40 11  78 45 00 00 00 00 ff =
ff
>>>>> ff ff 00 00 00 00 00 00  00 00
>>>>>              ^
>>>>> /home/petmay01/linaro/qemu-for-merges/hw/net/net_tx_pkt.c:208:65:
>>>>> runtime error: member access within misaligned address =
0x55b4ffee8246
>>>>> for type 'struct ip_header', which requires 4 byte alignment
>>>>> 0x55b4ffee8246: note: pointer points here
>>>>>  01 00 00 00 45 00  01 a9 01 00 00 00 40 11  78 45 00 00 00 00 ff =
ff
>>>>> ff ff 00 00 00 00 00 00  00 00
>>>>>              ^
>>>>> /home/petmay01/linaro/qemu-for-merges/hw/net/net_tx_pkt.c:210:13:
>>>>> runtime error: member access within misaligned address =
0x55b4ffee8246
>>>>> for type 'struct ip_header', which requires 4 byte alignment
>>>>> 0x55b4ffee8246: note: pointer points here
>>>>>  01 00 00 00 45 00  01 a9 01 00 00 00 40 11  78 45 00 00 00 00 ff =
ff
>>>>> ff ff 00 00 00 00 00 00  00 00
>>>>>              ^
>>>>> /home/petmay01/linaro/qemu-for-merges/hw/net/net_tx_pkt.c:210:13:
>>>>> runtime error: load of misaligned address 0x55b4ffee8246 for type
>>>>> 'uint8_t' (aka 'unsigned char'), which requires 4 byte alignment
>>>>> 0x55b4ffee8246: note: pointer points here
>>>>>  01 00 00 00 45 00  01 a9 01 00 00 00 40 11  78 45 00 00 00 00 ff =
ff
>>>>> ff ff 00 00 00 00 00 00  00 00
>>>>>              ^
>>>>>=20
>>>>> Sorry for the late report, I didn't quite have time
>>>>> to process the pull before Christmas holidays.
>>>>>=20
>>>>> thanks
>>>>> -- PMM
>>>> So I bisected and the reason is this commit:
>>>>=20
>>>> commit 18b20bb43a2f37f0c8ae23a3e9b3d9a4a05b6bd4
>>>> Author: David Gibson <david@gibson.dropbear.id.au>
>>>> Date:   Tue Dec 19 15:45:22 2017 +1100
>>>>=20
>>>>     tests/pxe-test: Add some extra tests
>>>>          Previously virtio-net was only tested for ppc64 in "slow" =
mode.  That
>>>>     doesn't make much sense since virtio-net is used much more =
often in
>>>>     practice than the spapr-vlan device which was tested always.  =
So, move
>>>>     virtio-net to always be tested on ppc64.
>>>>          We had no tests at all for the q35 machine, which doesn't =
seem wise
>>>>     given its increasing prominence.  Add a couple of tests for it,
>>>>     including testing the newer e1000e adapter.
>>>>          Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>>>     Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>>     Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>>>     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>=20
>>>> :040000 040000 5a982bfea24b9ac3c651b84425a39b3c85f4871e =
771af3fdfb2778c6d6ed6b1098d1e79c181d6fb0 M      tests
>>>>=20
>>>> Pls either fix or drop e1000e test
>>> Feel free to drop this patch for now.  I'll debug and repost it when =
I
>>> have a chance.
>>>=20
>>> --=20
>>> David Gibson			| I'll have my music baroque, =
and my code
>>> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT =
_the_ _other_
>>> 				| _way_ _around_!
>>> http://www.ozlabs.org/~dgibson
>> BTw, Jason, you might want to take a look.
>> I suspect it's a bug somewhere in the e1000e emulation.
>>=20
>=20
> Will have a look.
>=20
> cc Dmitry for more thoughts.

Not all uint8_t fields in IP header are aligned by 32 bit. Should type =
of those fields be changed to something that does not require alignment?

>=20
> Thanks

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ebKoq-0003xS-HW
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 01:34:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ebKon-0003TV-Al
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 01:34:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ebKon-0003TF-16
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 01:33:57 -0500
From: Jason Wang <jasowang@redhat.com>
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
Message-ID: <81ae7df4-666c-c10a-25fa-d8040905f70d@redhat.com>
Date: Tue, 16 Jan 2018 14:33:48 +0800
MIME-Version: 1.0
In-Reply-To: <84d463e9-1cd6-f3aa-7554-f1ef95bdebc9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philippe@mathieu-daude.net>, QEMU Developers <qemu-devel@nongnu.org>



On 2018=E5=B9=B401=E6=9C=8816=E6=97=A5 14:28, Jason Wang wrote:
>
>
> On 2018=E5=B9=B401=E6=9C=8816=E6=97=A5 10:48, Michael S. Tsirkin wrote:
>> On Tue, Jan 09, 2018 at 12:10:10PM +1100, David Gibson wrote:
>>> On Mon, Jan 08, 2018 at 08:10:23PM +0200, Michael S. Tsirkin wrote:
>>>> On Mon, Jan 08, 2018 at 09:14:41AM +0000, Peter Maydell wrote:
>>>>> On 21 December 2017 at 23:43, Michael S. Tsirkin <mst@redhat.com>=20
>>>>> wrote:
>>>>>>> you also need to drop "hw/pci: remove obsolete PCIDevice->init()"
>>>>>>> (applied in your tree as 18951fce55d5aa58cd1629b4cb704ee51bab4420=
)
>>>>>>> else the not-yet-QOM'ified NVME won't work anymore.
>>>>>> Done that too, thanks a lot
>>>>> Hi. I'm afraid this pullreq (merge of 880b1ff) has new runtime
>>>>> errors from the clang sanitizer:
>>>>>
>>>>> /home/petmay01/linaro/qemu-for-merges/hw/net/net_tx_pkt.c:201:27:
>>>>> runtime error: member access within misaligned address 0x55b4ffee82=
46
>>>>> for type 'struct ip_header', which requires 4 byte alignment
>>>>> 0x55b4ffee8246: note: pointer points here
>>>>> =C2=A0 01 00 00 00 45 00=C2=A0 01 a9 01 00 00 00 40 11=C2=A0 78 45 =
00 00 00 00 ff ff
>>>>> ff ff 00 00 00 00 00 00=C2=A0 00 00
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^
>>>>> /home/petmay01/linaro/qemu-for-merges/hw/net/net_tx_pkt.c:201:27:
>>>>> runtime error: load of misaligned address 0x55b4ffee8246 for type
>>>>> 'uint8_t' (aka 'unsigned char'), which requires 4 byte alignment
>>>>> 0x55b4ffee8246: note: pointer points here
>>>>> =C2=A0 01 00 00 00 45 00=C2=A0 01 a9 01 00 00 00 40 11=C2=A0 78 45 =
00 00 00 00 ff ff
>>>>> ff ff 00 00 00 00 00 00=C2=A0 00 00
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^
>>>>> /home/petmay01/linaro/qemu-for-merges/hw/net/net_tx_pkt.c:208:65:
>>>>> runtime error: member access within misaligned address 0x55b4ffee82=
46
>>>>> for type 'struct ip_header', which requires 4 byte alignment
>>>>> 0x55b4ffee8246: note: pointer points here
>>>>> =C2=A0 01 00 00 00 45 00=C2=A0 01 a9 01 00 00 00 40 11=C2=A0 78 45 =
00 00 00 00 ff ff
>>>>> ff ff 00 00 00 00 00 00=C2=A0 00 00
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^
>>>>> /home/petmay01/linaro/qemu-for-merges/hw/net/net_tx_pkt.c:210:13:
>>>>> runtime error: member access within misaligned address 0x55b4ffee82=
46
>>>>> for type 'struct ip_header', which requires 4 byte alignment
>>>>> 0x55b4ffee8246: note: pointer points here
>>>>> =C2=A0 01 00 00 00 45 00=C2=A0 01 a9 01 00 00 00 40 11=C2=A0 78 45 =
00 00 00 00 ff ff
>>>>> ff ff 00 00 00 00 00 00=C2=A0 00 00
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^
>>>>> /home/petmay01/linaro/qemu-for-merges/hw/net/net_tx_pkt.c:210:13:
>>>>> runtime error: load of misaligned address 0x55b4ffee8246 for type
>>>>> 'uint8_t' (aka 'unsigned char'), which requires 4 byte alignment
>>>>> 0x55b4ffee8246: note: pointer points here
>>>>> =C2=A0 01 00 00 00 45 00=C2=A0 01 a9 01 00 00 00 40 11=C2=A0 78 45 =
00 00 00 00 ff ff
>>>>> ff ff 00 00 00 00 00 00=C2=A0 00 00
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ^
>>>>>
>>>>> Sorry for the late report, I didn't quite have time
>>>>> to process the pull before Christmas holidays.
>>>>>
>>>>> thanks
>>>>> -- PMM
>>>> So I bisected and the reason is this commit:
>>>>
>>>> commit 18b20bb43a2f37f0c8ae23a3e9b3d9a4a05b6bd4
>>>> Author: David Gibson <david@gibson.dropbear.id.au>
>>>> Date:=C2=A0=C2=A0 Tue Dec 19 15:45:22 2017 +1100
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 tests/pxe-test: Add some extra tests
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 Previously virtio-=
net was only tested for ppc64 in "slow"=20
>>>> mode.=C2=A0 That
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 doesn't make much sense since virtio-net is=
 used much more=20
>>>> often in
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 practice than the spapr-vlan device which w=
as tested always.=C2=A0=20
>>>> So, move
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 virtio-net to always be tested on ppc64.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 We had no tests at=
 all for the q35 machine, which doesn't=20
>>>> seem wise
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 given its increasing prominence.=C2=A0 Add =
a couple of tests for it,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 including testing the newer e1000e adapter.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 Signed-off-by: Dav=
id Gibson <david@gibson.dropbear.id.au>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Reviewed-by: Michael S. Tsirkin <mst@redhat=
.com>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Signed-off-by: Michael S. Tsirkin <mst@redh=
at.com>
>>>>
>>>> :040000 040000 5a982bfea24b9ac3c651b84425a39b3c85f4871e=20
>>>> 771af3fdfb2778c6d6ed6b1098d1e79c181d6fb0 M=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 tests
>>>>
>>>> Pls either fix or drop e1000e test
>>> Feel free to drop this patch for now.=C2=A0 I'll debug and repost it =
when I
>>> have a chance.
>>>
>>> --=20
>>> David Gibson=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | I'll have my music baroque, and my code
>>> david AT gibson.dropbear.id.au=C2=A0=C2=A0=C2=A0 | minimalist, thank =
you. NOT _the_=20
>>> _other_
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | _way_ _around_!
>>> http://www.ozlabs.org/~dgibson
>> BTw, Jason, you might want to take a look.
>> I suspect it's a bug somewhere in the e1000e emulation.
>>
>
> Will have a look.
>
> cc Dmitry for more thoughts.
>
> Thanks
>

Cc again with the correct address.

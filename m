Received: from eggs.gnu.org ([209.51.188.92]:49076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1go2Ak-0001H0-5R
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:21:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1go2Ai-0001Fj-FP
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:21:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:12959)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1go2Ah-0001Dx-Kx
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:21:36 -0500
References: <20190125151440.13794-1-sourav.jb1988@gmail.com>
	<f9288ca3-1f07-3409-ac16-ce4dc958940e@redhat.com>
	<cc09d469-56bc-9438-acc0-0d4ccf67e6a5@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c3d19d18-3269-ff31-affb-68d38de7cc3e@redhat.com>
Date: Mon, 28 Jan 2019 09:14:03 +0100
MIME-Version: 1.0
In-Reply-To: <cc09d469-56bc-9438-acc0-0d4ccf67e6a5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw: input: set category of the i8042 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, kumar sourav <sourav.jb1988@gmail.com>, qemu-trivial@nongnu.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, mst@redhat.com

On 2019-01-25 17:44, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/25/19 4:24 PM, Thomas Huth wrote:
>> On 2019-01-25 16:14, kumar sourav wrote:
>>> Sets the category of i8042 device as DEVICE_CATEGORY_INPUT
>>> Devices should be assigned to one of DEVICE_CATEGORY_XXXX.
>>>
>>> Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>
>>> ---
>>>  hw/input/pckbd.c | 1 +
>=20
> It seems we have other potential cases:
>=20
> $ git grep -L 'set_bit(DEVICE_CATEGORY_INPUT' hw/input/*c
> hw/input/adb.c
> hw/input/hid.c
> hw/input/lm832x.c
> hw/input/milkymist-softusb.c
> hw/input/pckbd.c
> hw/input/pl050.c
> hw/input/ps2.c
> hw/input/pxa2xx_keypad.c
> hw/input/stellaris_input.c
> hw/input/tsc2005.c
> hw/input/tsc210x.c
> hw/input/virtio-input-hid.c
> hw/input/virtio-input-host.c

Note that some of these are not even "qomified" yet (e.g. tsc2005),
others are not creatable by the user (pl050) as far as I can see, so it
does not make much sense to set a category for these devices yet.

 Thomas

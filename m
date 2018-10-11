Received: from eggs.gnu.org ([2001:4830:134:3::10]:50098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1gAdhR-0006mq-9B
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 12:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1gAdhQ-0005oR-2f
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 12:20:33 -0400
References: <20181002142443.30976-1-damien.hedde@greensocs.com>
	<08d9d1e0-3c37-4b69-bb68-bf993b91289a@redhat.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <2dddf6d3-4362-9ed1-18b5-f927e850c10f@greensocs.com>
Date: Thu, 11 Oct 2018 18:20:11 +0200
MIME-Version: 1.0
In-Reply-To: <08d9d1e0-3c37-4b69-bb68-bf993b91289a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 0/9] Clock framework API.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, edgar.iglesias@xilinx.com, peter.maydell@linaro.org, alistair@alistair23.me, mark.burton@greensocs.com, saipava@xilinx.com, qemu-arm@nongnu.org, pbonzini@redhat.com, konrad@adacore.com, luc.michel@greensocs.com


Hi Philippe,

On 10/4/18 6:13 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Damien,
>=20
> On 02/10/2018 16:24, Damien Hedde wrote:
>> This series aims to add a way to model clocks in qemu between devices.
>> This allows to model the clock tree of a platform allowing us to inspe=
ct clock
>> configuration and detect problems such as disabled clock or bad config=
ured
>> pll.
>>
>> [...]
>>
>> Any comments and suggestion are welcomed.
>=20
> How would you instanciate devices and connect their clocks from the
> command line (with the -device option)?
I didn't not thought about that. I'm not sure to understand how this is
done for a gpio for example. Is this done by setting the link property
manually ?

If that's the case, I suppose we can somehow add a link property on the
input side to the output side to achieve that. The other way seem not
possible due to the fact the output side has a dynamically allocated
list of inputs.
>=20
> Should clocked devices have DeviceClass::user_creatable =3D false by de=
fault?
It would be a solution, but I don't think we want this ?
>=20
> Thanks,
>=20
> Phil.
>=20

Thanks,

Damien

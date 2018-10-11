Received: from eggs.gnu.org ([2001:4830:134:3::10]:50811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAdkZ-0007jz-DA
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 12:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAdkV-0007eo-Si
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 12:23:45 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gAdkT-0007dO-TY
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 12:23:43 -0400
Received: by mail-ot1-x344.google.com with SMTP id c32so9493930otb.8
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 09:23:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2dddf6d3-4362-9ed1-18b5-f927e850c10f@greensocs.com>
References: <20181002142443.30976-1-damien.hedde@greensocs.com>
	<08d9d1e0-3c37-4b69-bb68-bf993b91289a@redhat.com>
	<2dddf6d3-4362-9ed1-18b5-f927e850c10f@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Oct 2018 17:23:20 +0100
Message-ID: <CAFEAcA-mv2k=fe_QoBpdow4afm6QR2BPAAaD+aC3hdxEfvcPAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Damien Hedde <damien.hedde@greensocs.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, konrad@adacore.com, Luc Michel <luc.michel@greensocs.com>

On 11 October 2018 at 17:20, Damien Hedde <damien.hedde@greensocs.com> wrot=
e:
>
> Hi Philippe,
>
> On 10/4/18 6:13 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Damien,
>>
>> On 02/10/2018 16:24, Damien Hedde wrote:
>>> This series aims to add a way to model clocks in qemu between devices.
>>> This allows to model the clock tree of a platform allowing us to inspec=
t clock
>>> configuration and detect problems such as disabled clock or bad configu=
red
>>> pll.
>>>
>>> [...]
>>>
>>> Any comments and suggestion are welcomed.
>>
>> How would you instanciate devices and connect their clocks from the
>> command line (with the -device option)?
> I didn't not thought about that. I'm not sure to understand how this is
> done for a gpio for example. Is this done by setting the link property
> manually ?

You can't wire up GPIOs on the command line. I don't think we
really need to be able to wire up clocks on the command line either,
do we?

> Should clocked devices have DeviceClass::user_creatable =3D false by defa=
ult?

How many devices have a clock and nothing else that would cause
them to be non-user-creatable (ie no GPIOs, no IRQ lines, no
memory-mapped memory regions) ?

thanks
-- PMM

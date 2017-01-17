Received: from eggs.gnu.org ([2001:4830:134:3::10]:46126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cTPGo-0004YL-Ch
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:37:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cTPGk-0000wS-5S
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:37:34 -0500
Received: from 11.mo5.mail-out.ovh.net ([46.105.47.167]:51674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cTPGj-0000w8-VE
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:37:30 -0500
Received: from player760.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 7D7156D335
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 09:37:28 +0100 (CET)
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
	<1483979087-32663-12-git-send-email-clg@kaod.org>
	<b5660d74-0c16-871b-bec0-31a5a6e19f04@gmail.com>
	<9b1c1700-04cc-9b1e-6fdc-5ac84e5cd42e@kaod.org>
	<e6c78999-f851-eb32-6244-80e85e0b5190@gmail.com>
	<64b13418-337d-d3a6-2c65-0add542c9ba8@kaod.org>
	<f36efc32-d25b-0948-6302-0b84ccc3bdda@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1585f3eb-c387-d3c5-c11a-0426bd236a17@kaod.org>
Date: Tue, 17 Jan 2017 09:37:23 +0100
MIME-Version: 1.0
In-Reply-To: <f36efc32-d25b-0948-6302-0b84ccc3bdda@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/11] aspeed/smc: handle dummy bytes
 when doing fast reads in command mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "mar.krzeminski" <mar.krzeminski@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 01/16/2017 07:58 PM, mar.krzeminski wrote:
>=20
>=20
> W dniu 16.01.2017 o 09:18, C=C3=A9dric Le Goater pisze:
>>> I did not notice that this function is also called in writes, isn't i=
t?
>>> If yes, dummy cycles are used only during reads so probably CTRL_FREA=
DMODE
>>> needs to be tested.
>> yes. I can take care of that in a follow up patchset for
>> dummy support.
>>   Dummies in user mode is a bit painful to implement, as I had
>> to snoop into the command flow to catch the fast read op.
>> Not sure this is the right approach so I kept it for later.
> Definitelly wrong, controller should not be aware of tha, fix is still =
on me :(

ok. np. I will send the support for command mode though,=20
as this is a must have for booting.

>>
>>
>> Did you have time to take look at the other patches adding
>> Command mode and extending the tests ? I should have addressed
>> your comments there.
> Yes, there is one more thing that could be important. It popped out in =
Sabrelite
> SPI model. The question is does SCM support different CS active (so dev=
ice
> is active at CS high). Your code assume that SMC will always use CS LOW=
 to activate
> device. If this is not true you might be interested in update this too.

Aspeed SoC does not let you configure the chip select polarity=20
(nor the clock phase ) So it is active low only.

Thanks,

C.

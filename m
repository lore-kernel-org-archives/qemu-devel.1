Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C37DC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:30:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0120B222A2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0120B222A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX6Oq-00033I-PG
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 11:30:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iX6M9-0000yx-6m
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:28:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iX6M7-0001rI-5i
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:27:57 -0500
Received: from 1.mo177.mail-out.ovh.net ([178.33.107.143]:44256)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iX6M5-0001jk-BT
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:27:54 -0500
Received: from player692.ha.ovh.net (unknown [10.108.35.59])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 1E07E113FBA
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 17:27:49 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player692.ha.ovh.net (Postfix) with ESMTPSA id 9575FC2C8C00;
 Tue, 19 Nov 2019 16:27:40 +0000 (UTC)
Subject: Re: [PATCH] misc/pca9552: Add qom set and get
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>
References: <20191118061757.52550-1-joel@jms.id.au>
 <42f378d5-e7ea-11ce-11d5-9589fe7194d2@kaod.org>
 <9f810374-97d4-8162-c92d-a1513c1a23a0@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <817b83f1-f534-9886-2054-4de6cd04a899@kaod.org>
Date: Tue, 19 Nov 2019 17:27:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <9f810374-97d4-8162-c92d-a1513c1a23a0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 1730789633458932500
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -83
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegkedgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdludejmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuffhomhgrihhnpehophgvnhhpohifvghrrdighiiipdhoiihlrggsshdrohhrghenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.107.143
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jeffery <andrew@aj.id.au>, Rashmica Gupta <rashmica.g@gmail.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/11/2019 18:48, Philippe Mathieu-Daud=C3=A9 wrote:
> Odd... I only received C=C3=A9dric answer, not Joel patch.
>=20
> On 11/18/19 11:00 AM, C=C3=A9dric Le Goater wrote:
>> On 18/11/2019 07:17, Joel Stanley wrote:
>>> Following the pattern of the work recently done with the ASPEED GPIO
>>> model, this adds support for inspecting and modifying the PCA9552 LED=
s
>>> from the monitor.
>>>
>>> =C2=A0 (qemu) qom-set=C2=A0 /machine/unattached/device[17] led0 on
>>> =C2=A0 (qemu) qom-get=C2=A0 /machine/unattached/device[17] led0
>>> =C2=A0 "on"
>>>
>>> =C2=A0 (qemu) qom-set=C2=A0 /machine/unattached/device[17] led0 off
>>> =C2=A0 (qemu) qom-get=C2=A0 /machine/unattached/device[17] led0
>>> =C2=A0 "off"
>>>
>>> =C2=A0 (qemu) qom-set=C2=A0 /machine/unattached/device[17] led0 pwm0
>>> =C2=A0 (qemu) qom-get=C2=A0 /machine/unattached/device[17] led0
>>> =C2=A0 "pwm0"
>>>
>>> =C2=A0 (qemu) qom-set=C2=A0 /machine/unattached/device[17] led0 pwm1
>>> =C2=A0 (qemu) qom-get=C2=A0 /machine/unattached/device[17] led0
>>> =C2=A0 "pwm1"
>>
>> It would be nice to revive the QOM get patchset from David.
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0http://patchwork.ozlabs.org/patch/666458/
>>
>> Did we reach some consensus ?
>>
>>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>>
>> Some comments below.
>>
>>> ---
>>> The qom device in mainline qemu is a different path. Using the monito=
r
>>> examine `info qom-tree /machine/unattached/` to discover it.
>>>
>>> This can be tested with a Witherspoon image.
>>>
>>> $ wget https://openpower.xyz/job/openbmc-build/distro=3Dubuntu,label=3D=
builder,target=3Dwitherspoon/lastSuccessfulBuild/artifact/deploy/images/w=
itherspoon/obmc-phosphor-image-witherspoon.ubi.mtd
>>>
>>> $ qemu-system-arm -M witherspoon-bmc -serial pty -monitor pty -nograp=
hic \
>>> =C2=A0 -drive file=3Dobmc-phosphor-image-witherspoon.ubi.mtd,format=3D=
raw,if=3Dmtd
>>> char device redirected to /dev/pts/5 (label compat_monitor0)
>>> char device redirected to /dev/pts/10 (label serial0)
>>>
>>> $ screen /dev/pts/5
>>> QEMU 4.1.91 monitor - type 'help' for more information
>>> (qemu) qom-get=C2=A0 /machine/unattached/device[17] led0
>>> "off"
>>>
>>> $ screen /dev/pts/19
>>> root@witherspoon:~# cd /sys/class/gpio/
>>> root@witherspoon:/sys/class/gpio# echo 248 > export
>>> root@witherspoon:/sys/class/gpio# cat gpio248/value
>>> 0
>>>
>>> (qemu) qom-set=C2=A0 /machine/unattached/device[17] led0 on
>>>
>>> root@witherspoon:/sys/class/gpio# echo out > gpio248/direction
>>> root@witherspoon:/sys/class/gpio# cat gpio248/value
>>> 1
>>>
>>> (qemu) qom-get=C2=A0 /machine/unattached/device[17] led0
>>> "on"
>>>
>>> (qemu) qom-set=C2=A0 /machine/unattached/device[17] led0 off
>>> (qemu) qom-get=C2=A0 /machine/unattached/device[17] led0
>>> "off"
>>>
>>> root@witherspoon:/sys/class/gpio# cat gpio248/value
>>> 0
>=20
> I am assuming this is 5.0 material.
>=20
> This is a good starting point, and is useful.
>=20
> However this would be useful for other boards/devices too.
>=20
> What about defining a InterfaceInfo[] for external GPIOs?

The code below is very specific to pca9552.

What kind of interface do you have in mind more precisely ?=20
which handlers ?

Thanks

C.

> Shouldn't we use the qemu_irq type for that then?
>=20
>>>
>>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>>> ---
>>> =C2=A0 hw/misc/pca9552.c | 91 +++++++++++++++++++++++++++++++++++++++=
++++++++
>>> =C2=A0 1 file changed, 91 insertions(+)
>>>
>>> diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
>>> index 73be28d9369c..0362aac8c862 100644
>>> --- a/hw/misc/pca9552.c
>>> +++ b/hw/misc/pca9552.c
>>> @@ -15,12 +15,16 @@
>>> =C2=A0 #include "hw/misc/pca9552.h"
>>> =C2=A0 #include "hw/misc/pca9552_regs.h"
>>> =C2=A0 #include "migration/vmstate.h"
>>> +#include "qapi/error.h"
>>> +#include "qapi/visitor.h"
>>> =C2=A0 =C2=A0 #define PCA9552_LED_ON=C2=A0=C2=A0 0x0
>>> =C2=A0 #define PCA9552_LED_OFF=C2=A0 0x1
>>> =C2=A0 #define PCA9552_LED_PWM0 0x2
>>> =C2=A0 #define PCA9552_LED_PWM1 0x3
>>> =C2=A0 +static const char *led_state[] =3D {"on", "off", "pwm0", "pwm=
1"};
>=20
> BTW "pwm0/pwm1" as "state" is confuse, but I understand this is how the=
 PCA9552 datasheet describes it.
>=20
>>> +
>>> =C2=A0 static uint8_t pca9552_pin_get_config(PCA9552State *s, int pin=
)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t reg=C2=A0=C2=A0 =3D PCA9552_LS=
0 + (pin / 4);
>>> @@ -169,6 +173,84 @@ static int pca9552_event(I2CSlave *i2c, enum i2c=
_event event)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>> =C2=A0 +static void pca9552_get_led(Object *obj, Visitor *v, const ch=
ar *name,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 void *opaque, Error **errp)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 PCA9552State *s =3D PCA9552(obj);
>>> +=C2=A0=C2=A0=C2=A0 int led, rc, reg;
>>> +=C2=A0=C2=A0=C2=A0 char *str;
>>> +=C2=A0=C2=A0=C2=A0 uint8_t state;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 rc =3D sscanf(name, "led%2d", &led);
>>> +=C2=A0=C2=A0=C2=A0 if (rc !=3D 1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "%s: err=
or reading %s", __func__, name);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (led < 0 || led > s->nr_leds) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "%s inva=
lid led %s", __func__, name);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Get the LSx register as the qom interface=
 should expose the device
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * state, not the modeled 'input line' behav=
iour which would come from
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reading the INPUTx reg
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 reg =3D PCA9552_LS0 + led / 4;
>>> +=C2=A0=C2=A0=C2=A0 state =3D (pca9552_read(s, reg) >> (led % 8)) & 0=
x3;
>>
>> Could we add accessors to extract the register fields and to clarify
>> the layout ?
>>
>>> +=C2=A0=C2=A0=C2=A0 str =3D g_strdup(led_state[state]);
>>> +=C2=A0=C2=A0=C2=A0 visit_type_str(v, name, &str, errp);
>>> +}
>>> +
>>> +/*
>>> + * Return an LED selector register value based on an existing one, w=
ith
>>> + * the appropriate 2-bit state value set for the given LED number (0=
-3).
>>> + */
>>> +static inline uint8_t pca955x_ledsel(uint8_t oldval, int led_num, in=
t state)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (oldval & (~(0x3 <=
< (led_num << 1)))) |
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ((state & 0x3) << (led_num << 1));
>>> +}
>>> +
>>> +static void pca9552_set_led(Object *obj, Visitor *v, const char *nam=
e,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 void *opaque, Error **errp)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 PCA9552State *s =3D PCA9552(obj);
>>> +=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0 int led, rc, reg, val;
>>> +=C2=A0=C2=A0=C2=A0 uint8_t state;
>>> +=C2=A0=C2=A0=C2=A0 char *state_str;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 visit_type_str(v, name, &state_str, &local_err);
>>> +=C2=A0=C2=A0=C2=A0 if (local_err) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp, loc=
al_err);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 rc =3D sscanf(name, "led%2d", &led);
>>> +=C2=A0=C2=A0=C2=A0 if (rc !=3D 1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "%s: err=
or reading %s", __func__, name);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (led < 0 || led > s->nr_leds) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "%s inva=
lid led %s", __func__, name);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for (state =3D 0; state < ARRAY_SIZE(led_state); =
state++) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!strcmp(state_str, le=
d_state[state])) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (state >=3D ARRAY_SIZE(led_state)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "%s inva=
lid led state %s", __func__, state_str);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 reg =3D PCA9552_LS0 + led / 4;
>>> +=C2=A0=C2=A0=C2=A0 val =3D pca9552_read(s, reg);
>>> +=C2=A0=C2=A0=C2=A0 val =3D pca955x_ledsel(val, led % 4, state);
>>> +=C2=A0=C2=A0=C2=A0 pca9552_write(s, reg, val);
>>> +}
>>> +
>>> =C2=A0 static const VMStateDescription pca9552_vmstate =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "PCA9552",
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .version_id =3D 0,
>>> @@ -204,6 +286,7 @@ static void pca9552_reset(DeviceState *dev)
>>> =C2=A0 static void pca9552_initfn(Object *obj)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCA9552State *s =3D PCA9552(obj);
>>> +=C2=A0=C2=A0=C2=A0 int led;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If support for the other PCA=
955X devices are implemented, these
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * constant values might be part =
of class structure describing the
>>> @@ -211,6 +294,14 @@ static void pca9552_initfn(Object *obj)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->max_reg =3D PCA9552_LS3;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->nr_leds =3D 16;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for (led =3D 0; led < s->nr_leds; led++) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *name;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D g_strdup_printf(=
"led%d", led);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_add(obj, =
name, "bool", pca9552_get_led, pca9552_set_led,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 NULL, NULL, NULL);
>>
>> It misses a :
>>
>> =C2=A0=C2=A0=C2=A0 g_free(name)
>>
>> C.
>>
>>> +=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 }
>>> =C2=A0 =C2=A0 static void pca9552_class_init(ObjectClass *klass, void=
 *data)
>>>
>>
>>
>=20



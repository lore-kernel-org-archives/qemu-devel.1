Received: from eggs.gnu.org ([2001:4830:134:3::10]:55639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cb1xW-0006WI-He
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 04:21:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cb1xR-0002T9-J7
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 04:21:10 -0500
Received: from greensocs.com ([193.104.36.180]:44789)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cb1xR-0002Rn-5P
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 04:21:05 -0500
References: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
	<1485424060-12217-2-git-send-email-fred.konrad@greensocs.com>
	<a4aa34e4-dd2b-4d0a-543e-c19e5fced1b4@kaod.org>
From: Frederic Konrad <fred.konrad@greensocs.com>
Message-ID: <10f9e10f-788a-7b04-0f29-034af42345f4@greensocs.com>
Date: Tue, 7 Feb 2017 10:20:59 +0100
MIME-Version: 1.0
In-Reply-To: <a4aa34e4-dd2b-4d0a-543e-c19e5fced1b4@kaod.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2 01/10] qemu-clk: introduce qemu-clk qom
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, edgar.iglesias@xilinx.com, peter.maydell@linaro.org, mark.burton@greensocs.com, alistair.francis@xilinx.com

On 02/05/2017 04:25 PM, C=E9dric Le Goater wrote:
> ello Frederic,

Hi C=E9dric,

Thanks for taking a look at this!

>=20
> On 01/26/2017 10:47 AM, fred.konrad@greensocs.com wrote:
>> From: KONRAD Frederic <fred.konrad@greensocs.com>
>>
>> This introduces qemu-clk qom object.
>>
>> Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
>> ---
>>  Makefile.objs             |  1 +
>>  include/qemu/qemu-clock.h | 40 +++++++++++++++++++++++++++++++++++++
>>  qemu-clock.c              | 50 ++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  3 files changed, 91 insertions(+)
>>  create mode 100644 include/qemu/qemu-clock.h
>>  create mode 100644 qemu-clock.c
>>
>> diff --git a/Makefile.objs b/Makefile.objs
>> index 01cef86..de0219d 100644
>> --- a/Makefile.objs
>> +++ b/Makefile.objs
>> @@ -78,6 +78,7 @@ common-obj-y +=3D backends/
>>  common-obj-$(CONFIG_SECCOMP) +=3D qemu-seccomp.o
>> =20
>>  common-obj-$(CONFIG_FDT) +=3D device_tree.o
>> +common-obj-y +=3D qemu-clock.o
>> =20
>>  #####################################################################=
#
>>  # qapi
>> diff --git a/include/qemu/qemu-clock.h b/include/qemu/qemu-clock.h
>> new file mode 100644
>> index 0000000..e7acd68
>> --- /dev/null
>> +++ b/include/qemu/qemu-clock.h
>> @@ -0,0 +1,40 @@
>> +/*
>> + * QEMU Clock
>> + *
>> + *  Copyright (C) 2016 : GreenSocs Ltd
>> + *      http://www.greensocs.com/ , email: info@greensocs.com
>> + *
>> + *  Frederic Konrad <fred.konrad@greensocs.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modi=
fy
>> + * it under the terms of the GNU General Public License as published =
by
>> + * the Free Software Foundation, either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License =
along
>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>=20
> May be we could shorten the GPL v2 statement to something like :
> =20
>  * This code is licensed under the GPL version 2 or later. See the
>  * COPYING file in the top-level directory.
>=20
> I haven't been very good at that my self, but we could save=20
> quite a few lines in qemu if files were not repeating the=20
> License statement.

Well if it is really needed I can get rid of this few lines :).

>=20
>=20
>> + *
>> + */
>> +
>> +#ifndef QEMU_CLOCK_H
>> +#define QEMU_CLOCK_H
>> +
>> +#include "qemu/osdep.h"
>> +#include "qom/object.h"
>> +
>> +#define TYPE_CLOCK "qemu-clk"
>> +#define QEMU_CLOCK(obj) OBJECT_CHECK(struct qemu_clk, (obj), TYPE_CLO=
CK)
>> +
>> +typedef struct qemu_clk {
>> +    /*< private >*/
>> +    Object parent_obj;
>> +} *qemu_clk;
>>
>=20
> CODING_STYLE says that we should use CamelCase for typedef. Also, I don=
't=20
> think the '*' is required. What's the idea ?=20

Your right, I tried to follow the gpio "style".. But maybe it's old and
we better go for the camelcase and without the pointer.

>=20
>> +#endif /* QEMU_CLOCK_H */
>> +
>> +
>> diff --git a/qemu-clock.c b/qemu-clock.c
>> new file mode 100644
>> index 0000000..ceea98d
>> --- /dev/null
>> +++ b/qemu-clock.c
>> @@ -0,0 +1,50 @@
>> +/*
>> + * QEMU Clock
>> + *
>> + *  Copyright (C) 2016 : GreenSocs Ltd
>> + *      http://www.greensocs.com/ , email: info@greensocs.com
>> + *
>> + *  Frederic Konrad <fred.konrad@greensocs.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modi=
fy
>> + * it under the terms of the GNU General Public License as published =
by
>> + * the Free Software Foundation, either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License =
along
>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/qemu-clock.h"
>> +#include "hw/hw.h"
>> +#include "qemu/log.h"
>> +
>> +#ifndef DEBUG_QEMU_CLOCK
>> +#define DEBUG_QEMU_CLOCK 0
>> +#endif
>> +
>> +#define DPRINTF(fmt, args...) do {                                   =
        \
>> +    if (DEBUG_QEMU_CLOCK) {                                          =
        \
>> +        qemu_log("%s: " fmt, __func__, ## args);                     =
        \
>> +    }                                                                =
        \
>> +} while (0);
>=20
> I think the trace framework should be used instead.

Seems not really standard AFAIK.
Some files use printf, some other qemu_log etc..

Thanks,
Fred
>=20
> Thanks
>=20
> C.
>=20
>> +static const TypeInfo qemu_clk_info =3D {
>> +    .name          =3D TYPE_CLOCK,
>> +    .parent        =3D TYPE_OBJECT,
>> +    .instance_size =3D sizeof(struct qemu_clk),
>> +};
>> +
>> +static void qemu_clk_register_types(void)
>> +{
>> +    type_register_static(&qemu_clk_info);
>> +}
>> +
>> +type_init(qemu_clk_register_types);
>>
>=20
>=20

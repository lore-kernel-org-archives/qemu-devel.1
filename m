Received: from eggs.gnu.org ([2001:4830:134:3::10]:40747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alastair@au1.ibm.com>) id 1cOv0x-0002zq-Gx
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 18:30:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alastair@au1.ibm.com>) id 1cOv0t-0005K3-CK
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 18:30:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57964
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alastair@au1.ibm.com>)
	id 1cOv0t-0005J6-32
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 18:30:35 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v04NToka041143
	for <qemu-devel@nongnu.org>; Wed, 4 Jan 2017 18:30:34 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27s6xy8prv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 18:30:33 -0500
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alastair@au1.ibm.com>;
	Thu, 5 Jan 2017 09:30:30 +1000
From: "Alastair D'Silva" <alastair@au1.ibm.com>
Date: Thu, 05 Jan 2017 10:30:26 +1100
In-Reply-To: <1483510484.22609.8.camel@aj.id.au>
References: <20161215054812.12602-1-alastair@au1.ibm.com>
	<20161215054812.12602-8-alastair@au1.ibm.com>
	<1483510484.22609.8.camel@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1483572626.13607.15.camel@au1.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 7/8] tests: Test all implemented RX8900
 functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Joel Stanley <joel@jms.id.au>



On Wed, 2017-01-04 at 16:44 +1030, Andrew Jeffery wrote:
> Hi Alastair,
>=20
> Again, small comments below.
>=20
> On Thu, 2016-12-15 at 16:48 +1100, Alastair D'Silva wrote:
> > > From: Alastair D'Silva <alastair@d-silva.org>
> > > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> >=20
> > ---
> > =C2=A0tests/Makefile.include |=C2=A0=C2=A0=C2=A02 +
> > =C2=A0tests/rx8900-test.c=C2=A0=C2=A0=C2=A0=C2=A0| 882
> > +++++++++++++++++++++++++++++++++++++++++++++++++
> > =C2=A02 files changed, 884 insertions(+)
> > =C2=A0create mode 100644 tests/rx8900-test.c
> >=20
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index e98d3b6..e52e355 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -300,6 +300,7 @@ check-qtest-sparc64-y =3D tests/endianness-
> > test$(EXESUF)
> > =C2=A0
> > =C2=A0check-qtest-arm-y =3D tests/tmp105-test$(EXESUF)
> > =C2=A0check-qtest-arm-y +=3D tests/ds1338-test$(EXESUF)
> > +check-qtest-arm-y +=3D tests/rx8900-test$(EXESUF)
> > =C2=A0check-qtest-arm-y +=3D tests/m25p80-test$(EXESUF)
> > =C2=A0gcov-files-arm-y +=3D hw/misc/tmp105.c
> > =C2=A0check-qtest-arm-y +=3D tests/virtio-blk-test$(EXESUF)
> > @@ -637,6 +638,7 @@ tests/bios-tables-test$(EXESUF): tests/bios-
> > tables-test.o \
> > =C2=A0tests/pxe-test$(EXESUF): tests/pxe-test.o tests/boot-sector.o
> > $(libqos-obj-y)
> > =C2=A0tests/tmp105-test$(EXESUF): tests/tmp105-test.o $(libqos-omap-o=
bj-
> > y)
> > =C2=A0tests/ds1338-test$(EXESUF): tests/ds1338-test.o $(libqos-imx-ob=
j-
> > y)
> > +tests/rx8900-test$(EXESUF): tests/rx8900-test.o $(libqos-imx-obj-
> > y)
> > =C2=A0tests/m25p80-test$(EXESUF): tests/m25p80-test.o
> > =C2=A0tests/i440fx-test$(EXESUF): tests/i440fx-test.o $(libqos-pc-obj=
-y)
> > =C2=A0tests/q35-test$(EXESUF): tests/q35-test.o $(libqos-pc-obj-y)
> > diff --git a/tests/rx8900-test.c b/tests/rx8900-test.c
> > new file mode 100644
> > index 0000000..1769659
> > --- /dev/null
> > +++ b/tests/rx8900-test.c
> > @@ -0,0 +1,882 @@
> > +/*
> > + * QTest testcase for the Epson RX8900SA/CE RTC
> > + *
> > + * Copyright (c) 2016 IBM Corporation
> > + * Authors:
> > > + *=C2=A0=C2=A0Alastair D'Silva <alastair@d-silva.org>
> >=20
> > + *
> > + * This code is licensed under the GPL version 2 or later.=C2=A0=C2=A0=
See
> > + * the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/timer/rx8900_regs.h"
> > +#include "libqtest.h"
> > +#include "libqos/i2c.h"
> > +#include "qemu/timer.h"
> > +
> > +#define IMX25_I2C_0_BASE 0x43F80000
> > +#define RX8900_TEST_ID "rx8900-test"
> > +#define RX8900_ADDR 0x32
> > +#define RX8900_INTERRUPT_OUT "rx8900-interrupt-out"
> > +#define RX8900_FOUT_ENABLE "rx8900-fout-enable"
> > +#define RX8900_FOUT "rx8900-fout"
> > +
> > +static I2CAdapter *i2c;
> > +static uint8_t addr;
> > +
> > +static inline uint8_t bcd2bin(uint8_t x)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0return (x & 0x0f) + (x >> 4) * 10;
> > +}
> > +
> > +static inline uint8_t bin2bcd(uint8_t x)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0return (x / 10 << 4) | (x % 10);
> > +}
> > +
> > +static void qmp_rx8900_set_temperature(const char *id, double
> > value)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0QDict *response;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0response =3D qmp("{ 'execute': 'qom-set', 'a=
rguments': { 'path':
> > %s, "
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"'property': 'temperature', =
'value': %f } }",
> > id, value);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert(qdict_haskey(response, "return"));
> > +=C2=A0=C2=A0=C2=A0=C2=A0QDECREF(response);
> > +}
> > +
> > +static void qmp_rx8900_set_voltage(const char *id, double value)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0QDict *response;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0response =3D qmp("{ 'execute': 'qom-set', 'a=
rguments': { 'path':
> > %s, "
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"'property': 'voltage', 'val=
ue': %f } }", id,
> > value);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert(qdict_haskey(response, "return"));
> > +=C2=A0=C2=A0=C2=A0=C2=A0QDECREF(response);
> > +}
> > +
> > +/**
> > + * Read an RX8900 register
> > + * @param reg the address of the register
> > + * @return the value of the register
> > + */
> > +static uint8_t read_register(RX8900Addresses reg)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t val;
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t reg_address =3D (uint8_t)reg;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0i2c_send(i2c, addr, &reg_address, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0i2c_recv(i2c, addr, &val, 1);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0return val;
> > +}
> > +
> > +/**
> > + * Write to an RX8900 register
> > + * @param reg the address of the register
> > + * @param val the value to write
> > + */
> > +static uint8_t write_register(RX8900Addresses reg, uint8_t val)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t buf[2];
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[0] =3D reg;
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[1] =3D val;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0i2c_send(i2c, addr, buf, 2);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0return val;
> > +}
> > +
> > +/**
> > + * Set bits in a register
> > + * @param reg the address of the register
> > + * @param mask a mask of the bits to set
> > + */
> > +static void set_bits_in_register(RX8900Addresses reg, uint8_t
> > mask)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t value =3D read_register(reg);
> > +=C2=A0=C2=A0=C2=A0=C2=A0value |=3D mask;
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_register(reg, value);
> > +}
> > +
> > +/**
> > + * Clear bits in a register
> > + * @param reg the address of the register
> > + * @param mask a mask of the bits to set
> > + */
> > +static void clear_bits_in_register(RX8900Addresses reg, uint8_t
> > mask)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t value =3D read_register(reg);
> > +=C2=A0=C2=A0=C2=A0=C2=A0value &=3D ~mask;
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_register(reg, value);
> > +}
> > +
> > +/**
> > + * Read a number of sequential RX8900 registers
> > + * @param reg the address of the first register
> > + * @param buf (out) an output buffer to stash the register values
> > + * @param count the number of registers to read
> > + */
> > +static void read_registers(RX8900Addresses reg, uint8_t *buf,
> > uint8_t count)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t reg_address =3D (uint8_t)reg;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0i2c_send(i2c, addr, &reg_address, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0i2c_recv(i2c, addr, buf, count);
> > +}
> > +
> > +/**
> > + * Write to a sequential number of RX8900 registers
> > + * @param reg the address of the first register
> > + * @param buffer a buffer of values to write
> > + * @param count the sumber of registers to write
> > + */
> > +static void write_registers(RX8900Addresses reg, uint8_t *buffer,
> > uint8_t count)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t buf[RX8900_NVRAM_SIZE + 1];
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[0] =3D (uint8_t)reg;
> > +=C2=A0=C2=A0=C2=A0=C2=A0memcpy(buf + 1, buffer, count);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0i2c_send(i2c, addr, buf, count + 1);
> > +}
> > +
> > +/**
> > + * Set the time on the RX8900
> > + * @param secs the seconds to set
> > + * @param mins the minutes to set
> > + * @param hours the hours to set
> > + * @param weekday the day of the week to set (0 =3D Sunday)
> > + * @param day the day of the month to set
> > + * @param month the month to set
> > + * @param year the year to set
> > + */
> > +static void set_time(uint8_t secs, uint8_t mins, uint8_t hours,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0uint8_t weekday, uin=
t8_t day, uint8_t month, uint8_t year)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t buf[7];
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[0] =3D bin2bcd(secs);
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[1] =3D bin2bcd(mins);
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[2] =3D bin2bcd(hours);
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[3] =3D BIT(weekday);
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[4] =3D bin2bcd(day);
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[5] =3D bin2bcd(month);
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[6] =3D bin2bcd(year);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_registers(SECONDS, buf, 7);
> > +}
> > +
> > +
> > +/**
> > + * Check basic communication
> > + */
> > +static void send_and_receive(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t buf[7];
> > +=C2=A0=C2=A0=C2=A0=C2=A0time_t now =3D time(NULL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0struct tm *tm_ptr;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* retrieve the date */
> > +=C2=A0=C2=A0=C2=A0=C2=A0read_registers(SECONDS, buf, 7);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0tm_ptr =3D gmtime(&now);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* check retrieved time against local time *=
/
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(bcd2bin(buf[0]), =3D=3D , t=
m_ptr->tm_sec);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(bcd2bin(buf[1]), =3D=3D , t=
m_ptr->tm_min);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(bcd2bin(buf[2]), =3D=3D , t=
m_ptr->tm_hour);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(bcd2bin(buf[4]), =3D=3D , t=
m_ptr->tm_mday);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(bcd2bin(buf[5]), =3D=3D , 1=
 + tm_ptr->tm_mon);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(2000 + bcd2bin(buf[6]), =3D=
=3D , 1900 + tm_ptr-
> > >tm_year);
> > +}
> > +
> > +/**
> > + * Check that the temperature can be altered via properties
> > + */
> > +static void check_temperature(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0/* Check the initial temperature is 25C */
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t temperature;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0temperature =3D read_register(TEMPERATURE);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(temperature, =3D=3D , 133);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Set the temperature to 40C and check the =
temperature again
> > */
> > +=C2=A0=C2=A0=C2=A0=C2=A0qmp_rx8900_set_temperature(RX8900_TEST_ID, 4=
0.0f);
> > +=C2=A0=C2=A0=C2=A0=C2=A0temperature =3D read_register(TEMPERATURE);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(temperature, =3D=3D , 157);
> > +}
> > +
> > +/**
> > + * Check that the time rolls over correctly
> > + */
> > +static void check_rollover(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t buf[7];
> > +
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_time(59, 59, 23, 1, 29, 2, 16);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Wait for the clock to rollover */
> > +=C2=A0=C2=A0=C2=A0=C2=A0sleep(2);
> >=20
>=20
> Can we control time some other way so we're not delaying the test
> suite? I assume not?
>=20

Not yet - given that qemu_gettimeofday is wrapped, we could implement
one, but I think that should be an enhancement for later.

> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0memset(buf, 0, sizeof(buf));
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Check that the clock rolled over */
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Read from registers starting at 0x00 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[0] =3D 0x00;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0read_registers(SECONDS, buf, 7);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Ignore seconds as there may be some noise=
,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* we expect 00:00:xx Tuesday 1/3/2016
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
>=20
> this is why it would be nice if we could control time.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(bcd2bin(buf[1]), =3D=3D , 0=
);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(bcd2bin(buf[2]), =3D=3D , 0=
);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(bcd2bin(buf[3]), =3D=3D , 0=
x04);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(bcd2bin(buf[4]), =3D=3D , 1=
);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(bcd2bin(buf[5]), =3D=3D , 3=
);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(bcd2bin(buf[6]), =3D=3D , 1=
6);
> > +}
> > +
> > +uint32_t interrupt_counts[RX8900_INTERRUPT_SOURCES];
> > +
> > +/**
> > + * Reset the interrupt counts
> > + */
> > +static void count_reset(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0for (int source =3D 0; source < RX8900_INTER=
RUPT_SOURCES;
> > source++) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0interrupt_counts[sou=
rce] =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > +}
> > +
> > +/**
> > + * Handle an RX8900 interrupt (update the counts for that
> > interrupt type)
> > + */
> > +static void handle_interrupt(void *opaque, const char *name, int
> > irq,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool level)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0if (!level) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
> > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t flags =3D read_register(FLAG_REGISTE=
R);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0for (int flag =3D 0; flag < 8; flag++) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (flags & BIT(flag=
)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0interrupt_counts[flag]++;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_register(FLAG_REGISTER, 0x00);
> > +}
> > +
> > +uint32_t fout_counts;
> > +
> > +/**
> > + * Handle an Fout state change
> > + */
> > +static void handle_fout(void *opaque, const char *name, int irq,
> > bool level)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0if (!level) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
> > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0fout_counts++;
> > +}
> > +
> > +/**
> > + * Reset the fout count
> > + */
> > +static void fout_count_reset(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0fout_counts =3D 0;
> > +}
> > +
> > +
> > +/**
> > + * Sleep for some real time while counting interrupts
> > + * @param delay the delay in microseconds
> > + * @param loop the loop time in microseconds
> > + */
> > +static void wait_for(uint64_t delay, uint64_t loop)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0struct timeval end, now;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0gettimeofday(&end, NULL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0delay +=3D end.tv_usec;
> > +=C2=A0=C2=A0=C2=A0=C2=A0end.tv_sec +=3D delay / 1000000;
> > +=C2=A0=C2=A0=C2=A0=C2=A0end.tv_usec =3D delay % 1000000;
>=20
> I think we should use timeradd() here, as this might be out by part
> of
> a second.
>=20

Ok

> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0while (gettimeofday(&now, NULL),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0now.tv_sec < end.tv_sec || now.tv_usec < end.tv_usec)
> > {
>=20
> This condition is a little clever and also buggy. You'll at least
> need
> something like:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0while(gettimeofday(&now, NULL),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
now.tv_sec < end.tv_sec ||
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
now.tv_sec =3D=3D end.tv_sec && now.tv_usec < end.tv_usec) {
> ... }
>=20
> Depending on the value of loop you may wind up in the position where=C2=
=A0
> now.tv_usec < end.tv_usec is true for multiple loops beyond
> now.tv_sec
> < end.tv_sec failing with the case now.tv_sec > end.tv_sec.
>=20
> But you should probably use timercmp().
>=20

Ok

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clock_step(loop * 10=
00);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0usleep(loop);
> > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > +}
> > +
> > +/**
> > + * Sleep for some emulated time while counting interrupts
> > + * @param delay the delay in nanoseconds
> > + * @param loop the loop time in nanoseconds
> > + */
> > +static void wait_cycles(uint64_t delay, uint64_t loop)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint64_t counter;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0for (counter =3D 0; counter < delay; counter=
 +=3D loop) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clock_step(loop);
> > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > +}
> > +
> > +
> > +/**
> > + * Check that when the update timer interrupt is disabled, that no
> > interrupts
> > + * occur
> > + */
> > +static void check_update_interrupt_disabled(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Disable the update interrupt */
> > +=C2=A0=C2=A0=C2=A0=C2=A0clear_bits_in_register(CONTROL_REGISTER, CTR=
L_MASK_UIE);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Wait for the clock to rollover, this will=
 cover both
> > seconds & minutes
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_time(59, 59, 23, 1, 29, 2, 16);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0count_reset();
> > +=C2=A0=C2=A0=C2=A0=C2=A0wait_for(2 * 1000000, 1000);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_U=
F], =3D=3D, 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_A=
F], =3D=3D, 0);
> > +}
> > +
> > +
> > +/**
> > + * Check that when the update timer interrupt is enabled and
> > configured for
> > + * per second updates, that we get the appropriate number of
> > interrupts
> > + */
> > +static void check_update_interrupt_seconds(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_time(59, 59, 23, 1, 29, 2, 16);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Enable the update interrupt for per secon=
d updates */
> > +=C2=A0=C2=A0=C2=A0=C2=A0clear_bits_in_register(EXTENSION_REGISTER, E=
XT_MASK_USEL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_bits_in_register(CONTROL_REGISTER, CTRL_=
MASK_UIE);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0count_reset();
> > +=C2=A0=C2=A0=C2=A0=C2=A0wait_for(5.1f * 1000000ULL, 1000);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Disable the update interrupt */
> > +=C2=A0=C2=A0=C2=A0=C2=A0clear_bits_in_register(CONTROL_REGISTER, CTR=
L_MASK_UIE);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_U=
F], >=3D, 5);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_U=
F], <=3D, 6);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_A=
F], =3D=3D, 0);
> > +}
> > +
> > +/**
> > + * Check that when the update timer interrupt is enabled and
> > configured for
> > + * per minute updates, that we get the appropriate number of
> > interrupts
> > + */
> > +static void check_update_interrupt_minutes(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_time(59, 59, 23, 1, 29, 2, 16);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Enable the update interrupt for per minut=
e updates */
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_bits_in_register(EXTENSION_REGISTER, EXT=
_MASK_USEL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_bits_in_register(CONTROL_REGISTER, CTRL_=
MASK_UIE);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0count_reset();
> > +=C2=A0=C2=A0=C2=A0=C2=A0wait_for(5 * 1000000ULL, 1000);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Disable the update interrupt */
> > +=C2=A0=C2=A0=C2=A0=C2=A0clear_bits_in_register(CONTROL_REGISTER, CTR=
L_MASK_UIE);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_U=
F], =3D=3D, 1);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_A=
F], =3D=3D, 0);
> > +}
> > +
> > +
> > +/**
> > + * Check that when the alarm timer interrupt is disabled, that no
> > interrupts
> > + * occur
> > + */
> > +static void check_alarm_interrupt_disabled(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Disable the alarm interrupt */
> > +=C2=A0=C2=A0=C2=A0=C2=A0clear_bits_in_register(CONTROL_REGISTER, CTR=
L_MASK_AIE);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Set an alarm for midnight */
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t buf[3];
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[0] =3D bin2bcd(0); /* minutes */
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[1] =3D bin2bcd(0); /* hours */
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[2] =3D bin2bcd(1); /* day */
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_registers(ALARM_MINUTE, buf, 3);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Wait for the clock to rollover */
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_time(59, 59, 23, 1, 29, 2, 16);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0count_reset();
> > +=C2=A0=C2=A0=C2=A0=C2=A0wait_for(2 * 1000000, 1000);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_U=
F], =3D=3D, 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_A=
F], =3D=3D, 0);
> > +}
> > +
> > +/**
> > + * Check that when the alarm timer interrupt is enabled, that an
> > interrupt
> > + * occurs
> > + */
> > +static void check_alarm_interrupt_day_of_month(void)
> > +{
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Set an alarm for midnight */
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t buf[3];
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[0] =3D bin2bcd(0); /* minutes */
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[1] =3D bin2bcd(0); /* hours */
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[2] =3D bin2bcd(1); /* day */
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_registers(ALARM_MINUTE, buf, 3);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Set alarm to day of month mode */
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_bits_in_register(EXTENSION_REGISTER, EXT=
_MASK_WADA);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Enable the alarm interrupt */
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_bits_in_register(CONTROL_REGISTER, CTRL_=
MASK_AIE);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Wait for the clock to rollover */
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_time(59, 59, 23, 1, 29, 2, 16);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0count_reset();
> > +=C2=A0=C2=A0=C2=A0=C2=A0wait_for(2 * 1000000, 1000);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Disable the alarm interrupt */
> > +=C2=A0=C2=A0=C2=A0=C2=A0clear_bits_in_register(CONTROL_REGISTER, CTR=
L_MASK_AIE);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_U=
F], =3D=3D, 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_A=
F], =3D=3D, 1);
> > +}
> > +
> > +/**
> > + * Check that when the alarm timer interrupt is enabled, that an
> > interrupt
> > + * does not occur
> > + */
> > +static void check_alarm_interrupt_day_of_month_negative(void)
> > +{
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Set an alarm for midnight */
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t buf[3];
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[0] =3D bin2bcd(0); /* minutes */
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[1] =3D bin2bcd(0); /* hours */
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[2] =3D bin2bcd(2); /* day */
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_registers(ALARM_MINUTE, buf, 3);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Set alarm to day of month mode */
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_bits_in_register(EXTENSION_REGISTER, EXT=
_MASK_WADA);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Enable the alarm interrupt */
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_bits_in_register(CONTROL_REGISTER, CTRL_=
MASK_AIE);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Wait for the clock to rollover */
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_time(59, 59, 23, 1, 29, 2, 16);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0count_reset();
> > +=C2=A0=C2=A0=C2=A0=C2=A0wait_for(2 * 1000000, 1000);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Disable the alarm interrupt */
> > +=C2=A0=C2=A0=C2=A0=C2=A0clear_bits_in_register(CONTROL_REGISTER, CTR=
L_MASK_AIE);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_U=
F], =3D=3D, 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_A=
F], =3D=3D, 0);
> > +}
> > +
> > +/**
> > + * Check that when the alarm timer interrupt is enabled, that an
> > interrupt
> > + * occurs
> > + */
> > +static void check_alarm_interrupt_day_of_week(void)
> > +{
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Set an alarm for midnight */
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t buf[3];
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[0] =3D bin2bcd(0); /* minutes */
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[1] =3D bin2bcd(0); /* hours */
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[2] =3D 0x01 << 2; /* day */
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_registers(ALARM_MINUTE, buf, 3);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Set alarm to day of week mode */
> > +=C2=A0=C2=A0=C2=A0=C2=A0clear_bits_in_register(EXTENSION_REGISTER, E=
XT_MASK_WADA);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Enable the alarm interrupt */
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_bits_in_register(CONTROL_REGISTER, CTRL_=
MASK_AIE);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Wait for the clock to rollover */
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_time(59, 59, 23, 1, 29, 2, 16);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0count_reset();
> > +=C2=A0=C2=A0=C2=A0=C2=A0wait_for(2 * 1000000, 1000);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Disable the alarm interrupt */
> > +=C2=A0=C2=A0=C2=A0=C2=A0clear_bits_in_register(CONTROL_REGISTER, CTR=
L_MASK_AIE);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_U=
F], =3D=3D, 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_A=
F], =3D=3D, 1);
> > +}
> > +
> > +/**
> > + * Check that when the alarm timer interrupt is enabled, that an
> > interrupt
> > + * does not occur
> > + */
> > +static void check_alarm_interrupt_day_of_week_negative(void)
> > +{
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Set an alarm for midnight */
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t buf[3];
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[0] =3D bin2bcd(0); /* minutes */
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[1] =3D bin2bcd(0); /* hours */
> > +=C2=A0=C2=A0=C2=A0=C2=A0buf[2] =3D 0x01 << 2; /* day */
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_registers(ALARM_MINUTE, buf, 3);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Set alarm to day of week mode */
> > +=C2=A0=C2=A0=C2=A0=C2=A0clear_bits_in_register(EXTENSION_REGISTER, E=
XT_MASK_WADA);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Enable the alarm interrupt */
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_bits_in_register(CONTROL_REGISTER, CTRL_=
MASK_AIE);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Wait for the clock to rollover */
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_time(59, 59, 23, 3, 29, 2, 16);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0count_reset();
> > +=C2=A0=C2=A0=C2=A0=C2=A0wait_for(2 * 1000000, 1000);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Disable the alarm interrupt */
> > +=C2=A0=C2=A0=C2=A0=C2=A0clear_bits_in_register(CONTROL_REGISTER, CTR=
L_MASK_AIE);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_U=
F], =3D=3D, 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_A=
F], =3D=3D, 0);
> > +}
> > +
> > +/**
> > + * Check that the reset function
> > + */
> > +static void check_reset(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_bits_in_register(FLAG_REGISTER, FLAG_MAS=
K_UF);
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_bits_in_register(CONTROL_REGISTER, CTRL_=
MASK_RESET);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(read_register(FLAG_REGISTER=
), =3D=3D,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A00x00);
> > +}
> > +
> > +/**
> > + * Check that Fout operates at 1Hz
> > + */
> > +static void check_fout_1hz(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t ext_reg =3D read_register(EXTENSION_=
REGISTER);
> > +=C2=A0=C2=A0=C2=A0=C2=A0ext_reg |=3D EXT_MASK_FSEL1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0ext_reg &=3D ~EXT_MASK_FSEL0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_register(EXTENSION_REGISTER, ext_reg);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Enable Fout */
> > +=C2=A0=C2=A0=C2=A0=C2=A0irq_set(RX8900_TEST_ID, RX8900_FOUT_ENABLE, =
0, true);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0fout_count_reset();
> > +=C2=A0=C2=A0=C2=A0=C2=A0wait_cycles(2 * 1000000000ULL, 1000000);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* disable Fout */
> > +=C2=A0=C2=A0=C2=A0=C2=A0irq_set(RX8900_TEST_ID, RX8900_FOUT_ENABLE, =
0, false);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(fout_counts, =3D=3D, 2);
> > +}
> > +
> > +/**
> > + * Check that Fout operates at 1024Hz
> > + */
> > +static void check_fout_1024hz(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t ext_reg =3D read_register(EXTENSION_=
REGISTER);
> > +=C2=A0=C2=A0=C2=A0=C2=A0ext_reg |=3D EXT_MASK_FSEL0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0ext_reg &=3D ~EXT_MASK_FSEL1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_register(EXTENSION_REGISTER, ext_reg);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Enable Fout */
> > +=C2=A0=C2=A0=C2=A0=C2=A0irq_set(RX8900_TEST_ID, RX8900_FOUT_ENABLE, =
0, true);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0fout_count_reset();
> > +=C2=A0=C2=A0=C2=A0=C2=A0wait_cycles(2 * 1000000000ULL, 100000);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* disable Fout */
> > +=C2=A0=C2=A0=C2=A0=C2=A0irq_set(RX8900_TEST_ID, RX8900_FOUT_ENABLE, =
0, false);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(fout_counts, =3D=3D, 1024 *=
 2);
> > +}
> > +
> > +/**
> > + * Check that Fout operates at 32768Hz
> > + */
> > +static void check_fout_32768hz(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t ext_reg =3D read_register(EXTENSION_=
REGISTER);
> > +=C2=A0=C2=A0=C2=A0=C2=A0ext_reg &=3D ~EXT_MASK_FSEL0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0ext_reg &=3D ~EXT_MASK_FSEL1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_register(EXTENSION_REGISTER, ext_reg);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Enable Fout */
> > +=C2=A0=C2=A0=C2=A0=C2=A0irq_set(RX8900_TEST_ID, RX8900_FOUT_ENABLE, =
0, true);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0fout_count_reset();
> > +=C2=A0=C2=A0=C2=A0=C2=A0wait_cycles(2 * 1000000000ULL, 15000);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* disable Fout */
> > +=C2=A0=C2=A0=C2=A0=C2=A0irq_set(RX8900_TEST_ID, RX8900_FOUT_ENABLE, =
0, false);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* There appears to be some rounding errors =
in the timer,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* we'll tolerate it for now
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(fout_counts, >=3D, 32768 * =
2);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(fout_counts, <=3D, 65540);
>=20
> Maybe it would be more intuitive to write this as (32768 * 2 + 4) so
> it's clear what the tolerance is.
>=20

Ok

> > +}
> > +
> > +/**
> > + * Check the countdown timer operates at 1 Hz
> > + */
> > +static void check_countdown_1hz(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t ext_reg;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_register(TIMER_COUNTER_0, 5);
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_register(TIMER_COUNTER_1, 0);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0ext_reg =3D read_register(EXTENSION_REGISTER=
);
> > +=C2=A0=C2=A0=C2=A0=C2=A0ext_reg &=3D ~EXT_MASK_TSEL1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0ext_reg |=3D EXT_MASK_TSEL0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0ext_reg |=3D EXT_MASK_TE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_register(EXTENSION_REGISTER, ext_reg);
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_bits_in_register(CONTROL_REGISTER, CTRL_=
MASK_TIE);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0count_reset();
> > +=C2=A0=C2=A0=C2=A0=C2=A0wait_cycles(5 * 1000000000ULL, 1000000);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_T=
F], =3D=3D, 0);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0wait_cycles(1 * 1000000000ULL, 1000000);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_T=
F], =3D=3D, 1);
> > +}
> > +
> > +/**
> > + * Check the countdown timer operates at 64 Hz
> > + */
> > +static void check_countdown_64hz(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t ext_reg;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_register(TIMER_COUNTER_0, 0x40);
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_register(TIMER_COUNTER_1, 0x01); /* 5 =
* 64 */
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0ext_reg =3D read_register(EXTENSION_REGISTER=
);
> > +=C2=A0=C2=A0=C2=A0=C2=A0ext_reg &=3D ~EXT_MASK_TSEL0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0ext_reg &=3D ~EXT_MASK_TSEL1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0ext_reg |=3D EXT_MASK_TE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_register(EXTENSION_REGISTER, ext_reg);
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_bits_in_register(CONTROL_REGISTER, CTRL_=
MASK_TIE);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0count_reset();
> > +=C2=A0=C2=A0=C2=A0=C2=A0wait_cycles(5 * 1000000000ULL, 1000000);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_T=
F], =3D=3D, 0);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0wait_cycles(1 * 1000000000ULL, 1000000);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_T=
F], =3D=3D, 1);
> > +}
> > +
> > +/**
> > + * Check the countdown timer operates at 4096 Hz
> > + */
> > +static void check_countdown_4096hz(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t ext_reg;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_register(TIMER_COUNTER_0, 0xFF);
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_register(TIMER_COUNTER_1, 0x0F); /* 40=
95 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0ext_reg =3D read_register(EXTENSION_REGISTER=
);
> > +=C2=A0=C2=A0=C2=A0=C2=A0ext_reg |=3D EXT_MASK_TSEL0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0ext_reg |=3D EXT_MASK_TSEL1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0ext_reg |=3D EXT_MASK_TE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_register(EXTENSION_REGISTER, ext_reg);
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_bits_in_register(CONTROL_REGISTER, CTRL_=
MASK_TIE);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0count_reset();
> > +=C2=A0=C2=A0=C2=A0=C2=A0wait_cycles(999755859ULL, 10000);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_T=
F], =3D=3D, 0);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0wait_cycles(244141ULL, 10000);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_T=
F], =3D=3D, 1);
> > +}
> > +
> > +/**
> > + * Check the countdown timer operates at 1 minute
> > + */
> > +static void check_countdown_1m(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t ext_reg;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_register(TIMER_COUNTER_0, 0x01);
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_register(TIMER_COUNTER_1, 0x00);
> > +=C2=A0=C2=A0=C2=A0=C2=A0ext_reg =3D read_register(EXTENSION_REGISTER=
);
> > +=C2=A0=C2=A0=C2=A0=C2=A0ext_reg &=3D ~EXT_MASK_TSEL0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0ext_reg |=3D EXT_MASK_TSEL1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0ext_reg |=3D EXT_MASK_TE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_register(EXTENSION_REGISTER, ext_reg);
> > +=C2=A0=C2=A0=C2=A0=C2=A0set_bits_in_register(CONTROL_REGISTER, CTRL_=
MASK_TIE);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0count_reset();
> > +=C2=A0=C2=A0=C2=A0=C2=A0wait_cycles(59 * 1000000000ULL, 100000);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_T=
F], =3D=3D, 0);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0wait_cycles(1000000001LL, 100000);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(interrupt_counts[FLAG_REG_T=
F], =3D=3D, 1);
> > +}
> > +
> > +/**
> > + * Check that the voltage can be altered via properties
> > + */
> > +static void check_voltage(void)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t flags =3D read_register(FLAG_REGISTE=
R) &
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0(FLAG_MASK_VDET | FLAG_MASK_VLF);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* start from a good state */
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(flags, =3D=3D , 0x00);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* 1.9V triggers VDET but not VLF */
> > +=C2=A0=C2=A0=C2=A0=C2=A0qmp_rx8900_set_voltage(RX8900_TEST_ID, 1.9f)=
;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0flags =3D read_register(FLAG_REGISTER) & (FL=
AG_MASK_VDET |
> > FLAG_MASK_VLF);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(flags, =3D=3D , FLAG_MASK_V=
DET);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Clearing the flag should reassert it as t=
he voltage is
> > still low */
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_register(FLAG_REGISTER, 0x00);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0flags =3D read_register(FLAG_REGISTER) & (FL=
AG_MASK_VDET |
> > FLAG_MASK_VLF);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(flags, =3D=3D , FLAG_MASK_V=
DET);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Set the voltage to a good level, the low =
voltage flag
> > should persist */
> > +=C2=A0=C2=A0=C2=A0=C2=A0qmp_rx8900_set_voltage(RX8900_TEST_ID, 3.3f)=
;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0flags =3D read_register(FLAG_REGISTER) & (FL=
AG_MASK_VDET |
> > FLAG_MASK_VLF);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(flags, =3D=3D , FLAG_MASK_V=
DET);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* We should be able to clear the flag with =
a good voltage */
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_register(FLAG_REGISTER, 0x00);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0flags =3D read_register(FLAG_REGISTER) & (FL=
AG_MASK_VDET |
> > FLAG_MASK_VLF);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(flags, =3D=3D , 0x00);
> > +
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* 1.5V should trigger both VDET & VLF */
> > +=C2=A0=C2=A0=C2=A0=C2=A0qmp_rx8900_set_voltage(RX8900_TEST_ID, 1.5f)=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0flags =3D read_register(FLAG_REGISTER) & (FL=
AG_MASK_VDET |
> > FLAG_MASK_VLF);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(flags, =3D=3D , FLAG_MASK_V=
DET | FLAG_MASK_VLF);
> > +
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Clearing the flag should reassert it as t=
he voltage is
> > still low */
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_register(FLAG_REGISTER, 0x00);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0flags =3D read_register(FLAG_REGISTER) & (FL=
AG_MASK_VDET |
> > FLAG_MASK_VLF);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(flags, =3D=3D , FLAG_MASK_V=
DET | FLAG_MASK_VLF);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Set the voltage to a good level, the low =
voltage flag
> > should persist */
> > +=C2=A0=C2=A0=C2=A0=C2=A0qmp_rx8900_set_voltage(RX8900_TEST_ID, 3.3f)=
;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0flags =3D read_register(FLAG_REGISTER) & (FL=
AG_MASK_VDET |
> > FLAG_MASK_VLF);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(flags, =3D=3D , FLAG_MASK_V=
DET | FLAG_MASK_VLF);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* We should be able to clear the flag with =
a good voltage */
> > +=C2=A0=C2=A0=C2=A0=C2=A0write_register(FLAG_REGISTER, 0x00);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0flags =3D read_register(FLAG_REGISTER) & (FL=
AG_MASK_VDET |
> > FLAG_MASK_VLF);
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_assert_cmpuint(flags, =3D=3D , 0);
> > +}
> > +
> > +
> > +
> > +int main(int argc, char **argv)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0QTestState *s =3D NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0char args[255];
> > +=C2=A0=C2=A0=C2=A0=C2=A0snprintf(args, sizeof(args), "-display none =
-machine imx25-pdk=20
> > "
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0"-device rx8900,bus=3Di2c-bus.0,address=3D0x%x,id=3D%s"
> > +#ifdef RX8900_TRACE
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0" -trace events=3D/tmp/events"
> > +#endif
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0RX8900_ADDR, RX8900_TEST_ID);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_test_init(&argc, &argv, NULL);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0s =3D qtest_start(args);
> > +=C2=A0=C2=A0=C2=A0=C2=A0i2c =3D imx_i2c_create(IMX25_I2C_0_BASE);
> > +=C2=A0=C2=A0=C2=A0=C2=A0addr =3D RX8900_ADDR;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0irq_intercept_out(RX8900_TEST_ID);
> > +=C2=A0=C2=A0=C2=A0=C2=A0irq_attach(RX8900_INTERRUPT_OUT, 0, handle_i=
nterrupt, NULL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0irq_attach(RX8900_FOUT, 0, handle_fout, NULL=
);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/rx8900/reset", check_reset)=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/rx8900/tx-rx", send_and_rec=
eive);
> > +=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/rx8900/temperature", check_=
temperature);
> > +=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/rx8900/rollover", check_rol=
lover);
> > +=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/rx8900/update-interrupt-dis=
abled",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0check_update_interrupt_disabled);
> > +=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/rx8900/update-interrupt-sec=
onds",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0check_update_interrupt_seconds);
> > +=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/rx8900/update-interrupt-min=
utes",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0check_update_interrupt_minutes);
> > +=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/rx8900/alarm-interrupt-disa=
bled",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0check_alarm_interrupt_disabled);
> > +=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/rx8900/alarm-interrupt-mont=
h",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0check_alarm_interrupt_day_of_month);
> > +=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/rx8900/alarm-interrupt-mont=
h-negative",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0check_alarm_interrupt_day_of_month_negative);
> > +=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/rx8900/alarm-interrupt-week=
",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0check_alarm_interrupt_day_of_week);
> > +=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/rx8900/alarm-interrupt-week=
-negative",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0check_alarm_interrupt_day_of_week_negative);
> > +=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/rx8900/fout_1hz", check_fou=
t_1hz);
> > +=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/rx8900/fout_1024hz", check_=
fout_1024hz);
> > +=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/rx8900/fout_32768hz", check=
_fout_32768hz);
> > +=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/rx8900/countdown_1hz", chec=
k_countdown_1hz);
> > +=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/rx8900/countdown_64hz",
> > check_countdown_64hz);
> > +=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/rx8900/countdown_4096hz",
> > check_countdown_4096hz);
> > +=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/rx8900/countdown_1m", check=
_countdown_1m);
> > +=C2=A0=C2=A0=C2=A0=C2=A0qtest_add_func("/rx8900/low_voltage", check_=
voltage);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0ret =3D g_test_run();
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0if (s) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qtest_quit(s);
> > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > +=C2=A0=C2=A0=C2=A0=C2=A0g_free(i2c);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> > +}
>=20
> Andrew

--=20
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819

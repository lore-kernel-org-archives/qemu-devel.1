Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397F4C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04431222BF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04431222BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDYOk-0003qn-Rf
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 14:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iDYMt-0002L6-Fo
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iDYMr-0003VZ-NN
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:19:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54810)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iDYMh-0003Hs-IS; Thu, 26 Sep 2019 14:19:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 613F564D87;
 Thu, 26 Sep 2019 18:19:42 +0000 (UTC)
Received: from [10.18.17.231] (dhcp-17-231.bos.redhat.com [10.18.17.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4206C1000337;
 Thu, 26 Sep 2019 18:19:37 +0000 (UTC)
Subject: Re: [SeaBIOS] [PATCH v7 8/8] hd-geo-test: Add tests for lchs override
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Sam Eiderman <sameid@google.com>, qemu-devel@nongnu.org
References: <20190925110639.100699-1-sameid@google.com>
 <20190925110639.100699-9-sameid@google.com>
 <729ca8ab-fc30-e3c3-1867-0122afbc8a45@redhat.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cad6684a-a4d1-03eb-2bf5-e592b174d070@redhat.com>
Date: Thu, 26 Sep 2019 14:19:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <729ca8ab-fc30-e3c3-1867-0122afbc8a45@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 26 Sep 2019 18:19:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, seabios@seabios.org, kraxel@redhat.com,
 qemu-block@nongnu.org, arbel.moshe@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/26/19 6:00 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 9/25/19 1:06 PM, Sam Eiderman wrote:
>> From: Sam Eiderman <shmuel.eiderman@oracle.com>
>>
>> Add QTest tests to check the logical geometry override option.
>>
>> The tests in hd-geo-test are out of date - they only test IDE and do n=
ot
>> test interesting MBRs.
>>
>> I added a few helper functions which will make adding more tests easie=
r.
>>
>> QTest's fw_cfg helper functions support only legacy fw_cfg, so I had t=
o
>> read the new fw_cfg layout on my own.
>>
>> Creating qcow2 disks with specific size and MBR layout is currently
>> unused - we only use a default empty MBR.
>>
>> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
>> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
>> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
>> ---
>>  tests/Makefile.include |   2 +-
>>  tests/hd-geo-test.c    | 589 ++++++++++++++++++++++++++++++++++++++++=
+
>>  2 files changed, 590 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 479664f899..a5b92fea6a 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -780,7 +780,7 @@ tests/ide-test$(EXESUF): tests/ide-test.o $(libqos=
-pc-obj-y)
>>  tests/ahci-test$(EXESUF): tests/ahci-test.o $(libqos-pc-obj-y) qemu-i=
mg$(EXESUF)
>>  tests/ipmi-kcs-test$(EXESUF): tests/ipmi-kcs-test.o
>>  tests/ipmi-bt-test$(EXESUF): tests/ipmi-bt-test.o
>> -tests/hd-geo-test$(EXESUF): tests/hd-geo-test.o
>> +tests/hd-geo-test$(EXESUF): tests/hd-geo-test.o $(libqos-obj-y)
>>  tests/boot-order-test$(EXESUF): tests/boot-order-test.o $(libqos-obj-=
y)
>>  tests/boot-serial-test$(EXESUF): tests/boot-serial-test.o $(libqos-ob=
j-y)
>>  tests/bios-tables-test$(EXESUF): tests/bios-tables-test.o \
>> diff --git a/tests/hd-geo-test.c b/tests/hd-geo-test.c
>> index 62eb624726..458de99c31 100644
>> --- a/tests/hd-geo-test.c
>> +++ b/tests/hd-geo-test.c
>> @@ -17,7 +17,12 @@
>> =20
>>  #include "qemu/osdep.h"
>>  #include "qemu-common.h"
>> +#include "qemu/bswap.h"
>> +#include "qapi/qmp/qlist.h"
>>  #include "libqtest.h"
>> +#include "libqos/fw_cfg.h"
>> +#include "libqos/libqos.h"
>> +#include "standard-headers/linux/qemu_fw_cfg.h"
>> =20
>>  #define ARGV_SIZE 256
>> =20
>> @@ -388,6 +393,575 @@ static void test_ide_drive_cd_0(void)
>>      qtest_quit(qts);
>>  }
>> =20
>> +typedef struct {
>> +    bool active;
>> +    uint32_t head;
>> +    uint32_t sector;
>> +    uint32_t cyl;
>> +    uint32_t end_head;
>> +    uint32_t end_sector;
>> +    uint32_t end_cyl;
>> +    uint32_t start_sect;
>> +    uint32_t nr_sects;
>> +} MBRpartitions[4];
>> +
>> +static MBRpartitions empty_mbr =3D { {false, 0, 0, 0, 0, 0, 0, 0, 0},
>> +                                   {false, 0, 0, 0, 0, 0, 0, 0, 0},
>> +                                   {false, 0, 0, 0, 0, 0, 0, 0, 0},
>> +                                   {false, 0, 0, 0, 0, 0, 0, 0, 0} };
>> +
>> +static char *create_qcow2_with_mbr(MBRpartitions mbr, uint64_t sector=
s)
>> +{
>> +    const char *template =3D "/tmp/qtest.XXXXXX";
>> +    char *raw_path =3D strdup(template);
>> +    char *qcow2_path =3D strdup(template);
>> +    char cmd[100 + 2 * PATH_MAX];
>> +    uint8_t buf[512];
>> +    int i, ret, fd, offset;
>> +    uint64_t qcow2_size =3D sectors * 512;
>> +    uint8_t status, parttype, head, sector, cyl;
>> +    char *qemu_img_path;
>> +    char *qemu_img_abs_path;
>> +
>> +    offset =3D 0xbe;
>> +
>> +    for (i =3D 0; i < 4; i++) {
>> +        status =3D mbr[i].active ? 0x80 : 0x00;
>> +        g_assert(mbr[i].head < 256);
>> +        g_assert(mbr[i].sector < 64);
>> +        g_assert(mbr[i].cyl < 1024);
>> +        head =3D mbr[i].head;
>> +        sector =3D mbr[i].sector + ((mbr[i].cyl & 0x300) >> 2);
>> +        cyl =3D mbr[i].cyl & 0xff;
>> +
>> +        buf[offset + 0x0] =3D status;
>> +        buf[offset + 0x1] =3D head;
>> +        buf[offset + 0x2] =3D sector;
>> +        buf[offset + 0x3] =3D cyl;
>> +
>> +        parttype =3D 0;
>> +        g_assert(mbr[i].end_head < 256);
>> +        g_assert(mbr[i].end_sector < 64);
>> +        g_assert(mbr[i].end_cyl < 1024);
>> +        head =3D mbr[i].end_head;
>> +        sector =3D mbr[i].end_sector + ((mbr[i].end_cyl & 0x300) >> 2=
);
>> +        cyl =3D mbr[i].end_cyl & 0xff;
>> +
>> +        buf[offset + 0x4] =3D parttype;
>> +        buf[offset + 0x5] =3D head;
>> +        buf[offset + 0x6] =3D sector;
>> +        buf[offset + 0x7] =3D cyl;
>> +
>> +        (*(uint32_t *)&buf[offset + 0x8]) =3D cpu_to_le32(mbr[i].star=
t_sect);
>> +        (*(uint32_t *)&buf[offset + 0xc]) =3D cpu_to_le32(mbr[i].nr_s=
ects);
>> +
>> +        offset +=3D 0x10;
>> +    }
>> +
>> +    fd =3D mkstemp(raw_path);
>> +    g_assert(fd);
>> +    close(fd);
>> +
>> +    fd =3D open(raw_path, O_WRONLY);
>> +    g_assert(fd >=3D 0);
>> +    ret =3D write(fd, buf, sizeof(buf));
>> +    g_assert(ret =3D=3D sizeof(buf));
>> +    close(fd);
>> +
>> +    fd =3D mkstemp(qcow2_path);
>> +    g_assert(fd);
>> +    close(fd);
>> +
>> +    qemu_img_path =3D getenv("QTEST_QEMU_IMG");
>> +    g_assert(qemu_img_path);
>> +    qemu_img_abs_path =3D realpath(qemu_img_path, NULL);
>> +    g_assert(qemu_img_abs_path);
>> +
>> +    ret =3D snprintf(cmd, sizeof(cmd),
>> +                   "%s convert -f raw -O qcow2 %s %s > /dev/null",
>> +                   qemu_img_abs_path,
>> +                   raw_path, qcow2_path);
>> +    g_assert((0 < ret) && (ret <=3D sizeof(cmd)));
>> +    ret =3D system(cmd);
>> +    g_assert(ret =3D=3D 0);
>> +
>> +    ret =3D snprintf(cmd, sizeof(cmd),
>> +                   "%s resize %s %" PRIu64 " > /dev/null",
>> +                   qemu_img_abs_path,
>> +                   qcow2_path, qcow2_size);
>> +    g_assert((0 < ret) && (ret <=3D sizeof(cmd)));
>> +    ret =3D system(cmd);
>> +    g_assert(ret =3D=3D 0);
>> +
>> +    free(qemu_img_abs_path);
>> +
>> +    unlink(raw_path);
>> +    free(raw_path);
>> +
>> +    return qcow2_path;
>> +}
>> +
>> +struct QemuCfgFile {
>> +    uint32_t  size;        /* file size */
>> +    uint16_t  select;      /* write this to 0x510 to read it */
>> +    uint16_t  reserved;
>> +    char name[56];
>> +};
>> +
>> +static uint16_t find_fw_cfg_file(QFWCFG *fw_cfg,
>> +                                 const char *filename)
>> +{
>> +    struct QemuCfgFile qfile;
>> +    uint32_t count, e;
>> +    uint16_t select;
>> +
>> +    count =3D qfw_cfg_get_u32(fw_cfg, FW_CFG_FILE_DIR);
>> +    count =3D be32_to_cpu(count);
>> +    for (select =3D 0, e =3D 0; e < count; e++) {
>> +        qfw_cfg_read_data(fw_cfg, &qfile, sizeof(qfile));
>> +        if (!strcmp(filename, qfile.name)) {
>> +            select =3D be16_to_cpu(qfile.select);
>> +        }
>> +    }
>> +
>> +    return select;
>> +}
>> +
>> +static void read_fw_cfg_file(QFWCFG *fw_cfg,
>> +                             const char *filename,
>> +                             void *data,
>> +                             size_t len)
>> +{
>> +    uint16_t select =3D find_fw_cfg_file(fw_cfg, filename);
>> +
>> +    g_assert(select);
>> +
>> +    qfw_cfg_get(fw_cfg, select, data, len);
>> +}
>> +
>> +#define BIOS_GEOMETRY_MAX_SIZE 10000
>> +
>> +typedef struct {
>> +    uint32_t c;
>> +    uint32_t h;
>> +    uint32_t s;
>> +} CHS;
>> +
>> +typedef struct {
>> +    const char *dev_path;
>> +    CHS chs;
>> +} CHSResult;
>> +
>> +static void read_bootdevices(QFWCFG *fw_cfg, CHSResult expected[])
>> +{
>> +    char *buf =3D g_malloc0(BIOS_GEOMETRY_MAX_SIZE);
>> +    char *cur;
>> +    GList *results =3D NULL, *cur_result;
>> +    CHSResult *r;
>> +    int i;
>> +    int res;
>> +    bool found;
>> +
>> +    read_fw_cfg_file(fw_cfg, "bios-geometry", buf, BIOS_GEOMETRY_MAX_=
SIZE);
>=20
> Oh I'm glad to see the test I requested while reviewing the previous
> patch! I'll have a look at it, but John 589 LoC I doubt I can do it for
> Friday.
>=20

It's just a test, even so -- we can amend it. There's no real hurry.

--js


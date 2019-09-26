Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CE0C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 10:02:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23225217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 10:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23225217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDQbx-0005qc-NE
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 06:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDQZy-0004fH-K4
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDQZv-0005Hp-GS
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:00:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37442)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDQZv-0005He-6x
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 06:00:51 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0ACBC11A03
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 10:00:50 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id z205so915493wmb.7
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 03:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gIbtvSmBjU9gQVM/opZNHVIAkqMA5EUaF1qKa3tigjs=;
 b=kaqwFxex98TK1Rm9LwJQA+K2aV9YQvojVEjGFNCoI2/sLLd0ix8U7vxjNrgqCn7XbV
 Z5PzIvn8c3n84Ko1JuhZwRLi0t6Dzl+cLUF/PM38kuC/SYlMGTKIhymN95zPkBgTsPLG
 Udvj2nvCojKJGR25DffyEc8n2WSga4vWbCr3ipe7M6SFHr4DCnc9mi7WWJ4arf1S+U+b
 tAVGDhkfvN4ij/vB42/yX+fWMLT0KTFOnQqdcySeEbCy1+zc5DLiHV2vunxVTDxn/o1C
 2dorJy1STTGji+z/8I77JqnPO0hGeP50f4Jx6j43bVDT8Zs+xJw3aA0aMrfZtoNd3eNQ
 L47g==
X-Gm-Message-State: APjAAAXAp11UL1NbFQ9PVAkiPifAcX1lZbJAnjfdvjYbVhKbj1CeCGAs
 dX6hjZSS9UMLXpBGPWrA7G9ztvGpfDoQ6sd2jhIfThTx03Ql0PP4PWM8OXmy+txYpP9rSH8mNd9
 HnEzUIvik2pDURXk=
X-Received: by 2002:a7b:ce0a:: with SMTP id m10mr2372426wmc.167.1569492048621; 
 Thu, 26 Sep 2019 03:00:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzd9LUc7ffCqMhJ8UPERNn94Od5AuTz6FOP0RLY5Q194oiTriUdThjZL/rfrpYQznSeiQgqDQ==
X-Received: by 2002:a7b:ce0a:: with SMTP id m10mr2372351wmc.167.1569492047695; 
 Thu, 26 Sep 2019 03:00:47 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id l10sm2864917wrh.20.2019.09.26.03.00.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 03:00:47 -0700 (PDT)
Subject: Re: [SeaBIOS] [PATCH v7 8/8] hd-geo-test: Add tests for lchs override
To: Sam Eiderman <sameid@google.com>, qemu-devel@nongnu.org
References: <20190925110639.100699-1-sameid@google.com>
 <20190925110639.100699-9-sameid@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <729ca8ab-fc30-e3c3-1867-0122afbc8a45@redhat.com>
Date: Thu, 26 Sep 2019 12:00:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190925110639.100699-9-sameid@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, kraxel@redhat.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/19 1:06 PM, Sam Eiderman wrote:
> From: Sam Eiderman <shmuel.eiderman@oracle.com>
> 
> Add QTest tests to check the logical geometry override option.
> 
> The tests in hd-geo-test are out of date - they only test IDE and do not
> test interesting MBRs.
> 
> I added a few helper functions which will make adding more tests easier.
> 
> QTest's fw_cfg helper functions support only legacy fw_cfg, so I had to
> read the new fw_cfg layout on my own.
> 
> Creating qcow2 disks with specific size and MBR layout is currently
> unused - we only use a default empty MBR.
> 
> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
> ---
>  tests/Makefile.include |   2 +-
>  tests/hd-geo-test.c    | 589 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 590 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 479664f899..a5b92fea6a 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -780,7 +780,7 @@ tests/ide-test$(EXESUF): tests/ide-test.o $(libqos-pc-obj-y)
>  tests/ahci-test$(EXESUF): tests/ahci-test.o $(libqos-pc-obj-y) qemu-img$(EXESUF)
>  tests/ipmi-kcs-test$(EXESUF): tests/ipmi-kcs-test.o
>  tests/ipmi-bt-test$(EXESUF): tests/ipmi-bt-test.o
> -tests/hd-geo-test$(EXESUF): tests/hd-geo-test.o
> +tests/hd-geo-test$(EXESUF): tests/hd-geo-test.o $(libqos-obj-y)
>  tests/boot-order-test$(EXESUF): tests/boot-order-test.o $(libqos-obj-y)
>  tests/boot-serial-test$(EXESUF): tests/boot-serial-test.o $(libqos-obj-y)
>  tests/bios-tables-test$(EXESUF): tests/bios-tables-test.o \
> diff --git a/tests/hd-geo-test.c b/tests/hd-geo-test.c
> index 62eb624726..458de99c31 100644
> --- a/tests/hd-geo-test.c
> +++ b/tests/hd-geo-test.c
> @@ -17,7 +17,12 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> +#include "qemu/bswap.h"
> +#include "qapi/qmp/qlist.h"
>  #include "libqtest.h"
> +#include "libqos/fw_cfg.h"
> +#include "libqos/libqos.h"
> +#include "standard-headers/linux/qemu_fw_cfg.h"
>  
>  #define ARGV_SIZE 256
>  
> @@ -388,6 +393,575 @@ static void test_ide_drive_cd_0(void)
>      qtest_quit(qts);
>  }
>  
> +typedef struct {
> +    bool active;
> +    uint32_t head;
> +    uint32_t sector;
> +    uint32_t cyl;
> +    uint32_t end_head;
> +    uint32_t end_sector;
> +    uint32_t end_cyl;
> +    uint32_t start_sect;
> +    uint32_t nr_sects;
> +} MBRpartitions[4];
> +
> +static MBRpartitions empty_mbr = { {false, 0, 0, 0, 0, 0, 0, 0, 0},
> +                                   {false, 0, 0, 0, 0, 0, 0, 0, 0},
> +                                   {false, 0, 0, 0, 0, 0, 0, 0, 0},
> +                                   {false, 0, 0, 0, 0, 0, 0, 0, 0} };
> +
> +static char *create_qcow2_with_mbr(MBRpartitions mbr, uint64_t sectors)
> +{
> +    const char *template = "/tmp/qtest.XXXXXX";
> +    char *raw_path = strdup(template);
> +    char *qcow2_path = strdup(template);
> +    char cmd[100 + 2 * PATH_MAX];
> +    uint8_t buf[512];
> +    int i, ret, fd, offset;
> +    uint64_t qcow2_size = sectors * 512;
> +    uint8_t status, parttype, head, sector, cyl;
> +    char *qemu_img_path;
> +    char *qemu_img_abs_path;
> +
> +    offset = 0xbe;
> +
> +    for (i = 0; i < 4; i++) {
> +        status = mbr[i].active ? 0x80 : 0x00;
> +        g_assert(mbr[i].head < 256);
> +        g_assert(mbr[i].sector < 64);
> +        g_assert(mbr[i].cyl < 1024);
> +        head = mbr[i].head;
> +        sector = mbr[i].sector + ((mbr[i].cyl & 0x300) >> 2);
> +        cyl = mbr[i].cyl & 0xff;
> +
> +        buf[offset + 0x0] = status;
> +        buf[offset + 0x1] = head;
> +        buf[offset + 0x2] = sector;
> +        buf[offset + 0x3] = cyl;
> +
> +        parttype = 0;
> +        g_assert(mbr[i].end_head < 256);
> +        g_assert(mbr[i].end_sector < 64);
> +        g_assert(mbr[i].end_cyl < 1024);
> +        head = mbr[i].end_head;
> +        sector = mbr[i].end_sector + ((mbr[i].end_cyl & 0x300) >> 2);
> +        cyl = mbr[i].end_cyl & 0xff;
> +
> +        buf[offset + 0x4] = parttype;
> +        buf[offset + 0x5] = head;
> +        buf[offset + 0x6] = sector;
> +        buf[offset + 0x7] = cyl;
> +
> +        (*(uint32_t *)&buf[offset + 0x8]) = cpu_to_le32(mbr[i].start_sect);
> +        (*(uint32_t *)&buf[offset + 0xc]) = cpu_to_le32(mbr[i].nr_sects);
> +
> +        offset += 0x10;
> +    }
> +
> +    fd = mkstemp(raw_path);
> +    g_assert(fd);
> +    close(fd);
> +
> +    fd = open(raw_path, O_WRONLY);
> +    g_assert(fd >= 0);
> +    ret = write(fd, buf, sizeof(buf));
> +    g_assert(ret == sizeof(buf));
> +    close(fd);
> +
> +    fd = mkstemp(qcow2_path);
> +    g_assert(fd);
> +    close(fd);
> +
> +    qemu_img_path = getenv("QTEST_QEMU_IMG");
> +    g_assert(qemu_img_path);
> +    qemu_img_abs_path = realpath(qemu_img_path, NULL);
> +    g_assert(qemu_img_abs_path);
> +
> +    ret = snprintf(cmd, sizeof(cmd),
> +                   "%s convert -f raw -O qcow2 %s %s > /dev/null",
> +                   qemu_img_abs_path,
> +                   raw_path, qcow2_path);
> +    g_assert((0 < ret) && (ret <= sizeof(cmd)));
> +    ret = system(cmd);
> +    g_assert(ret == 0);
> +
> +    ret = snprintf(cmd, sizeof(cmd),
> +                   "%s resize %s %" PRIu64 " > /dev/null",
> +                   qemu_img_abs_path,
> +                   qcow2_path, qcow2_size);
> +    g_assert((0 < ret) && (ret <= sizeof(cmd)));
> +    ret = system(cmd);
> +    g_assert(ret == 0);
> +
> +    free(qemu_img_abs_path);
> +
> +    unlink(raw_path);
> +    free(raw_path);
> +
> +    return qcow2_path;
> +}
> +
> +struct QemuCfgFile {
> +    uint32_t  size;        /* file size */
> +    uint16_t  select;      /* write this to 0x510 to read it */
> +    uint16_t  reserved;
> +    char name[56];
> +};
> +
> +static uint16_t find_fw_cfg_file(QFWCFG *fw_cfg,
> +                                 const char *filename)
> +{
> +    struct QemuCfgFile qfile;
> +    uint32_t count, e;
> +    uint16_t select;
> +
> +    count = qfw_cfg_get_u32(fw_cfg, FW_CFG_FILE_DIR);
> +    count = be32_to_cpu(count);
> +    for (select = 0, e = 0; e < count; e++) {
> +        qfw_cfg_read_data(fw_cfg, &qfile, sizeof(qfile));
> +        if (!strcmp(filename, qfile.name)) {
> +            select = be16_to_cpu(qfile.select);
> +        }
> +    }
> +
> +    return select;
> +}
> +
> +static void read_fw_cfg_file(QFWCFG *fw_cfg,
> +                             const char *filename,
> +                             void *data,
> +                             size_t len)
> +{
> +    uint16_t select = find_fw_cfg_file(fw_cfg, filename);
> +
> +    g_assert(select);
> +
> +    qfw_cfg_get(fw_cfg, select, data, len);
> +}
> +
> +#define BIOS_GEOMETRY_MAX_SIZE 10000
> +
> +typedef struct {
> +    uint32_t c;
> +    uint32_t h;
> +    uint32_t s;
> +} CHS;
> +
> +typedef struct {
> +    const char *dev_path;
> +    CHS chs;
> +} CHSResult;
> +
> +static void read_bootdevices(QFWCFG *fw_cfg, CHSResult expected[])
> +{
> +    char *buf = g_malloc0(BIOS_GEOMETRY_MAX_SIZE);
> +    char *cur;
> +    GList *results = NULL, *cur_result;
> +    CHSResult *r;
> +    int i;
> +    int res;
> +    bool found;
> +
> +    read_fw_cfg_file(fw_cfg, "bios-geometry", buf, BIOS_GEOMETRY_MAX_SIZE);

Oh I'm glad to see the test I requested while reviewing the previous
patch! I'll have a look at it, but John 589 LoC I doubt I can do it for
Friday.

> +
> +    for (cur = buf; *cur; cur++) {
> +        if (*cur == '\n') {
> +            *cur = '\0';
> +        }
> +    }
> +    cur = buf;
> +
> +    while (strlen(cur)) {
> +
> +        r = g_malloc0(sizeof(*r));
> +        r->dev_path = g_malloc0(strlen(cur) + 1);
> +        res = sscanf(cur, "%s %" PRIu32 " %" PRIu32 " %" PRIu32,
> +                     (char *)r->dev_path,
> +                     &(r->chs.c), &(r->chs.h), &(r->chs.s));
> +
> +        g_assert(res == 4);
> +
> +        results = g_list_prepend(results, r);
> +
> +        cur += strlen(cur) + 1;
> +    }
> +
> +    i = 0;
> +
> +    while (expected[i].dev_path) {
> +        found = false;
> +        cur_result = results;
> +        while (cur_result) {
> +            r = cur_result->data;
> +            if (!strcmp(r->dev_path, expected[i].dev_path) &&
> +                !memcmp(&(r->chs), &(expected[i].chs), sizeof(r->chs))) {
> +                found = true;
> +                break;
> +            }
> +            cur_result = g_list_next(cur_result);
> +        }
> +        g_assert(found);
> +        g_free((char *)((CHSResult *)cur_result->data)->dev_path);
> +        g_free(cur_result->data);
> +        results = g_list_delete_link(results, cur_result);
> +        i++;
> +    }
> +
> +    g_assert(results == NULL);
> +
> +    g_free(buf);
> +}
> +
> +#define MAX_DRIVES 30
> +
> +typedef struct {
> +    char **argv;
> +    int argc;
> +    char **drives;
> +    int n_drives;
> +    int n_scsi_disks;
> +    int n_scsi_controllers;
> +    int n_virtio_disks;
> +} TestArgs;
> +
> +static TestArgs *create_args(void)
> +{
> +    TestArgs *args = g_malloc0(sizeof(*args));
> +    args->argv = g_new0(char *, ARGV_SIZE);
> +    args->argc = append_arg(args->argc, args->argv,
> +                            ARGV_SIZE, g_strdup("-nodefaults"));
> +    args->drives = g_new0(char *, MAX_DRIVES);
> +    return args;
> +}
> +
> +static void add_drive_with_mbr(TestArgs *args,
> +                               MBRpartitions mbr, uint64_t sectors)
> +{
> +    char *img_file_name;
> +    char part[300];
> +    int ret;
> +
> +    g_assert(args->n_drives < MAX_DRIVES);
> +
> +    img_file_name = create_qcow2_with_mbr(mbr, sectors);
> +
> +    args->drives[args->n_drives] = img_file_name;
> +    ret = snprintf(part, sizeof(part),
> +                   "-drive file=%s,if=none,format=qcow2,id=disk%d",
> +                   img_file_name, args->n_drives);
> +    g_assert((0 < ret) && (ret <= sizeof(part)));
> +    args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, g_strdup(part));
> +    args->n_drives++;
> +}
> +
> +static void add_ide_disk(TestArgs *args,
> +                         int drive_idx, int bus, int unit, int c, int h, int s)
> +{
> +    char part[300];
> +    int ret;
> +
> +    ret = snprintf(part, sizeof(part),
> +                   "-device ide-hd,drive=disk%d,bus=ide.%d,unit=%d,"
> +                   "lcyls=%d,lheads=%d,lsecs=%d",
> +                   drive_idx, bus, unit, c, h, s);
> +    g_assert((0 < ret) && (ret <= sizeof(part)));
> +    args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, g_strdup(part));
> +}
> +
> +static void add_scsi_controller(TestArgs *args,
> +                                const char *type,
> +                                const char *bus,
> +                                int addr)
> +{
> +    char part[300];
> +    int ret;
> +
> +    ret = snprintf(part, sizeof(part),
> +                   "-device %s,id=scsi%d,bus=%s,addr=%d",
> +                   type, args->n_scsi_controllers, bus, addr);
> +    g_assert((0 < ret) && (ret <= sizeof(part)));
> +    args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, g_strdup(part));
> +    args->n_scsi_controllers++;
> +}
> +
> +static void add_scsi_disk(TestArgs *args,
> +                          int drive_idx, int bus,
> +                          int channel, int scsi_id, int lun,
> +                          int c, int h, int s)
> +{
> +    char part[300];
> +    int ret;
> +
> +    ret = snprintf(part, sizeof(part),
> +                   "-device scsi-hd,id=scsi-disk%d,drive=disk%d,"
> +                   "bus=scsi%d.0,"
> +                   "channel=%d,scsi-id=%d,lun=%d,"
> +                   "lcyls=%d,lheads=%d,lsecs=%d",
> +                   args->n_scsi_disks, drive_idx, bus, channel, scsi_id, lun,
> +                   c, h, s);
> +    g_assert((0 < ret) && (ret <= sizeof(part)));
> +    args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, g_strdup(part));
> +    args->n_scsi_disks++;
> +}
> +
> +static void add_virtio_disk(TestArgs *args,
> +                            int drive_idx, const char *bus, int addr,
> +                            int c, int h, int s)
> +{
> +    char part[300];
> +    int ret;
> +
> +    ret = snprintf(part, sizeof(part),
> +                   "-device virtio-blk-pci,id=virtio-disk%d,"
> +                   "drive=disk%d,bus=%s,addr=%d,"
> +                   "lcyls=%d,lheads=%d,lsecs=%d",
> +                   args->n_virtio_disks, drive_idx, bus, addr, c, h, s);
> +    g_assert((0 < ret) && (ret <= sizeof(part)));
> +    args->argc = append_arg(args->argc, args->argv, ARGV_SIZE, g_strdup(part));
> +    args->n_virtio_disks++;
> +}
> +
> +static void test_override(TestArgs *args, CHSResult expected[])
> +{
> +    QTestState *qts;
> +    char *joined_args;
> +    QFWCFG *fw_cfg;
> +    int i;
> +
> +    joined_args = g_strjoinv(" ", args->argv);
> +
> +    qts = qtest_init(joined_args);
> +    fw_cfg = pc_fw_cfg_init(qts);
> +
> +    read_bootdevices(fw_cfg, expected);
> +
> +    g_free(joined_args);
> +    qtest_quit(qts);
> +
> +    g_free(fw_cfg);
> +
> +    for (i = 0; i < args->n_drives; i++) {
> +        unlink(args->drives[i]);
> +        free(args->drives[i]);
> +    }
> +    g_free(args->drives);
> +    g_strfreev(args->argv);
> +    g_free(args);
> +}
> +
> +static void test_override_ide(void)
> +{
> +    TestArgs *args = create_args();
> +    CHSResult expected[] = {
> +        {"/pci@i0cf8/ide@1,1/drive@0/disk@0", {10000, 120, 30} },
> +        {"/pci@i0cf8/ide@1,1/drive@0/disk@1", {9000, 120, 30} },
> +        {"/pci@i0cf8/ide@1,1/drive@1/disk@0", {0, 1, 1} },
> +        {"/pci@i0cf8/ide@1,1/drive@1/disk@1", {1, 0, 0} },
> +        {NULL, {0, 0, 0} }
> +    };
> +    add_drive_with_mbr(args, empty_mbr, 1);
> +    add_drive_with_mbr(args, empty_mbr, 1);
> +    add_drive_with_mbr(args, empty_mbr, 1);
> +    add_drive_with_mbr(args, empty_mbr, 1);
> +    add_ide_disk(args, 0, 0, 0, 10000, 120, 30);
> +    add_ide_disk(args, 1, 0, 1, 9000, 120, 30);
> +    add_ide_disk(args, 2, 1, 0, 0, 1, 1);
> +    add_ide_disk(args, 3, 1, 1, 1, 0, 0);
> +    test_override(args, expected);
> +}
> +
> +static void test_override_scsi(void)
> +{
> +    TestArgs *args = create_args();
> +    CHSResult expected[] = {
> +        {"/pci@i0cf8/scsi@3/channel@0/disk@0,0", {10000, 120, 30} },
> +        {"/pci@i0cf8/scsi@3/channel@0/disk@1,0", {9000, 120, 30} },
> +        {"/pci@i0cf8/scsi@3/channel@0/disk@2,0", {1, 0, 0} },
> +        {"/pci@i0cf8/scsi@3/channel@0/disk@3,0", {0, 1, 0} },
> +        {NULL, {0, 0, 0} }
> +    };
> +    add_drive_with_mbr(args, empty_mbr, 1);
> +    add_drive_with_mbr(args, empty_mbr, 1);
> +    add_drive_with_mbr(args, empty_mbr, 1);
> +    add_drive_with_mbr(args, empty_mbr, 1);
> +    add_scsi_controller(args, "lsi53c895a", "pci.0", 3);
> +    add_scsi_disk(args, 0, 0, 0, 0, 0, 10000, 120, 30);
> +    add_scsi_disk(args, 1, 0, 0, 1, 0, 9000, 120, 30);
> +    add_scsi_disk(args, 2, 0, 0, 2, 0, 1, 0, 0);
> +    add_scsi_disk(args, 3, 0, 0, 3, 0, 0, 1, 0);
> +    test_override(args, expected);
> +}
> +
> +static void test_override_scsi_2_controllers(void)
> +{
> +    TestArgs *args = create_args();
> +    CHSResult expected[] = {
> +        {"/pci@i0cf8/scsi@3/channel@0/disk@0,0", {10000, 120, 30} },
> +        {"/pci@i0cf8/scsi@3/channel@0/disk@1,0", {9000, 120, 30} },
> +        {"/pci@i0cf8/scsi@4/channel@0/disk@0,1", {1, 0, 0} },
> +        {"/pci@i0cf8/scsi@4/channel@0/disk@1,2", {0, 1, 0} },
> +        {NULL, {0, 0, 0} }
> +    };
> +    add_drive_with_mbr(args, empty_mbr, 1);
> +    add_drive_with_mbr(args, empty_mbr, 1);
> +    add_drive_with_mbr(args, empty_mbr, 1);
> +    add_drive_with_mbr(args, empty_mbr, 1);
> +    add_scsi_controller(args, "lsi53c895a", "pci.0", 3);
> +    add_scsi_controller(args, "virtio-scsi-pci", "pci.0", 4);
> +    add_scsi_disk(args, 0, 0, 0, 0, 0, 10000, 120, 30);
> +    add_scsi_disk(args, 1, 0, 0, 1, 0, 9000, 120, 30);
> +    add_scsi_disk(args, 2, 1, 0, 0, 1, 1, 0, 0);
> +    add_scsi_disk(args, 3, 1, 0, 1, 2, 0, 1, 0);
> +    test_override(args, expected);
> +}
> +
> +static void test_override_virtio_blk(void)
> +{
> +    TestArgs *args = create_args();
> +    CHSResult expected[] = {
> +        {"/pci@i0cf8/scsi@3/disk@0,0", {10000, 120, 30} },
> +        {"/pci@i0cf8/scsi@4/disk@0,0", {9000, 120, 30} },
> +        {NULL, {0, 0, 0} }
> +    };
> +    add_drive_with_mbr(args, empty_mbr, 1);
> +    add_drive_with_mbr(args, empty_mbr, 1);
> +    add_virtio_disk(args, 0, "pci.0", 3, 10000, 120, 30);
> +    add_virtio_disk(args, 1, "pci.0", 4, 9000, 120, 30);
> +    test_override(args, expected);
> +}
> +
> +static void test_override_zero_chs(void)
> +{
> +    TestArgs *args = create_args();
> +    CHSResult expected[] = {
> +        {NULL, {0, 0, 0} }
> +    };
> +    add_drive_with_mbr(args, empty_mbr, 1);
> +    add_ide_disk(args, 0, 1, 1, 0, 0, 0);
> +    test_override(args, expected);
> +}
> +
> +static void test_override_scsi_hot_unplug(void)
> +{
> +    QTestState *qts;
> +    char *joined_args;
> +    QFWCFG *fw_cfg;
> +    QDict *response;
> +    int i;
> +    TestArgs *args = create_args();
> +    CHSResult expected[] = {
> +        {"/pci@i0cf8/scsi@2/channel@0/disk@0,0", {10000, 120, 30} },
> +        {"/pci@i0cf8/scsi@2/channel@0/disk@1,0", {20, 20, 20} },
> +        {NULL, {0, 0, 0} }
> +    };
> +    CHSResult expected2[] = {
> +        {"/pci@i0cf8/scsi@2/channel@0/disk@1,0", {20, 20, 20} },
> +        {NULL, {0, 0, 0} }
> +    };
> +    add_drive_with_mbr(args, empty_mbr, 1);
> +    add_drive_with_mbr(args, empty_mbr, 1);
> +    add_scsi_controller(args, "virtio-scsi-pci", "pci.0", 2);
> +    add_scsi_disk(args, 0, 0, 0, 0, 0, 10000, 120, 30);
> +    add_scsi_disk(args, 1, 0, 0, 1, 0, 20, 20, 20);
> +
> +    joined_args = g_strjoinv(" ", args->argv);
> +
> +    qts = qtest_init(joined_args);
> +    fw_cfg = pc_fw_cfg_init(qts);
> +
> +    read_bootdevices(fw_cfg, expected);
> +
> +    /* unplug device an restart */
> +    response = qtest_qmp(qts,
> +                         "{ 'execute': 'device_del',"
> +                         "  'arguments': {'id': 'scsi-disk0' }}");
> +    g_assert(response);
> +    g_assert(!qdict_haskey(response, "error"));
> +    qobject_unref(response);
> +    response = qtest_qmp(qts,
> +                         "{ 'execute': 'system_reset', 'arguments': { }}");
> +    g_assert(response);
> +    g_assert(!qdict_haskey(response, "error"));
> +    qobject_unref(response);
> +
> +    qtest_qmp_eventwait(qts, "RESET");
> +
> +    read_bootdevices(fw_cfg, expected2);
> +
> +    g_free(joined_args);
> +    qtest_quit(qts);
> +
> +    g_free(fw_cfg);
> +
> +    for (i = 0; i < args->n_drives; i++) {
> +        unlink(args->drives[i]);
> +        free(args->drives[i]);
> +    }
> +    g_free(args->drives);
> +    g_strfreev(args->argv);
> +    g_free(args);
> +}
> +
> +static void test_override_virtio_hot_unplug(void)
> +{
> +    QTestState *qts;
> +    char *joined_args;
> +    QFWCFG *fw_cfg;
> +    QDict *response;
> +    int i;
> +    TestArgs *args = create_args();
> +    CHSResult expected[] = {
> +        {"/pci@i0cf8/scsi@2/disk@0,0", {10000, 120, 30} },
> +        {"/pci@i0cf8/scsi@3/disk@0,0", {20, 20, 20} },
> +        {NULL, {0, 0, 0} }
> +    };
> +    CHSResult expected2[] = {
> +        {"/pci@i0cf8/scsi@3/disk@0,0", {20, 20, 20} },
> +        {NULL, {0, 0, 0} }
> +    };
> +    add_drive_with_mbr(args, empty_mbr, 1);
> +    add_drive_with_mbr(args, empty_mbr, 1);
> +    add_virtio_disk(args, 0, "pci.0", 2, 10000, 120, 30);
> +    add_virtio_disk(args, 1, "pci.0", 3, 20, 20, 20);
> +
> +    joined_args = g_strjoinv(" ", args->argv);
> +
> +    qts = qtest_init(joined_args);
> +    fw_cfg = pc_fw_cfg_init(qts);
> +
> +    read_bootdevices(fw_cfg, expected);
> +
> +    /* unplug device an restart */
> +    response = qtest_qmp(qts,
> +                         "{ 'execute': 'device_del',"
> +                         "  'arguments': {'id': 'virtio-disk0' }}");
> +    g_assert(response);
> +    g_assert(!qdict_haskey(response, "error"));
> +    qobject_unref(response);
> +    response = qtest_qmp(qts,
> +                         "{ 'execute': 'system_reset', 'arguments': { }}");
> +    g_assert(response);
> +    g_assert(!qdict_haskey(response, "error"));
> +    qobject_unref(response);
> +
> +    qtest_qmp_eventwait(qts, "RESET");
> +
> +    read_bootdevices(fw_cfg, expected2);
> +
> +    g_free(joined_args);
> +    qtest_quit(qts);
> +
> +    g_free(fw_cfg);
> +
> +    for (i = 0; i < args->n_drives; i++) {
> +        unlink(args->drives[i]);
> +        free(args->drives[i]);
> +    }
> +    g_free(args->drives);
> +    g_strfreev(args->argv);
> +    g_free(args);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      Backend i;
> @@ -413,6 +987,21 @@ int main(int argc, char **argv)
>      qtest_add_func("hd-geo/ide/device/mbr/chs", test_ide_device_mbr_chs);
>      qtest_add_func("hd-geo/ide/device/user/chs", test_ide_device_user_chs);
>      qtest_add_func("hd-geo/ide/device/user/chst", test_ide_device_user_chst);
> +    if (have_qemu_img()) {
> +        qtest_add_func("hd-geo/override/ide", test_override_ide);
> +        qtest_add_func("hd-geo/override/scsi", test_override_scsi);
> +        qtest_add_func("hd-geo/override/scsi_2_controllers",
> +                       test_override_scsi_2_controllers);
> +        qtest_add_func("hd-geo/override/virtio_blk", test_override_virtio_blk);
> +        qtest_add_func("hd-geo/override/zero_chs", test_override_zero_chs);
> +        qtest_add_func("hd-geo/override/scsi_hot_unplug",
> +                       test_override_scsi_hot_unplug);
> +        qtest_add_func("hd-geo/override/virtio_hot_unplug",
> +                       test_override_virtio_hot_unplug);
> +    } else {
> +        g_test_message("QTEST_QEMU_IMG not set or qemu-img missing; "
> +                       "skipping hd-geo/override/* tests");
> +    }
>  
>      ret = g_test_run();
>  
> 


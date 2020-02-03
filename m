Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA648C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:05:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B952166E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B952166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iybQD-0005qA-Rv
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 08:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1iybOF-00049a-Fh
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:03:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1iybO9-00040E-I7
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:03:46 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:12305)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1iybO1-0003Ng-8h; Mon, 03 Feb 2020 08:03:41 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id A2235746383;
 Mon,  3 Feb 2020 14:03:30 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 47A7F74637C; Mon,  3 Feb 2020 14:03:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4591974637F;
 Mon,  3 Feb 2020 14:03:30 +0100 (CET)
Date: Mon, 3 Feb 2020 14:03:30 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu v6 6/6] spapr: Implement Open Firmware client
 interface
In-Reply-To: <20200203032943.121178-7-aik@ozlabs.ru>
Message-ID: <alpine.BSF.2.22.395.2002031352190.31211@zero.eik.bme.hu>
References: <20200203032943.121178-1-aik@ozlabs.ru>
 <20200203032943.121178-7-aik@ozlabs.ru>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1257719729-1580735010=:31211"
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1257719729-1580735010=:31211
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Feb 2020, Alexey Kardashevskiy wrote:
[...]
> diff --git a/hw/ppc/spapr_of_client.c b/hw/ppc/spapr_of_client.c
> new file mode 100644
> index 000000000000..31555c356de8
> --- /dev/null
> +++ b/hw/ppc/spapr_of_client.c
> @@ -0,0 +1,1526 @@
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include <sys/ioctl.h>
> +#include <termios.h>
> +#include "qapi/error.h"
> +#include "exec/memory.h"
> +#include "hw/ppc/spapr.h"
> +#include "hw/ppc/spapr_vio.h"

I haven't read all of this as it's a lot of code but I was thinking this=20
might also be useful to implement a replacement for the proprietary=20
firmware of the pegasos2 emulation later. See:

https://osdn.net/projects/qmiga/wiki/SubprojectPegasos2

for details. I likely don't need a complete OpenFirmware for booting Linu=
x=20
and MorphOS as these only get some data from the device tree and then use=
=20
their own drivers (MorphOS may use some RTAS but I'm not sure) so=20
something like this might be enough to get these booting without the=20
original firmware on pegasos2 and is easier than reimplementing the=20
firmware or trying to modify OpenFirmware to emulate the different device=
=20
tree that machine has.

Question is if it's possible to make this file independent of spapr or=20
gather the OF emulation parts in a separate file that could be reused=20
later? This could be done afterwards but if there's anything now that you=
=20
can do to make it easier then that would help so maybe it's good idea to=20
make you aware of this in case you can consider this possible use case.

Regards,
BALATON Zoltan

> +#include "hw/ppc/fdt.h"
> +#include "hw/block/block.h"
> +#include "sysemu/block-backend.h"
> +#include "sysemu/sysemu.h"
> +#include "chardev/char-fe.h"
> +#include "qom/qom-qobject.h"
> +#include "elf.h"
> +#include "hw/ppc/ppc.h"
> +#include "hw/loader.h"
> +#include "trace.h"
> +
> +#define ALIGN(x, a) (((x) + (a) - 1) & ~((a) - 1))
> +
> +struct gpt_header {
> +    char signature[8];
> +    char revision[4];
> +    uint32_t header_size;
> +    uint32_t crc;
> +    uint32_t reserved;
> +    uint64_t current_lba;
> +    uint64_t backup_lba;
> +    uint64_t first_usable_lba;
> +    uint64_t last_usable_lba;
> +    char guid[16];
> +    uint64_t partition_entries_lba;
> +    uint32_t nr_partition_entries;
> +    uint32_t size_partition_entry;
> +    uint32_t crc_partitions;
> +};
> +
> +#define GPT_SIGNATURE "EFI PART"
> +#define GPT_REVISION "\0\0\1\0" /* revision 1.0 */
> +
> +struct gpt_entry {
> +    char partition_type_guid[16];
> +    char unique_guid[16];
> +    uint64_t first_lba;
> +    uint64_t last_lba;
> +    uint64_t attributes;
> +    char name[72];                /* UTF-16LE */
> +};
> +
> +#define GPT_MIN_PARTITIONS 128
> +#define GPT_PT_ENTRY_SIZE 128
> +#define SECTOR_SIZE 512
> +
> +static int find_prep_partition_on_gpt(BlockBackend *blk, uint8_t *lba0=
1,
> +                                      uint64_t *offset, uint64_t *size=
)
> +{
> +    unsigned i, partnum, partentrysize;
> +    int ret;
> +    struct gpt_header *hdr =3D (struct gpt_header *) (lba01 + SECTOR_S=
IZE);
> +    const char *prep_uuid =3D "9e1a2d38-c612-4316-aa26-8b49521e5a8b";
> +
> +    if (memcmp(hdr, "EFI PART", 8)) {
> +        return -1;
> +    }
> +
> +    partnum =3D le32_to_cpu(hdr->nr_partition_entries);
> +    partentrysize =3D le32_to_cpu(hdr->size_partition_entry);
> +
> +    if (partentrysize < 128 || partentrysize > 512) {
> +        return -1;
> +    }
> +
> +    for (i =3D 0; i < partnum; ++i) {
> +        uint8_t partdata[partentrysize];
> +        struct gpt_entry *entry =3D (struct gpt_entry *) partdata;
> +        unsigned long first, last;
> +        QemuUUID parttype;
> +        char *uuid;
> +
> +        ret =3D blk_pread(blk, 2 * SECTOR_SIZE + i * partentrysize,
> +                        partdata, sizeof(partdata));
> +        if (ret < 0) {
> +            return ret;
> +        } else if (!ret) {
> +            return -1;
> +        }
> +
> +        memcpy(parttype.data, entry->partition_type_guid, 16);
> +        parttype =3D qemu_uuid_bswap(parttype);
> +        first =3D le64_to_cpu(entry->first_lba);
> +        last =3D le64_to_cpu(entry->last_lba);
> +
> +        uuid =3D qemu_uuid_unparse_strdup(&parttype);
> +        if (!strcmp(uuid, prep_uuid)) {
> +            *offset =3D first * SECTOR_SIZE;
> +            *size =3D (last - first) * SECTOR_SIZE;
> +        }
> +    }
> +
> +    if (*offset) {
> +        return 0;
> +    }
> +
> +    return -1;
> +}
> +
> +struct partition_record {
> +    uint8_t bootable;
> +    uint8_t start_head;
> +    uint32_t start_cylinder;
> +    uint8_t start_sector;
> +    uint8_t system;
> +    uint8_t end_head;
> +    uint8_t end_cylinder;
> +    uint8_t end_sector;
> +    uint32_t start_sector_abs;
> +    uint32_t nb_sectors_abs;
> +};
> +
> +static void read_partition(uint8_t *p, struct partition_record *r)
> +{
> +    r->bootable =3D p[0];
> +    r->start_head =3D p[1];
> +    r->start_cylinder =3D p[3] | ((p[2] << 2) & 0x0300);
> +    r->start_sector =3D p[2] & 0x3f;
> +    r->system =3D p[4];
> +    r->end_head =3D p[5];
> +    r->end_cylinder =3D p[7] | ((p[6] << 2) & 0x300);
> +    r->end_sector =3D p[6] & 0x3f;
> +    r->start_sector_abs =3D ldl_le_p(p + 8);
> +    r->nb_sectors_abs   =3D ldl_le_p(p + 12);
> +}
> +
> +static int find_prep_partition(BlockBackend *blk, uint64_t *offset,
> +                               uint64_t *size)
> +{
> +    uint8_t lba01[SECTOR_SIZE * 2];
> +    int i;
> +    int ret =3D -ENOENT;
> +
> +    ret =3D blk_pread(blk, 0, lba01, sizeof(lba01));
> +    if (ret < 0) {
> +        error_report("error while reading: %s", strerror(-ret));
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    if (lba01[510] !=3D 0x55 || lba01[511] !=3D 0xaa) {
> +        return find_prep_partition_on_gpt(blk, lba01, offset, size);
> +    }
> +
> +    for (i =3D 0; i < 4; i++) {
> +        struct partition_record part =3D { 0 };
> +
> +        read_partition(&lba01[446 + 16 * i], &part);
> +        if (!part.system || !part.nb_sectors_abs) {
> +            continue;
> +        }
> +
> +        /* 0xEE =3D=3D GPT */
> +        if (part.system =3D=3D 0xEE) {
> +            ret =3D find_prep_partition_on_gpt(blk, lba01, offset, siz=
e);
> +        }
> +        /* 0x41 =3D=3D PReP */
> +        if (part.system =3D=3D 0x41) {
> +            *offset =3D (uint64_t)part.start_sector_abs << 9;
> +            *size =3D (uint64_t)part.nb_sectors_abs << 9;
> +            ret =3D 0;
> +        }
> +    }
> +
> +    return ret;
> +}
> +
> +/*
> + * Below is a compiled version of RTAS blob and OF client interface en=
try point.
> + *
> + * gcc -nostdlib  -mbig -o spapr-rtas.img spapr-rtas.S
> + * objcopy  -O binary -j .text  spapr-rtas.img spapr-rtas.bin
> + *
> + *   .globl  _start
> + *   _start:
> + *           mr      4,3
> + *           lis     3,KVMPPC_H_RTAS@h
> + *           ori     3,3,KVMPPC_H_RTAS@l
> + *           sc      1
> + *           blr
> + * ...
> + */
> +static const uint8_t rtas_blob[] =3D {
> +    0x7c, 0x64, 0x1b, 0x78,
> +    0x3c, 0x60, 0x00, 0x00,
> +    0x60, 0x63, 0xf0, 0x00,
> +    0x44, 0x00, 0x00, 0x22,
> +    0x4e, 0x80, 0x00, 0x20
> +};
> +
> +/*
> + * ...
> + *           mr      4,3
> + *           lis     3,KVMPPC_H_OF_CLIENT@h
> + *           ori     3,3,KVMPPC_H_OF_CLIENT@l
> + *           sc      1
> + *           blr
> + */
> +static const uint8_t of_client_blob[] =3D {
> +    0x7c, 0x64, 0x1b, 0x78,
> +    0x3c, 0x60, 0x00, 0x00,
> +    0x60, 0x63, 0xf0, 0x05,
> +    0x44, 0x00, 0x00, 0x22,
> +    0x4e, 0x80, 0x00, 0x20
> +};
> +
> +typedef struct {
> +    DeviceState *dev;
> +    CharBackend *cbe;
> +    BlockBackend *blk;
> +    uint64_t blk_pos;
> +    uint16_t blk_physical_block_size;
> +    char *path; /* the path used to open the instance */
> +    uint32_t phandle;
> +} SpaprOfInstance;
> +
> +/*
> + * OF 1275 "nextprop" description suggests is it 32 bytes max but
> + * LoPAPR defines "ibm,query-interrupt-source-number" which is 33 char=
s long.
> + */
> +#define OF_PROPNAME_LEN_MAX 64
> +
> +/* Copied from SLOF, and 4K is definitely not enough for GRUB */
> +#define OF_STACK_SIZE       0x8000
> +
> +/* Defined as Big Endian */
> +struct prom_args {
> +    uint32_t service;
> +    uint32_t nargs;
> +    uint32_t nret;
> +    uint32_t args[10];
> +};
> +
> +static void readstr(hwaddr pa, char *buf, int size)
> +{
> +    cpu_physical_memory_read(pa, buf, size);
> +    if (buf[size - 1] !=3D '\0') {
> +        buf[size - 1] =3D '\0';
> +        if (strlen(buf) =3D=3D size - 1) {
> +            trace_spapr_of_client_error_str_truncated(buf, size);
> +        }
> +    }
> +}
> +
> +static bool cmpservice(const char *s, size_t len,
> +                       unsigned nargs, unsigned nret,
> +                       const char *s1, size_t len1,
> +                       unsigned nargscheck, unsigned nretcheck)
> +{
> +    if (strcmp(s, s1)) {
> +        return false;
> +    }
> +    if ((nargscheck && (nargs !=3D nargscheck)) ||
> +        (nretcheck && (nret !=3D nretcheck))) {
> +        trace_spapr_of_client_error_param(s, nargscheck, nretcheck, na=
rgs,
> +                                          nret);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static void split_path(const char *fullpath, char **node, char **unit,
> +                       char **part)
> +{
> +    const char *c, *p =3D NULL, *u =3D NULL;
> +
> +    *node =3D *unit =3D *part =3D NULL;
> +
> +    if (fullpath[0] =3D=3D '\0') {
> +        *node =3D g_strdup(fullpath);
> +        return;
> +    }
> +
> +    for (c =3D fullpath + strlen(fullpath) - 1; c > fullpath; --c) {
> +        if (*c =3D=3D '/') {
> +            break;
> +        }
> +        if (*c =3D=3D ':') {
> +            p =3D c + 1;
> +            continue;
> +        }
> +        if (*c =3D=3D '@') {
> +            u =3D c + 1;
> +            continue;
> +        }
> +    }
> +
> +    if (p && u && p < u) {
> +        p =3D NULL;
> +    }
> +
> +    if (u && p) {
> +        *node =3D g_strndup(fullpath, u - fullpath - 1);
> +        *unit =3D g_strndup(u, p - u - 1);
> +        *part =3D g_strdup(p);
> +    } else if (!u && p) {
> +        *node =3D g_strndup(fullpath, p - fullpath - 1);
> +        *part =3D g_strdup(p);
> +    } else if (!p && u) {
> +        *node =3D g_strndup(fullpath, u - fullpath - 1);
> +        *unit =3D g_strdup(u);
> +    } else {
> +        *node =3D g_strdup(fullpath);
> +    }
> +}
> +
> +static void prop_format(char *tval, int tlen, const void *prop, int le=
n)
> +{
> +    int i;
> +    const char *c;
> +    char *t;
> +    const char bin[] =3D "...";
> +
> +    for (i =3D 0, c =3D prop; i < len; ++i, ++c) {
> +        if (*c =3D=3D '\0' && i =3D=3D len - 1) {
> +            strncpy(tval, prop, tlen - 1);
> +            return;
> +        }
> +        if (*c < 0x20 || *c >=3D 0x80) {
> +            /* Not reliably printable string so assume it is binary */
> +            break;
> +        }
> +    }
> +
> +    /* Accidentally the binary will look like big endian (which it is)=
 */
> +    for (i =3D 0, c =3D prop, t =3D tval; i < len; ++i, ++c) {
> +        if (t >=3D tval + tlen - sizeof(bin) - 1 - 2 - 1) {
> +            strcpy(t, bin);
> +            return;
> +        }
> +        if (i && i % 4 =3D=3D 0 && i !=3D len - 1) {
> +            strcat(t, " ");
> +            ++t;
> +        }
> +        t +=3D sprintf(t, "%02X", *c & 0xFF);
> +    }
> +}
> +
> +static int of_client_fdt_path_offset(const void *fdt, const char *node=
,
> +                                     const char *unit)
> +{
> +    int offset;
> +
> +    offset =3D fdt_path_offset(fdt, node);
> +
> +    if (offset < 0 && unit) {
> +        char *tmp =3D g_strdup_printf("%s@%s", node, unit);
> +
> +        offset =3D fdt_path_offset(fdt, tmp);
> +        g_free(tmp);
> +    }
> +
> +    return offset;
> +}
> +
> +static uint32_t of_client_finddevice(const void *fdt, uint32_t nodeadd=
r)
> +{
> +    char *node, *unit, *part;
> +    char fullnode[1024];
> +    uint32_t ret =3D -1;
> +    int offset;
> +
> +    readstr(nodeaddr, fullnode, sizeof(fullnode));
> +
> +    split_path(fullnode, &node, &unit, &part);
> +    offset =3D of_client_fdt_path_offset(fdt, node, unit);
> +    if (offset >=3D 0) {
> +        ret =3D fdt_get_phandle(fdt, offset);
> +    }
> +    trace_spapr_of_client_finddevice(fullnode, ret);
> +    g_free(node);
> +    g_free(unit);
> +    g_free(part);
> +    return (uint32_t) ret;
> +}
> +
> +static uint32_t of_client_getprop(const void *fdt, uint32_t nodeph,
> +                                  uint32_t pname, uint32_t valaddr,
> +                                  uint32_t vallen)
> +{
> +    char propname[OF_PROPNAME_LEN_MAX + 1];
> +    uint32_t ret =3D 0;
> +    int proplen =3D 0;
> +    const void *prop;
> +    char trval[64] =3D "";
> +    int nodeoff =3D fdt_node_offset_by_phandle(fdt, nodeph);
> +
> +    readstr(pname, propname, sizeof(propname));
> +    if (strcmp(propname, "name") =3D=3D 0) {
> +        prop =3D fdt_get_name(fdt, nodeoff, &proplen);
> +        proplen +=3D 1;
> +    } else {
> +        prop =3D fdt_getprop(fdt, nodeoff, propname, &proplen);
> +    }
> +
> +    if (prop) {
> +        int cb =3D MIN(proplen, vallen);
> +
> +        cpu_physical_memory_write(valaddr, prop, cb);
> +        /*
> +         * OF1275 says:
> +         * "Size is either the actual size of the property, or =E2=80=93=
1 if name
> +         * does not exist", hence returning proplen instead of cb.
> +         */
> +        ret =3D proplen;
> +        prop_format(trval, sizeof(trval), prop, ret);
> +    } else {
> +        ret =3D -1;
> +    }
> +    trace_spapr_of_client_getprop(nodeph, propname, ret, trval);
> +
> +    return ret;
> +}
> +
> +static uint32_t of_client_getproplen(const void *fdt, uint32_t nodeph,
> +                                     uint32_t pname)
> +{
> +    char propname[OF_PROPNAME_LEN_MAX + 1];
> +    uint32_t ret =3D 0;
> +    int proplen =3D 0;
> +    const void *prop;
> +    int nodeoff =3D fdt_node_offset_by_phandle(fdt, nodeph);
> +
> +    readstr(pname, propname, sizeof(propname));
> +    if (strcmp(propname, "name") =3D=3D 0) {
> +        prop =3D fdt_get_name(fdt, nodeoff, &proplen);
> +        proplen +=3D 1;
> +    } else {
> +        prop =3D fdt_getprop(fdt, nodeoff, propname, &proplen);
> +    }
> +
> +    if (prop) {
> +        ret =3D proplen;
> +    } else {
> +        ret =3D -1;
> +    }
> +    trace_spapr_of_client_getproplen(nodeph, propname, ret);
> +
> +    return ret;
> +}
> +
> +static uint32_t of_client_setprop(SpaprMachineState *spapr,
> +                                  uint32_t nodeph, uint32_t pname,
> +                                  uint32_t valaddr, uint32_t vallen)
> +{
> +    char propname[OF_PROPNAME_LEN_MAX + 1];
> +    uint32_t ret =3D -1;
> +    int offset;
> +    char trval[64] =3D "";
> +
> +    readstr(pname, propname, sizeof(propname));
> +    /*
> +     * We only allow changing properties which we know how to update o=
n
> +     * the QEMU side.
> +     */
> +    if (vallen =3D=3D sizeof(uint32_t)) {
> +        uint32_t val32 =3D ldl_be_phys(first_cpu->as, valaddr);
> +
> +        if ((strcmp(propname, "linux,rtas-base") =3D=3D 0) ||
> +            (strcmp(propname, "linux,rtas-entry") =3D=3D 0)) {
> +            spapr->rtas_base =3D val32;
> +        } else if (strcmp(propname, "linux,initrd-start") =3D=3D 0) {
> +            spapr->initrd_base =3D val32;
> +        } else if (strcmp(propname, "linux,initrd-end") =3D=3D 0) {
> +            spapr->initrd_size =3D val32 - spapr->initrd_base;
> +        } else {
> +            goto trace_exit;
> +        }
> +    } else if (vallen =3D=3D sizeof(uint64_t)) {
> +        uint64_t val64 =3D ldq_be_phys(first_cpu->as, valaddr);
> +
> +        if (strcmp(propname, "linux,initrd-start") =3D=3D 0) {
> +            spapr->initrd_base =3D val64;
> +        } else if (strcmp(propname, "linux,initrd-end") =3D=3D 0) {
> +            spapr->initrd_size =3D val64 - spapr->initrd_base;
> +        } else {
> +            goto trace_exit;
> +        }
> +    } else if (strcmp(propname, "bootargs") =3D=3D 0) {
> +        char val[1024];
> +
> +        readstr(valaddr, val, sizeof(val));
> +        g_free(spapr->bootargs);
> +        spapr->bootargs =3D g_strdup(val);
> +    } else {
> +        goto trace_exit;
> +    }
> +
> +    offset =3D fdt_node_offset_by_phandle(spapr->fdt_blob, nodeph);
> +    if (offset >=3D 0) {
> +        uint8_t data[vallen];
> +
> +        cpu_physical_memory_read(valaddr, data, vallen);
> +        if (!fdt_setprop(spapr->fdt_blob, offset, propname, data, vall=
en)) {
> +            ret =3D vallen;
> +            prop_format(trval, sizeof(trval), data, ret);
> +        }
> +    }
> +
> +trace_exit:
> +    trace_spapr_of_client_setprop(nodeph, propname, trval, ret);
> +
> +    return ret;
> +}
> +
> +static uint32_t of_client_nextprop(const void *fdt, uint32_t phandle,
> +                                   uint32_t prevaddr, uint32_t nameadd=
r)
> +{
> +    int offset =3D fdt_node_offset_by_phandle(fdt, phandle);
> +    char prev[OF_PROPNAME_LEN_MAX + 1];
> +    const char *tmp;
> +
> +    readstr(prevaddr, prev, sizeof(prev));
> +    for (offset =3D fdt_first_property_offset(fdt, offset);
> +         offset >=3D 0;
> +         offset =3D fdt_next_property_offset(fdt, offset)) {
> +
> +        if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
> +            return 0;
> +        }
> +        if (prev[0] =3D=3D '\0' || strcmp(prev, tmp) =3D=3D 0) {
> +            if (prev[0] !=3D '\0') {
> +                offset =3D fdt_next_property_offset(fdt, offset);
> +                if (offset < 0) {
> +                    return 0;
> +                }
> +            }
> +            if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
> +                return 0;
> +            }
> +
> +            cpu_physical_memory_write(nameaddr, tmp, strlen(tmp) + 1);
> +            return 1;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static uint32_t of_client_peer(const void *fdt, uint32_t phandle)
> +{
> +    int ret;
> +
> +    if (phandle =3D=3D 0) {
> +        ret =3D fdt_path_offset(fdt, "/");
> +    } else {
> +        ret =3D fdt_next_subnode(fdt, fdt_node_offset_by_phandle(fdt, =
phandle));
> +    }
> +
> +    if (ret < 0) {
> +        ret =3D 0;
> +    } else {
> +        ret =3D fdt_get_phandle(fdt, ret);
> +    }
> +
> +    return ret;
> +}
> +
> +static uint32_t of_client_child(const void *fdt, uint32_t phandle)
> +{
> +    int ret =3D fdt_first_subnode(fdt, fdt_node_offset_by_phandle(fdt,=
 phandle));
> +
> +    if (ret < 0) {
> +        ret =3D 0;
> +    } else {
> +        ret =3D fdt_get_phandle(fdt, ret);
> +    }
> +
> +    return ret;
> +}
> +
> +static uint32_t of_client_parent(const void *fdt, uint32_t phandle)
> +{
> +    int ret =3D fdt_parent_offset(fdt, fdt_node_offset_by_phandle(fdt,=
 phandle));
> +
> +    if (ret < 0) {
> +        ret =3D 0;
> +    } else {
> +        ret =3D fdt_get_phandle(fdt, ret);
> +    }
> +
> +    return ret;
> +}
> +
> +static DeviceState *of_client_find_qom_dev(BusState *bus, const char *=
path)
> +{
> +    BusChild *kid;
> +
> +    QTAILQ_FOREACH(kid, &bus->children, sibling) {
> +        const char *p =3D qdev_get_fw_dev_path(kid->child);
> +        BusState *child;
> +
> +        if (p && strcmp(path, p) =3D=3D 0) {
> +            return kid->child;
> +        }
> +        QLIST_FOREACH(child, &kid->child->child_bus, sibling) {
> +            DeviceState *d =3D of_client_find_qom_dev(child, path);
> +
> +            if (d) {
> +                return d;
> +            }
> +        }
> +    }
> +    return NULL;
> +}
> +
> +static uint32_t spapr_of_client_open(SpaprMachineState *spapr, const c=
har *path)
> +{
> +    int offset;
> +    uint32_t ret =3D 0;
> +    SpaprOfInstance *inst =3D NULL;
> +    char *node, *unit, *part;
> +
> +    if (spapr->of_instance_last =3D=3D 0xFFFFFFFF) {
> +        /* We do not recycle ihandles yet */
> +        goto trace_exit;
> +    }
> +
> +    split_path(path, &node, &unit, &part);
> +    if (part && strcmp(part, "0")) {
> +        error_report("Error: Do not do partitions now");
> +        g_free(part);
> +        part =3D NULL;
> +    }
> +
> +    offset =3D of_client_fdt_path_offset(spapr->fdt_blob, node, unit);
> +    if (offset < 0) {
> +        trace_spapr_of_client_error_unknown_path(path);
> +        goto trace_exit;
> +    }
> +
> +    inst =3D g_new0(SpaprOfInstance, 1);
> +    inst->phandle =3D fdt_get_phandle(spapr->fdt_blob, offset);
> +    g_assert(inst->phandle);
> +    ++spapr->of_instance_last;
> +
> +    inst->dev =3D of_client_find_qom_dev(sysbus_get_default(), node);
> +    if (!inst->dev) {
> +        char *tmp =3D g_strdup_printf("%s@%s", node, unit);
> +        inst->dev =3D of_client_find_qom_dev(sysbus_get_default(), tmp=
);
> +        g_free(tmp);
> +    }
> +    inst->path =3D g_strdup(path);
> +    g_hash_table_insert(spapr->of_instances,
> +                        GINT_TO_POINTER(spapr->of_instance_last),
> +                        inst);
> +    ret =3D spapr->of_instance_last;
> +
> +    if (inst->dev) {
> +        const char *cdevstr =3D object_property_get_str(OBJECT(inst->d=
ev),
> +                                                      "chardev", NULL)=
;
> +        const char *blkstr =3D object_property_get_str(OBJECT(inst->de=
v),
> +                                                     "drive", NULL);
> +
> +        if (cdevstr) {
> +            Chardev *cdev =3D qemu_chr_find(cdevstr);
> +
> +            if (cdev) {
> +                inst->cbe =3D cdev->be;
> +            }
> +        } else if (blkstr) {
> +            BlockConf conf =3D { 0 };
> +
> +            inst->blk =3D blk_by_name(blkstr);
> +            conf.blk =3D inst->blk;
> +            blkconf_blocksizes(&conf);
> +            inst->blk_physical_block_size =3D conf.physical_block_size=
;
> +        }
> +    }
> +
> +trace_exit:
> +    trace_spapr_of_client_open(path, inst ? inst->phandle : 0, ret);
> +    g_free(node);
> +    g_free(unit);
> +    g_free(part);
> +
> +    return ret;
> +}
> +
> +static uint32_t of_client_open(SpaprMachineState *spapr, uint32_t path=
addr)
> +{
> +    char path[256];
> +
> +    readstr(pathaddr, path, sizeof(path));
> +
> +    return spapr_of_client_open(spapr, path);
> +}
> +
> +static void of_client_close(SpaprMachineState *spapr, uint32_t ihandle=
)
> +{
> +    if (!g_hash_table_remove(spapr->of_instances, GINT_TO_POINTER(ihan=
dle))) {
> +        trace_spapr_of_client_error_unknown_ihandle_close(ihandle);
> +    }
> +}
> +
> +static uint32_t of_client_instance_to_package(SpaprMachineState *spapr=
,
> +                                              uint32_t ihandle)
> +{
> +    gpointer instp =3D g_hash_table_lookup(spapr->of_instances,
> +                                         GINT_TO_POINTER(ihandle));
> +    uint32_t ret =3D -1;
> +
> +    if (instp) {
> +        ret =3D ((SpaprOfInstance *)instp)->phandle;
> +    }
> +    trace_spapr_of_client_instance_to_package(ihandle, ret);
> +
> +    return ret;
> +}
> +
> +static uint32_t of_client_package_to_path(const void *fdt, uint32_t ph=
andle,
> +                                          uint32_t buf, uint32_t len)
> +{
> +    uint32_t ret =3D -1;
> +    char tmp[256] =3D "";
> +
> +    if (0 =3D=3D fdt_get_path(fdt, fdt_node_offset_by_phandle(fdt, pha=
ndle), tmp,
> +                          sizeof(tmp))) {
> +        tmp[sizeof(tmp) - 1] =3D 0;
> +        ret =3D MIN(len, strlen(tmp) + 1);
> +        cpu_physical_memory_write(buf, tmp, ret);
> +    }
> +
> +    trace_spapr_of_client_package_to_path(phandle, tmp, ret);
> +
> +    return ret;
> +}
> +
> +static uint32_t of_client_instance_to_path(SpaprMachineState *spapr,
> +                                           uint32_t ihandle, uint32_t =
buf,
> +                                           uint32_t len)
> +{
> +    uint32_t ret =3D -1;
> +    uint32_t phandle =3D of_client_instance_to_package(spapr, ihandle)=
;
> +    char tmp[256] =3D "";
> +
> +    if (phandle !=3D -1) {
> +        if (0 =3D=3D fdt_get_path(spapr->fdt_blob,
> +                              fdt_node_offset_by_phandle(spapr->fdt_bl=
ob,
> +                                                         phandle),
> +                              tmp, sizeof(tmp))) {
> +            tmp[sizeof(tmp) - 1] =3D 0;
> +            ret =3D MIN(len, strlen(tmp) + 1);
> +            cpu_physical_memory_write(buf, tmp, ret);
> +        }
> +    }
> +    trace_spapr_of_client_instance_to_path(ihandle, phandle, tmp, ret)=
;
> +
> +    return ret;
> +}
> +
> +static uint32_t of_client_write(SpaprMachineState *spapr, uint32_t iha=
ndle,
> +                                uint32_t buf, uint32_t len)
> +{
> +    char tmp[256];
> +    int toread, toprint, cb =3D MIN(len, 1024);
> +    SpaprOfInstance *inst =3D (SpaprOfInstance *)
> +        g_hash_table_lookup(spapr->of_instances, GINT_TO_POINTER(ihand=
le));
> +
> +    while (cb > 0) {
> +        toread =3D MIN(cb, sizeof(tmp) - 1);
> +
> +        cpu_physical_memory_read(buf, tmp, toread);
> +
> +        toprint =3D toread;
> +        if (inst) {
> +            if (inst->cbe) {
> +                toprint =3D qemu_chr_fe_write_all(inst->cbe, (uint8_t =
*) tmp,
> +                                                toprint);
> +            } else if (inst->blk) {
> +                trace_spapr_of_client_blk_write(ihandle, len);
> +            }
> +        } else {
> +            /* We normally open stdout so this is fallback */
> +            tmp[toprint] =3D '\0';
> +            printf("DBG[%d]%s", ihandle, tmp);
> +        }
> +        buf +=3D toprint;
> +        cb -=3D toprint;
> +    }
> +
> +    return len;
> +}
> +
> +static uint32_t of_client_read(SpaprMachineState *spapr, uint32_t ihan=
dle,
> +                               uint32_t bufaddr, uint32_t len)
> +{
> +    uint32_t ret =3D 0;
> +    SpaprOfInstance *inst =3D (SpaprOfInstance *)
> +        g_hash_table_lookup(spapr->of_instances, GINT_TO_POINTER(ihand=
le));
> +
> +    if (inst) {
> +        hwaddr xlat =3D 0;
> +        hwaddr xlen =3D len;
> +        MemoryRegion *mr =3D address_space_translate(&address_space_me=
mory,
> +                                                   bufaddr, &xlat, &xl=
en, true,
> +                                                   MEMTXATTRS_UNSPECIF=
IED);
> +
> +        if (mr && xlen =3D=3D len) {
> +            uint8_t *buf =3D memory_region_get_ram_ptr(mr) + xlat;
> +
> +            if (inst->cbe) {
> +                SpaprVioDevice *sdev =3D VIO_SPAPR_DEVICE(inst->dev);
> +
> +                ret =3D vty_getchars(sdev, buf, len); /* qemu_chr_fe_r=
ead_all? */
> +            } else if (inst->blk) {
> +                int rc =3D blk_pread(inst->blk, inst->blk_pos, buf, le=
n);
> +
> +                if (rc > 0) {
> +                    ret =3D rc;
> +                }
> +                trace_spapr_of_client_blk_read(ihandle, inst->blk_pos,=
 len,
> +                                               ret);
> +                if (rc > 0) {
> +                    inst->blk_pos +=3D rc;
> +                }
> +            }
> +        }
> +    }
> +
> +    return ret;
> +}
> +
> +static uint32_t of_client_seek(SpaprMachineState *spapr, uint32_t ihan=
dle,
> +                               uint32_t hi, uint32_t lo)
> +{
> +    uint32_t ret =3D -1;
> +    uint64_t pos =3D ((uint64_t) hi << 32) | lo;
> +    SpaprOfInstance *inst =3D (SpaprOfInstance *)
> +        g_hash_table_lookup(spapr->of_instances, GINT_TO_POINTER(ihand=
le));
> +
> +    if (inst) {
> +        if (inst->blk) {
> +            inst->blk_pos =3D pos;
> +            ret =3D 1;
> +            trace_spapr_of_client_blk_seek(ihandle, pos, ret);
> +        }
> +    }
> +
> +    return ret;
> +}
> +
> +static void of_client_clamed_dump(GArray *claimed)
> +{
> +#ifdef DEBUG
> +    int i;
> +    SpaprOfClaimed c;
> +
> +    for (i =3D 0; i < claimed->len; ++i) {
> +        c =3D g_array_index(claimed, SpaprOfClaimed, i);
> +        error_printf("CLAIMED %lx..%lx size=3D%ld\n", c.start, c.start=
 + c.size,
> +                     c.size);
> +    }
> +#endif
> +}
> +
> +static bool of_client_claim_avail(GArray *claimed, uint64_t virt, uint=
64_t size)
> +{
> +    int i;
> +    SpaprOfClaimed c;
> +
> +    for (i =3D 0; i < claimed->len; ++i) {
> +        c =3D g_array_index(claimed, SpaprOfClaimed, i);
> +        if ((c.start <=3D virt && virt < c.start + c.size) ||
> +            (virt <=3D c.start && c.start < virt + size)) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
> +static void of_client_claim_add(GArray *claimed, uint64_t virt, uint64=
_t size)
> +{
> +    SpaprOfClaimed newclaim;
> +
> +    newclaim.start =3D virt;
> +    newclaim.size =3D size;
> +    g_array_append_val(claimed, newclaim);
> +}
> +
> +/*
> + * "claim" claims memory at @virt if @align=3D=3D0; otherwise it alloc=
ates
> + * memory at the requested alignment.
> + */
> +static void of_client_dt_memory_available(void *fdt, GArray *claimed,
> +                                          uint64_t base);
> +
> +static uint64_t of_client_claim(SpaprMachineState *spapr, uint64_t vir=
t,
> +                                uint64_t size, uint64_t align)
> +{
> +    uint64_t ret;
> +
> +    if (align =3D=3D 0) {
> +        if (!of_client_claim_avail(spapr->claimed, virt, size)) {
> +            ret =3D -1;
> +        } else {
> +            ret =3D virt;
> +        }
> +    } else {
> +        spapr->claimed_base =3D ALIGN(spapr->claimed_base, align);
> +        while (1) {
> +            if (spapr->claimed_base >=3D spapr->rma_size) {
> +                error_report("Out of RMA memory for the OF client");
> +                return -1;
> +            }
> +            if (of_client_claim_avail(spapr->claimed, spapr->claimed_b=
ase,
> +                                      size)) {
> +                break;
> +            }
> +            spapr->claimed_base +=3D size;
> +        }
> +        ret =3D spapr->claimed_base;
> +    }
> +
> +    if (ret !=3D -1) {
> +        spapr->claimed_base =3D MAX(spapr->claimed_base, ret + size);
> +        of_client_claim_add(spapr->claimed, ret, size);
> +        /* The client reads "/memory@0/available" to know where it can=
 claim */
> +        of_client_dt_memory_available(spapr->fdt_blob, spapr->claimed,
> +                                      spapr->claimed_base);
> +    }
> +    trace_spapr_of_client_claim(virt, size, align, ret);
> +
> +    return ret;
> +}
> +
> +static uint32_t of_client_release(SpaprMachineState *spapr, uint64_t v=
irt,
> +                                  uint64_t size)
> +{
> +    uint32_t ret =3D -1;
> +    int i;
> +    GArray *claimed =3D spapr->claimed;
> +    SpaprOfClaimed c;
> +
> +    for (i =3D 0; i < claimed->len; ++i) {
> +        c =3D g_array_index(claimed, SpaprOfClaimed, i);
> +        if (c.start =3D=3D virt && c.size =3D=3D size) {
> +            g_array_remove_index(claimed, i);
> +            ret =3D 0;
> +            break;
> +        }
> +    }
> +
> +    trace_spapr_of_client_release(virt, size, ret);
> +
> +    return ret;
> +}
> +
> +static void of_client_instantiate_rtas(SpaprMachineState *spapr, uint3=
2_t base)
> +{
> +    uint64_t check_claim =3D of_client_claim(spapr, base, sizeof(rtas_=
blob), 0);
> +    /*
> +     * The client should have claimed RTAS memory, make sure it has or
> +     * just claim it here with a warning.
> +     */
> +    if (check_claim !=3D -1) {
> +        error_report("The OF client did not claim RTAS memory at 0x%x"=
, base);
> +    }
> +    spapr->rtas_base =3D base;
> +    cpu_physical_memory_write(base, rtas_blob, sizeof(rtas_blob));
> +}
> +
> +static uint32_t of_client_call_method(SpaprMachineState *spapr,
> +                                      uint32_t methodaddr, uint32_t ih=
andle,
> +                                      uint32_t param1, uint32_t param2=
,
> +                                      uint32_t param3, uint32_t param4=
,
> +                                      uint32_t *ret2)
> +{
> +    uint32_t ret =3D -1;
> +    char method[256] =3D "";
> +    SpaprOfInstance *inst =3D NULL;
> +
> +    if (!ihandle) {
> +        goto trace_exit;
> +    }
> +
> +    inst =3D (SpaprOfInstance *) g_hash_table_lookup(spapr->of_instanc=
es,
> +                                                   GINT_TO_POINTER(iha=
ndle));
> +    if (!inst) {
> +        goto trace_exit;
> +    }
> +
> +    readstr(methodaddr, method, sizeof(method));
> +
> +    if (strcmp(inst->path, "/") =3D=3D 0) {
> +        if (strcmp(method, "ibm,client-architecture-support") =3D=3D 0=
) {
> +            ret =3D do_client_architecture_support(POWERPC_CPU(first_c=
pu), spapr,
> +                                                 param1, FDT_MAX_SIZE)=
;
> +            *ret2 =3D 0;
> +        }
> +    } else if (strcmp(inst->path, "/rtas") =3D=3D 0) {
> +        if (strcmp(method, "instantiate-rtas") =3D=3D 0) {
> +            of_client_instantiate_rtas(spapr, param1);
> +            ret =3D 0;
> +            *ret2 =3D param1; /* rtasbase */
> +        }
> +    } else if (inst->cbe) {
> +        if (strcmp(method, "color!") =3D=3D 0) {
> +            /* do not bother about colors now */
> +            ret =3D 0;
> +        }
> +    } else if (inst->blk) {
> +        if (strcmp(method, "block-size") =3D=3D 0) {
> +            ret =3D 0;
> +            *ret2 =3D inst->blk_physical_block_size;
> +        } else if (strcmp(method, "#blocks") =3D=3D 0) {
> +            ret =3D 0;
> +            *ret2 =3D blk_getlength(inst->blk) / inst->blk_physical_bl=
ock_size;
> +        }
> +     } else if (inst->dev) {
> +        if (strcmp(method, "vscsi-report-luns") =3D=3D 0) {
> +            /* TODO: Not implemented yet, not clear when it is really =
needed */
> +            ret =3D -1;
> +            *ret2 =3D 1;
> +        }
> +    } else {
> +        trace_spapr_of_client_error_unknown_method(method);
> +    }
> +
> +trace_exit:
> +    trace_spapr_of_client_method(ihandle, method, param1, ret, *ret2);
> +
> +    return ret;
> +}
> +
> +static uint32_t of_client_call_interpret(SpaprMachineState *spapr,
> +                                         uint32_t cmdaddr, uint32_t pa=
ram1,
> +                                         uint32_t param2, uint32_t *re=
t2)
> +{
> +    uint32_t ret =3D -1;
> +    char cmd[256] =3D "";
> +
> +    readstr(cmdaddr, cmd, sizeof(cmd));
> +    trace_spapr_of_client_interpret(cmd, param1, param2, ret, *ret2);
> +
> +    return ret;
> +}
> +
> +static void of_client_quiesce(SpaprMachineState *spapr)
> +{
> +    /* We could as well just free the blob as there is no use for it f=
rom now */
> +    int rc =3D fdt_pack(spapr->fdt_blob);
> +    /* Should only fail if we've built a corrupted tree */
> +    assert(rc =3D=3D 0);
> +
> +    spapr->fdt_size =3D fdt_totalsize(spapr->fdt_blob);
> +    spapr->fdt_initial_size =3D spapr->fdt_size;
> +    of_client_clamed_dump(spapr->claimed);
> +}
> +
> +static target_ulong spapr_h_of_client(PowerPCCPU *cpu, SpaprMachineSta=
te *spapr,
> +                                      target_ulong opcode, target_ulon=
g *args)
> +{
> +    target_ulong of_client_args =3D ppc64_phys_to_real(args[0]);
> +    struct prom_args pargs =3D { 0 };
> +    char service[64];
> +    unsigned nargs, nret;
> +    int i, servicelen;
> +
> +    cpu_physical_memory_read(of_client_args, &pargs, sizeof(pargs));
> +    nargs =3D be32_to_cpu(pargs.nargs);
> +    nret =3D be32_to_cpu(pargs.nret);
> +    readstr(be32_to_cpu(pargs.service), service, sizeof(service));
> +    servicelen =3D strlen(service);
> +
> +    if (nargs >=3D ARRAY_SIZE(pargs.args)) {
> +        /* Bounds checking: something is just very wrong */
> +        return H_PARAMETER;
> +    }
> +
> +#define cmpserv(s, a, r) \
> +    cmpservice(service, servicelen, nargs, nret, (s), sizeof(s), (a), =
(r))
> +
> +    if (cmpserv("finddevice", 1, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_finddevice(spapr->fdt_blob,
> +                                 be32_to_cpu(pargs.args[0]));
> +    } else if (cmpserv("getprop", 4, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_getprop(spapr->fdt_blob,
> +                              be32_to_cpu(pargs.args[0]),
> +                              be32_to_cpu(pargs.args[1]),
> +                              be32_to_cpu(pargs.args[2]),
> +                              be32_to_cpu(pargs.args[3]));
> +    } else if (cmpserv("getproplen", 2, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_getproplen(spapr->fdt_blob,
> +                                 be32_to_cpu(pargs.args[0]),
> +                                 be32_to_cpu(pargs.args[1]));
> +    } else if (cmpserv("setprop", 4, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_setprop(spapr,
> +                              be32_to_cpu(pargs.args[0]),
> +                              be32_to_cpu(pargs.args[1]),
> +                              be32_to_cpu(pargs.args[2]),
> +                              be32_to_cpu(pargs.args[3]));
> +    } else if (cmpserv("nextprop", 3, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_nextprop(spapr->fdt_blob,
> +                               be32_to_cpu(pargs.args[0]),
> +                               be32_to_cpu(pargs.args[1]),
> +                               be32_to_cpu(pargs.args[2]));
> +    } else if (cmpserv("peer", 1, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_peer(spapr->fdt_blob,
> +                           be32_to_cpu(pargs.args[0]));
> +    } else if (cmpserv("child", 1, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_child(spapr->fdt_blob,
> +                            be32_to_cpu(pargs.args[0]));
> +    } else if (cmpserv("parent", 1, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_parent(spapr->fdt_blob,
> +                             be32_to_cpu(pargs.args[0]));
> +    } else if (cmpserv("open", 1, 1)) {
> +        pargs.args[nargs] =3D of_client_open(spapr, be32_to_cpu(pargs.=
args[0]));
> +    } else if (cmpserv("close", 1, 0)) {
> +        of_client_close(spapr, be32_to_cpu(pargs.args[0]));
> +    } else if (cmpserv("instance-to-package", 1, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_instance_to_package(spapr,
> +                                          be32_to_cpu(pargs.args[0]));
> +    } else if (cmpserv("package-to-path", 3, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_package_to_path(spapr->fdt_blob,
> +                                      be32_to_cpu(pargs.args[0]),
> +                                      be32_to_cpu(pargs.args[1]),
> +                                      be32_to_cpu(pargs.args[2]));
> +    } else if (cmpserv("instance-to-path", 3, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_instance_to_path(spapr,
> +                                       be32_to_cpu(pargs.args[0]),
> +                                       be32_to_cpu(pargs.args[1]),
> +                                       be32_to_cpu(pargs.args[2]));
> +    } else if (cmpserv("write", 3, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_write(spapr,
> +                            be32_to_cpu(pargs.args[0]),
> +                            be32_to_cpu(pargs.args[1]),
> +                            be32_to_cpu(pargs.args[2]));
> +    } else if (cmpserv("read", 3, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_read(spapr,
> +                           be32_to_cpu(pargs.args[0]),
> +                           be32_to_cpu(pargs.args[1]),
> +                           be32_to_cpu(pargs.args[2]));
> +    } else if (cmpserv("seek", 3, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_seek(spapr,
> +                           be32_to_cpu(pargs.args[0]),
> +                           be32_to_cpu(pargs.args[1]),
> +                           be32_to_cpu(pargs.args[2]));
> +    } else if (cmpserv("claim", 3, 1)) {
> +        pargs.args[nargs] =3D
> +            of_client_claim(spapr,
> +                            be32_to_cpu(pargs.args[0]),
> +                            be32_to_cpu(pargs.args[1]),
> +                            be32_to_cpu(pargs.args[2]));
> +    } else if (cmpserv("release", 2, 0)) {
> +        pargs.args[nargs] =3D
> +            of_client_release(spapr,
> +                              be32_to_cpu(pargs.args[0]),
> +                              be32_to_cpu(pargs.args[1]));
> +    } else if (cmpserv("call-method", 0, 0)) {
> +        pargs.args[nargs] =3D
> +            of_client_call_method(spapr,
> +                                  be32_to_cpu(pargs.args[0]),
> +                                  be32_to_cpu(pargs.args[1]),
> +                                  be32_to_cpu(pargs.args[2]),
> +                                  be32_to_cpu(pargs.args[3]),
> +                                  be32_to_cpu(pargs.args[4]),
> +                                  be32_to_cpu(pargs.args[5]),
> +                                  &pargs.args[nargs + 1]);
> +    } else if (cmpserv("interpret", 0, 0)) {
> +        pargs.args[nargs] =3D
> +            of_client_call_interpret(spapr,
> +                                     be32_to_cpu(pargs.args[0]),
> +                                     be32_to_cpu(pargs.args[1]),
> +                                     be32_to_cpu(pargs.args[2]),
> +                                     &pargs.args[nargs + 1]);
> +    } else if (cmpserv("milliseconds", 0, 1)) {
> +        pargs.args[nargs] =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> +    } else if (cmpserv("quiesce", 0, 0)) {
> +        of_client_quiesce(spapr);
> +    } else if (cmpserv("exit", 0, 0)) {
> +        error_report("Stopped as the VM requested \"exit\"");
> +        vm_stop(RUN_STATE_PAUSED); /* Or qemu_system_guest_panicked(NU=
LL); ? */
> +    } else {
> +        trace_spapr_of_client_error_unknown_service(service, nargs, nr=
et);
> +        pargs.args[nargs] =3D -1;
> +    }
> +
> +    for (i =3D 0; i < nret; ++i) {
> +        pargs.args[nargs + i] =3D be32_to_cpu(pargs.args[nargs + i]);
> +    }
> +
> +    /* Copy what is needed as GRUB allocates only required minimum on =
stack */
> +    cpu_physical_memory_write(of_client_args, &pargs,
> +                              sizeof(uint32_t) * (3 + nargs + nret));
> +
> +    return H_SUCCESS;
> +}
> +
> +static void of_instance_free(gpointer data)
> +{
> +    SpaprOfInstance *inst =3D (SpaprOfInstance *) data;
> +
> +    g_free(inst->path);
> +    g_free(inst);
> +}
> +
> +void spapr_setup_of_client(SpaprMachineState *spapr, target_ulong *sta=
ck_ptr,
> +                           target_ulong *prom_entry)
> +{
> +    if (spapr->claimed) {
> +        g_array_unref(spapr->claimed);
> +    }
> +    if (spapr->of_instances) {
> +        g_hash_table_unref(spapr->of_instances);
> +    }
> +
> +    spapr->claimed =3D g_array_new(false, false, sizeof(SpaprOfClaimed=
));
> +    spapr->of_instances =3D g_hash_table_new_full(g_direct_hash, g_dir=
ect_equal,
> +                                                NULL, of_instance_free=
);
> +
> +    *stack_ptr =3D of_client_claim(spapr, 0, OF_STACK_SIZE, OF_STACK_S=
IZE);
> +    if (*stack_ptr =3D=3D -1) {
> +        error_report("Memory allocation for stack failed");
> +        exit(1);
> +    }
> +    /*
> +     * Stack grows downwards and we also reserve here space for
> +     * the minimum stack frame.
> +     */
> +    *stack_ptr +=3D OF_STACK_SIZE - 0x20;
> +
> +    *prom_entry =3D of_client_claim(spapr, 0, sizeof(of_client_blob),
> +                                  sizeof(of_client_blob));
> +    if (*prom_entry =3D=3D -1) {
> +        error_report("Memory allocation for OF client failed");
> +        exit(1);
> +    }
> +
> +    cpu_physical_memory_write(*prom_entry, of_client_blob,
> +                              sizeof(of_client_blob));
> +
> +    if (of_client_claim(spapr, spapr->kernel_addr,
> +                        spapr->kernel_size, 0) =3D=3D -1) {
> +        error_report("Memory for kernel is in use");
> +        exit(1);
> +    }
> +
> +    if (spapr->initrd_size &&
> +        of_client_claim(spapr, spapr->initrd_base,
> +                        spapr->initrd_size, 0) =3D=3D -1) {
> +        error_report("Memory for initramdisk is in use");
> +        exit(1);
> +    }
> +
> +    /*
> +     * We skip writing FDT as nothing expects it; OF client interface =
is
> +     * going to be used for reading the device tree.
> +     */
> +}
> +
> +static gint of_claimed_compare_func(gconstpointer a, gconstpointer b)
> +{
> +    return ((SpaprOfClaimed *)a)->start - ((SpaprOfClaimed *)b)->start=
;
> +}
> +
> +static void of_client_dt_memory_available(void *fdt, GArray *claimed,
> +                                          uint64_t base)
> +{
> +    int i, n, offset, proplen =3D 0;
> +    uint64_t *mem0_reg;
> +    struct { uint64_t start, size; } *avail;
> +
> +    if (!fdt || !claimed) {
> +        return;
> +    }
> +
> +    offset =3D fdt_path_offset(fdt, "/memory@0");
> +    _FDT(offset);
> +
> +    mem0_reg =3D (uint64_t *) fdt_getprop(fdt, offset, "reg", &proplen=
);
> +    if (!mem0_reg || proplen !=3D 2 * sizeof(uint64_t)) {
> +        return;
> +    }
> +
> +    g_array_sort(claimed, of_claimed_compare_func);
> +    of_client_clamed_dump(claimed);
> +
> +    avail =3D g_malloc0(sizeof(uint64_t) * 2 * claimed->len);
> +    for (i =3D 0, n =3D 0; i < claimed->len; ++i) {
> +        SpaprOfClaimed c =3D g_array_index(claimed, SpaprOfClaimed, i)=
;
> +
> +        avail[n].start =3D c.start + c.size;
> +        if (i < claimed->len - 1) {
> +            SpaprOfClaimed cn =3D g_array_index(claimed, SpaprOfClaime=
d, i + 1);
> +
> +            avail[n].size =3D cn.start - avail[n].start;
> +        } else {
> +            avail[n].size =3D be64_to_cpu(mem0_reg[1]) - avail[n].star=
t;
> +        }
> +
> +        if (avail[n].size) {
> +#ifdef DEBUG
> +            error_printf("AVAIL %lx..%lx size=3D%ld\n", avail[n].start=
,
> +                         avail[n].start + avail[n].size, avail[n].size=
);
> +#endif
> +            avail[n].start =3D cpu_to_be64(avail[n].start);
> +            avail[n].size =3D cpu_to_be64(avail[n].size);
> +            ++n;
> +        }
> +    }
> +    _FDT((fdt_setprop(fdt, offset, "available", avail,
> +                      sizeof(uint64_t) * 2 * n)));
> +    g_free(avail);
> +}
> +
> +void spapr_of_client_dt(SpaprMachineState *spapr, void *fdt)
> +{
> +    uint32_t phandle;
> +    int i, offset, proplen =3D 0;
> +    const void *prop;
> +    bool found =3D false;
> +    GArray *phandles =3D g_array_new(false, false, sizeof(uint32_t));
> +    const char *nodename;
> +    char *stdout_path =3D spapr_vio_stdout_path(spapr->vio_bus);
> +    int aliases;
> +    aliases =3D fdt_add_subnode(fdt, 0, "aliases");
> +
> +    if (stdout_path) {
> +        fdt_setprop_string(fdt, aliases, "hvterm", stdout_path);
> +    }
> +
> +    /* Add options now, doing it at the end of this __func__ breaks it=
 :-/ */
> +    offset =3D fdt_add_subnode(fdt, 0, "options");
> +    if (offset > 0) {
> +        struct winsize ws;
> +
> +        if (ioctl(1, TIOCGWINSZ, &ws) !=3D -1) {
> +            _FDT(fdt_setprop_cell(fdt, offset, "screen-#columns", ws.w=
s_col));
> +            _FDT(fdt_setprop_cell(fdt, offset, "screen-#rows", ws.ws_r=
ow));
> +        }
> +        _FDT(fdt_setprop_cell(fdt, offset, "real-mode?", 1));
> +    }
> +
> +    /* Add "disk" nodes to SCSI hosts */
> +    for (offset =3D fdt_next_node(fdt, -1, NULL), phandle =3D 1;
> +         offset >=3D 0;
> +         offset =3D fdt_next_node(fdt, offset, NULL), ++phandle) {
> +
> +        nodename =3D fdt_get_name(fdt, offset, NULL);
> +        if (strncmp(nodename, "scsi@", 5) =3D=3D 0 ||
> +            strncmp(nodename, "v-scsi@", 7) =3D=3D 0) {
> +            int disk_node_off =3D fdt_add_subnode(fdt, offset, "disk")=
;
> +
> +            fdt_setprop_string(fdt, disk_node_off, "device_type", "blo=
ck");
> +        }
> +    }
> +
> +    /* Find all predefined phandles */
> +    for (offset =3D fdt_next_node(fdt, -1, NULL);
> +         offset >=3D 0;
> +         offset =3D fdt_next_node(fdt, offset, NULL)) {
> +        prop =3D fdt_getprop(fdt, offset, "phandle", &proplen);
> +        if (prop && proplen =3D=3D sizeof(uint32_t)) {
> +            phandle =3D fdt32_ld(prop);
> +            g_array_append_val(phandles, phandle);
> +        }
> +    }
> +
> +    /* Assign phandles skipping the predefined ones */
> +    for (offset =3D fdt_next_node(fdt, -1, NULL), phandle =3D 1;
> +         offset >=3D 0;
> +         offset =3D fdt_next_node(fdt, offset, NULL), ++phandle) {
> +
> +        prop =3D fdt_getprop(fdt, offset, "phandle", &proplen);
> +        if (prop) {
> +            continue;
> +        }
> +        /* Check if the current phandle is not allocated already */
> +        for ( ; ; ++phandle) {
> +            for (i =3D 0, found =3D false; i < phandles->len; ++i) {
> +                if (phandle =3D=3D g_array_index(phandles, uint32_t, i=
)) {
> +                    found =3D true;
> +                    break;
> +                }
> +            }
> +            if (!found) {
> +                break;
> +            }
> +        }
> +        _FDT(fdt_setprop_cell(fdt, offset, "phandle", phandle));
> +    }
> +    g_array_unref(phandles);
> +
> +    of_client_dt_memory_available(fdt, spapr->claimed, spapr->claimed_=
base);
> +
> +    /* Advertise RTAS presense */
> +    offset =3D fdt_path_offset(fdt, "/rtas");
> +    _FDT(offset);
> +    _FDT(fdt_setprop_cell(fdt, offset, "rtas-size", sizeof(rtas_blob))=
);
> +}
> +
> +void spapr_of_client_dt_finalize(SpaprMachineState *spapr)
> +{
> +    void *fdt =3D spapr->fdt_blob;
> +    char *stdout_path =3D spapr_vio_stdout_path(spapr->vio_bus);
> +    int chosen =3D fdt_path_offset(fdt, "/chosen");
> +    size_t cb =3D 0;
> +    char *bootlist =3D get_boot_devices_list(&cb);
> +
> +    /*
> +     * SLOF-less setup requires an open instance of stdout for early
> +     * kernel printk. By now all phandles are settled so we can open
> +     * the default serial console.
> +     */
> +    if (stdout_path) {
> +        _FDT(fdt_setprop_cell(fdt, chosen, "stdout",
> +                              spapr_of_client_open(spapr, stdout_path)=
));
> +        _FDT(fdt_setprop_cell(fdt, chosen, "stdin",
> +                              spapr_of_client_open(spapr, stdout_path)=
));
> +    }
> +
> +    if (bootlist) {
> +        _FDT(fdt_setprop_string(fdt, chosen, "bootpath", bootlist));
> +        _FDT(fdt_setprop_string(fdt, chosen, "bootargs",
> +                                spapr->bootargs ? spapr->bootargs : ""=
));
> +    }
> +}
> +
> +static void spapr_of_client_machine_ready(Notifier *n, void *opaque)
> +{
> +    SpaprMachineState *spapr =3D container_of(n, SpaprMachineState,
> +                                            machine_ready);
> +    size_t cb =3D 0;
> +    char *bootlist =3D get_boot_devices_list(&cb);
> +    const char *blkstr;
> +    BlockBackend *blk;
> +    char *cur, *next;
> +    DeviceState *qdev;
> +    uint64_t offset =3D 0, size =3D 0;
> +    uint8_t *grub;
> +    int rc;
> +
> +    if (spapr->kernel_size) {
> +        return;
> +    }
> +
> +    bootlist =3D get_boot_devices_list(&cb);
> +
> +    if (!bootlist) {
> +        return;
> +    }
> +
> +    for (cur =3D bootlist; cb > 0; cur =3D next + 1) {
> +        for (next =3D cur; cb > 0; --cb) {
> +            if (*next =3D=3D '\n') {
> +                *next =3D '\0';
> +                ++next;
> +                --cb;
> +                break;
> +            }
> +        }
> +
> +        qdev =3D of_client_find_qom_dev(sysbus_get_default(), cur);
> +        if (!qdev) {
> +            continue;
> +        }
> +
> +        blkstr =3D object_property_get_str(OBJECT(qdev), "drive", NULL=
);
> +        if (!blkstr) {
> +            continue;
> +        }
> +
> +        blk =3D blk_by_name(blkstr);
> +        if (!blk) {
> +            continue;
> +        }
> +
> +        if (find_prep_partition(blk, &offset, &size)) {
> +            continue;
> +        }
> +
> +        grub =3D g_malloc0(size);
> +        if (!grub) {
> +            continue;
> +        }
> +
> +        rc =3D blk_pread(blk, offset, grub, size);
> +        if (rc <=3D 0) {
> +            g_free(grub);
> +            continue;
> +        }
> +
> +        g_file_set_contents("my.grub", (void *) grub, size, NULL);
> +        spapr->kernel_size =3D load_elf("my.grub", NULL, NULL, NULL,
> +                                      NULL, &spapr->kernel_addr,
> +                                      NULL, NULL, 1,
> +                                      PPC_ELF_MACHINE, 0, 0);
> +        spapr->kernel_size =3D size;
> +
> +        trace_spapr_of_client_blk_bootloader_read(offset, size);
> +        break;
> +    }
> +
> +    g_free(bootlist);
> +}
> +
> +void spapr_of_client_machine_init(SpaprMachineState *spapr)
> +{
> +    spapr_register_hypercall(KVMPPC_H_OF_CLIENT, spapr_h_of_client);
> +    spapr->machine_ready.notify =3D spapr_of_client_machine_ready;
> +    qemu_add_machine_init_done_notifier(&spapr->machine_ready);
> +}
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index 9ea620f23c85..757afb66834e 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -21,6 +21,30 @@ spapr_update_dt(unsigned cb) "New blob %u bytes"
> spapr_update_dt_failed_size(unsigned cbold, unsigned cbnew, unsigned ma=
gic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
> spapr_update_dt_failed_check(unsigned cbold, unsigned cbnew, unsigned m=
agic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
>
> +# spapr_client.c
> +spapr_of_client_error_str_truncated(const char *s, int len) "%s trunca=
ted to %d"
> +spapr_of_client_error_param(const char *method, int nargscheck, int nr=
etcheck, int nargs, int nret) "%s takes/returns %d/%d, not %d/%d"
> +spapr_of_client_error_unknown_service(const char *service, int nargs, =
int nret) "\"%s\" args=3D%d rets=3D%d"
> +spapr_of_client_error_unknown_method(const char *method) "\"%s\""
> +spapr_of_client_error_unknown_ihandle_close(uint32_t ih) "ih=3D0x%x"
> +spapr_of_client_error_unknown_path(const char *path) "\"%s\""
> +spapr_of_client_finddevice(const char *path, uint32_t ph) "\"%s\" =3D>=
 ph=3D0x%x"
> +spapr_of_client_claim(uint32_t virt, uint32_t size, uint32_t align, ui=
nt32_t ret) "virt=3D0x%x size=3D0x%x align=3D0x%x =3D> 0x%x"
> +spapr_of_client_release(uint32_t virt, uint32_t size, uint32_t ret) "v=
irt=3D0x%x size=3D0x%x =3D> 0x%x"
> +spapr_of_client_method(uint32_t ihandle, const char *method, uint32_t =
param, uint32_t ret, uint32_t ret2) "ih=3D0x%x \"%s\"(0x%x) =3D> 0x%x 0x%=
x"
> +spapr_of_client_getprop(uint32_t ph, const char *prop, uint32_t ret, c=
onst char *val) "ph=3D0x%x \"%s\" =3D> len=3D%d [%s]"
> +spapr_of_client_getproplen(uint32_t ph, const char *prop, uint32_t ret=
) "ph=3D0x%x \"%s\" =3D> len=3D%d"
> +spapr_of_client_setprop(uint32_t ph, const char *prop, const char *val=
, uint32_t ret) "ph=3D0x%x \"%s\" [%s] =3D> len=3D%d"
> +spapr_of_client_open(const char *path, uint32_t ph, uint32_t ih) "%s p=
h=3D0x%x =3D> ih=3D0x%x"
> +spapr_of_client_interpret(const char *cmd, uint32_t param1, uint32_t p=
aram2, uint32_t ret, uint32_t ret2) "[%s] 0x%x 0x%x =3D> 0x%x 0x%x"
> +spapr_of_client_blk_write(uint32_t ih, uint32_t len) "0x%x =3D> len=3D=
%d"
> +spapr_of_client_blk_read(uint32_t ih, uint64_t pos, uint32_t len, uint=
32_t ret) "ih=3D0x%x @0x%"PRIx64" size=3D%d =3D> %d"
> +spapr_of_client_blk_seek(uint32_t ih, uint64_t pos, uint32_t ret) "ih=3D=
0x%x 0x%"PRIx64" =3D> %d"
> +spapr_of_client_blk_bootloader_read(uint64_t offset, uint64_t size) "0=
x%"PRIx64" size=3D0x%"PRIx64
> +spapr_of_client_package_to_path(uint32_t ph, const char *tmp, uint32_t=
 ret) "ph=3D0x%x =3D> %s len=3D%d"
> +spapr_of_client_instance_to_path(uint32_t ih, uint32_t ph, const char =
*tmp, uint32_t ret) "ih=3D0x%x ph=3D0x%x =3D> %s len=3D%d"
> +spapr_of_client_instance_to_package(uint32_t ih, uint32_t ph) "ih=3D0x=
%x =3D> ph=3D0x%x"
> +
> # spapr_hcall_tpm.c
> spapr_h_tpm_comm(const char *device_path, uint64_t operation) "tpm_devi=
ce_path=3D%s operation=3D0x%"PRIu64
> spapr_tpm_execute(uint64_t data_in, uint64_t data_in_sz, uint64_t data_=
out, uint64_t data_out_sz) "data_in=3D0x%"PRIx64", data_in_sz=3D%"PRIu64"=
, data_out=3D0x%"PRIx64", data_out_sz=3D%"PRIu64
>
--3866299591-1257719729-1580735010=:31211--


Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9F7C3B188
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 07:06:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8E72168B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 07:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuOZg+ts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8E72168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j28aK-0003ID-9N
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 02:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1j28Zb-0002sT-2n
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 02:06:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1j28ZZ-0001iD-3W
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 02:06:06 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:34029)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1j28ZY-0001hs-OO
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 02:06:05 -0500
Received: by mail-lj1-x244.google.com with SMTP id x7so5333514ljc.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 23:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KglKVgQL8ipWefzx88cuGsPIOOIDHhqLuWhJx2mELYs=;
 b=OuOZg+tsgAnVuqaEuhHlzS03+x5XmfRwf0TQV8Ia5BS5mk7ZHc7pxplEanC3c7j8zz
 a59yYoHV1D3F2uth1jxcfpYpny8SefP1DDVKoHoA8jmaqE43bpGIX0MJdhJCjCxMXd3F
 qMcux9VCzJnIRWoxKWTKjoBpE37mcdniM3UtjN9vud2G0vdkvafDTcirgy2tke9YlLgN
 qx+3HHtUXLLrTYOIMYcj5N+wE1juHiy8HgqjnEymK4hokXlQ4QS0Gcf8GpYup8GWVmW0
 1Jwg2BQO9AN+0zUyzUulTUG9QZYAWbYwVNbSI8rLHFP0lOz3pfUXc3xDfrQftYMnKaMI
 t0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KglKVgQL8ipWefzx88cuGsPIOOIDHhqLuWhJx2mELYs=;
 b=i/rWA9EumXLdIbleuFSwyvZiN0eVpoJ0Kyq5Jg2QZVrx1Bq2x7LDyWI+rBff8JDxPK
 nv4DLEpfL1/9usQx4p0Hz23sEk47ELttnM8Es3+M1ywvLFWosqBjO+jr8fV1RVu3Uxeo
 F6OAs+jBgkaW5TCJ2VY7A+imRwo8ia47AgMWZV2PsO31OQMEDptkclj8UJU7pgKJP/3K
 oNSGT/xt5WS879cPDPNSxY5q9AP9Qq0U5xFMs3fBH9z/+JP3gUAy13ci8L3/SR1e5/Yu
 QY3rFtQiIXLDRP/uEG89DNP/Ke+WYFirQNDspSA65PEahB0Qn5uRiijlG2e4wItmZphp
 bTGA==
X-Gm-Message-State: APjAAAWXKRqX7HaZh1jAqH9CaWx+WpRdq2ZjqehPdMZz6VxbFgber7PL
 h4cvZFZHc5bxkq2fpDo6pWqPIkfazP7SWTpQ4M6aXBrv
X-Google-Smtp-Source: APXvYqzF/AuX0hIKeoziOwiM+HR3bCie7VauWccn80wrBjRKTc7MiFPTO3MeZf37/KEL0kMtXmWqxCo+HpLshJPIi+s=
X-Received: by 2002:a2e:814e:: with SMTP id t14mr10215087ljg.149.1581577562887; 
 Wed, 12 Feb 2020 23:06:02 -0800 (PST)
MIME-Version: 1.0
References: <20200212095137.7977-1-coiby.xu@gmail.com>
 <20200212095137.7977-5-coiby.xu@gmail.com>
In-Reply-To: <20200212095137.7977-5-coiby.xu@gmail.com>
From: Coiby Xu <coiby.xu@gmail.com>
Date: Thu, 13 Feb 2020 15:05:26 +0800
Message-ID: <CAJAkqrVboa2D67VpQvBL1L89wW8xu-b884qufwvQwZpvxtyXBw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] a standone-alone tool to directly share disk image
 file via vhost-user protocol
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I forgot to put backends/vhost-user-blk-server.o as dependency for
qemu-vu target in Makefile,

 qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y)
$(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y)
$(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+
+ifdef CONFIG_LINUX
+qemu-vu$(EXESUF): qemu-vu.o backends/vhost-user-blk-server.o
$(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y)
$(COMMON_LDADDS) libvhost-user.a
+endif
 qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y)
$(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)

I also noticed in the latest version of QEMU, `make check-qtest`
somehow doesn't run qos-test. If you need to run vhost-user-blk
testsuite, please execute the following command after applying the
above fix and the 5th patch,

  MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=./qemu-img QTEST_QEMU_VU_BINARY=./qemu-vu
tests/qos-test -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
--test-name="qos-test"


On Wed, Feb 12, 2020 at 5:52 PM Coiby Xu <coiby.xu@gmail.com> wrote:
>
> vhost-user-blk could have played as vhost-user backend but it only supports raw
> file and don't support VIRTIO_BLK_T_DISCARD and VIRTIO_BLK_T_WRITE_ZEROES
> operations on raw file (ioctl(fd, BLKDISCARD) is only valid for real
> block device).
>
> In the future Kevin's qemu-storage-daemon will be used to replace this
> tool.
>
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  Makefile  |   4 +
>  configure |   3 +
>  qemu-vu.c | 252 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 259 insertions(+)
>  create mode 100644 qemu-vu.c
>
> diff --git a/Makefile b/Makefile
> index f0e1a2fc1d..0bfd2f1ddd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -572,6 +572,10 @@ qemu-img.o: qemu-img-cmds.h
>
>  qemu-img$(EXESUF): qemu-img.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
>  qemu-nbd$(EXESUF): qemu-nbd.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
> +
> +ifdef CONFIG_LINUX
> +qemu-vu$(EXESUF): qemu-vu.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS) libvhost-user.a
> +endif
>  qemu-io$(EXESUF): qemu-io.o $(authz-obj-y) $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
>
>  qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
> diff --git a/configure b/configure
> index 115dc38085..e87c9a5587 100755
> --- a/configure
> +++ b/configure
> @@ -6217,6 +6217,9 @@ if test "$want_tools" = "yes" ; then
>    if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
>      tools="qemu-nbd\$(EXESUF) $tools"
>    fi
> +  if [ "$linux" = "yes" ] ; then
> +    tools="qemu-vu\$(EXESUF) $tools"
> +  fi
>    if [ "$ivshmem" = "yes" ]; then
>      tools="ivshmem-client\$(EXESUF) ivshmem-server\$(EXESUF) $tools"
>    fi
> diff --git a/qemu-vu.c b/qemu-vu.c
> new file mode 100644
> index 0000000000..dd1032b205
> --- /dev/null
> +++ b/qemu-vu.c
> @@ -0,0 +1,252 @@
> +/*
> + *  Copyright (C) 2020  Coiby Xu <coiby.xu@gmail.com>
> + *
> + *  standone-alone vhost-user-blk device server backend
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; under version 2 of the License.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <getopt.h>
> +#include <libgen.h>
> +#include "backends/vhost-user-blk-server.h"
> +#include "block/block_int.h"
> +#include "io/net-listener.h"
> +#include "qapi/error.h"
> +#include "qapi/qmp/qdict.h"
> +#include "qapi/qmp/qstring.h"
> +#include "qemu/config-file.h"
> +#include "qemu/cutils.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/module.h"
> +#include "qemu/option.h"
> +#include "qemu-common.h"
> +#include "qemu-version.h"
> +#include "qom/object_interfaces.h"
> +#include "sysemu/block-backend.h"
> +#define QEMU_VU_OPT_CACHE         256
> +#define QEMU_VU_OPT_AIO           257
> +#define QEMU_VU_OBJ_ID   "vu_disk"
> +static QemuOptsList qemu_object_opts = {
> +    .name = "object",
> +    .implied_opt_name = "qom-type",
> +    .head = QTAILQ_HEAD_INITIALIZER(qemu_object_opts.head),
> +    .desc = {
> +        { }
> +    },
> +};
> +static char *srcpath;
> +
> +static void usage(const char *name)
> +{
> +    (printf) (
> +"Usage: %s [OPTIONS] FILE\n"
> +"  or:  %s -L [OPTIONS]\n"
> +"QEMU Vhost-user Server Utility\n"
> +"\n"
> +"  -h, --help                display this help and exit\n"
> +"  -V, --version             output version information and exit\n"
> +"\n"
> +"Connection properties:\n"
> +"  -k, --socket=PATH         path to the unix socket\n"
> +"\n"
> +"General purpose options:\n"
> +"  -e, -- exit-panic         When the panic callback is called, the program\n"
> +"                            will exit. Useful for make check-qtest.\n"
> +"\n"
> +"Block device options:\n"
> +"  -f, --format=FORMAT       set image format (raw, qcow2, ...)\n"
> +"  -r, --read-only           export read-only\n"
> +"  -n, --nocache             disable host cache\n"
> +"      --cache=MODE          set cache mode (none, writeback, ...)\n"
> +"      --aio=MODE            set AIO mode (native or threads)\n"
> +"\n"
> +QEMU_HELP_BOTTOM "\n"
> +    , name, name);
> +}
> +
> +static void version(const char *name)
> +{
> +    printf(
> +"%s " QEMU_FULL_VERSION "\n"
> +"Written by Coiby Xu, based on qemu-nbd by Anthony Liguori\n"
> +"\n"
> +QEMU_COPYRIGHT "\n"
> +"This is free software; see the source for copying conditions.  There is NO\n"
> +"warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.\n"
> +    , name);
> +}
> +
> +static VuBlockDev *vu_block_device;
> +
> +static void vus_shutdown(void)
> +{
> +
> +    Error *local_err = NULL;
> +    job_cancel_sync_all();
> +    bdrv_close_all();
> +    user_creatable_del(QEMU_VU_OBJ_ID, &local_err);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    BlockBackend *blk;
> +    BlockDriverState *bs;
> +    bool readonly = false;
> +    char *sockpath = NULL;
> +    const char *sopt = "hVrnvek:f:";
> +    struct option lopt[] = {
> +        { "help", no_argument, NULL, 'h' },
> +        { "version", no_argument, NULL, 'V' },
> +        { "exit-panic", no_argument, NULL, 'e' },
> +        { "socket", required_argument, NULL, 'k' },
> +        { "read-only", no_argument, NULL, 'r' },
> +        { "nocache", no_argument, NULL, 'n' },
> +        { "cache", required_argument, NULL, QEMU_VU_OPT_CACHE },
> +        { "aio", required_argument, NULL, QEMU_VU_OPT_AIO },
> +        { "format", required_argument, NULL, 'f' },
> +        { NULL, 0, NULL, 0 }
> +    };
> +    int ch;
> +    int opt_ind = 0;
> +    int flags = BDRV_O_RDWR;
> +    bool seen_cache = false;
> +    bool seen_aio = false;
> +    const char *fmt = NULL;
> +    Error *local_err = NULL;
> +    QDict *options = NULL;
> +    bool writethrough = true;
> +    bool exit_when_panic = false;
> +
> +    error_init(argv[0]);
> +
> +    module_call_init(MODULE_INIT_QOM);
> +    qemu_init_exec_dir(argv[0]);
> +
> +    while ((ch = getopt_long(argc, argv, sopt, lopt, &opt_ind)) != -1) {
> +        switch (ch) {
> +        case 'e':
> +            exit_when_panic = true;
> +            break;
> +        case 'n':
> +            optarg = (char *) "none";
> +            /* fallthrough */
> +        case QEMU_VU_OPT_CACHE:
> +            if (seen_cache) {
> +                error_report("-n and --cache can only be specified once");
> +                exit(EXIT_FAILURE);
> +            }
> +            seen_cache = true;
> +            if (bdrv_parse_cache_mode(optarg, &flags, &writethrough) == -1) {
> +                error_report("Invalid cache mode `%s'", optarg);
> +                exit(EXIT_FAILURE);
> +            }
> +            break;
> +        case QEMU_VU_OPT_AIO:
> +            if (seen_aio) {
> +                error_report("--aio can only be specified once");
> +                exit(EXIT_FAILURE);
> +            }
> +            seen_aio = true;
> +            if (!strcmp(optarg, "native")) {
> +                flags |= BDRV_O_NATIVE_AIO;
> +            } else if (!strcmp(optarg, "threads")) {
> +                /* this is the default */
> +            } else {
> +               error_report("invalid aio mode `%s'", optarg);
> +               exit(EXIT_FAILURE);
> +            }
> +            break;
> +        case 'r':
> +            readonly = true;
> +            flags &= ~BDRV_O_RDWR;
> +            break;
> +        case 'k':
> +            sockpath = optarg;
> +            if (sockpath[0] != '/') {
> +                error_report("socket path must be absolute");
> +                exit(EXIT_FAILURE);
> +            }
> +            break;
> +        case 'f':
> +            fmt = optarg;
> +            break;
> +        case 'V':
> +            version(argv[0]);
> +            exit(0);
> +            break;
> +        case 'h':
> +            usage(argv[0]);
> +            exit(0);
> +            break;
> +        case '?':
> +            error_report("Try `%s --help' for more information.", argv[0]);
> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +
> +    if ((argc - optind) != 1) {
> +        error_report("Invalid number of arguments");
> +        error_printf("Try `%s --help' for more information.\n", argv[0]);
> +        exit(EXIT_FAILURE);
> +    }
> +    if (qemu_init_main_loop(&local_err)) {
> +        error_report_err(local_err);
> +        exit(EXIT_FAILURE);
> +    }
> +    bdrv_init();
> +
> +    srcpath = argv[optind];
> +    if (fmt) {
> +        options = qdict_new();
> +        qdict_put_str(options, "driver", fmt);
> +    }
> +    blk = blk_new_open(srcpath, NULL, options, flags, &local_err);
> +
> +    if (!blk) {
> +        error_reportf_err(local_err, "Failed to blk_new_open '%s': ",
> +                          argv[optind]);
> +        exit(EXIT_FAILURE);
> +    }
> +    bs = blk_bs(blk);
> +
> +    char buf[300];
> +    snprintf(buf, 300, "%s,id=%s,node-name=%s,unix-socket=%s,writable=%s",
> +             TYPE_VHOST_USER_BLK_SERVER, QEMU_VU_OBJ_ID, bdrv_get_node_name(bs),
> +             sockpath, !readonly ? "on" : "off");
> +    /* While calling user_creatable_del, 'object' group is required */
> +    qemu_add_opts(&qemu_object_opts);
> +    QemuOpts *opts = qemu_opts_parse(&qemu_object_opts, buf, true, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        goto error;
> +    }
> +
> +    Object *obj = user_creatable_add_opts(opts, &local_err);
> +
> +    if (local_err) {
> +        error_report_err(local_err);
> +        goto error;
> +    }
> +
> +    vu_block_device = VHOST_USER_BLK_SERVER(obj);
> +    vu_block_device->exit_when_panic = exit_when_panic;
> +
> +    do {
> +        main_loop_wait(false);
> +    } while (!vu_block_device->exit_when_panic || !vu_block_device->vu_server->close);
> +
> + error:
> +    vus_shutdown();
> +    exit(EXIT_SUCCESS);
> +}
> --
> 2.25.0
>


--
Best regards,
Coiby


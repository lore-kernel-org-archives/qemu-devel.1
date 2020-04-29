Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA40EC83007
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 04:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72F2C2076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 04:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F2C2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTeJn-0000KM-FX
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 00:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <LYan@suse.com>) id 1jTeIf-0007zS-4Z
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 00:26:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <LYan@suse.com>) id 1jTeH2-0007ew-FD
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 00:26:20 -0400
Received: from m4a0073g.houston.softwaregrp.com ([15.124.2.131]:52283)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <LYan@suse.com>) id 1jTeH1-0007dC-Rr
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 00:24:40 -0400
Received: FROM m4a0073g.houston.softwaregrp.com (15.120.17.146) BY
 m4a0073g.houston.softwaregrp.com WITH ESMTP; 
 Wed, 29 Apr 2020 04:22:23 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 29 Apr 2020 04:22:17 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (15.124.72.12) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 29 Apr 2020 04:22:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1OhYYyFN9dH7Gq7iTe2WtbeZ0llKt7HSd4EA81GHW1UpxXLeEtObAuBVBUY6e2ZBbj7mUEbTgNp4AUpZEFccnAMLGJ68Hwv3FRXH0EBN+RyAvVkYFcy5dV29jQTEdZhwoLk1cL/3bDDnr8Rzv8tCf31Gu1ErqOBkzCUbeCuCy8FkhRn29qJ41lr128It0fGGNW+8AWY6VVKD9lc7N9CmGtfWbGWpocPH47KAUIN49doM4Qrm1B5d/su0ksrjlZmOhftvSubOJi/tKSS2a8fgVm3pxOQK2KhA/iuMxG+5RQvVX0wIDdMSArEer83npVMvSkZ754Kmezal99GTwd4Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HZTYZRNrYAPyVtbel0l5cdHTyJdozf7tFwGf1njEXg=;
 b=c5HZxGDDiNEj8/toLJ9r8x0TauPaRzlcQ2rIataDVJklLGkYR2ILnpCc/WW+lAM0QgfccJvnW+DJKVptf8ka7FL1Ubj8yu2o3HHIxAhltaxpP8opmt1R3ZJIN2o6LkD6tn9dKuapkqaXbEedG5OewKm6FldDhdie2GMTJslnH3xmPd3YcocsF/yEVrEe8Dc41EixiVrS/QqW7qpUxMpt1HZHFkh1Jnhp5h5xALe3gKCg1pIAwlJ2/eV+ZnDHhZQLqBfIrUImgqdxobMfQCdO5Igb6x2A+DOdavL7MqSnM7owaj8Sn0rGJ6LS80HwC/FkUueHm/mBZgbA+Mnq//DJHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: googlegroups.com; dkim=none (message not signed)
 header.d=none;googlegroups.com; dmarc=none action=none header.from=suse.com;
Received: from BYAPR18MB3047.namprd18.prod.outlook.com (2603:10b6:a03:105::32)
 by BYAPR18MB2549.namprd18.prod.outlook.com (2603:10b6:a03:136::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 04:22:16 +0000
Received: from BYAPR18MB3047.namprd18.prod.outlook.com
 ([fe80::2d27:6a4b:3a2f:1ca1]) by BYAPR18MB3047.namprd18.prod.outlook.com
 ([fe80::2d27:6a4b:3a2f:1ca1%4]) with mapi id 15.20.2937.026; Wed, 29 Apr 2020
 04:22:16 +0000
Subject: Re: [RFC][PATCH v2 3/3] contrib: Add server for ivshmem revision 2
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
References: <cover.1578407802.git.jan.kiszka@siemens.com>
 <1acc31a0de7efc9d7c3bc6ca42b985a36e19c28c.1578407802.git.jan.kiszka@siemens.com>
From: Liang Yan <lyan@suse.com>
Autocrypt: addr=lyan@suse.com; prefer-encrypt=mutual; keydata=
 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
 yMQQ+LPXfanS4w==
Message-ID: <b8815297-a535-60d1-64e5-e8f4ee34ebe0@suse.com>
Date: Wed, 29 Apr 2020 00:22:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <1acc31a0de7efc9d7c3bc6ca42b985a36e19c28c.1578407802.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:208:2d::32) To BYAPR18MB3047.namprd18.prod.outlook.com
 (2603:10b6:a03:105::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2605:a000:160e:228::ab4] (2605:a000:160e:228::ab4) by
 BL0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:208:2d::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Wed, 29 Apr 2020 04:22:14 +0000
X-Originating-IP: [2605:a000:160e:228::ab4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03cc74ce-0575-4f68-95c2-08d7ebf4e5cf
X-MS-TrafficTypeDiagnostic: BYAPR18MB2549:
X-Microsoft-Antispam-PRVS: <BYAPR18MB2549A4B34B9DCCEAE61DDE29BFAD0@BYAPR18MB2549.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:204;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR18MB3047.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(6486002)(8936002)(478600001)(54906003)(66476007)(66946007)(110136005)(316002)(66556008)(86362001)(4326008)(186003)(16526019)(2616005)(36756003)(5660300002)(31696002)(30864003)(53546011)(52116002)(966005)(2906002)(31686004)(8676002)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fJC/vj+QMUEDrpaj5upNvpQiMb1CJcN6omTDDrL+iOKsz/jcCJaHWRPCayy2XfGTNHS5ROF64/wWZmoXMeCG+820eWzebBU/x5zMIjTPTe0YOwyvOJS7GpR4ckXKHZmO8pAbvxr/ZENs6jKFkEqzG07Mfc/g8/9W4LVXusn8h+c0YxXnnITaEPVVOpLQbHXgXXoNZTlAFuXeohVHT26YFN9z9IC3MY8AAcm62Lfa4x/+UT1t5fJbvuFN+KDHwOppuPSY4vcm54X1JG3rSTvURP+6G1yZi9T6vcS/jjFyYRrDXW9weuH6hk0KIRMDJgJvdZDq+ymEJ3SSCmqP/lMOka12tkxym68obX/JKBAmj6/nXfHdWex8ja9XqGkb1RVjBAr29ybZMJ/zhjOYzAyawRvqLFipHpJ0ZTiu34yNMJLgtH4+7I0wOvKU5GrUuAUEXimpykC0qTKfFUrgh5rKCK4a9UoUFpRJvI+Zglvbp2AFtAaXrKcwVxsgGej62rTas19zk+uEGDYM5ej1izpx1Ebh4UyQYIHPtRXQGKRt+hL1LPChG9JP996SVXxm18dz
X-MS-Exchange-AntiSpam-MessageData: nJnI1iuwFIe9F3bSyjyW3jObv2L46gVkeI/x7nf4SiLZzoUJIkfsBPdSsbEhb/ruSbtBa2nWtzC/PqsY60FLbyy8v5Ab6DsZOtb1a3we39Qz850t3DqGKNs4D1fSP/l7E7fzLYQP2PJCo9Jo0a9SSUM/WuvGOg7RUfqB96rh6RMGxZTJZvEzvD/RXS+VI80tsEpn9fEu/G+j37+7M4tWMO7MVFY+FkqgassTFq7dEbI3hEF/rG+l6mHHaBc7shsa07h7Tx3ey7eQoL22mB968xeMgLykbEf0277RfSoYau2/2Z85orJyiAHX9/YO7Z06sXOPVhS/Lyn+ACd49pk4ymDfB4BCTZoMHBeISH8ddUcWPPYps39DzBnILII9iEpqr2oCd3udOC2JcmBYilRJxh5Hyup1iIpbUBOQWPmMswYtTaZFHjXPPckcFy3qut7xb9VquBlJej2FF7WO2Xu7G9lEMjvAtXu/mjR2lp4BqA6WTL3DPQSGodGsjPWLUG5c/6zPe9Z3+fym+sn1UmM9JGMUoC7rccK6/5cf/MlHysnB3sVgGXjqIh59gTbvUoFxdWABarQdMNp+1GGHcwVjSlH/+B+CpfX8HRWIekb8cXu/gWR2LVACOghpi5N/xgRhZoudI5OZFDo3bYOqPoDNYfw+QYPr1GlNiOIqlHCI3WoMpzI5eM+s0HGsYkRdBUWzO/4osZwK//cRmM8zD0nTI1hpGq/yOkA9o+pdMuSDbjkHpgx9Yp5IGaYPOBI38AifuoUzPeBrfulkVVrZfOmgUv94tVBevs78+g/XUCcnuJUyZ7Awgp+2fMRyUMermkycSXzcP1AqpHAOFM8INxqsGQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cc74ce-0575-4f68-95c2-08d7ebf4e5cf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 04:22:16.0186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVRvle0iq2H3ht475+br/P1ln3uArh2i5oLddicFAwJRGogDlYE9dGCR7ki3TXtI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2549
X-OriginatorOrg: suse.com
Received-SPF: pass client-ip=15.124.2.131; envelope-from=LYan@suse.com;
 helo=m4a0073g.houston.softwaregrp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:24:28
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 15.124.2.131
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
Cc: Jailhouse <jailhouse-dev@googlegroups.com>,
 Claudio Fontana <claudio.fontana@gmail.com>, "Michael
 S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hannes Reinecke <hare@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A quick check by checkpatch.pl, pretty straightforward to fix.

ERROR: memory barrier without comment
#205: FILE: contrib/ivshmem2-server/ivshmem2-server.c:106:
+    smp_mb();

ERROR: spaces required around that '*' (ctx:VxV)
#753: FILE: contrib/ivshmem2-server/main.c:22:
+#define IVSHMEM_SERVER_DEFAULT_SHM_SIZE       (4*1024*1024)
                                                 ^

ERROR: spaces required around that '*' (ctx:VxV)
#753: FILE: contrib/ivshmem2-server/main.c:22:
+#define IVSHMEM_SERVER_DEFAULT_SHM_SIZE       (4*1024*1024)


Best,
Liang



On 1/7/20 9:36 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This implements the server process for ivshmem v2 device models of QEMU.
> Again, no effort has been spent yet on sharing code with the v1 server.
> Parts have been copied, others were rewritten.
> 
> In addition to parameters of v1, this server now also specifies
> 
>  - the maximum number of peers to be connected (required to know in
>    advance because of v2's state table)
>  - the size of the output sections (can be 0)
>  - the protocol ID to be published to all peers
> 
> When a virtio protocol ID is chosen, only 2 peers can be connected.
> Furthermore, the server will signal the backend variant of the ID to the
> master instance and the frontend ID to the slave peer.
> 
> To start, e.g., a server that allows virtio console over ivshmem, call
> 
> ivshmem2-server -F -l 64K -n 2 -V 3 -P 0x8003
> 
> TODO: specify the new server protocol.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  Makefile                                  |   3 +
>  Makefile.objs                             |   1 +
>  configure                                 |   1 +
>  contrib/ivshmem2-server/Makefile.objs     |   1 +
>  contrib/ivshmem2-server/ivshmem2-server.c | 462 ++++++++++++++++++++++++++++++
>  contrib/ivshmem2-server/ivshmem2-server.h | 158 ++++++++++
>  contrib/ivshmem2-server/main.c            | 313 ++++++++++++++++++++
>  7 files changed, 939 insertions(+)
>  create mode 100644 contrib/ivshmem2-server/Makefile.objs
>  create mode 100644 contrib/ivshmem2-server/ivshmem2-server.c
>  create mode 100644 contrib/ivshmem2-server/ivshmem2-server.h
>  create mode 100644 contrib/ivshmem2-server/main.c
> 
> diff --git a/Makefile b/Makefile
> index 6b5ad1121b..33bb0eefdb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -427,6 +427,7 @@ dummy := $(call unnest-vars,, \
>                  elf2dmp-obj-y \
>                  ivshmem-client-obj-y \
>                  ivshmem-server-obj-y \
> +                ivshmem2-server-obj-y \
>                  rdmacm-mux-obj-y \
>                  libvhost-user-obj-y \
>                  vhost-user-scsi-obj-y \
> @@ -655,6 +656,8 @@ ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
>  	$(call LINK, $^)
>  ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
>  	$(call LINK, $^)
> +ivshmem2-server$(EXESUF): $(ivshmem2-server-obj-y) $(COMMON_LDADDS)
> +	$(call LINK, $^)
>  endif
>  vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y) libvhost-user.a
>  	$(call LINK, $^)
> diff --git a/Makefile.objs b/Makefile.objs
> index 02bf5ce11d..ce243975ef 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -115,6 +115,7 @@ qga-vss-dll-obj-y = qga/
>  elf2dmp-obj-y = contrib/elf2dmp/
>  ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
>  ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
> +ivshmem2-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem2-server/
>  libvhost-user-obj-y = contrib/libvhost-user/
>  vhost-user-scsi.o-cflags := $(LIBISCSI_CFLAGS)
>  vhost-user-scsi.o-libs := $(LIBISCSI_LIBS)
> diff --git a/configure b/configure
> index 747d3b4120..1cb1427f1b 100755
> --- a/configure
> +++ b/configure
> @@ -6165,6 +6165,7 @@ if test "$want_tools" = "yes" ; then
>    fi
>    if [ "$ivshmem" = "yes" ]; then
>      tools="ivshmem-client\$(EXESUF) ivshmem-server\$(EXESUF) $tools"
> +    tools="ivshmem2-server\$(EXESUF) $tools"
>    fi
>    if [ "$curl" = "yes" ]; then
>        tools="elf2dmp\$(EXESUF) $tools"
> diff --git a/contrib/ivshmem2-server/Makefile.objs b/contrib/ivshmem2-server/Makefile.objs
> new file mode 100644
> index 0000000000..d233e18ec8
> --- /dev/null
> +++ b/contrib/ivshmem2-server/Makefile.objs
> @@ -0,0 +1 @@
> +ivshmem2-server-obj-y = ivshmem2-server.o main.o
> diff --git a/contrib/ivshmem2-server/ivshmem2-server.c b/contrib/ivshmem2-server/ivshmem2-server.c
> new file mode 100644
> index 0000000000..b341f1fcd0
> --- /dev/null
> +++ b/contrib/ivshmem2-server/ivshmem2-server.c
> @@ -0,0 +1,462 @@
> +/*
> + * Copyright 6WIND S.A., 2014
> + * Copyright (c) Siemens AG, 2019
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/host-utils.h"
> +#include "qemu/sockets.h"
> +#include "qemu/atomic.h"
> +
> +#include <sys/socket.h>
> +#include <sys/un.h>
> +
> +#include "ivshmem2-server.h"
> +
> +/* log a message on stdout if verbose=1 */
> +#define IVSHMEM_SERVER_DEBUG(server, fmt, ...) do { \
> +        if ((server)->args.verbose) {         \
> +            printf(fmt, ## __VA_ARGS__); \
> +        }                                \
> +    } while (0)
> +
> +/** maximum size of a huge page, used by ivshmem_server_ftruncate() */
> +#define IVSHMEM_SERVER_MAX_HUGEPAGE_SIZE (1024 * 1024 * 1024)
> +
> +/** default listen backlog (number of sockets not accepted) */
> +#define IVSHMEM_SERVER_LISTEN_BACKLOG 10
> +
> +/* send message to a client unix socket */
> +static int ivshmem_server_send_msg(int sock_fd, void *payload, int len, int fd)
> +{
> +    int ret;
> +    struct msghdr msg;
> +    struct iovec iov[1];
> +    union {
> +        struct cmsghdr cmsg;
> +        char control[CMSG_SPACE(sizeof(int))];
> +    } msg_control;
> +    struct cmsghdr *cmsg;
> +
> +    iov[0].iov_base = payload;
> +    iov[0].iov_len = len;
> +
> +    memset(&msg, 0, sizeof(msg));
> +    msg.msg_iov = iov;
> +    msg.msg_iovlen = 1;
> +
> +    /* if fd is specified, add it in a cmsg */
> +    if (fd >= 0) {
> +        memset(&msg_control, 0, sizeof(msg_control));
> +        msg.msg_control = &msg_control;
> +        msg.msg_controllen = sizeof(msg_control);
> +        cmsg = CMSG_FIRSTHDR(&msg);
> +        cmsg->cmsg_level = SOL_SOCKET;
> +        cmsg->cmsg_type = SCM_RIGHTS;
> +        cmsg->cmsg_len = CMSG_LEN(sizeof(int));
> +        memcpy(CMSG_DATA(cmsg), &fd, sizeof(fd));
> +    }
> +
> +    ret = sendmsg(sock_fd, &msg, 0);
> +    if (ret <= 0) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int ivshmem_server_send_event_fd(int sock_fd, int peer_id, int vector,
> +                                        int fd)
> +{
> +    IvshmemEventFd msg = {
> +        .header = {
> +            .type = GUINT32_TO_LE(IVSHMEM_MSG_EVENT_FD),
> +            .len = GUINT32_TO_LE(sizeof(msg)),
> +        },
> +        .id = GUINT32_TO_LE(peer_id),
> +        .vector = GUINT32_TO_LE(vector),
> +    };
> +
> +    return ivshmem_server_send_msg(sock_fd, &msg, sizeof(msg), fd);
> +}
> +
> +/* free a peer when the server advertises a disconnection or when the
> + * server is freed */
> +static void
> +ivshmem_server_free_peer(IvshmemServer *server, IvshmemServerPeer *peer)
> +{
> +    unsigned vector;
> +    IvshmemServerPeer *other_peer;
> +    IvshmemPeerGone msg = {
> +        .header = {
> +            .type = GUINT32_TO_LE(IVSHMEM_MSG_PEER_GONE),
> +            .len = GUINT32_TO_LE(sizeof(msg)),
> +        },
> +        .id = GUINT32_TO_LE(peer->id),
> +    };
> +
> +    IVSHMEM_SERVER_DEBUG(server, "free peer %" PRId64 "\n", peer->id);
> +    close(peer->sock_fd);
> +    QTAILQ_REMOVE(&server->peer_list, peer, next);
> +
> +    server->state_table[peer->id] = 0;
> +    smp_mb();
> +
> +    /* advertise the deletion to other peers */
> +    QTAILQ_FOREACH(other_peer, &server->peer_list, next) {
> +        ivshmem_server_send_msg(other_peer->sock_fd, &msg, sizeof(msg), -1);
> +    }
> +
> +    for (vector = 0; vector < peer->vectors_count; vector++) {
> +        event_notifier_cleanup(&peer->vectors[vector]);
> +    }
> +
> +    g_free(peer);
> +}
> +
> +/* send the peer id and the shm_fd just after a new client connection */
> +static int
> +ivshmem_server_send_initial_info(IvshmemServer *server, IvshmemServerPeer *peer)
> +{
> +    IvshmemInitialInfo msg = {
> +        .header = {
> +            .type = GUINT32_TO_LE(IVSHMEM_MSG_INIT),
> +            .len = GUINT32_TO_LE(sizeof(msg)),
> +        },
> +        .version = GUINT32_TO_LE(IVSHMEM_PROTOCOL_VERSION),
> +        .compatible_version = GUINT32_TO_LE(IVSHMEM_PROTOCOL_VERSION),
> +        .id = GUINT32_TO_LE(peer->id),
> +        .max_peers = GUINT32_TO_LE(server->args.max_peers),
> +        .vectors = GUINT32_TO_LE(server->args.vectors),
> +        .protocol = GUINT32_TO_LE(server->args.protocol),
> +        .output_section_size = GUINT64_TO_LE(server->args.output_section_size),
> +    };
> +    unsigned virtio_protocol;
> +    int ret;
> +
> +    if (server->args.protocol >= 0x8000) {
> +        virtio_protocol = server->args.protocol & ~0x4000;
> +        msg.protocol &= ~0x4000;
> +        if (peer->id == 0) {
> +            virtio_protocol |= 0x4000;
> +        }
> +        msg.protocol = GUINT32_TO_LE(virtio_protocol);
> +    }
> +
> +    ret = ivshmem_server_send_msg(peer->sock_fd, &msg, sizeof(msg),
> +                                  server->shm_fd);
> +    if (ret < 0) {
> +        IVSHMEM_SERVER_DEBUG(server, "cannot send initial info: %s\n",
> +                             strerror(errno));
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +/* handle message on listening unix socket (new client connection) */
> +static int
> +ivshmem_server_handle_new_conn(IvshmemServer *server)
> +{
> +    IvshmemServerPeer *peer, *other_peer;
> +    struct sockaddr_un unaddr;
> +    socklen_t unaddr_len;
> +    int newfd;
> +    unsigned i;
> +
> +    /* accept the incoming connection */
> +    unaddr_len = sizeof(unaddr);
> +    newfd = qemu_accept(server->sock_fd,
> +                        (struct sockaddr *)&unaddr, &unaddr_len);
> +
> +    if (newfd < 0) {
> +        IVSHMEM_SERVER_DEBUG(server, "cannot accept() %s\n", strerror(errno));
> +        return -1;
> +    }
> +
> +    qemu_set_nonblock(newfd);
> +    IVSHMEM_SERVER_DEBUG(server, "accept()=%d\n", newfd);
> +
> +    /* allocate new structure for this peer */
> +    peer = g_malloc0(sizeof(*peer));
> +    peer->sock_fd = newfd;
> +
> +    /* get an unused peer id */
> +    /* XXX: this could use id allocation such as Linux IDA, or simply
> +     * a free-list */
> +    for (i = 0; i < G_MAXUINT16; i++) {
> +        if (ivshmem_server_search_peer(server, i) == NULL) {
> +            break;
> +        }
> +    }
> +    if (i >= server->args.max_peers) {
> +        IVSHMEM_SERVER_DEBUG(server, "cannot allocate new client id\n");
> +        close(newfd);
> +        g_free(peer);
> +        return -1;
> +    }
> +    peer->id = i;
> +
> +    /* create eventfd, one per vector */
> +    peer->vectors_count = server->args.vectors;
> +    for (i = 0; i < peer->vectors_count; i++) {
> +        if (event_notifier_init(&peer->vectors[i], FALSE) < 0) {
> +            IVSHMEM_SERVER_DEBUG(server, "cannot create eventfd\n");
> +            goto fail;
> +        }
> +    }
> +
> +    /* send peer id and shm fd */
> +    if (ivshmem_server_send_initial_info(server, peer) < 0) {
> +        IVSHMEM_SERVER_DEBUG(server, "cannot send initial info\n");
> +        goto fail;
> +    }
> +
> +    /* advertise the new peer to others */
> +    QTAILQ_FOREACH(other_peer, &server->peer_list, next) {
> +        for (i = 0; i < peer->vectors_count; i++) {
> +            ivshmem_server_send_event_fd(other_peer->sock_fd, peer->id, i,
> +                                         peer->vectors[i].wfd);
> +        }
> +    }
> +
> +    /* advertise the other peers to the new one */
> +    QTAILQ_FOREACH(other_peer, &server->peer_list, next) {
> +        for (i = 0; i < peer->vectors_count; i++) {
> +            ivshmem_server_send_event_fd(peer->sock_fd, other_peer->id, i,
> +                                         other_peer->vectors[i].wfd);
> +        }
> +    }
> +
> +    /* advertise the new peer to itself */
> +    for (i = 0; i < peer->vectors_count; i++) {
> +        ivshmem_server_send_event_fd(peer->sock_fd, peer->id, i,
> +                                     event_notifier_get_fd(&peer->vectors[i]));
> +    }
> +
> +    QTAILQ_INSERT_TAIL(&server->peer_list, peer, next);
> +    IVSHMEM_SERVER_DEBUG(server, "new peer id = %" PRId64 "\n",
> +                         peer->id);
> +    return 0;
> +
> +fail:
> +    while (i--) {
> +        event_notifier_cleanup(&peer->vectors[i]);
> +    }
> +    close(newfd);
> +    g_free(peer);
> +    return -1;
> +}
> +
> +/* Try to ftruncate a file to next power of 2 of shmsize.
> + * If it fails; all power of 2 above shmsize are tested until
> + * we reach the maximum huge page size. This is useful
> + * if the shm file is in a hugetlbfs that cannot be truncated to the
> + * shm_size value. */
> +static int
> +ivshmem_server_ftruncate(int fd, unsigned shmsize)
> +{
> +    int ret;
> +    struct stat mapstat;
> +
> +    /* align shmsize to next power of 2 */
> +    shmsize = pow2ceil(shmsize);
> +
> +    if (fstat(fd, &mapstat) != -1 && mapstat.st_size == shmsize) {
> +        return 0;
> +    }
> +
> +    while (shmsize <= IVSHMEM_SERVER_MAX_HUGEPAGE_SIZE) {
> +        ret = ftruncate(fd, shmsize);
> +        if (ret == 0) {
> +            return ret;
> +        }
> +        shmsize *= 2;
> +    }
> +
> +    return -1;
> +}
> +
> +/* Init a new ivshmem server */
> +void ivshmem_server_init(IvshmemServer *server)
> +{
> +    server->sock_fd = -1;
> +    server->shm_fd = -1;
> +    server->state_table = NULL;
> +    QTAILQ_INIT(&server->peer_list);
> +}
> +
> +/* open shm, create and bind to the unix socket */
> +int
> +ivshmem_server_start(IvshmemServer *server)
> +{
> +    struct sockaddr_un sun;
> +    int shm_fd, sock_fd, ret;
> +    void *state_table;
> +
> +    /* open shm file */
> +    if (server->args.use_shm_open) {
> +        IVSHMEM_SERVER_DEBUG(server, "Using POSIX shared memory: %s\n",
> +                             server->args.shm_path);
> +        shm_fd = shm_open(server->args.shm_path, O_CREAT | O_RDWR, S_IRWXU);
> +    } else {
> +        gchar *filename = g_strdup_printf("%s/ivshmem.XXXXXX",
> +                                          server->args.shm_path);
> +        IVSHMEM_SERVER_DEBUG(server, "Using file-backed shared memory: %s\n",
> +                             server->args.shm_path);
> +        shm_fd = mkstemp(filename);
> +        unlink(filename);
> +        g_free(filename);
> +    }
> +
> +    if (shm_fd < 0) {
> +        fprintf(stderr, "cannot open shm file %s: %s\n", server->args.shm_path,
> +                strerror(errno));
> +        return -1;
> +    }
> +    if (ivshmem_server_ftruncate(shm_fd, server->args.shm_size) < 0) {
> +        fprintf(stderr, "ftruncate(%s) failed: %s\n", server->args.shm_path,
> +                strerror(errno));
> +        goto err_close_shm;
> +    }
> +    state_table = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED,
> +                       shm_fd, 0);
> +    if (state_table == MAP_FAILED) {
> +        fprintf(stderr, "mmap failed: %s\n", strerror(errno));
> +        goto err_close_shm;
> +    }
> +
> +    IVSHMEM_SERVER_DEBUG(server, "create & bind socket %s\n",
> +                         server->args.unix_socket_path);
> +
> +    /* create the unix listening socket */
> +    sock_fd = socket(AF_UNIX, SOCK_STREAM, 0);
> +    if (sock_fd < 0) {
> +        IVSHMEM_SERVER_DEBUG(server, "cannot create socket: %s\n",
> +                             strerror(errno));
> +        goto err_unmap;
> +    }
> +
> +    sun.sun_family = AF_UNIX;
> +    ret = snprintf(sun.sun_path, sizeof(sun.sun_path), "%s",
> +                   server->args.unix_socket_path);
> +    if (ret < 0 || ret >= sizeof(sun.sun_path)) {
> +        IVSHMEM_SERVER_DEBUG(server, "could not copy unix socket path\n");
> +        goto err_close_sock;
> +    }
> +    if (bind(sock_fd, (struct sockaddr *)&sun, sizeof(sun)) < 0) {
> +        IVSHMEM_SERVER_DEBUG(server, "cannot connect to %s: %s\n", sun.sun_path,
> +                             strerror(errno));
> +        goto err_close_sock;
> +    }
> +
> +    if (listen(sock_fd, IVSHMEM_SERVER_LISTEN_BACKLOG) < 0) {
> +        IVSHMEM_SERVER_DEBUG(server, "listen() failed: %s\n", strerror(errno));
> +        goto err_close_sock;
> +    }
> +
> +    server->sock_fd = sock_fd;
> +    server->shm_fd = shm_fd;
> +    server->state_table = state_table;
> +
> +    return 0;
> +
> +err_close_sock:
> +    close(sock_fd);
> +err_unmap:
> +    munmap(state_table, 4096);
> +err_close_shm:
> +    if (server->args.use_shm_open) {
> +        shm_unlink(server->args.shm_path);
> +    }
> +    close(shm_fd);
> +    shm_unlink(server->args.shm_path);
> +    return -1;
> +}
> +
> +/* close connections to clients, the unix socket and the shm fd */
> +void
> +ivshmem_server_close(IvshmemServer *server)
> +{
> +    IvshmemServerPeer *peer, *npeer;
> +
> +    IVSHMEM_SERVER_DEBUG(server, "close server\n");
> +
> +    QTAILQ_FOREACH_SAFE(peer, &server->peer_list, next, npeer) {
> +        ivshmem_server_free_peer(server, peer);
> +    }
> +
> +    unlink(server->args.unix_socket_path);
> +    if (server->args.use_shm_open) {
> +        shm_unlink(server->args.shm_path);
> +    }
> +    close(server->sock_fd);
> +    munmap(server->state_table, 4096);
> +    close(server->shm_fd);
> +    server->sock_fd = -1;
> +    server->shm_fd = -1;
> +}
> +
> +/* get the fd_set according to the unix socket and the peer list */
> +void
> +ivshmem_server_get_fds(const IvshmemServer *server, fd_set *fds, int *maxfd)
> +{
> +    IvshmemServerPeer *peer;
> +
> +    if (server->sock_fd == -1) {
> +        return;
> +    }
> +
> +    FD_SET(server->sock_fd, fds);
> +    if (server->sock_fd >= *maxfd) {
> +        *maxfd = server->sock_fd + 1;
> +    }
> +
> +    QTAILQ_FOREACH(peer, &server->peer_list, next) {
> +        FD_SET(peer->sock_fd, fds);
> +        if (peer->sock_fd >= *maxfd) {
> +            *maxfd = peer->sock_fd + 1;
> +        }
> +    }
> +}
> +
> +/* process incoming messages on the sockets in fd_set */
> +int
> +ivshmem_server_handle_fds(IvshmemServer *server, fd_set *fds, int maxfd)
> +{
> +    IvshmemServerPeer *peer, *peer_next;
> +
> +    if (server->sock_fd < maxfd && FD_ISSET(server->sock_fd, fds) &&
> +        ivshmem_server_handle_new_conn(server) < 0 && errno != EINTR) {
> +        IVSHMEM_SERVER_DEBUG(server, "ivshmem_server_handle_new_conn() "
> +                             "failed\n");
> +        return -1;
> +    }
> +
> +    QTAILQ_FOREACH_SAFE(peer, &server->peer_list, next, peer_next) {
> +        /* any message from a peer socket result in a close() */
> +        IVSHMEM_SERVER_DEBUG(server, "peer->sock_fd=%d\n", peer->sock_fd);
> +        if (peer->sock_fd < maxfd && FD_ISSET(peer->sock_fd, fds)) {
> +            ivshmem_server_free_peer(server, peer);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +/* lookup peer from its id */
> +IvshmemServerPeer *
> +ivshmem_server_search_peer(IvshmemServer *server, int64_t peer_id)
> +{
> +    IvshmemServerPeer *peer;
> +
> +    QTAILQ_FOREACH(peer, &server->peer_list, next) {
> +        if (peer->id == peer_id) {
> +            return peer;
> +        }
> +    }
> +    return NULL;
> +}
> diff --git a/contrib/ivshmem2-server/ivshmem2-server.h b/contrib/ivshmem2-server/ivshmem2-server.h
> new file mode 100644
> index 0000000000..3fd6166577
> --- /dev/null
> +++ b/contrib/ivshmem2-server/ivshmem2-server.h
> @@ -0,0 +1,158 @@
> +/*
> + * Copyright 6WIND S.A., 2014
> + * Copyright (c) Siemens AG, 2019
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +
> +#ifndef IVSHMEM2_SERVER_H
> +#define IVSHMEM2_SERVER_H
> +
> +/**
> + * The ivshmem server is a daemon that creates a unix socket in listen
> + * mode. The ivshmem clients (qemu or ivshmem-client) connect to this
> + * unix socket. For each client, the server will create some eventfd
> + * (see EVENTFD(2)), one per vector. These fd are transmitted to all
> + * clients using the SCM_RIGHTS cmsg message. Therefore, each client is
> + * able to send a notification to another client without being
> + * "profixied" by the server.
> + *
> + * We use this mechanism to send interruptions between guests.
> + * qemu is able to transform an event on a eventfd into a PCI MSI-x
> + * interruption in the guest.
> + *
> + * The ivshmem server is also able to share the file descriptor
> + * associated to the ivshmem shared memory.
> + */
> +
> +#include <sys/select.h>
> +
> +#include "qemu/event_notifier.h"
> +#include "qemu/queue.h"
> +#include "hw/misc/ivshmem2.h"
> +
> +/**
> + * Maximum number of notification vectors supported by the server
> + */
> +#define IVSHMEM_SERVER_MAX_VECTORS 64
> +
> +/**
> + * Structure storing a peer
> + *
> + * Each time a client connects to an ivshmem server, a new
> + * IvshmemServerPeer structure is created. This peer and all its
> + * vectors are advertised to all connected clients through the connected
> + * unix sockets.
> + */
> +typedef struct IvshmemServerPeer {
> +    QTAILQ_ENTRY(IvshmemServerPeer) next;    /**< next in list*/
> +    int sock_fd;                             /**< connected unix sock */
> +    int64_t id;                              /**< the id of the peer */
> +    EventNotifier vectors[IVSHMEM_SERVER_MAX_VECTORS]; /**< one per vector */
> +    unsigned vectors_count;                  /**< number of vectors */
> +} IvshmemServerPeer;
> +
> +/**
> + * Structure describing ivshmem server arguments
> + */
> +typedef struct IvshmemServerArgs {
> +    bool verbose;                   /**< true to enable verbose mode */
> +    const char *unix_socket_path;   /**< pointer to unix socket file name */
> +    const char *shm_path;           /**< Path to the shared memory; path
> +                                         corresponds to a POSIX shm name or a
> +                                         hugetlbfs mount point. */
> +    bool use_shm_open;              /**< true to use shm_open, false for
> +                                         file-backed shared memory */
> +    uint64_t shm_size;              /**< total size of shared memory */
> +    uint64_t output_section_size;   /**< size of each output section */
> +    unsigned max_peers;             /**< maximum number of peers */
> +    unsigned vectors;               /**< interrupt vectors per client */
> +    unsigned protocol;              /**< protocol advertised to all clients */
> +} IvshmemServerArgs;
> +
> +/**
> + * Structure describing an ivshmem server
> + *
> + * This structure stores all information related to our server: the name
> + * of the server unix socket and the list of connected peers.
> + */
> +typedef struct IvshmemServer {
> +    IvshmemServerArgs args;          /**< server arguments */
> +    int sock_fd;                     /**< unix sock file descriptor */
> +    int shm_fd;                      /**< shm file descriptor */
> +    uint32_t *state_table;           /**< mapped state table */
> +    QTAILQ_HEAD(, IvshmemServerPeer) peer_list; /**< list of peers */
> +} IvshmemServer;
> +
> +/**
> + * Initialize an ivshmem server
> + *
> + * @server:         A pointer to an uninitialized IvshmemServer structure
> + */
> +void ivshmem_server_init(IvshmemServer *server);
> +
> +/**
> + * Open the shm, then create and bind to the unix socket
> + *
> + * @server: The pointer to the initialized IvshmemServer structure
> + *
> + * Returns: 0 on success, or a negative value on error
> + */
> +int ivshmem_server_start(IvshmemServer *server);
> +
> +/**
> + * Close the server
> + *
> + * Close connections to all clients, close the unix socket and the
> + * shared memory file descriptor. The structure remains initialized, so
> + * it is possible to call ivshmem_server_start() again after a call to
> + * ivshmem_server_close().
> + *
> + * @server: The ivshmem server
> + */
> +void ivshmem_server_close(IvshmemServer *server);
> +
> +/**
> + * Fill a fd_set with file descriptors to be monitored
> + *
> + * This function will fill a fd_set with all file descriptors that must
> + * be polled (unix server socket and peers unix socket). The function
> + * will not initialize the fd_set, it is up to the caller to do it.
> + *
> + * @server: The ivshmem server
> + * @fds:    The fd_set to be updated
> + * @maxfd:  Must be set to the max file descriptor + 1 in fd_set. This value is
> + *          updated if this function adds a greater fd in fd_set.
> + */
> +void
> +ivshmem_server_get_fds(const IvshmemServer *server, fd_set *fds, int *maxfd);
> +
> +/**
> + * Read and handle new messages
> + *
> + * Given a fd_set (for instance filled by a call to select()), handle
> + * incoming messages from peers.
> + *
> + * @server: The ivshmem server
> + * @fds:    The fd_set containing the file descriptors to be checked. Note that
> + *          file descriptors that are not related to our server are ignored.
> + * @maxfd:  The maximum fd in fd_set, plus one.
> + *
> + * Returns: 0 on success, or a negative value on error
> + */
> +int ivshmem_server_handle_fds(IvshmemServer *server, fd_set *fds, int maxfd);
> +
> +/**
> + * Search a peer from its identifier
> + *
> + * @server:  The ivshmem server
> + * @peer_id: The identifier of the peer structure
> + *
> + * Returns:  The peer structure, or NULL if not found
> + */
> +IvshmemServerPeer *
> +ivshmem_server_search_peer(IvshmemServer *server, int64_t peer_id);
> +
> +#endif /* IVSHMEM2_SERVER_H */
> diff --git a/contrib/ivshmem2-server/main.c b/contrib/ivshmem2-server/main.c
> new file mode 100644
> index 0000000000..35cd6fca0f
> --- /dev/null
> +++ b/contrib/ivshmem2-server/main.c
> @@ -0,0 +1,313 @@
> +/*
> + * Copyright 6WIND S.A., 2014
> + * Copyright (c) Siemens AG, 2019
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/cutils.h"
> +#include "qemu/option.h"
> +#include "ivshmem2-server.h"
> +
> +#define IVSHMEM_SERVER_DEFAULT_FOREGROUND     0
> +#define IVSHMEM_SERVER_DEFAULT_PID_FILE       "/var/run/ivshmem-server.pid"
> +
> +#define IVSHMEM_SERVER_DEFAULT_VERBOSE        0
> +#define IVSHMEM_SERVER_DEFAULT_UNIX_SOCK_PATH "/tmp/ivshmem_socket"
> +#define IVSHMEM_SERVER_DEFAULT_SHM_PATH       "ivshmem"
> +#define IVSHMEM_SERVER_DEFAULT_SHM_SIZE       (4*1024*1024)
> +#define IVSHMEM_SERVER_DEFAULT_OUTPUT_SEC_SZ  0
> +#define IVSHMEM_SERVER_DEFAULT_MAX_PEERS      2
> +#define IVSHMEM_SERVER_DEFAULT_VECTORS        1
> +#define IVSHMEM_SERVER_DEFAULT_PROTOCOL       0
> +
> +/* used to quit on signal SIGTERM */
> +static int ivshmem_server_quit;
> +
> +static bool foreground = IVSHMEM_SERVER_DEFAULT_FOREGROUND;
> +static const char *pid_file = IVSHMEM_SERVER_DEFAULT_PID_FILE;
> +
> +static void
> +ivshmem_server_usage(const char *progname)
> +{
> +    printf("Usage: %s [OPTION]...\n"
> +           "  -h: show this help\n"
> +           "  -v: verbose mode\n"
> +           "  -F: foreground mode (default is to daemonize)\n"
> +           "  -p <pid-file>: path to the PID file (used in daemon mode only)\n"
> +           "     default " IVSHMEM_SERVER_DEFAULT_PID_FILE "\n"
> +           "  -S <unix-socket-path>: path to the unix socket to listen to\n"
> +           "     default " IVSHMEM_SERVER_DEFAULT_UNIX_SOCK_PATH "\n"
> +           "  -M <shm-name>: POSIX shared memory object to use\n"
> +           "     default " IVSHMEM_SERVER_DEFAULT_SHM_PATH "\n"
> +           "  -m <dir-name>: where to create shared memory\n"
> +           "  -l <size>: size of shared memory in bytes\n"
> +           "     suffixes K, M and G can be used, e.g. 1K means 1024\n"
> +           "     default %u\n"
> +           "  -o <size>: size of each output section in bytes "
> +                "(suffixes supported)\n"
> +           "     default %u\n"
> +           "  -n <peers>: maximum number of peers\n"
> +           "     default %u\n"
> +           "  -V <vectors>: number of vectors\n"
> +           "     default %u\n"
> +           "  -P <protocol>: 16-bit protocol to be advertised\n"
> +           "     default 0x%04x\n"
> +           "     When using virtio (0x8000...0xffff), only two peers are "
> +           "supported, peer 0\n"
> +           "     will become backend, peer 1 frontend\n",
> +           progname, IVSHMEM_SERVER_DEFAULT_SHM_SIZE,
> +           IVSHMEM_SERVER_DEFAULT_OUTPUT_SEC_SZ,
> +           IVSHMEM_SERVER_DEFAULT_MAX_PEERS, IVSHMEM_SERVER_DEFAULT_VECTORS,
> +           IVSHMEM_SERVER_DEFAULT_PROTOCOL);
> +}
> +
> +static void
> +ivshmem_server_help(const char *progname)
> +{
> +    fprintf(stderr, "Try '%s -h' for more information.\n", progname);
> +}
> +
> +/* parse the program arguments, exit on error */
> +static void
> +ivshmem_server_parse_args(IvshmemServerArgs *args, int argc, char *argv[])
> +{
> +    int c;
> +    unsigned long long v;
> +    Error *err = NULL;
> +
> +    while ((c = getopt(argc, argv, "hvFp:S:m:M:l:o:n:V:P:")) != -1) {
> +
> +        switch (c) {
> +        case 'h': /* help */
> +            ivshmem_server_usage(argv[0]);
> +            exit(0);
> +            break;
> +
> +        case 'v': /* verbose */
> +            args->verbose = 1;
> +            break;
> +
> +        case 'F': /* foreground */
> +            foreground = 1;
> +            break;
> +
> +        case 'p': /* pid file */
> +            pid_file = optarg;
> +            break;
> +
> +        case 'S': /* unix socket path */
> +            args->unix_socket_path = optarg;
> +            break;
> +
> +        case 'M': /* shm name */
> +        case 'm': /* dir name */
> +            args->shm_path = optarg;
> +            args->use_shm_open = c == 'M';
> +            break;
> +
> +        case 'l': /* shm size */
> +            parse_option_size("shm_size", optarg, &args->shm_size, &err);
> +            if (err) {
> +                error_report_err(err);
> +                ivshmem_server_help(argv[0]);
> +                exit(1);
> +            }
> +            break;
> +
> +        case 'o': /* output section size */
> +            parse_option_size("output_section_size", optarg,
> +                              &args->output_section_size, &err);
> +            if (err) {
> +                error_report_err(err);
> +                ivshmem_server_help(argv[0]);
> +                exit(1);
> +            }
> +            break;
> +
> +        case 'n': /* maximum number of peers */
> +            if (parse_uint_full(optarg, &v, 0) < 0) {
> +                fprintf(stderr, "cannot parse max-peers\n");
> +                ivshmem_server_help(argv[0]);
> +                exit(1);
> +            }
> +            args->max_peers = v;
> +            break;
> +
> +        case 'V': /* number of vectors */
> +            if (parse_uint_full(optarg, &v, 0) < 0) {
> +                fprintf(stderr, "cannot parse vectors\n");
> +                ivshmem_server_help(argv[0]);
> +                exit(1);
> +            }
> +            args->vectors = v;
> +            break;
> +
> +        case 'P': /* protocol */
> +            if (parse_uint_full(optarg, &v, 0) < 0) {
> +                fprintf(stderr, "cannot parse protocol\n");
> +                ivshmem_server_help(argv[0]);
> +                exit(1);
> +            }
> +            args->protocol = v;
> +            break;
> +
> +        default:
> +            ivshmem_server_usage(argv[0]);
> +            exit(1);
> +            break;
> +        }
> +    }
> +
> +    if (args->vectors > IVSHMEM_SERVER_MAX_VECTORS) {
> +        fprintf(stderr, "too many requested vectors (max is %d)\n",
> +                IVSHMEM_SERVER_MAX_VECTORS);
> +        ivshmem_server_help(argv[0]);
> +        exit(1);
> +    }
> +
> +    if (args->protocol >= 0x8000 && args->max_peers > 2) {
> +        fprintf(stderr, "virtio protocols only support 2 peers\n");
> +        ivshmem_server_help(argv[0]);
> +        exit(1);
> +    }
> +
> +    if (args->verbose == 1 && foreground == 0) {
> +        fprintf(stderr, "cannot use verbose in daemon mode\n");
> +        ivshmem_server_help(argv[0]);
> +        exit(1);
> +    }
> +}
> +
> +/* wait for events on listening server unix socket and connected client
> + * sockets */
> +static int
> +ivshmem_server_poll_events(IvshmemServer *server)
> +{
> +    fd_set fds;
> +    int ret = 0, maxfd;
> +
> +    while (!ivshmem_server_quit) {
> +
> +        FD_ZERO(&fds);
> +        maxfd = 0;
> +        ivshmem_server_get_fds(server, &fds, &maxfd);
> +
> +        ret = select(maxfd, &fds, NULL, NULL, NULL);
> +
> +        if (ret < 0) {
> +            if (errno == EINTR) {
> +                continue;
> +            }
> +
> +            fprintf(stderr, "select error: %s\n", strerror(errno));
> +            break;
> +        }
> +        if (ret == 0) {
> +            continue;
> +        }
> +
> +        if (ivshmem_server_handle_fds(server, &fds, maxfd) < 0) {
> +            fprintf(stderr, "ivshmem_server_handle_fds() failed\n");
> +            break;
> +        }
> +    }
> +
> +    return ret;
> +}
> +
> +static void
> +ivshmem_server_quit_cb(int signum)
> +{
> +    ivshmem_server_quit = 1;
> +}
> +
> +int
> +main(int argc, char *argv[])
> +{
> +    IvshmemServer server = {
> +        .args = {
> +            .verbose = IVSHMEM_SERVER_DEFAULT_VERBOSE,
> +            .unix_socket_path = IVSHMEM_SERVER_DEFAULT_UNIX_SOCK_PATH,
> +            .shm_path = IVSHMEM_SERVER_DEFAULT_SHM_PATH,
> +            .use_shm_open = true,
> +            .shm_size = IVSHMEM_SERVER_DEFAULT_SHM_SIZE,
> +            .output_section_size = IVSHMEM_SERVER_DEFAULT_OUTPUT_SEC_SZ,
> +            .max_peers = IVSHMEM_SERVER_DEFAULT_MAX_PEERS,
> +            .vectors = IVSHMEM_SERVER_DEFAULT_VECTORS,
> +            .protocol = IVSHMEM_SERVER_DEFAULT_PROTOCOL,
> +        },
> +    };
> +    struct sigaction sa, sa_quit;
> +    int ret = 1;
> +
> +    /*
> +     * Do not remove this notice without adding proper error handling!
> +     * Start with handling ivshmem_server_send_one_msg() failure.
> +     */
> +    printf("*** Example code, do not use in production ***\n");
> +
> +    /* parse arguments, will exit on error */
> +    ivshmem_server_parse_args(&server.args, argc, argv);
> +
> +    /* Ignore SIGPIPE, see this link for more info:
> +     * http://www.mail-archive.com/libevent-users@monkey.org/msg01606.html */
> +    sa.sa_handler = SIG_IGN;
> +    sa.sa_flags = 0;
> +    if (sigemptyset(&sa.sa_mask) == -1 ||
> +        sigaction(SIGPIPE, &sa, 0) == -1) {
> +        perror("failed to ignore SIGPIPE; sigaction");
> +        goto err;
> +    }
> +
> +    sa_quit.sa_handler = ivshmem_server_quit_cb;
> +    sa_quit.sa_flags = 0;
> +    if (sigemptyset(&sa_quit.sa_mask) == -1 ||
> +        sigaction(SIGTERM, &sa_quit, 0) == -1 ||
> +        sigaction(SIGINT, &sa_quit, 0) == -1) {
> +        perror("failed to add signal handler; sigaction");
> +        goto err;
> +    }
> +
> +    /* init the ivshms structure */
> +    ivshmem_server_init(&server);
> +
> +    /* start the ivshmem server (open shm & unix socket) */
> +    if (ivshmem_server_start(&server) < 0) {
> +        fprintf(stderr, "cannot bind\n");
> +        goto err;
> +    }
> +
> +    /* daemonize if asked to */
> +    if (!foreground) {
> +        FILE *fp;
> +
> +        if (qemu_daemon(1, 1) < 0) {
> +            fprintf(stderr, "cannot daemonize: %s\n", strerror(errno));
> +            goto err_close;
> +        }
> +
> +        /* write pid file */
> +        fp = fopen(pid_file, "w");
> +        if (fp == NULL) {
> +            fprintf(stderr, "cannot write pid file: %s\n", strerror(errno));
> +            goto err_close;
> +        }
> +
> +        fprintf(fp, "%d\n", (int) getpid());
> +        fclose(fp);
> +    }
> +
> +    ivshmem_server_poll_events(&server);
> +    fprintf(stdout, "server disconnected\n");
> +    ret = 0;
> +
> +err_close:
> +    ivshmem_server_close(&server);
> +err:
> +    return ret;
> +}
> 


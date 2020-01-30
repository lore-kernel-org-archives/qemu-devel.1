Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063EDC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4513206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eO9gpqJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4513206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix95I-0003It-Qe
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 07:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ix94I-0001aB-CF
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:37:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ix94F-0007GR-LW
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:37:09 -0500
Received: from mail-eopbgr50109.outbound.protection.outlook.com
 ([40.107.5.109]:39650 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ix94A-00073X-92; Thu, 30 Jan 2020 07:37:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkLRJNyEcEvz6cQBPpjG2t3G9ijsnHP+AYQPXiZx9zZ/P1rrEOSMbMI4FnAEENIB6uBkRPojpaOlEq4qwPk4nGt2XQyKwqLa2O97WtM2wyDAcpXPsM8gN77fcjpVJYsN3cCMGL4X3ePdimPIPfOjaAuctmHKf+EsFU7NNr43xU7g1/SftgYBqqoPo3eoR7+F7fzmyV5VbgSvhVFCLe1V7YdGqxg2jBeRrTFe6jW4crsn0CN5YUe1esMAUiEHrv6l7ReHdYlG7PMaa2dR9z8YQ0mcLaAMPNmXAppr5vsdinM1KqXGlrMSFN008cHRPVVNEpBYZ5w9P4k0umakr8koLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TASeDtrRQB4DG+rVrEMe/FHM4VsQd3A4+c/ktE0VF6A=;
 b=RvEoaLxl8HNIgVJBhKblQQhPerZC8Uu6KOkK29nI1CAocn11guHO6ZdTnpciH8h9faCu0GVEfo9l/siUUeK278udUMi1ggjhRVQKLIRlrkRsqDYBTH281mZbqNKlNOkvodPifaUJYeIhRLC1nyYnUKBsgzq6lx0EZIwHLE6kMqxzT9OxcxzrBs7cTQpzLosZwz46eqv0T4sHwq6pIqp/RCy7Sb3fWTXs95aoV9fkwG+hssA7fFY39JoSSZDOIX6bsqYWLXLWRLWcANPZV61CIwXlkLIv8Q1v1oGkdImgB60rK7LdHN0vqHVOhM52bpEGFAJiNXkqKEC/24/8v0Ny8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TASeDtrRQB4DG+rVrEMe/FHM4VsQd3A4+c/ktE0VF6A=;
 b=eO9gpqJ4JzFmFQVWDeOZ4B2eyVxrVpyF02/oWR7aVcDDviAsPgT9KEhTMzMROLhQI6ty6b5bP3+iKG0pZWsHvCIpqflgpNb4HoKQ71dQu3nZ+r7hmEN2WYZLYq7YuXTR7ZbN2A/T6b2vkXyFWmm2OzeTfT//3QOvnq8JfZIWjvQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3509.eurprd08.prod.outlook.com (20.177.115.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Thu, 30 Jan 2020 12:36:58 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2686.025; Thu, 30 Jan 2020
 12:36:58 +0000
Subject: Re: [PATCH v6 00/11] error: auto propagated local_err part I
To: qemu-devel@nongnu.org
References: <20200110194158.14190-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200130153654995
Message-ID: <95d4bf85-b52d-b076-e1fe-8237a28c9d25@virtuozzo.com>
Date: Thu, 30 Jan 2020 15:36:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200110194158.14190-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HE1PR05CA0357.eurprd05.prod.outlook.com
 (2603:10a6:7:94::16) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0357.eurprd05.prod.outlook.com (2603:10a6:7:94::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27 via Frontend Transport; Thu, 30 Jan 2020 12:36:56 +0000
X-Tagtoolbar-Keys: D20200130153654995
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 960eee75-dbd8-4282-c357-08d7a581187c
X-MS-TrafficTypeDiagnostic: AM6PR08MB3509:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3509BBFA7AAF6BD6F287F94FC1040@AM6PR08MB3509.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(39850400004)(346002)(376002)(136003)(396003)(366004)(189003)(199004)(66476007)(16526019)(66556008)(316002)(86362001)(26005)(956004)(2616005)(66946007)(6916009)(54906003)(16576012)(36756003)(966005)(5660300002)(52116002)(478600001)(31696002)(186003)(31686004)(8676002)(81156014)(8936002)(7416002)(81166006)(2906002)(6486002)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3509;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zz6FUXWCbVEfWT16sFCJA3hFtPjd2bA6a/+dmyoNB2UjLWadDLpr7VboDtEdxxiI4EKUCroEels0zAjvrfMdi00l1oAHoPE272Qt6G92zRfv6UT9CUd7+IKmQnfk12aUAD/k25njYcPBiR0UhTwVCRR/dOTQYTRtnCjVW4C5T1lQN4sTbD2c6lGiwBs0B5HV7pRoxwUbUnuFju8DfS/+DbAPkeggAkoi5wFOkzPoFRx+/LIM03fenxKEzYHWCkHF2VeafNh/l3GCBdB2Q2S99V+BhtJ3FwccCZQkm+igpWYQwPHZncZcyFxUQHUeS7Zk0XdGqZVsWzaG7I3TeSOYzIKd4yiko0XdsBhr3T5SVsqGcDIvyZdSdW4wjIkX3OSWaLO0jyYJG52IUQ2sfdYJu26F7ew1bx7zzPcglehL/PlxMK601KLC+iVAhDye5sRzWEBD6+h4SHx8hr8JuThAifkUXcQEEEd30n2HmyMR9HSN/67pWE0qdAnaekH63rhbpKlYq1wzy9t3IPEEmB2JMQ==
X-MS-Exchange-AntiSpam-MessageData: EXQc4pAdkIqS46H4WZ/uZxcj7g8ujYm/y3Ffj+4nw0uimZgZl7RDQ31g4aE//btzOr/syPVWJMBQ7Or+tFMbNBiyUJTxdd+rstTDItmUiOAWvmeBvINrgtoucX9SpMGzNM1EibgjUSnAmxeV2EWsBg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960eee75-dbd8-4282-c357-08d7a581187c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 12:36:58.0426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: er1wF4R2KJGpmNb9VNaClya1SBZGx4upxMsbbcp4V0DwxlyWROwV9bCaCXh9YxcJFxZYqJHAE1dgdN9FaoKlKHnuzlFlcXv2aibMgL9oegA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3509
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.109
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Greg Kurz <groug@kaod.org>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus, what about this? Should I respin?

10.01.2020 22:41, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
>=20
> Now, when preparations from
>   [RFC v5 000/126] error: auto propagated local_err
>   https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg02771.html
>   https://src.openvz.org/scm/~vsementsov/qemu.git #tag up-auto-local-err-=
v5
> , after some iterations, are finally merged, let's proceed with the
> rest. Sorry for a big delay on my part.
>=20
> As a first step, I decided to take subsystems, each of them covered by
> one patch, which get r-b/a-b marks by maintainer of the subsystem in v5.
>=20
> v6 is available at
>   https://src.openvz.org/scm/~vsementsov/qemu.git #tag up-auto-local-err-=
partI-v6
>=20
> Changes v5->v6:
> 01: use errp name for the parameter, add assertion
> 02: add a lot of text information, drop Eric's r-b.
>      no semantic changes.
> 03: add more comments
>      skip functions with pattern error_append_.*_hint in name
>      make errp identifier, to match any name of Error ** paramter
>      some other improvements
> 04: only commit message changed,
>      keep Philippe's r-b
> 05: new, manual update for hw/sd/ssi-sd
> 06: only commit message changed,
>      keep Philippe's r-b
> 07: only commit message changed,
>      keep Philippe's r-b
> 08: local_parse_opts() changed, so patch changed in this
>      function, drop a-b mark
>      also, indentation fixed, by improvement in coccinelle script
> 09: only commit message changed,
>      keep Stefan's r-b
> 10: commit message and a bit of context changed, still seems
>      valid to keep Eric's r-b
> 11: add new hunk: hw/pci-host/xen_igd_pt.c, so, drop r-b
>      also, indentation fixed, by improvement in coccinelle script
>=20
> In these series, there is no commit-per-subsystem script, each generated
> commit is generated in separate.
>=20
> Still, generating commands are very similar, and looks like
>=20
>      sed -n '/^<Subsystem name>$/,/^$/{s/^F: //p}' MAINTAINERS | \
>      xargs git ls-files | grep '\.[hc]$' | \
>      xargs spatch \
>          --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>          --macro-file scripts/cocci-macro-file.h \
>          --in-place --no-show-diff --max-width 80
>=20
> Note, that in each generated commit, generation command is the only
> text, indented by 8 spaces in 'git log -1' output, so, to regenerate all
> commits (for example, after rebase, or change in coccinelle script), you
> may use the following command:
>=20
> git rebase -x "sh -c \"git show --pretty=3D --name-only | xargs git check=
out HEAD^ -- ; git reset; git log -1 | grep '^        ' | sh\"" HEAD~7
>=20
> Which will start automated interactive rebase for generated patches,
> which will stop if generated patch changed
> (you may do git commit --amend to apply updated generated changes).
>=20
> Note:
>    git show --pretty=3D --name-only   - lists files, changed in HEAD
>    git log -1 | grep '^        ' | sh   - rerun generation command of HEA=
D
>=20
>=20
> Check for compilation of changed .c files
> git rebase -x "sh -c \"git show --pretty=3D --name-only | sed -n 's/\.c$/=
.o/p' | xargs make -j9\"" HEAD~7
>   =20
>=20
> Vladimir Sementsov-Ogievskiy (11):
>    qapi/error: add (Error **errp) cleaning APIs
>    error: auto propagated local_err
>    scripts: add coccinelle script to use auto propagated errp
>    hw/sd/ssi-sd: fix error handling in ssi_sd_realize
>    SD (Secure Card): introduce ERRP_AUTO_PROPAGATE
>    pflash: introduce ERRP_AUTO_PROPAGATE
>    fw_cfg: introduce ERRP_AUTO_PROPAGATE
>    virtio-9p: introduce ERRP_AUTO_PROPAGATE
>    TPM: introduce ERRP_AUTO_PROPAGATE
>    nbd: introduce ERRP_AUTO_PROPAGATE
>    xen: introduce ERRP_AUTO_PROPAGATE
>=20
>   include/block/nbd.h                           |   1 +
>   include/qapi/error.h                          | 113 +++++++++++++-
>   block/nbd.c                                   |  49 +++---
>   hw/9pfs/9p-local.c                            |  12 +-
>   hw/9pfs/9p.c                                  |   1 +
>   hw/block/dataplane/xen-block.c                |  17 +--
>   hw/block/pflash_cfi01.c                       |   7 +-
>   hw/block/pflash_cfi02.c                       |   7 +-
>   hw/block/xen-block.c                          | 125 +++++++---------
>   hw/nvram/fw_cfg.c                             |  14 +-
>   hw/pci-host/xen_igd_pt.c                      |   7 +-
>   hw/sd/sdhci-pci.c                             |   7 +-
>   hw/sd/sdhci.c                                 |  21 ++-
>   hw/sd/ssi-sd.c                                |  26 +++-
>   hw/tpm/tpm_util.c                             |   7 +-
>   hw/xen/xen-backend.c                          |   7 +-
>   hw/xen/xen-bus.c                              | 100 ++++++-------
>   hw/xen/xen-host-pci-device.c                  |  27 ++--
>   hw/xen/xen_pt.c                               |  25 ++--
>   hw/xen/xen_pt_config_init.c                   |  20 +--
>   nbd/client.c                                  |   5 +
>   nbd/server.c                                  |   5 +
>   tpm.c                                         |   7 +-
>   scripts/coccinelle/auto-propagated-errp.cocci | 139 ++++++++++++++++++
>   24 files changed, 482 insertions(+), 267 deletions(-)
>   create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci
>=20
> CC: Cornelia Huck <cohuck@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Greg Kurz <groug@kaod.org>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Stefano Stabellini <sstabellini@kernel.org>
> CC: Anthony Perard <anthony.perard@citrix.com>
> CC: Paul Durrant <paul@xen.org>
> CC: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> CC: Laszlo Ersek <lersek@redhat.com>
> CC: Gerd Hoffmann <kraxel@redhat.com>
> CC: Stefan Berger <stefanb@linux.ibm.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Michael Roth <mdroth@linux.vnet.ibm.com>
> CC: qemu-block@nongnu.org
> CC: xen-devel@lists.xenproject.org
>=20


--=20
Best regards,
Vladimir


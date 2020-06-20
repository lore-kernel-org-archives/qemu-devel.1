Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C708C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 22:00:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D4A22202
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 22:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mysuse.onmicrosoft.com header.i=@mysuse.onmicrosoft.com header.b="D8lDmsa/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D4A22202
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmlX5-000191-TQ
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 18:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>)
 id 1jmlW4-0000Cl-Ei; Sat, 20 Jun 2020 17:59:12 -0400
Received: from mail-eopbgr20054.outbound.protection.outlook.com
 ([40.107.2.54]:37282 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>)
 id 1jmlW1-00011V-3a; Sat, 20 Jun 2020 17:59:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WO7YgpG4UiWzZbiiXBb494G4MtBPVDkfFyWsHumOmT60043ZIYGkRyXA0W9CWWD4xLPGTCDeGBVIFiKoRX/NptuW0nx/kW3PiALVQ0Cuwfk3TA+cabxXWkXIBbKFgQBAo/VLKIyUGoFnUbe7HqoW5YxdjqT+bWxfmmu1IGJcLHto8BJsEy8A5UltZfMz7MdjaW7McomF14NNl18QSQzDxTLORvXyV7jWhEqfBkWh2bRWZ/W3zynX1/nmdov75u7CEvLS4OPnY/tN2IABNSsY3MpBZw4M64vd9MwfPiNF6EOsv/y0fYV5JWndhL4cB5lTEK69PrFEPnc64JLwq15dIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haaZcQIKtlSuwhTA+JQZKxErL6T3vMRFoQmApxjQK1I=;
 b=Q6aoib1ZEtE3hW4BUKZqxJyAIlB/3KqrZ4d2dewBxKwp0J/HjJaXInBD1ZriVy3sLeKM1jJzrUC6beu2/O+fVfSjiNHsB8NBiCSQk6XUovUWLjLFmMjjdyt53xOlCKHYjnTujaHNlREL9UEQs+8ggjmFDjiUAijapsXf8IiPYKx2pF1mleOf7dIAvSqG1rQI4R4uMQOOg3KMPmXKC26jgjDrf6VMru32cZnw17xQC6n4wN/CuwFA6+GpXPmH50Gf6lrpeGUO1Xh3xvsac0Qov0xQT8I5D1MMMuFBUBvh+RCJoPv2CsUyH/PK+lUTh7/E2gZZFyNVOW36Zk03MmVZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haaZcQIKtlSuwhTA+JQZKxErL6T3vMRFoQmApxjQK1I=;
 b=D8lDmsa/t6VsfW+BbcRKD8HN7GHv+zhmIkX6Wt70/ikDAJMw9Z00G8xrRYp3jkPjfOMq1DqzKoxn40ohKnrCuyvHiD3jIC4vt6mtM44KSt3gZw4Uw+jhmu+7d4gMZa/8jYed0fcbAXn+Q1tFpYvRd8/ODgzAngOIJah3JYRIPtdyAa/LpoAbh5H9UIAmhTZYLey9KYdneLfmUkHP3mZQK1gHWy+ijFgR/J8eukc5PlSXafkSFAmUu9pW7IvM1SA+jw7BcS16/pAhe1MlmyHu5FDWug/JeI51VW+doeATNkYpp4Jd3vJwF/phIWD4n6mlS1s91X36OwZRpg6tZMoSxw==
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21) by AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Sat, 20 Jun
 2020 21:44:02 +0000
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::7065:39d1:bcc:21d3]) by AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::7065:39d1:bcc:21d3%2]) with mapi id 15.20.3109.025; Sat, 20 Jun 2020
 21:44:02 +0000
From: Bruce Rogers <brogers@suse.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 00/78] Patch Round-up for stable 4.2.1, freeze on
 2020-06-22
Thread-Topic: [PATCH 00/78] Patch Round-up for stable 4.2.1, freeze on
 2020-06-22
Thread-Index: AQHWQ+mSazCcxTR/akegVvZFM+JwyqjiDkiE
Date: Sat, 20 Jun 2020 21:44:01 +0000
Message-ID: <AM4PR0401MB23545BF794CC4FA9E7F22324D9990@AM4PR0401MB2354.eurprd04.prod.outlook.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.vnet.ibm.com; dkim=none (message not signed)
 header.d=none;linux.vnet.ibm.com; dmarc=none action=none
 header.from=suse.com;
x-originating-ip: [63.248.145.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84b443a3-2db6-4ddc-1e5b-08d815630c09
x-ms-traffictypediagnostic: AM4PR0401MB2354:
x-microsoft-antispam-prvs: <AM4PR0401MB23542B55B1841268B9AFF8D6D9990@AM4PR0401MB2354.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:597;
x-forefront-prvs: 0440AC9990
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w5QXVKiWSa6cEV5366s3ezwwYSSA14U4nHCuCM0KnN0RCVn9QtV2rgtRwg1Fx87p5YW+o2Sspv0N2EAGrV8pvX6VDhhq4ZEh3H3r1eESCri3kZnrO01Qr8cZB4kCnk0G+xxVK4YMEGshuF33hnr4Kwbqnl+VNBmULssaXv/xcD9hqSeSsPELqj115j09p6P98Xj8M7jXdKXqYJgcBV6vIyAhBGrbKXjD8YHT6/T3c1c6giFhRGJ8lvR9BTi7zgflzhIZiEvBff8PsT7O97iA5lIa8Kh5Ew0NisC9dR4EkPC6bRkT9SHPSi/SDOTZxrfE5CviBqNMgD7XKTpiAtzxlqkDPQMeTBd8dP44i7nzsCpLxON6ezhPT+Mp78/di7BzvUsMr5EBYDq42HA+Nqjb0A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR0401MB2354.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(39850400004)(136003)(346002)(376002)(366004)(9686003)(53546011)(966005)(478600001)(83380400001)(26005)(186003)(316002)(6506007)(8936002)(8676002)(110136005)(4326008)(7696005)(2906002)(91956017)(64756008)(66946007)(66476007)(66556008)(33656002)(76116006)(66446008)(55016002)(86362001)(30864003)(71200400001)(66574015)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: +QHZVqJPHLaZXlwoyikvG1ts9t8gp1ARCu+wi0dtyuBPu9qYvsDe0LtyFa2AIby66sB3+pD0zIo+NwLNLscrb4Na37nyOoGxU2PcNJDlRpGNqFG+M9TiP99FaYzXIQrzxK1pL5qzynp+VpCWFQcmn9rXFtZmdQ8wyG+HLG2AyntuAXV5dj233jqtGNdlVnNLjWBT+tln6ZSAjSjcs/FdI/vemEgyCIZk+tnUmvjCyzprzJ15cFvACN086H1Ky+hZ3VQRIJn1REAB9oljBtABxLzGEAW1YpxVn5hyLgSwPW1HHRqc0OG+yc/YVmSXrrSgsEMiNAb8ds+uENI7mENfcEe0t4D3M5L7yXcXgMf1Q2uC0FM4+3c6YfDuJ4tZv+yBJbvIdw5/yNduPO5WiIEzH+EWzwTjibJecHhZc/wVrxsO2X7goqbGHxUEvf3dQh4+g3FPrnS9SVA9JmsgArLBPu50IRgRMqrFMj6z/Pk1zixJhrIds9a/f6a4S7H64Wed
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b443a3-2db6-4ddc-1e5b-08d815630c09
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2020 21:44:01.9545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c+Df5N9M51hYWVVxfzZs71aICCHPpJGL9wZ8Sqm2ZyqmqmIon6csZm2/LgHcwNzcQ3+VfqPGFi0BnR2NWmpcJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2354
Received-SPF: pass client-ip=40.107.2.54; envelope-from=brogers@suse.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 17:59:06
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,=0A=
=0A=
Our upcoming SLE15-SP2 and Leap 15.2 releases have a qemu package which=0A=
is based on v4.2.0. In addition to some of the patches already mentioned, h=
ere=0A=
is a list of others we have backported as being stable material. I threw a =
little=0A=
wider net this time than usual, so feel free to give it a more critical eye=
.=0A=
=0A=
commit 8937a39da22e5d5689c516a2d4ce4f2bb6a378fc=0A=
Author: Han Han <hhan@redhat.com>=0A=
=0A=
    Revert "qemu-options.hx: Update for reboot-timeout parameter"=0A=
=0A=
commit 0f516ca4767042aec8716369d6d62436fa10593a=0A=
Author: Robert Foley <robert.foley@linaro.org>=0A=
=0A=
    Fix double free issue in qemu_set_log_filename().=0A=
=0A=
commit eb4ea9aaa0051054b3c148ad8631be7510851681=0A=
Author: Max Reitz <mreitz@redhat.com>=0A=
=0A=
    iotests: Fix IMGOPTSSYNTAX for nbd=0A=
=0A=
commit fcd3f2cc124600385dba46c69a80626985c15b50=0A=
Author: Igor Mammedov <imammedo@redhat.com>=0A=
=0A=
    numa: properly check if numa is supported=0A=
=0A=
commit ca26b032e5a0e8a190c763ce828a8740d24b9b65=0A=
Author: Cole Robinson <crobinso@redhat.com>=0A=
=0A=
    vhost-user-gpu: Drop trailing json comma=0A=
=0A=
commit 0d82411d0e38a0de7829f97d04406765c8d2210d=0A=
Author: Cameron Esfahani <dirty@apple.com>=0A=
=0A=
    display/bochs-display: fix memory leak=0A=
=0A=
commit 3d44c60500785f18bb469c9de0aeba7415c0f28f=0A=
Author: Simon Veith <sveith@amazon.de>=0A=
=0A=
    hw/arm/smmuv3: Apply address mask to linear strtab base address=0A=
=0A=
commit 3293b9f514a413e019b7dbc9d543458075b4849e=0A=
Author: Simon Veith <sveith@amazon.de>=0A=
=0A=
    hw/arm/smmuv3: Correct SMMU_BASE_ADDR_MASK value=0A=
=0A=
commit 05ff2fb80ce4ca85d8a39d48ff8156de739b4f51=0A=
Author: Simon Veith <sveith@amazon.de>=0A=
=0A=
    hw/arm/smmuv3: Check stream IDs against actual table LOG2SIZE=0A=
=0A=
commit 41678c33aac61261522b74f08595ccf2221a430a=0A=
Author: Simon Veith <sveith@amazon.de>=0A=
=0A=
    hw/arm/smmuv3: Align stream table base address to table size=0A=
=0A=
commit a7f65ceb851af5a5b639c6e30801076d848db2c2=0A=
Author: Simon Veith <sveith@amazon.de>=0A=
=0A=
    hw/arm/smmuv3: Use correct bit positions in EVT_SET_ADDR2 macro=0A=
=0A=
commit b255cafb59578d16716186ed955717bc8f87bdb7=0A=
Author: Simon Veith <sveith@amazon.de>=0A=
=0A=
    hw/arm/smmuv3: Report F_STE_FETCH fault address in correct word positio=
n=0A=
=0A=
commit 7b1d9c4df0603fbc526226a9c5ef91118aa6c957=0A=
Author: Max Reitz <mreitz@redhat.com>=0A=
=0A=
    block: Add bdrv_qapi_perm_to_blk_perm()=0A=
=0A=
commit 69c6449ff10fe4e3219e960549307096d5366bd0=0A=
Author: Max Reitz <mreitz@redhat.com>=0A=
=0A=
    blkdebug: Allow taking/unsharing permissions=0A=
=0A=
commit 16c5c6928ff53bd95e6504301ef6c285501531e7=0A=
Author: Laurent Vivier <lvivier@redhat.com>=0A=
=0A=
    migration-test: ppc64: fix FORTH test program=0A=
=0A=
commit 30d544839e278dc76017b9a42990c41e84a34377=0A=
Author: Jeff Kubascik <jeff.kubascik@dornerworks.com>=0A=
=0A=
    target/arm: Return correct IL bit in merge_syn_data_abort=0A=
=0A=
commit ddad81bd28de665475a87693a93e6cf5d6fd8bab=0A=
Author: Laurent Vivier <lvivier@redhat.com>=0A=
=0A=
    runstate: ignore finishmigrate -> prelaunch transition=0A=
=0A=
commit 97e1e06780e70f6e98a0d2df881e0c0927d3aeb6=0A=
Author: Dr. David Alan Gilbert <dgilbert@redhat.com>=0A=
=0A=
    migration: Rate limit inside host pages=0A=
=0A=
commit 0780ec7be82dd4781e9fd216b5d99a125882ff5a=0A=
Author: Gerd Hoffmann <kraxel@redhat.com>=0A=
=0A=
    Revert "vnc: allow fall back to RAW encoding"=0A=
=0A=
commit 557ba0e57200014bd4f453f6516f02b61bdfc782=0A=
Author: Cameron Esfahani <dirty@apple.com>=0A=
=0A=
    vnc: prioritize ZRLE compression over ZLIB=0A=
=0A=
commit 322f244aaa80a5208090d41481c1c09c6face66b=0A=
Author: Laurent Vivier <laurent@vivier.eu>=0A=
=0A=
    m68k: Fix regression causing Single-Step via GDB/RSP to not single step=
=0A=
=0A=
commit de0b1bae6461f67243282555475f88b2384a1eb9=0A=
Author: Vincent Dehors <vincent.dehors@smile.fr>=0A=
=0A=
    target/arm: Fix PAuth sbox functions=0A=
=0A=
commit 420ae1fc51c99abfd03b1c590f55617edd2a2bed=0A=
Author: Paolo Bonzini <pbonzini@redhat.com>=0A=
=0A=
    target/i386: kvm: initialize feature MSRs very early=0A=
=0A=
commit 3c5fd8074335c67777d9391b84f97070c35d9c63=0A=
Author: Cornelia Huck <cohuck@redhat.com>=0A=
=0A=
    s390x: adapter routes error handling=0A=
=0A=
commit fb574de81bfdd71fdb0315105a3a7761efb68395=0A=
Author: Eiichi Tsukata <devel@etsukata.com>=0A=
=0A=
    block/backup: fix memory leak in bdrv_backup_top_append()=0A=
=0A=
commit 71e415c8a75c130875f14d6b2136825789feb297=0A=
Author: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
=0A=
    tpm-ppi: page-align PPI RAM=0A=
=0A=
commit 618bacabd3c8c3360be795cd8763bacdf5bec101=0A=
Author: Zenghui Yu <yuzenghui@huawei.com>=0A=
=0A=
    hw/intc/arm_gicv3_kvm: Stop wrongly programming GICR_PENDBASER.PTZ bit=
=0A=
=0A=
commit 7a4ede0047a8613b0e3b72c9d351038f013dd357=0A=
Author: Gerd Hoffmann <kraxel@redhat.com>=0A=
=0A=
    audio/oss: fix buffer pos calculation=0A=
=0A=
commit aeab8e5eb220cc5ff84b0b68b9afccc611bf0fcd=0A=
Author: Alex Benn=E9e <alex.bennee@linaro.org>=0A=
=0A=
    target/arm: fix TCG leak for fcvt half->double=0A=
=0A=
commit cb8956144ccaccf23d5cc4167677e2c84fa5a9f8=0A=
Author: Pan Nengyuan <pannengyuan@huawei.com>=0A=
=0A=
    block: fix memleaks in bdrv_refresh_filename=0A=
=0A=
commit 0df62f45c1de6c020f1e6fba4eeafd248209b003=0A=
Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=0A=
=0A=
    block/backup-top: fix failure path=0A=
=0A=
commit a541fcc27c98b96da187c7d4573f3270f3ddd283=0A=
Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=0A=
=0A=
    iotests: add test for backup-top failure on permission activation=0A=
=0A=
commit 0999a4ba8718aa96105b978d3567fc7e90244c7e=0A=
Author: Liang Yan <lyan@suse.com>=0A=
=0A=
    target/arm/monitor: query-cpu-model-expansion crashed qemu when using m=
achine type none=0A=
=0A=
commit ac9d00bf7b47acae6b0e42910d9ed55fef3af5b8=0A=
Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=0A=
=0A=
    block: fix crash on zero-length unaligned write and read=0A=
=0A=
commit 804359b8b90f76d9d8fbe8d85a6544b68f107f10=0A=
Author: Max Reitz <mreitz@redhat.com>=0A=
=0A=
    block: Fix VM size field width in snapshot dump=0A=
=0A=
commit a1ed04dd79aabb9dbeeb5fa7d49f1a3de0357553=0A=
Author: Peter Maydell <peter.maydell@linaro.org>=0A=
=0A=
    target/arm: Correct definition of PMCRDP=0A=
=0A=
commit 9861546e1dae05c5152de7d3bd14e341ecadc972=0A=
Author: Pan Nengyuan <pannengyuan@huawei.com>=0A=
=0A=
    virtio-pmem: do delete rq_vq in virtio_pmem_unrealize=0A=
=0A=
commit d56e1c8256cb37e68f9b5d98c6cc4e6ca463f1fd=0A=
Author: Pan Nengyuan <pannengyuan@huawei.com>=0A=
=0A=
    virtio-crypto: do delete ctrl_vq in virtio_crypto_device_unrealize=0A=
=0A=
commit 13e5468127111bf44c5dc314d1dd2ec5a65dfec4=0A=
Author: Pan Nengyuan <pannengyuan@huawei.com>=0A=
=0A=
    vhost-user-blk: delete virtioqueues in unrealize to fix memleaks=0A=
=0A=
commit 2104df2a1fbf44b2564427aa72fd58d66ce290a7=0A=
Author: Niek Linnenbank <nieklinnenbank@gmail.com>=0A=
=0A=
    hw/arm/cubieboard: use ARM Cortex-A8 as the default CPU in machine defi=
nition=0A=
=0A=
commit 9bfc04f9ef6802fff0fc77130ff345a541783363=0A=
Author: Janosch Frank <frankja@linux.ibm.com>=0A=
=0A=
    pc-bios: s390x: Save iplb location in lowcore=0A=
=0A=
commit 69135eb30b9c3fca583737a96df015174dc8e6dd=0A=
Author: Eric Blake <eblake@redhat.com>=0A=
=0A=
    iotests: Fix nonportable use of od --endian=0A=
=0A=
commit 1583794b9b36911df116cc726750dadbeeac506a=0A=
Author: Philippe Mathieu-Daud=E9 <philmd@redhat.com>=0A=
=0A=
    ppc/ppc405_boards: Remove unnecessary NULL check=0A=
=0A=
commit 71eaec2e8c7c8d266137b5c5f42da0bd6d6b5eb7=0A=
Author: Eric Blake <eblake@redhat.com>=0A=
=0A=
    block: Avoid memleak on qcow2 image info failure=0A=
=0A=
commit 6e57963a77df1e275a73dab4c6a7ec9a9d3468d4=0A=
Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=0A=
=0A=
    block: bdrv_set_backing_bs: fix use-after-free=0A=
=0A=
commit d4ff109373ce871928c7e9ef648973eba642b484=0A=
Author: Dr. David Alan Gilbert <dgilbert@redhat.com>=0A=
=0A=
    hmp/vnc: Fix info vnc list leak=0A=
=0A=
commit 27d07fcfa70c3afa0664288cbce5334ed9595a3a=0A=
Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=0A=
=0A=
    migration/colo: fix use after free of local_err=0A=
=0A=
commit b4a1733c5e6827c72b0dcfa295e07ef7b1ebccff=0A=
Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=0A=
=0A=
    migration/ram: fix use after free of local_err=0A=
=0A=
commit bb40ebce2cb0bd4bf37968074d43d5a864fb6dee=0A=
Author: Eric Blake <eblake@redhat.com>=0A=
=0A=
    qcow2: List autoclear bit names in header=0A=
=0A=
commit ed049910637be991c88cc25c864115bc5b1e4dab=0A=
Author: Eric Blake <eblake@redhat.com>=0A=
=0A=
    sheepdog: Consistently set bdrv_has_zero_init_truncate=0A=
=0A=
commit 8ffb7265af64ec81748335ec8f20e7ab542c3850=0A=
Author: Prasad J Pandit <pjp@fedoraproject.org>=0A=
=0A=
    net: tulip: check frame size and r/w data length=0A=
=0A=
commit 7aab5899764887f6b0512cb2e5c11bdc2a5d3644=0A=
Author: David Gibson <david@gibson.dropbear.id.au>=0A=
=0A=
    spapr: Fix failure path for attempting to hot unplug PCI bridges=0A=
=0A=
commit 3f6de653b946fe849330208becf79d6af7e876cb=0A=
Author: Kevin Wolf <kwolf@redhat.com>=0A=
=0A=
    vpc: Don't round up already aligned BAT sizes=0A=
=0A=
commit 1a03362b14affa4d8ddede55df6e21d7a07b87c2=0A=
Author: Max Filippov <jcmvbkbc@gmail.com>=0A=
=0A=
    target/xtensa: fix pasto in pfwait.r opcode name=0A=
=0A=
commit a4e57084c16d5b0eff3651693fba04f26b30b551=0A=
=0A=
- Bruce=0A=
=0A=
=0A=
________________________________________=0A=
From: Qemu-devel <qemu-devel-bounces+brogers=3Dsuse.com@nongnu.org> on beha=
lf of Michael Roth <mdroth@linux.vnet.ibm.com>=0A=
Sent: Tuesday, June 16, 2020 8:14 AM=0A=
To: qemu-devel@nongnu.org=0A=
Cc: qemu-stable@nongnu.org=0A=
Subject: [PATCH 00/78] Patch Round-up for stable 4.2.1, freeze on 2020-06-2=
2=0A=
=0A=
Hi everyone,=0A=
=0A=
The following new patches are queued for QEMU stable v4.2.1:=0A=
=0A=
  https://github.com/mdroth/qemu/commits/stable-4.2-staging=0A=
=0A=
The release is planned for 2020-06-25:=0A=
=0A=
  https://wiki.qemu.org/Planning/4.2=0A=
=0A=
Due to delays on my part this release is going out beyond the normal=0A=
~4 month support window. v5.0.1 is scheduled to be released as normal.=0A=
=0A=
Please respond here or CC qemu-stable@nongnu.org on any additional patches=
=0A=
you think should be included in the release.=0A=
=0A=
Thanks!=0A=
=0A=
=0A=
----------------------------------------------------------------=0A=
Alex Benn=E9e (2):=0A=
      target/arm: ensure we use current exception state after SCR update=0A=
      tcg: save vaddr temp for plugin usage=0A=
=0A=
Alexander Popov (2):=0A=
      tests/ide-test: Create a single unit-test covering more PRDT cases=0A=
      ide: Fix incorrect handling of some PRDTs in ide_dma_cb()=0A=
=0A=
Anthony PERARD (1):=0A=
      xen-block: Fix double qlist remove and request leak=0A=
=0A=
Basil Salman (2):=0A=
      qga: Installer: Wait for installation to finish=0A=
      qga-win: prevent crash when executing guest-file-read with large coun=
t=0A=
=0A=
Christian Borntraeger (1):=0A=
      s390/sclp: improve special wait psw logic=0A=
=0A=
Christophe de Dinechin (1):=0A=
      scsi/qemu-pr-helper: Fix out-of-bounds access to trnptid_list[]=0A=
=0A=
Cornelia Huck (1):=0A=
      compat: disable edid on correct virtio-gpu device=0A=
=0A=
Daniel P. Berrang=E9 (1):=0A=
      qapi: better document NVMe blockdev @device parameter=0A=
=0A=
David Hildenbrand (3):=0A=
      virtio-balloon: fix free page hinting without an iothread=0A=
      virtio-balloon: fix free page hinting check on unrealize=0A=
      virtio-balloon: unref the iothread when unrealizing=0A=
=0A=
Denis Plotnikov (1):=0A=
      virtio-mmio: update queue size on guest write=0A=
=0A=
Eduardo Habkost (1):=0A=
      i386: Resolve CPU models to v1 by default=0A=
=0A=
Emilio G. Cota (1):=0A=
      plugins/core: add missing break in cb_to_tcg_flags=0A=
=0A=
Eric Blake (3):=0A=
      qga: Fix undefined C behavior=0A=
      nbd/server: Avoid long error message assertions CVE-2020-10761=0A=
      block: Call attention to truncation of long NBD exports=0A=
=0A=
Finn Thain (14):=0A=
      dp8393x: Mask EOL bit from descriptor addresses=0A=
      dp8393x: Always use 32-bit accesses=0A=
      dp8393x: Clean up endianness hacks=0A=
      dp8393x: Have dp8393x_receive() return the packet size=0A=
      dp8393x: Update LLFA and CRDA registers from rx descriptor=0A=
      dp8393x: Clear RRRA command register bit only when appropriate=0A=
      dp8393x: Implement packet size limit and RBAE interrupt=0A=
      dp8393x: Don't clobber packet checksum=0A=
      dp8393x: Use long-word-aligned RRA pointers in 32-bit mode=0A=
      dp8393x: Pad frames to word or long word boundary=0A=
      dp8393x: Clear descriptor in_use field to release packet=0A=
      dp8393x: Always update RRA pointers and sequence numbers=0A=
      dp8393x: Don't reset Silicon Revision register=0A=
      dp8393x: Don't stop reception upon RBE interrupt assertion=0A=
=0A=
Greg Kurz (1):=0A=
      9p: Lock directory streams with a CoMutex=0A=
=0A=
Igor Mammedov (3):=0A=
      numa: remove not needed check=0A=
      numa: properly check if numa is supported=0A=
      hostmem: don't use mbind() if host-nodes is empty=0A=
=0A=
Kevin Wolf (4):=0A=
      block: Activate recursively even for already active nodes=0A=
      qcow2: update_refcount(): Reset old_table_index after qcow2_cache_put=
()=0A=
      qcow2: Fix qcow2_alloc_cluster_abort() for external data file=0A=
      iotests: Test copy offloading with external data file=0A=
=0A=
Li Hangjing (1):=0A=
      virtio-blk: fix out-of-bounds access to bitmap in notify_guest_bh=0A=
=0A=
Liu Yi L (2):=0A=
      intel_iommu: a fix to vtd_find_as_from_bus_num()=0A=
      intel_iommu: add present bit check for pasid table entries=0A=
=0A=
Max Reitz (4):=0A=
      backup-top: Begin drain earlier=0A=
      qcow2: Fix alloc_cluster_abort() for pre-existing clusters=0A=
      iotests/026: Test EIO on preallocated zero cluster=0A=
      iotests/026: Test EIO on allocation in a data-file=0A=
=0A=
Michael S. Tsirkin (3):=0A=
      virtio: update queue size on guest write=0A=
      virtio: add ability to delete vq through a pointer=0A=
      virtio: make virtio_delete_queue idempotent=0A=
=0A=
Nicholas Piggin (1):=0A=
      target/ppc: Fix mtmsr(d) L=3D1 variant that loses interrupts=0A=
=0A=
Niek Linnenbank (2):=0A=
      arm/arm-powerctl: set NSACR.{CP11, CP10} bits in arm_set_cpu_on()=0A=
      arm/arm-powerctl: rebuild hflags after setting CP15 bits in arm_set_c=
pu_on()=0A=
=0A=
Pan Nengyuan (2):=0A=
      block/nbd: extract the common cleanup code=0A=
      block/nbd: fix memory leak in nbd_open()=0A=
=0A=
Peter Maydell (2):=0A=
      hw/i386/amd_iommu.c: Fix corruption of log events passed to guest=0A=
      dump: Fix writing of ELF section=0A=
=0A=
Peter Wu (1):=0A=
      hw/i386/pc: fix regression in parsing vga cmdline parameter=0A=
=0A=
Peter Xu (1):=0A=
      vfio/pci: Don't remove irqchip notifier if not registered=0A=
=0A=
Philippe Mathieu-Daud=E9 (1):=0A=
      vhost-user-gpu: Release memory returned by vu_queue_pop() with free()=
=0A=
=0A=
Raphael Pour (1):=0A=
      qemu-nbd: Close inherited stderr=0A=
=0A=
Richard Henderson (3):=0A=
      target/arm: Set ISSIs16Bit in make_issinfo=0A=
      tcg/i386: Fix INDEX_op_dup2_vec=0A=
      target/arm: Clear tail in gvec_fmul_idx_*, gvec_fmla_idx_*=0A=
=0A=
Sameeh Jubran (1):=0A=
      qga-win: Handle VSS_E_PROVIDER_ALREADY_REGISTERED error=0A=
=0A=
Stefan Hajnoczi (2):=0A=
      virtio: gracefully handle invalid region caches=0A=
      qemu-ga: document vsock-listen in the man page=0A=
=0A=
Thomas Huth (1):=0A=
      net: Do not include a newline in the id of -nic devices=0A=
=0A=
Vitaly Chikunov (1):=0A=
      target/ppc: Fix rlwinm on ppc64=0A=
=0A=
Vladimir Sementsov-Ogievskiy (5):=0A=
      qcow2-bitmaps: fix qcow2_can_store_new_dirty_bitmap=0A=
      block/qcow2-threads: fix qcow2_decompress=0A=
      job: refactor progress to separate object=0A=
      block/block-copy: fix progress calculation=0A=
      block/io: fix bdrv_co_do_copy_on_readv=0A=
=0A=
Yuri Benditovich (2):=0A=
      virtio: reset region cache when on queue deletion=0A=
      virtio-net: delete also control queue when TX/RX deleted=0A=
=0A=
 backends/hostmem.c                 |   6 +-=0A=
 block.c                            |  57 +++++------=0A=
 block/backup-top.c                 |   4 +-=0A=
 block/backup.c                     |  13 +--=0A=
 block/block-copy.c                 |  16 ++-=0A=
 block/io.c                         |   2 +-=0A=
 block/nbd.c                        |  48 +++++----=0A=
 block/qcow2-bitmap.c               |  41 ++++----=0A=
 block/qcow2-cluster.c              |   7 +-=0A=
 block/qcow2-refcount.c             |   1 +=0A=
 block/qcow2-threads.c              |  12 ++-=0A=
 blockjob.c                         |  16 +--=0A=
 contrib/vhost-user-gpu/main.c      |   4 +-=0A=
 contrib/vhost-user-gpu/virgl.c     |   2 +-=0A=
 docs/interop/qemu-ga.rst           |   5 +-=0A=
 dump/dump.c                        |   2 +-=0A=
 hw/9pfs/9p.h                       |   8 +-=0A=
 hw/arm/sbsa-ref.c                  |   1 -=0A=
 hw/block/dataplane/virtio-blk.c    |   2 +-=0A=
 hw/block/dataplane/xen-block.c     |  48 +++------=0A=
 hw/core/machine.c                  |   6 +-=0A=
 hw/core/numa.c                     |   7 +-=0A=
 hw/i386/amd_iommu.c                |   2 +-=0A=
 hw/i386/intel_iommu.c              |  93 +++++++++++++----=0A=
 hw/i386/intel_iommu_internal.h     |   1 +=0A=
 hw/i386/x86.c                      |   8 +-=0A=
 hw/ide/core.c                      |  30 ++++--=0A=
 hw/net/dp8393x.c                   | 200 ++++++++++++++++++++++++---------=
----=0A=
 hw/net/virtio-net.c                |   3 +-=0A=
 hw/vfio/pci.c                      |   4 +-=0A=
 hw/virtio/virtio-balloon.c         |  36 +++----=0A=
 hw/virtio/virtio-mmio.c            |   3 +-=0A=
 hw/virtio/virtio-pci.c             |   2 +=0A=
 hw/virtio/virtio.c                 | 116 ++++++++++++++++++---=0A=
 include/block/block-copy.h         |  15 +--=0A=
 include/hw/virtio/virtio.h         |   2 +=0A=
 include/qemu/job.h                 |  11 +-=0A=
 include/qemu/progress_meter.h      |  58 +++++++++++=0A=
 job-qmp.c                          |   4 +-=0A=
 job.c                              |   6 +-=0A=
 nbd/server.c                       |  23 ++++-=0A=
 net/net.c                          |   2 +-=0A=
 plugins/core.c                     |   1 +=0A=
 qapi/block-core.json               |   6 +-=0A=
 qemu-deprecated.texi               |   8 ++=0A=
 qemu-img.c                         |   6 +-=0A=
 qemu-nbd.c                         |   6 +-=0A=
 qga/commands-win32.c               |   8 +-=0A=
 qga/commands.c                     |   9 +-=0A=
 qga/installer/qemu-ga.wxs          |   2 +-=0A=
 qga/main.c                         |   4 +-=0A=
 qga/vss-win32/install.cpp          |  11 ++=0A=
 scsi/qemu-pr-helper.c              |  17 ++--=0A=
 target/arm/arm-powerctl.c          |   6 ++=0A=
 target/arm/cpu.h                   |   8 +-=0A=
 target/arm/helper.c                |  14 ++-=0A=
 target/arm/helper.h                |   1 +=0A=
 target/arm/translate.c             |   9 +-=0A=
 target/arm/vec_helper.c            |   2 +=0A=
 target/i386/cpu.c                  |   8 +-=0A=
 target/ppc/translate.c             |  66 ++++++------=0A=
 target/s390x/helper.c              |   2 +-=0A=
 tcg/i386/tcg-target.inc.c          |  10 +-=0A=
 tcg/tcg-op.c                       |  23 ++++-=0A=
 tests/ide-test.c                   | 174 ++++++++++++++------------------=
=0A=
 tests/qemu-iotests/026             |  53 ++++++++++=0A=
 tests/qemu-iotests/026.out         |  16 +++=0A=
 tests/qemu-iotests/026.out.nocache |  16 +++=0A=
 tests/qemu-iotests/143             |   4 +=0A=
 tests/qemu-iotests/143.out         |   2 +=0A=
 tests/qemu-iotests/244             |  14 +++=0A=
 tests/qemu-iotests/244.out         |   6 ++=0A=
 72 files changed, 963 insertions(+), 476 deletions(-)=0A=
 create mode 100644 include/qemu/progress_meter.h=0A=
=0A=
=0A=
=0A=


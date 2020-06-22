Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500CBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:35:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07454206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=openvz.org header.i=@openvz.org header.b="opqKgC5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07454206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnHvg-0002B3-7P
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 04:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jnHuZ-0001eT-5H; Mon, 22 Jun 2020 04:34:39 -0400
Received: from mail-am6eur05on2129.outbound.protection.outlook.com
 ([40.107.22.129]:25440 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jnHuV-00016Y-UQ; Mon, 22 Jun 2020 04:34:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0MFpltivVt81yGea1NucEr7E6Z+ocsI/2ULVkHKTmjDTTfmUo150H0L4Y/BX83hWl5BJQ8VVaVEFPo+q2OUBzd8Uu7ihEKP9dw5xRhOvC367WHHp3s9GHTmBXdVqMWzOfc/yvA0BN73xDWCwN5BrBzJxpS4EymTBLyn54s7km6XyyCsMfAz4wP2YB8yS9ARbwCOFqQ1ZKpO1Q0Bfi9AfUyji60HiP1ose+s00r+T7pmzdqDvuXf57mJllVYmjXiL9KkZuKjZUZPH24OK6ihqh54Wf029x7KFHPDk+ORqkUEMEl2zQzqRqA2c2jZD8hNet84HfC5K8vFtYZ4h/a+RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R81fFvuH1rif7rCpEid4C3g+hd0SJEFY4pwpRklLN1g=;
 b=beHuCZPW2GBYw6bxUvKftS28oUtB/WoNqswlx3OUFmzhRoPt4S8oRlcLvwh1zbUHcyxvZzJiLR+zMQlJRYUMyOvDIeq8A9Cs3Em4yj/nqN93IlM16mDknGO2TN1C2SkXST57l5A82xuFGZz1dbciJRvkUKrcHfMD3nDu/6z/zn7lfDoSR+TQgf6fQxy2BcCy/vDpDoixGefFqg+/OJY/0RW6sCXaut94qtNAS7K+z1iJa2wn8oR5xwMXPJlIyu2IZ4q+ljXjPTUHNJWsnMCVtNN9Zdih3NxmpTGwhUDg1DDrewsIXkeRzNSUObioMFKBBo7v3qMec8IaKY1YoNkTVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=openvz.org;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R81fFvuH1rif7rCpEid4C3g+hd0SJEFY4pwpRklLN1g=;
 b=opqKgC5od8FzPFEomxHo/Om3RvgTU84mXioL4oRdJJo+eotr6vXkpmTXsxa7I0L6sV6OAjFzJZS8itX35yX9x3yYNHAtf4l5llcshJn1KoaMfaKudrGZ442Gq7XUP6+ZCczwHErmtPyfDxcyu//x7e4VrGCXN69JG1JC1do2bsQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=openvz.org;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB3319.eurprd08.prod.outlook.com (2603:10a6:209:4e::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 08:34:31 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8%4]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 08:34:31 +0000
Subject: Re: [PATCH v5 0/6] block: seriously improve savevm performance
To: qemu-devel@nongnu.org
References: <159256454989.466.16326042043777980183@d1fd068a5071>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <a0259034-3282-2676-da28-45cd234b2056@openvz.org>
Date: Mon, 22 Jun 2020 11:34:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <159256454989.466.16326042043777980183@d1fd068a5071>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: HE1P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::19)
 To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 08:34:30 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b3ed619-6d9f-4c3d-314b-08d81687155b
X-MS-TrafficTypeDiagnostic: AM6PR08MB3319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3319C2D04E4247FDF772DA03B6970@AM6PR08MB3319.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:57;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/V+QX5JFI86M6nJviysrJoBeCLUJEMZ0i8EIyhI65c7FFAzyMXWmd0LS3quD5WTu4vdR9EQ1/4zQ5zKad8sDzEjjG6QhXnHiHxuFapt/HZ9GfG7IR2avxVh1epTZ+Fu8d4o/D41vhqH2c1jnOhWSDuz9ugtvMW+jv5ZP/uOmb8gO1A61a45TQsaRg1YdK638LtJbvCDsqwxpoATaFjcOlHqJeew9LOErInM1BirnSY0VFT+3CE1Vm2Y5iDH7NhFf8x2y+6nC54knKm/PBa7VUCbZIESwYwHL/IylenRPbnyZE+tWd3qPCmBeOrLRwIoRZ38JiBCTwJhYf5GUdvTmquRgnWDRXh8UrMakDknxhp2UOsN0p6wNhv530a8sMeNNjmsPf3sD/Bti1kd9Ctm1Xkf0bfKxNUaXm+HCm/EqiHwLoW31kStK4Q020DPu4YR4vCNJmEcx4WMGnojDjBgWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(366004)(136003)(39840400004)(2906002)(53546011)(31696002)(5660300002)(186003)(316002)(16576012)(83170400001)(8676002)(31686004)(478600001)(26005)(36756003)(4326008)(966005)(6916009)(956004)(6486002)(52116002)(66556008)(66476007)(2616005)(66946007)(8936002)(30864003)(83380400001)(16526019)(42882007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: tQnlHXpHtH17SG8VBqfBfAIdszQWF/HDkjmVKEuzlI/cEWk2LVtBGNFDhA+OneRFQE6oJ8EWhRbGemAkJqrwAPTkL3MzEgmpZeSSxsn7rm4epKxJmpKh/8c+GMos+Ck1oPE0mdeoR72nNsHLtrjFaKJuqBqJ+TXAUwbe7idRP0TtLYB6uwUQGiml/7QHCLQU30TmP6mgVUMVuWFC+cFLoQKFKxe5D1AaV3ntgwaGs2IB02JoPTF9UYxs/UCZG2Xo7zmHdgN7UZnQVwnwHE4aa2JGXu3gUusROMIhtF1Dk0SzZDwygu73fRhnyBvWAJQZrYcwfRMkblFV5w68mAlCRmSnH94cD7CcEyG30p0BSEgWhd/5xsuOLe2o0rHTUF1osV8FmW3Di+WG8c/PveWjl9sUhThanrngWGsjpeHme8Y3k2omT+kxVaFwFYmPrONt9fcI2HZruFLBN47BWXf8BSo9MWA7OAUpHybJod7QmTzAjCY5EXIs7WZRMVctzxbl
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3ed619-6d9f-4c3d-314b-08d81687155b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 08:34:31.2166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vW0VDiSt/77t9yHq8VJdUrp0ubQ3P6Khgsg0/SpHKsNAIFVpgVZT2LpIrh7fGtmBM0o9Q11f0TP/gGRD7GNPtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3319
Received-SPF: pass client-ip=40.107.22.129; envelope-from=den@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 04:34:32
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com,
 mreitz@redhat.com, dplotnikov@virtuozzo.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/20 2:02 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200619100708.30440-1-den@openvz.o=
rg/
>
>
>
> Hi,
>
> This series failed the asan build test. Please find the testing commands =
and
> their output below. If you have Docker installed, you can probably reprod=
uce it
> locally.
>
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> export ARCH=3Dx86_64
> make docker-image-fedora V=3D1 NETWORK=3D1
> time make docker-test-debug@fedora TARGET_LIST=3Dx86_64-softmmu J=3D14 NE=
TWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>
>   GEN     docs/interop/qemu-qmp-ref.html
>   GEN     docs/interop/qemu-qmp-ref.txt
>   GEN     docs/interop/qemu-qmp-ref.7
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `  CC      qga/commands.o
>   CC      qga/guest-agent-command-state.o
>   CC      qga/main.o
>   CC      qga/commands-posix.o
> ---
>   LINK    elf2dmp
>   CC      qemu-img.o
>   AR      libvhost-user.a
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   AS      pc-bios/optionrom/linuxboot.o
>   CC      pc-bios/optionrom/linuxboot_dma.o
>   AS      pc-bios/optionrom/kvmvapic.o
> ---
>   SIGN    pc-bios/optionrom/pvh.bin
>   LINK    qemu-ga
>   LINK    qemu-keymap
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   LINK    ivshmem-client
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   LINK    ivshmem-server
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   LINK    qemu-nbd
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   LINK    qemu-storage-daemon
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   LINK    qemu-img
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   LINK    qemu-io
>   LINK    qemu-edid
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   LINK    fsdev/virtfs-proxy-helper
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   LINK    scsi/qemu-pr-helper
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   LINK    qemu-bridge-helper
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   LINK    virtiofsd
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   LINK    vhost-user-input
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
>   GEN     x86_64-softmmu/hmp-commands.h
>   GEN     x86_64-softmmu/config-devices.h
>   GEN     x86_64-softmmu/hmp-commands-info.h
> ---
>   CC      x86_64-softmmu/gdbstub-xml.o
>   CC      x86_64-softmmu/trace/generated-helpers.o
>   LINK    x86_64-softmmu/qemu-system-x86_64
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-x86_64.a(=
asan_interceptors_vfork.S.o): warning: common of `__interception::real_vfor=
k' overridden by definition from /usr/lib64/clang/10.0.0/lib/linux/libclang=
_rt.asan-x86_64.a(asan_interceptors.cpp.o)
> common.rc: line 50: test: check: binary operator expected
> (printf '#define QEMU_PKGVERSION ""\n'; printf '#define QEMU_FULL_VERSION=
 "5.0.50"\n'; ) > qemu-version.h.tmp
> make -C /tmp/qemu-test/src/slirp BUILD_DIR=3D"/tmp/qemu-test/build/slirp"=
 PKG_CONFIG=3D"pkg-config" CC=3D"clang" AR=3D"ar"      LD=3D"ld" RANLIB=3D"=
ranlib" CFLAGS=3D"-I/usr/include/pixman-1   -Werror -fsanitize=3Dundefined =
-fsanitize=3Daddress  -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.=
0/include  -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwr=
ite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -=
std=3Dgnu99  -Wold-style-definition -Wtype-limits -Wformat-security -Wforma=
t-y2k -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs -Wendi=
f-labels -Wexpansion-to-defined -Wno-initializer-overrides -Wno-missing-inc=
lude-dirs -Wno-shift-negative-value -Wno-string-plus-int -Wno-typedef-redef=
inition -Wno-tautological-type-limit-compare -fstack-protector-strong   -I/=
usr/include/p11-kit-1   -DSTRUCT_IOVEC_DEFINED  -I/usr/include/libpng16  -I=
/usr/include/spice-1 -I/usr/include/spice-server -I/usr/include/cacard -I/u=
sr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/nss3 -I/us=
r/include/nspr4 -pthread -I/usr/include/libmount -I/usr/include/blkid -I/us=
r/include/pixman-1   -I/tmp/qemu-test/src/tests -I/tmp/qemu-test/src/tests/=
qtest -g " LDFLAGS=3D"-Wl,--warn-common -fsanitize=3Dundefined -fsanitize=
=3Daddress -Wl,-z,relro -Wl,-z,now -pie -m64  -fstack-protector-strong"
> ---
> clang -iquote /tmp/qemu-test/build/tests -iquote tests -iquote /tmp/qemu-=
test/src/tcg/i386 -isystem /tmp/qemu-test/src/linux-headers -isystem /tmp/q=
emu-test/build/linux-headers -iquote . -iquote /tmp/qemu-test/src -iquote /=
tmp/qemu-test/src/accel/tcg -iquote /tmp/qemu-test/src/include -iquote /tmp=
/qemu-test/src/disas/libvixl -I/usr/include/pixman-1   -Werror -fsanitize=
=3Dundefined -fsanitize=3Daddress  -pthread -I/usr/include/glib-2.0 -I/usr/=
lib64/glib-2.0/include  -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSE=
T_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall=
 -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-com=
mon -fwrapv -std=3Dgnu99  -Wold-style-definition -Wtype-limits -Wformat-sec=
urity -Wformat-y2k -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-e=
xterns -Wendif-labels -Wexpansion-to-defined -Wno-initializer-overrides -Wn=
o-missing-include-dirs -Wno-shift-negative-value -Wno-string-plus-int -Wno-=
typedef-redefinition -Wno-tautological-type-limit-compare -fstack-protector=
-strong   -I/usr/include/p11-kit-1   -DSTRUCT_IOVEC_DEFINED  -I/usr/include=
/libpng16  -I/usr/include/spice-1 -I/usr/include/spice-server -I/usr/includ=
e/cacard -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/inclu=
de/nss3 -I/usr/include/nspr4 -pthread -I/usr/include/libmount -I/usr/includ=
e/blkid -I/usr/include/pixman-1   -I/tmp/qemu-test/src/tests -I/tmp/qemu-te=
st/src/tests/qtest -MMD -MP -MT tests/test-io-task.o -MF tests/test-io-task=
.d -g   -c -o tests/test-io-task.o /tmp/qemu-test/src/tests/test-io-task.c
> clang -iquote /tmp/qemu-test/build/tests -iquote tests -iquote /tmp/qemu-=
test/src/tcg/i386 -isystem /tmp/qemu-test/src/linux-headers -isystem /tmp/q=
emu-test/build/linux-headers -iquote . -iquote /tmp/qemu-test/src -iquote /=
tmp/qemu-test/src/accel/tcg -iquote /tmp/qemu-test/src/include -iquote /tmp=
/qemu-test/src/disas/libvixl -I/usr/include/pixman-1   -Werror -fsanitize=
=3Dundefined -fsanitize=3Daddress  -pthread -I/usr/include/glib-2.0 -I/usr/=
lib64/glib-2.0/include  -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSE=
T_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall=
 -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-com=
mon -fwrapv -std=3Dgnu99  -Wold-style-definition -Wtype-limits -Wformat-sec=
urity -Wformat-y2k -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-e=
xterns -Wendif-labels -Wexpansion-to-defined -Wno-initializer-overrides -Wn=
o-missing-include-dirs -Wno-shift-negative-value -Wno-string-plus-int -Wno-=
typedef-redefinition -Wno-tautological-type-limit-compare -fstack-protector=
-strong   -I/usr/include/p11-kit-1   -DSTRUCT_IOVEC_DEFINED  -I/usr/include=
/libpng16  -I/usr/include/spice-1 -I/usr/include/spice-server -I/usr/includ=
e/cacard -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/inclu=
de/nss3 -I/usr/include/nspr4 -pthread -I/usr/include/libmount -I/usr/includ=
e/blkid -I/usr/include/pixman-1   -I/tmp/qemu-test/src/tests -I/tmp/qemu-te=
st/src/tests/qtest -MMD -MP -MT tests/test-io-channel-socket.o -MF tests/te=
st-io-channel-socket.d -g   -c -o tests/test-io-channel-socket.o /tmp/qemu-=
test/src/tests/test-io-channel-socket.c
> clang -iquote /tmp/qemu-test/build/tests -iquote tests -iquote /tmp/qemu-=
test/src/tcg/i386 -isystem /tmp/qemu-test/src/linux-headers -isystem /tmp/q=
emu-test/build/linux-headers -iquote . -iquote /tmp/qemu-test/src -iquote /=
tmp/qemu-test/src/accel/tcg -iquote /tmp/qemu-test/src/include -iquote /tmp=
/qemu-test/src/disas/libvixl -I/usr/include/pixman-1   -Werror -fsanitize=
=3Dundefined -fsanitize=3Daddress  -pthread -I/usr/include/glib-2.0 -I/usr/=
lib64/glib-2.0/include  -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSE=
T_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall=
 -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-com=
mon -fwrapv -std=3Dgnu99  -Wold-style-definition -Wtype-limits -Wformat-sec=
urity -Wformat-y2k -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-e=
xterns -Wendif-labels -Wexpansion-to-defined -Wno-initializer-overrides -Wn=
o-missing-include-dirs -Wno-shift-negative-value -Wno-string-plus-int -Wno-=
typedef-redefinition -Wno-tautological-type-limit-compare -fstack-protector=
-strong   -I/usr/include/p11-kit-1   -DSTRUCT_IOVEC_DEFINED  -I/usr/include=
/libpng16  -I/usr/include/spice-1 -I/usr/include/spice-server -I/usr/includ=
e/cacard -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/inclu=
de/nss3 -I/usr/include/nspr4 -pthread -I/usr/include/libmount -I/usr/includ=
e/blkid -I/usr/include/pixman-1   -I/tmp/qemu-test/src/tests -I/tmp/qemu-te=
st/src/tests/qtest -MMD -MP -MT tests/io-channel-helpers.o -MF tests/io-cha=
nnel-helpers.d -g   -c -o tests/io-channel-helpers.o /tmp/qemu-test/src/tes=
ts/io-channel-helpers.c
> /tmp/qemu-test/src/tests/qht-bench.c:287:29: error: implicit conversion f=
rom 'unsigned long' to 'double' changes value from 18446744073709551615 to =
18446744073709551616 [-Werror,-Wimplicit-int-float-conversion]
>         *threshold =3D rate * UINT64_MAX;
>                           ~ ^~~~~~~~~~
> /usr/include/stdint.h:130:23: note: expanded from macro 'UINT64_MAX'
> ---
> 18446744073709551615UL
> ^~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
> make: *** [/tmp/qemu-test/src/rules.mak:69: tests/qht-bench.o] Error 1
> make: *** Waiting for unfinished jobs....
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 669, in <module>
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '=
--label', 'com.qemu.instance.uuid=3Dc67c2e4d508c4d55a517b3da9a7e6c35', '-u'=
, '1001', '--security-opt', 'seccomp=3Dunconfined', '--rm', '-e', 'TARGET_L=
IST=3Dx86_64-softmmu', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D', '-e',=
 'J=3D14', '-e', 'DEBUG=3D', '-e', 'SHOW_ENV=3D', '-e', 'CCACHE_DIR=3D/var/=
tmp/ccache', '-v', '/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccache=
:z', '-v', '/var/tmp/patchew-tester-tmp-k4xm9z3a/src/docker-src.2020-06-19-=
06.55.27.1715:/var/tmp/qemu:z,ro', 'qemu:fedora', '/var/tmp/qemu/run', 'tes=
t-debug']' returned non-zero exit status 2.
> filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3Dc67c2e4d508c4d55a517=
b3da9a7e6c35
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-k4xm9z3a/src'
> make: *** [docker-run-test-debug@fedora] Error 2
>
> real    7m2.468s
> user    0m9.043s
>
>
> The full log is available at
> http://patchew.org/logs/20200619100708.30440-1-den@openvz.org/testing.asa=
n/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
reported problems does not look patchset related :(



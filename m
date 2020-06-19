Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8A2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:50:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF4D4206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Tsygaucj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4D4206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKE8-0006RX-2D
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 12:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jmKDE-0005Tm-OA
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 12:49:56 -0400
Received: from mail-mw2nam12on2083.outbound.protection.outlook.com
 ([40.107.244.83]:57596 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jmKDA-0001QZ-Mc
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 12:49:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsO695X5ev5sNFcrITg3h6rHTvmfN3GMMWDU662FPSprz/SUbzy3vzEVXbU7x9V7YZ19iWw/69mX7f4rKb4kaDHosXgtdRSlSXFrd60TDJAw/8LHIo74J3XRMc5GgAYj2je1dg35chvWL8Re0Q6iQY//AKnSqLkH9jGsK7V/ZHYw5+z9PbRmcyzVgmfwXz4zgBiNPIVJjg27G/L3YxSAD+g6rzB92RHOAkE5QIduiLyu3emtRGboaZa+gdS6X5ozDDIs0nj/ZRYyS91i2oACVdjCsBXo6oBTlFTvIa8bbo0MNbXf6HpWgqRMg5Qr46lNszhgiVEzukgSS192A/99dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjTicLWGHD20B1cNJEPWPvQ5kehtuK1smt7QujYNqaM=;
 b=nykTrs+xlnIwkBmVhVee/tu0zWpk7BhyTnco8Khss9QV0IymmyKlef/gOfyvZISBuc5hUxV03/OaLnG3Rss5MkW5R9w+yk1cjs+C269qvS9ZRbRDZjbD0DB1XIJ0Zys/801K4uddZ5hwFPFiBebrOzgGB9DRXCfcbzEYWqodKPpVciIyDyUBkqg6KXNG9rB7IocrjfoYkyHXGf1r5vFnGAVQrKUYBf/ZpQFWB1Rj0glpI2kugIR6AyE+8TetqPDrtb+sYxyXIfETapdXtBV+o1Mcx9S87WoJm5UVyh9MPDivDA4nPJ7ZuoAUPpGYFc+WNUKkAY0tdU98lQZ2vnUjyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjTicLWGHD20B1cNJEPWPvQ5kehtuK1smt7QujYNqaM=;
 b=Tsygaucjd1vReK5P75wxD+sBpDsbCL3mxv2MGlDvoEmj6zqN1jaZX2CUKs7uyLrwWmRFBNuRZ6ROimtglwSPKhSe3dQoPiCJHVlUFlx3vs9LmnivdcnECh8Y+JzJCB0sn2xv2fwWsPtLKc89wWsjog+lR+8bwbpbPKG/dGgTOJ4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4478.namprd12.prod.outlook.com (2603:10b6:806:9c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 16:49:49 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 16:49:49 +0000
Subject: RE: [PATCH] target/i386: Remove core_id assert check in CPUID
 0x8000001E
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <159257395689.52908.4409314503988289481.stgit@naples-babu.amd.com>
 <159257793472.2784.12183250446741698076@d1fd068a5071>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <52dd3f9d-202f-8331-21e5-0af56e083ef8@amd.com>
Date: Fri, 19 Jun 2020 11:49:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <159257793472.2784.12183250446741698076@d1fd068a5071>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM3PR12CA0131.namprd12.prod.outlook.com
 (2603:10b6:0:51::27) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by
 DM3PR12CA0131.namprd12.prod.outlook.com (2603:10b6:0:51::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Fri, 19 Jun 2020 16:49:48 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5f80784a-5087-414d-79af-08d81470c784
X-MS-TrafficTypeDiagnostic: SA0PR12MB4478:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4478BBD459ADAAA44540E3A495980@SA0PR12MB4478.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:116;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 670OXXOa5J9M9lRwM/tH8RF61kUKtuYxUK1Z/8B0aEBhbt0l0Z8mvRdOIzHlxFUsYrv14FD37ZccMlEIz5aYkDhogUyZPpUl/0/iMUH7kFg4dHyNzYl6VbHDaOMUhaxQPzSjl/p9IJtgLdddtI6YPYprfxo0PxdWu/mQRoRONm2WV5ZrdoGXJ+gR13pvmjOnsSln6j4jjg2FhfCAKZdLXCaC/cuza8ke6OOo257zDf7NFK+AM17JeZkhy5nDOE1DNgZQ6J/5VwSHP4gCIAZyWwV/AmhsgT5uJuTfWE+9gjv6+pSsn0UsgrXO7AaPfCNgfPBy3zIKdKNUx94LmUFW/GS0mKHi7Jht9UagKWotbaTRYJ+9ODGItJbBlZHIAthAz/EuONtmZh682Yuk68KEvnCDHox9zr1c8+WugHGmIrJYTwaOLzlUORg9W39bVGMaVhrdiPE0SPHDRM/kuGJZcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(19627235002)(5660300002)(31696002)(16576012)(316002)(54906003)(45080400002)(4326008)(8676002)(8936002)(83380400001)(966005)(6486002)(478600001)(16526019)(2906002)(36756003)(66946007)(66476007)(66556008)(31686004)(86362001)(6916009)(2616005)(52116002)(30864003)(53546011)(956004)(83080400001)(44832011)(186003)(26005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 59OyuFfRfA9F+EuNxUc0LF3OD6Z7LzS93ti0rlrMtlXalMUnmJLHqYOV5E+zBpw5P5tgVyjRoc75RzZbhH1YzMzGvvfWzlxpfEp7DFeCQx6GAaJgGT6apeCM/X2zCkMEcIQrtEmlNv7zeBp432zCc0ouz7DSJphyEJ8cwS+A6q2Rl7OSJ1lKQgDopIwIJSuuMfm3fGIdgmWTbCcz0SoCp6tSz9vyh4BqwbjfmzhNEUOZ+nw/fetxAbNeezjS5mkOmTB778YadlxmejhcPbZRDBDlhcQ5VFY2ZCa6zaDGlINS6z3efm9ORJERx86s+FenDy6ewJtBJbY7Pae4HuNlLr3/Vws/FvasuvM0EHh848ykchRU2TGXiektBvFLhvVwp9I6IM8GiJl95mxh7prg85rd1cxwNvxDkoFLZ5iP3Kq5eFUFc1B+KkXZ9UprLEsjfqxgmSJ1R23YiwAcxYUAsNMw7bwjKNNk95hOUglfSqU=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f80784a-5087-414d-79af-08d81470c784
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 16:49:49.1054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfpodmOePQJw+iT3LgWLfBlVKQz+WfQxZDsUNAjBk1nOjY/gtewY2FB7/ypfKZWl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4478
Received-SPF: none client-ip=40.107.244.83; envelope-from=Babu.Moger@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 12:49:50
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: no-reply@patchew.org <no-reply@patchew.org>
> Sent: Friday, June 19, 2020 9:46 AM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com; qemu-
> devel@nongnu.org
> Subject: Re: [PATCH] target/i386: Remove core_id assert check in CPUID
> 0x8000001E
> 
> Patchew URL:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatche
> w.org%2FQEMU%2F159257395689.52908.4409314503988289481.stgit%40napl
> es-
> babu.amd.com%2F&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C21f9
> e4ac5c634f97683208d8145f6f86%7C3dd8961fe4884e608e11a82d994e183d%7
> C0%7C0%7C637281748288967871&amp;sdata=GN6z6Yf7Nt0eRUHT8Tmu3%2F
> H1nONfs53mHTtcI1wvmvI%3D&amp;reserved=0
> 
> 
> 
> Hi,
> 
> This series failed the asan build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.

I do not think this failure has anything to do with these series. I will
just ignore.


 > > === TEST SCRIPT BEGIN ===
> #!/bin/bash
> export ARCH=x86_64
> make docker-image-fedora V=1 NETWORK=1
> time make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu J=14
> NETWORK=1
> === TEST SCRIPT END ===
> 
>   CC      qga/qapi-generated/qga-qapi-commands.o
>   CC      qga/qapi-generated/qga-qapi-init-commands.o
>   AR      libqemuutil.a
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors_vfork.S.o): warning: common of
> `__interception::real_vfork' overridden by definition from
> /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors.cpp.o)
>   LINK    elf2dmp
>   CC      qemu-img.o
>   AR      libvhost-user.a
>   GEN     docs/interop/qemu-ga-ref.html
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors_vfork.S.o): warning: common of
> `__interception::real_vfork' overridden by definition from
> /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors.cpp.o)
>   GEN     docs/interop/qemu-ga-ref.txt
>   GEN     docs/interop/qemu-ga-ref.7
>   AS      pc-bios/optionrom/multiboot.o
> ---
>   SIGN    pc-bios/optionrom/pvh.bin
>   LINK    qemu-ga
>   LINK    qemu-keymap
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors_vfork.S.o): warning: common of
> `__interception::real_vfork' overridden by definition from
> /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors.cpp.o)
>   LINK    ivshmem-client
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors_vfork.S.o): warning: common of
> `__interception::real_vfork' overridden by definition from
> /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors.cpp.o)
>   LINK    ivshmem-server
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors_vfork.S.o): warning: common of
> `__interception::real_vfork' overridden by definition from
> /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors.cpp.o)
>   LINK    qemu-nbd
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors_vfork.S.o): warning: common of
> `__interception::real_vfork' overridden by definition from
> /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors.cpp.o)
>   LINK    qemu-storage-daemon
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors_vfork.S.o): warning: common of
> `__interception::real_vfork' overridden by definition from
> /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors.cpp.o)
>   LINK    qemu-img
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors_vfork.S.o): warning: common of
> `__interception::real_vfork' overridden by definition from
> /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors.cpp.o)
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors_vfork.S.o): warning: common of
> `__interception::real_vfork' overridden by definition from
> /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors.cpp.o)
>   LINK    qemu-io
>   LINK    qemu-edid
>   LINK    fsdev/virtfs-proxy-helper
> ---
>   LINK    qemu-bridge-helper
>   LINK    virtiofsd
>   LINK    vhost-user-input
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors_vfork.S.o): warning: common of
> `__interception::real_vfork' overridden by definition from
> /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors.cpp.o)
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors_vfork.S.o): warning: common of
> `__interception::real_vfork' overridden by definition from
> /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors.cpp.o)
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors_vfork.S.o): warning: common of
> `__interception::real_vfork' overridden by definition from
> /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors.cpp.o)
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors_vfork.S.o): warning: common of
> `__interception::real_vfork' overridden by definition from
> /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors.cpp.o)
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors_vfork.S.o): warning: common of
> `__interception::real_vfork' overridden by definition from
> /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors.cpp.o)
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors_vfork.S.o): warning: common of
> `__interception::real_vfork' overridden by definition from
> /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors.cpp.o)
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors_vfork.S.o): warning: common of
> `__interception::real_vfork' overridden by definition from
> /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors.cpp.o)
>   GEN     x86_64-softmmu/hmp-commands-info.h
>   GEN     x86_64-softmmu/hmp-commands.h
>   GEN     x86_64-softmmu/config-devices.h
> ---
>   CC      x86_64-softmmu/gdbstub-xml.o
>   CC      x86_64-softmmu/trace/generated-helpers.o
>   LINK    x86_64-softmmu/qemu-system-x86_64
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors_vfork.S.o): warning: common of
> `__interception::real_vfork' overridden by definition from
> /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors.cpp.o)
> common.rc: line 50: test: check: binary operator expected
> (printf '#define QEMU_PKGVERSION ""\n'; printf '#define QEMU_FULL_VERSION
> "5.0.50"\n'; ) > qemu-version.h.tmp
> make -C /tmp/qemu-test/src/slirp BUILD_DIR="/tmp/qemu-test/build/slirp"
> PKG_CONFIG="pkg-config" CC="clang" AR="ar"      LD="ld" RANLIB="ranlib"
> CFLAGS="-I/usr/include/pixman-1   -Werror -fsanitize=undefined -
> fsanitize=address  -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include  -
> fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -
> D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -
> Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv
> -std=gnu99  -Wold-style-definition -Wtype-limits -Wformat-security -Wformat-
> y2k -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-
> labels -Wexpansion-to-defined -Wno-initializer-overrides -Wno-missing-include-
> dirs -Wno-shift-negative-value -Wno-string-plus-int -Wno-typedef-redefinition -
> Wno-tautological-type-limit-compare -fstack-protector-strong   -
> I/usr/include/p11-kit-1   -DSTRUCT_IOVEC_DEFINED  -I/usr/include/libpng16  -
> I/usr/include/spice-1 -I/usr/include/spice-server -I/usr/include/cacard -
> I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/nss3 -
> I/usr/include/nspr4 -pthread -I/usr/include/libmount -I/usr/include/blkid -
> I/usr/include/pixman-1   -I/tmp/qemu-test/src/tests -I/tmp/qemu-
> test/src/tests/qtest -g " LDFLAGS="-Wl,--warn-common -fsanitize=undefined -
> fsanitize=address -Wl,-z,relro -Wl,-z,now -pie -m64  -fstack-protector-strong"
> ---
> make  BUILD_DIR=/tmp/qemu-test/build -C /tmp/qemu-test/build/tests/fp/
> V="1" fp-test
> clang -iquote /tmp/qemu-test/build/tests/qtest -iquote tests/qtest -iquote
> /tmp/qemu-test/src/tcg/i386 -isystem /tmp/qemu-test/src/linux-headers -
> isystem /tmp/qemu-test/build/linux-headers -iquote . -iquote /tmp/qemu-
> test/src -iquote /tmp/qemu-test/src/accel/tcg -iquote /tmp/qemu-
> test/src/include -iquote /tmp/qemu-test/src/disas/libvixl -I/usr/include/pixman-
> 1   -Werror -fsanitize=undefined -fsanitize=address  -pthread -I/usr/include/glib-
> 2.0 -I/usr/lib64/glib-2.0/include  -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -
> D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -
> Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-
> strict-aliasing -fno-common -fwrapv -std=gnu99  -Wold-style-definition -Wtype-
> limits -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -
> Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined -Wno-
> initializer-overrides -Wno-missing-include-dirs -Wno-shift-negative-value -Wno-
> string-plus-int -Wno-typedef-redefinition -Wno-tautological-type-limit-compare
> -fstack-protector-strong   -I/usr/include/p11-kit-1   -DSTRUCT_IOVEC_DEFINED
> -I/usr/include/libpng16  -I/usr/include/spice-1 -I/usr/include/spice-server -
> I/usr/include/cacard -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -
> I/usr/include/nss3 -I/usr/include/nspr4 -pthread -I/usr/include/libmount -
> I/usr/include/blkid -I/usr/include/pixman-1   -I/tmp/qemu-test/src/tests -
> I/tmp/qemu-test/src/tests/qtest -MMD -MP -MT tests/qtest/endianness-test.o -
> MF tests/qtest/endianness-test.d -g   -c -o tests/qtest/endianness-test.o
> /tmp/qemu-test/src/tests/qtest/endianness-test.c
> clang -iquote /tmp/qemu-test/build/tests/qtest -iquote tests/qtest -iquote
> /tmp/qemu-test/src/tcg/i386 -isystem /tmp/qemu-test/src/linux-headers -
> isystem /tmp/qemu-test/build/linux-headers -iquote . -iquote /tmp/qemu-
> test/src -iquote /tmp/qemu-test/src/accel/tcg -iquote /tmp/qemu-
> test/src/include -iquote /tmp/qemu-test/src/disas/libvixl -I/usr/include/pixman-
> 1   -Werror -fsanitize=undefined -fsanitize=address  -pthread -I/usr/include/glib-
> 2.0 -I/usr/lib64/glib-2.0/include  -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -
> D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -
> Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-
> strict-aliasing -fno-common -fwrapv -std=gnu99  -Wold-style-definition -Wtype-
> limits -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -
> Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined -Wno-
> initializer-overrides -Wno-missing-include-dirs -Wno-shift-negative-value -Wno-
> string-plus-int -Wno-typedef-redefinition -Wno-tautological-type-limit-compare
> -fstack-protector-strong   -I/usr/include/p11-kit-1   -DSTRUCT_IOVEC_DEFINED
> -I/usr/include/libpng16  -I/usr/include/spice-1 -I/usr/include/spice-server -
> I/usr/include/cacard -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -
> I/usr/include/nss3 -I/usr/include/nspr4 -pthread -I/usr/include/libmount -
> I/usr/include/blkid -I/usr/include/pixman-1   -I/tmp/qemu-test/src/tests -
> I/tmp/qemu-test/src/tests/qtest -MMD -MP -MT tests/qtest/fdc-test.o -MF
> tests/qtest/fdc-test.d -g   -c -o tests/qtest/fdc-test.o /tmp/qemu-
> test/src/tests/qtest/fdc-test.c
> /tmp/qemu-test/src/tests/qht-bench.c:287:29: error: implicit conversion from
> 'unsigned long' to 'double' changes value from 18446744073709551615 to
> 18446744073709551616 [-Werror,-Wimplicit-int-float-conversion]
>         *threshold = rate * UINT64_MAX;
>                           ~ ^~~~~~~~~~
> /usr/include/stdint.h:130:23: note: expanded from macro 'UINT64_MAX'
> ---
> make[1]: Entering directory '/tmp/qemu-test/build/tests/fp'
> clang -iquote /tmp/qemu-test/build/. -iquote . -iquote /tmp/qemu-
> test/src/tcg/i386 -isystem /tmp/qemu-test/src/linux-headers -isystem
> /tmp/qemu-test/build/linux-headers -iquote . -iquote /tmp/qemu-test/src -
> iquote /tmp/qemu-test/src/accel/tcg -iquote /tmp/qemu-test/src/include -
> iquote /tmp/qemu-test/src/disas/libvixl -I/tmp/qemu-test/src/tests/fp -
> I/tmp/qemu-test/src/tests/fp/berkeley-softfloat-3/source/include -
> I/tmp/qemu-test/src/tests/fp/berkeley-softfloat-3/source/8086-SSE -
> I/tmp/qemu-test/src/tests/fp/berkeley-testfloat-3/source -
> I/usr/include/pixman-1 -Werror -fsanitize=undefined -fsanitize=address -pthread
> -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -fPIE -DPIE -m64 -mcx16 -
> D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-
> prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-
> prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99 -Wold-style-
> definition -Wtype-limits -Wformat-security -Wformat-y2k -Winit-self -
> Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels -
> Wexpansion-to-defined -Wno-initializer-overrides -Wno-missing-include-dirs -
> Wno-shift-negative-value -Wno-string-plus-int -Wno-typedef-redefinition -Wno-
> tautological-type-limit-compare -fstack-protector-strong -I/usr/include/p11-kit-
> 1 -DSTRUCT_IOVEC_DEFINED -I/usr/include/libpng16 -I/usr/include/spice-1 -
> I/usr/include/spice-server -I/usr/include/cacard -I/usr/include/glib-2.0 -
> I/usr/lib64/glib-2.0/include -I/usr/include/nss3 -I/usr/include/nspr4 -pthread -
> I/usr/include/libmount -I/usr/include/blkid -I/usr/include/pixman-1 -
> DHW_POISON_H -DTARGET_ARM  -DSOFTFLOAT_ROUND_ODD -
> DINLINE_LEVEL=5 -DSOFTFLOAT_FAST_DIV32TO16 -
> DSOFTFLOAT_FAST_DIV64TO32 -DSOFTFLOAT_FAST_INT64  -DFLOAT16 -
> DFLOAT64 -DEXTFLOAT80 -DFLOAT128 -DFLOAT_ROUND_ODD -
> DLONG_DOUBLE_IS_EXTFLOAT80 -MMD -MP -MT fp-test.o -MF ./fp-test.d -g   -
> c -o fp-test.o /tmp/qemu-test/src/tests/fp/fp-test.c
> clang -iquote /tmp/qemu-test/build/. -iquote . -iquote /tmp/qemu-
> test/src/tcg/i386 -isystem /tmp/qemu-test/src/linux-headers -isystem
> /tmp/qemu-test/build/linux-headers -iquote . -iquote /tmp/qemu-test/src -
> iquote /tmp/qemu-test/src/accel/tcg -iquote /tmp/qemu-test/src/include -
> iquote /tmp/qemu-test/src/disas/libvixl -I/tmp/qemu-test/src/tests/fp -
> I/tmp/qemu-test/src/tests/fp/berkeley-softfloat-3/source/include -
> I/tmp/qemu-test/src/tests/fp/berkeley-softfloat-3/source/8086-SSE -
> I/tmp/qemu-test/src/tests/fp/berkeley-testfloat-3/source -
> I/usr/include/pixman-1 -Werror -fsanitize=undefined -fsanitize=address -pthread
> -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -fPIE -DPIE -m64 -mcx16 -
> D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-
> prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-
> prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99 -Wold-style-
> definition -Wtype-limits -Wformat-security -Wformat-y2k -Winit-self -
> Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels -
> Wexpansion-to-defined -Wno-initializer-overrides -Wno-missing-include-dirs -
> Wno-shift-negative-value -Wno-string-plus-int -Wno-typedef-redefinition -Wno-
> tautological-type-limit-compare -fstack-protector-strong -I/usr/include/p11-kit-
> 1 -DSTRUCT_IOVEC_DEFINED -I/usr/include/libpng16 -I/usr/include/spice-1 -
> I/usr/include/spice-server -I/usr/include/cacard -I/usr/include/glib-2.0 -
> I/usr/lib64/glib-2.0/include -I/usr/include/nss3 -I/usr/include/nspr4 -pthread -
> I/usr/include/libmount -I/usr/include/blkid -I/usr/include/pixman-1 -
> DHW_POISON_H -DTARGET_ARM  -DSOFTFLOAT_ROUND_ODD -
> DINLINE_LEVEL=5 -DSOFTFLOAT_FAST_DIV32TO16 -
> DSOFTFLOAT_FAST_DIV64TO32 -DSOFTFLOAT_FAST_INT64  -DFLOAT16 -
> DFLOAT64 -DEXTFLOAT80 -DFLOAT128 -DFLOAT_ROUND_ODD -
> DLONG_DOUBLE_IS_EXTFLOAT80  -Wno-strict-prototypes -Wno-unknown-
> pragmas -Wno-uninitialized -Wno-missing-prototypes -Wno-return-type -Wno-
> unused-function -Wno-error -MMD -MP -MT slowfloat.o -MF ./slowfloat.d -g   -
> c -o slowfloat.o /tmp/qemu-test/src/tests/fp/berkeley-testfloat-
> 3/source/slowfloat.c
> make: *** [/tmp/qemu-test/src/rules.mak:69: tests/qht-bench.o] Error 1
> make: *** Waiting for unfinished jobs....
> clang -iquote /tmp/qemu-test/build/. -iquote . -iquote /tmp/qemu-
> test/src/tcg/i386 -isystem /tmp/qemu-test/src/linux-headers -isystem
> /tmp/qemu-test/build/linux-headers -iquote . -iquote /tmp/qemu-test/src -
> iquote /tmp/qemu-test/src/accel/tcg -iquote /tmp/qemu-test/src/include -
> iquote /tmp/qemu-test/src/disas/libvixl -I/tmp/qemu-test/src/tests/fp -
> I/tmp/qemu-test/src/tests/fp/berkeley-softfloat-3/source/include -
> I/tmp/qemu-test/src/tests/fp/berkeley-softfloat-3/source/8086-SSE -
> I/tmp/qemu-test/src/tests/fp/berkeley-testfloat-3/source -
> I/usr/include/pixman-1 -Werror -fsanitize=undefined -fsanitize=address -pthread
> -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -fPIE -DPIE -m64 -mcx16 -
> D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-
> prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-
> prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99 -Wold-style-
> definition -Wtype-limits -Wformat-security -Wformat-y2k -Winit-self -
> Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels -
> Wexpansion-to-defined -Wno-initializer-overrides -Wno-missing-include-dirs -
> Wno-shift-negative-value -Wno-string-plus-int -Wno-typedef-redefinition -Wno-
> tautological-type-limit-compare -fstack-protector-strong -I/usr/include/p11-kit-
> 1 -DSTRUCT_IOVEC_DEFINED -I/usr/include/libpng16 -I/usr/include/spice-1 -
> I/usr/include/spice-server -I/usr/include/cacard -I/usr/include/glib-2.0 -
> I/usr/lib64/glib-2.0/include -I/usr/include/nss3 -I/usr/include/nspr4 -pthread -
> I/usr/include/libmount -I/usr/include/blkid -I/usr/include/pixman-1 -
> DHW_POISON_H -DTARGET_ARM  -DSOFTFLOAT_ROUND_ODD -
> DINLINE_LEVEL=5 -DSOFTFLOAT_FAST_DIV32TO16 -
> DSOFTFLOAT_FAST_DIV64TO32 -DSOFTFLOAT_FAST_INT64  -DFLOAT16 -
> DFLOAT64 -DEXTFLOAT80 -DFLOAT128 -DFLOAT_ROUND_ODD -
> DLONG_DOUBLE_IS_EXTFLOAT80 -MMD -MP -MT softfloat.o -MF ./softfloat.d -
> g   -c -o softfloat.o /tmp/qemu-test/src/fpu/softfloat.c
> clang -iquote /tmp/qemu-test/build/. -iquote . -iquote /tmp/qemu-
> test/src/tcg/i386 -isystem /tmp/qemu-test/src/linux-headers -isystem
> /tmp/qemu-test/build/linux-headers -iquote . -iquote /tmp/qemu-test/src -
> iquote /tmp/qemu-test/src/accel/tcg -iquote /tmp/qemu-test/src/include -
> iquote /tmp/qemu-test/src/disas/libvixl -I/tmp/qemu-test/src/tests/fp -
> I/tmp/qemu-test/src/tests/fp/berkeley-softfloat-3/source/include -
> I/tmp/qemu-test/src/tests/fp/berkeley-softfloat-3/source/8086-SSE -
> I/tmp/qemu-test/src/tests/fp/berkeley-testfloat-3/source -
> I/usr/include/pixman-1 -Werror -fsanitize=undefined -fsanitize=address -pthread
> -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -fPIE -DPIE -m64 -mcx16 -
> D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-
> prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-
> prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99 -Wold-style-
> definition -Wtype-limits -Wformat-security -Wformat-y2k -Winit-self -
> Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels -
> Wexpansion-to-defined -Wno-initializer-overrides -Wno-missing-include-dirs -
> Wno-shift-negative-value -Wno-string-plus-int -Wno-typedef-redefinition -Wno-
> tautological-type-limit-compare -fstack-protector-strong -I/usr/include/p11-kit-
> 1 -DSTRUCT_IOVEC_DEFINED -I/usr/include/libpng16 -I/usr/include/spice-1 -
> I/usr/include/spice-server -I/usr/include/cacard -I/usr/include/glib-2.0 -
> I/usr/lib64/glib-2.0/include -I/usr/include/nss3 -I/usr/include/nspr4 -pthread -
> I/usr/include/libmount -I/usr/include/blkid -I/usr/include/pixman-1 -
> DHW_POISON_H -DTARGET_ARM  -DSOFTFLOAT_ROUND_ODD -
> DINLINE_LEVEL=5 -DSOFTFLOAT_FAST_DIV32TO16 -
> DSOFTFLOAT_FAST_DIV64TO32 -DSOFTFLOAT_FAST_INT64  -DFLOAT16 -
> DFLOAT64 -DEXTFLOAT80 -DFLOAT128 -DFLOAT_ROUND_ODD -
> DLONG_DOUBLE_IS_EXTFLOAT80  -Wno-strict-prototypes -Wno-unknown-
> pragmas -Wno-uninitialized -Wno-missing-prototypes -Wno-return-type -Wno-
> unused-function -Wno-error -MMD -MP -MT uint128_inline.o -MF
> ./uint128_inline.d -g   -c -o uint128_inline.o /tmp/qemu-
> test/src/tests/fp/berkeley-testfloat-3/source/uint128_inline.c
> ---
> rm -f libtestfloat.a && ar rcs libtestfloat.a uint128_inline.o uint128.o fail.o
> functions_common.o functionInfos.o standardFunctionInfos.o random.o
> genCases_common.o genCases_ui32.o genCases_ui64.o genCases_i32.o
> genCases_i64.o genCases_f16.o genCases_f32.o genCases_f64.o
> genCases_extF80.o genCases_f128.o genCases_writeTestsTotal.o
> verCases_inline.o verCases_common.o verCases_writeFunctionName.o
> readHex.o writeHex.o writeCase_a_ui32.o writeCase_a_ui64.o
> writeCase_a_f16.o writeCase_ab_f16.o writeCase_abc_f16.o
> writeCase_a_f32.o writeCase_ab_f32.o writeCase_abc_f32.o
> writeCase_a_f64.o writeCase_ab_f64.o writeCase_abc_f64.o
> writeCase_a_extF80M.o writeCase_ab_extF80M.o writeCase_a_f128M.o
> writeCase_ab_f128M.o writeCase_abc_f128M.o writeCase_z_bool.o
> writeCase_z_ui32.o writeCase_z_ui64.o writeCase_z_f16.o writeCase_z_f32.o
> writeCase_z_f64.o writeCase_z_extF80M.o writeCase_z_f128M.o
> testLoops_common.o test_a_ui32_z_f16.o test_a_ui32_z_f32.o
> test_a_ui32_z_f64.o test_a_ui32_z_extF80.o test_a_ui32_z_f128.o
> test_a_ui64_z_f16.o test_a_ui64_z_f32.o test_a_ui64_z_f64.o
> test_a_ui64_z_extF80.o test_a_ui64_z_f128.o test_a_i32_z_f16.o
> test_a_i32_z_f32.o test_a_i32_z_f64.o test_a_i32_z_extF80.o
> test_a_i32_z_f128.o test_a_i64_z_f16.o test_a_i64_z_f32.o test_a_i64_z_f64.o
> test_a_i64_z_extF80.o test_a_i64_z_f128.o test_a_f16_z_ui32_rx.o
> test_a_f16_z_ui64_rx.o test_a_f16_z_i32_rx.o test_a_f16_z_i64_rx.o
> test_a_f16_z_ui32_x.o test_a_f16_z_ui64_x.o test_a_f16_z_i32_x.o
> test_a_f16_z_i64_x.o test_a_f16_z_f32.o test_a_f16_z_f64.o
> test_a_f16_z_extF80.o test_a_f16_z_f128.o test_az_f16.o test_az_f16_rx.o
> test_abz_f16.o test_abcz_f16.o test_ab_f16_z_bool.o test_a_f32_z_ui32_rx.o
> test_a_f32_z_ui64_rx.o test_a_f32_z_i32_rx.o test_a_f32_z_i64_rx.o
> test_a_f32_z_ui32_x.o test_a_f32_z_ui64_x.o test_a_f32_z_i32_x.o
> test_a_f32_z_i64_x.o test_a_f32_z_f16.o test_a_f32_z_f64.o
> test_a_f32_z_extF80.o test_a_f32_z_f128.o test_az_f32.o test_az_f32_rx.o
> test_abz_f32.o test_abcz_f32.o test_ab_f32_z_bool.o test_a_f64_z_ui32_rx.o
> test_a_f64_z_ui64_rx.o test_a_f64_z_i32_rx.o test_a_f64_z_i64_rx.o
> test_a_f64_z_ui32_x.o test_a_f64_z_ui64_x.o test_a_f64_z_i32_x.o
> test_a_f64_z_i64_x.o test_a_f64_z_f16.o test_a_f64_z_f32.o
> test_a_f64_z_extF80.o test_a_f64_z_f128.o test_az_f64.o test_az_f64_rx.o
> test_abz_f64.o test_abcz_f64.o test_ab_f64_z_bool.o
> test_a_extF80_z_ui32_rx.o test_a_extF80_z_ui64_rx.o
> test_a_extF80_z_i32_rx.o test_a_extF80_z_i64_rx.o test_a_extF80_z_ui32_x.o
> test_a_extF80_z_ui64_x.o test_a_extF80_z_i32_x.o test_a_extF80_z_i64_x.o
> test_a_extF80_z_f16.o test_a_extF80_z_f32.o test_a_extF80_z_f64.o
> test_a_extF80_z_f128.o test_az_extF80.o test_az_extF80_rx.o
> test_abz_extF80.o test_ab_extF80_z_bool.o test_a_f128_z_ui32_rx.o
> test_a_f128_z_ui64_rx.o test_a_f128_z_i32_rx.o test_a_f128_z_i64_rx.o
> test_a_f128_z_ui32_x.o test_a_f128_z_ui64_x.o test_a_f128_z_i32_x.o
> test_a_f128_z_i64_x.o test_a_f128_z_f16.o test_a_f128_z_f32.o
> test_a_f128_z_f64.o test_a_f128_z_extF80.o test_az_f128.o test_az_f128_rx.o
> test_abz_f128.o test_abcz_f128.o test_ab_f128_z_bool.o
> rm -f libsoftfloat.a && ar rcs libsoftfloat.a s_eq128.o s_le128.o s_lt128.o
> s_shortShiftLeft128.o s_shortShiftRight128.o s_shortShiftRightJam64.o
> s_shortShiftRightJam64Extra.o s_shortShiftRightJam128.o
> s_shortShiftRightJam128Extra.o s_shiftRightJam32.o s_shiftRightJam64.o
> s_shiftRightJam64Extra.o s_shiftRightJam128.o s_shiftRightJam128Extra.o
> s_shiftRightJam256M.o s_countLeadingZeros8.o s_countLeadingZeros16.o
> s_countLeadingZeros32.o s_countLeadingZeros64.o s_add128.o s_add256M.o
> s_sub128.o s_sub256M.o s_mul64ByShifted32To128.o s_mul64To128.o
> s_mul128By32.o s_mul128To256M.o s_approxRecip_1Ks.o
> s_approxRecip32_1.o s_approxRecipSqrt_1Ks.o s_approxRecipSqrt32_1.o
> s_roundToUI32.o s_roundToUI64.o s_roundToI32.o s_roundToI64.o
> s_normSubnormalF16Sig.o s_roundPackToF16.o s_normRoundPackToF16.o
> s_addMagsF16.o s_subMagsF16.o s_mulAddF16.o s_normSubnormalF32Sig.o
> s_roundPackToF32.o s_normRoundPackToF32.o s_addMagsF32.o
> s_subMagsF32.o s_mulAddF32.o s_normSubnormalF64Sig.o
> s_roundPackToF64.o s_normRoundPackToF64.o s_addMagsF64.o
> s_subMagsF64.o s_mulAddF64.o s_normSubnormalExtF80Sig.o
> s_roundPackToExtF80.o s_normRoundPackToExtF80.o s_addMagsExtF80.o
> s_subMagsExtF80.o s_normSubnormalF128Sig.o s_roundPackToF128.o
> s_normRoundPackToF128.o s_addMagsF128.o s_subMagsF128.o
> s_mulAddF128.o softfloat_state.o ui32_to_f16.o ui32_to_f32.o ui32_to_f64.o
> ui32_to_extF80.o ui32_to_extF80M.o ui32_to_f128.o ui32_to_f128M.o
> ui64_to_f16.o ui64_to_f32.o ui64_to_f64.o ui64_to_extF80.o
> ui64_to_extF80M.o ui64_to_f128.o ui64_to_f128M.o i32_to_f16.o
> i32_to_f32.o i32_to_f64.o i32_to_extF80.o i32_to_extF80M.o i32_to_f128.o
> i32_to_f128M.o i64_to_f16.o i64_to_f32.o i64_to_f64.o i64_to_extF80.o
> i64_to_extF80M.o i64_to_f128.o i64_to_f128M.o f16_to_ui32.o f16_to_ui64.o
> f16_to_i32.o f16_to_i64.o f16_to_ui32_r_minMag.o f16_to_ui64_r_minMag.o
> f16_to_i32_r_minMag.o f16_to_i64_r_minMag.o f16_to_f32.o f16_to_f64.o
> f16_to_extF80.o f16_to_extF80M.o f16_to_f128.o f16_to_f128M.o
> f16_roundToInt.o f16_add.o f16_sub.o f16_mul.o f16_mulAdd.o f16_div.o
> f16_rem.o f16_sqrt.o f16_eq.o f16_le.o f16_lt.o f16_eq_signaling.o
> f16_le_quiet.o f16_lt_quiet.o f16_isSignalingNaN.o f32_to_ui32.o
> f32_to_ui64.o f32_to_i32.o f32_to_i64.o f32_to_ui32_r_minMag.o
> f32_to_ui64_r_minMag.o f32_to_i32_r_minMag.o f32_to_i64_r_minMag.o
> f32_to_f16.o f32_to_f64.o f32_to_extF80.o f32_to_extF80M.o f32_to_f128.o
> f32_to_f128M.o f32_roundToInt.o f32_add.o f32_sub.o f32_mul.o
> f32_mulAdd.o f32_div.o f32_rem.o f32_sqrt.o f32_eq.o f32_le.o f32_lt.o
> f32_eq_signaling.o f32_le_quiet.o f32_lt_quiet.o f32_isSignalingNaN.o
> f64_to_ui32.o f64_to_ui64.o f64_to_i32.o f64_to_i64.o
> f64_to_ui32_r_minMag.o f64_to_ui64_r_minMag.o f64_to_i32_r_minMag.o
> f64_to_i64_r_minMag.o f64_to_f16.o f64_to_f32.o f64_to_extF80.o
> f64_to_extF80M.o f64_to_f128.o f64_to_f128M.o f64_roundToInt.o f64_add.o
> f64_sub.o f64_mul.o f64_mulAdd.o f64_div.o f64_rem.o f64_sqrt.o f64_eq.o
> f64_le.o f64_lt.o f64_eq_signaling.o f64_le_quiet.o f64_lt_quiet.o
> f64_isSignalingNaN.o extF80_to_ui32.o extF80_to_ui64.o extF80_to_i32.o
> extF80_to_i64.o extF80_to_ui32_r_minMag.o extF80_to_ui64_r_minMag.o
> extF80_to_i32_r_minMag.o extF80_to_i64_r_minMag.o extF80_to_f16.o
> extF80_to_f32.o extF80_to_f64.o extF80_to_f128.o extF80_roundToInt.o
> extF80_add.o extF80_sub.o extF80_mul.o extF80_div.o extF80_rem.o
> extF80_sqrt.o extF80_eq.o extF80_le.o extF80_lt.o extF80_eq_signaling.o
> extF80_le_quiet.o extF80_lt_quiet.o extF80_isSignalingNaN.o
> extF80M_to_ui32.o extF80M_to_ui64.o extF80M_to_i32.o extF80M_to_i64.o
> extF80M_to_ui32_r_minMag.o extF80M_to_ui64_r_minMag.o
> extF80M_to_i32_r_minMag.o extF80M_to_i64_r_minMag.o extF80M_to_f16.o
> extF80M_to_f32.o extF80M_to_f64.o extF80M_to_f128M.o
> extF80M_roundToInt.o extF80M_add.o extF80M_sub.o extF80M_mul.o
> extF80M_div.o extF80M_rem.o extF80M_sqrt.o extF80M_eq.o extF80M_le.o
> extF80M_lt.o extF80M_eq_signaling.o extF80M_le_quiet.o extF80M_lt_quiet.o
> f128_to_ui32.o f128_to_ui64.o f128_to_i32.o f128_to_i64.o
> f128_to_ui32_r_minMag.o f128_to_ui64_r_minMag.o
> f128_to_i32_r_minMag.o f128_to_i64_r_minMag.o f128_to_f16.o
> f128_to_f32.o f128_to_extF80.o f128_to_f64.o f128_roundToInt.o f128_add.o
> f128_sub.o f128_mul.o f128_mulAdd.o f128_div.o f128_rem.o f128_sqrt.o
> f128_eq.o f128_le.o f128_lt.o f128_eq_signaling.o f128_le_quiet.o
> f128_lt_quiet.o f128_isSignalingNaN.o f128M_to_ui32.o f128M_to_ui64.o
> f128M_to_i32.o f128M_to_i64.o f128M_to_ui32_r_minMag.o
> f128M_to_ui64_r_minMag.o f128M_to_i32_r_minMag.o
> f128M_to_i64_r_minMag.o f128M_to_f16.o f128M_to_f32.o
> f128M_to_extF80M.o f128M_to_f64.o f128M_roundToInt.o f128M_add.o
> f128M_sub.o f128M_mul.o f128M_mulAdd.o f128M_div.o f128M_rem.o
> f128M_sqrt.o f128M_eq.o f128M_le.o f128M_lt.o f128M_eq_signaling.o
> f128M_le_quiet.o f128M_lt_quiet.o softfloat_raiseFlags.o
> s_f16UIToCommonNaN.o s_commonNaNToF16UI.o s_propagateNaNF16UI.o
> s_f32UIToCommonNaN.o s_commonNaNToF32UI.o s_propagateNaNF32UI.o
> s_f64UIToCommonNaN.o s_commonNaNToF64UI.o s_propagateNaNF64UI.o
> extF80M_isSignalingNaN.o s_extF80UIToCommonNaN.o
> s_commonNaNToExtF80UI.o s_propagateNaNExtF80UI.o
> f128M_isSignalingNaN.o s_f128UIToCommonNaN.o
> s_commonNaNToF128UI.o s_propagateNaNF128UI.o
> clang++ -g  -Wl,--warn-common -fsanitize=undefined -fsanitize=address -Wl,-
> z,relro -Wl,-z,now -pie -m64  -fstack-protector-strong -o fp-test fp-test.o
> slowfloat.o softfloat.o  libtestfloat.a libsoftfloat.a /tmp/qemu-
> test/build/libqemuutil.a   -lm -lz  -lgthread-2.0 -pthread -lglib-2.0  -lnettle  -
> lgnutls  -lzstd   -lrt
> /usr/bin/ld: /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors_vfork.S.o): warning: common of
> `__interception::real_vfork' overridden by definition from
> /usr/lib64/clang/10.0.0/lib/linux/libclang_rt.asan-
> x86_64.a(asan_interceptors.cpp.o)
> make[1]: Leaving directory '/tmp/qemu-test/build/tests/fp'
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 669, in <module>
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label',
> 'com.qemu.instance.uuid=ab26fa37530a4ed5b10342f342f7746f', '-u', '1003', '--
> security-opt', 'seccomp=unconfined', '--rm', '-e', 'TARGET_LIST=x86_64-
> softmmu', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=14', '-e', 'DEBUG=',
> '-e', 'SHOW_ENV=', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v',
> '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v',
> '/var/tmp/patchew-tester-tmp-8n_qvmlc/src/docker-src.2020-06-19-
> 10.40.33.11351:/var/tmp/qemu:z,ro', 'qemu:fedora', '/var/tmp/qemu/run',
> 'test-debug']' returned non-zero exit status 2.
> filter=--
> filter=label=com.qemu.instance.uuid=ab26fa37530a4ed5b10342f342f7746f
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-8n_qvmlc/src'
> make: *** [docker-run-test-debug@fedora] Error 2
> 
> real    5m0.701s
> user    0m8.271s
> 
> 
> The full log is available at
> https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fpatchew.
> org%2Flogs%2F159257395689.52908.4409314503988289481.stgit%40naples-
> babu.amd.com%2Ftesting.asan%2F%3Ftype%3Dmessage&amp;data=02%7C01
> %7Cbabu.moger%40amd.com%7C21f9e4ac5c634f97683208d8145f6f86%7C3dd
> 8961fe4884e608e11a82d994e183d%7C0%7C0%7C637281748288967871&amp;
> sdata=gdE2QyWLHMOJT1oUP5S4AdPxVZrwEp0UWGlzdTS6pWw%3D&amp;rese
> rved=0.
> ---
> Email generated automatically by Patchew
> [https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatche
> w.org%2F&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C21f9e4ac5c63
> 4f97683208d8145f6f86%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%
> 7C637281748288977827&amp;sdata=1J34HRSzC%2FMAiY9CGqrthn6vw0%2BY
> MNNkLiA9u0qa808%3D&amp;reserved=0].
> Please send your feedback to patchew-devel@redhat.com


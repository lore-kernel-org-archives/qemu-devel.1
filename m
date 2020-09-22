Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD8AC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 20:58:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C32372065D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 20:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Oi7bX5ra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32372065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKpNA-0008PH-Ki
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 16:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ashish.Kalra@amd.com>)
 id 1kKodV-0007Wv-7m
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 16:11:38 -0400
Received: from mail-dm6nam10on2071.outbound.protection.outlook.com
 ([40.107.93.71]:64577 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ashish.Kalra@amd.com>)
 id 1kKodR-0007II-H9
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 16:11:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzTAICJaeCa4Zs+qo6ZK+cwfNGpMN1i1WvOA386KUxVPNblhocnXHhOx0hItHGCzdaEK9dyexCK3wI0WyqQ+EwbDFmbph2/Xnvx0jzgDMp5Q2D3x3RwCAy9sb2VEH6bBdYfEgxbcsu9LTJbgkVswh9RaEzILVaAnqO3f2QHrKnBsu2txl73xtaKzsIkqTTykn4YJbylvWoGhcEDXACHH9Psdj3ibRJdC9dd+WWA1rMe8yK+/xrSWTJ0cv27wkMA56viy5gyKGKeq43J07mvWFeCoExC3tQpc9/AfqBVgwiF1K7B/rPAJ2lh97rYT38k7kVpqFUnWH8XORY3paTJjfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1GNzmZEFUN4gPNc5IXQcdhA+kyQ3d1pwcPlD2OZ2lI=;
 b=Zzott8pQo/QFvVhElvaZHGVOp/FYeVVutTSuIt6biak9N9JFWsGD1GLSPXOK138bFo6mR/R6t82tblanabtPim7bFPn831yP1PzHXK3ZZU+NaxSbh5zm+OmjuTPZNjFQV9DuFzv9UXhVOB+GCdPNDg/rPWiye7iVczDFbFrfbZe7u/Lfr9ww4RmBU5lEBctxIu9tNULUfg70LlVZU09TUR6EtHDPXPO3/UXA7emK2Apip/QmIK/mzfHqhi6vHm1C017Gr2ER9erfRFSgZzt2IjqIRAydMCz85PGsf/GB1droCodOSw+/Tp10nM0EUmsJuJImpDnNzbHZjp7SgZzsRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1GNzmZEFUN4gPNc5IXQcdhA+kyQ3d1pwcPlD2OZ2lI=;
 b=Oi7bX5ranhdXrUjPyhGY2DZRF8t/r2uYYK7ZmChLvy8H9plDOrQD97uC255K94Sb34na1NDQYzOZSo3tdUZWououZPGO5A26qQmiz50m1dtCC2NYRndFSJEX4h6443Wk9dNeoBOdj945UOCECca7O+SEKd9aN+1kyxYJwVi+50c=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN6PR12MB2829.namprd12.prod.outlook.com (2603:10b6:805:e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Tue, 22 Sep
 2020 20:11:30 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::1d50:341:16e2:84b1]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::1d50:341:16e2:84b1%6]) with mapi id 15.20.3391.027; Tue, 22 Sep 2020
 20:11:30 +0000
Date: Tue, 22 Sep 2020 20:11:24 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: dgilbert@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: SEV guest debugging support for Qemu
Message-ID: <20200922201124.GA6606@ashkalra_ubuntu_server>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: SN6PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:805:66::43) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 SN6PR08CA0030.namprd08.prod.outlook.com (2603:10b6:805:66::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Tue, 22 Sep 2020 20:11:30 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 12d59425-f37f-4656-d0e4-08d85f33b1d6
X-MS-TrafficTypeDiagnostic: SN6PR12MB2829:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB282998A048BB647B760122148E3B0@SN6PR12MB2829.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mr/A4mW/zXlM2txh9fERMh+96V7vEQHHyWMZILg1K/qaJzMNzOQZFmMswCUiZuYRiQijOk++An76xKZP82bSr5tuxgEo1Tvw83DSiGmh6CFmxON0U+j373PtoaAkdtyPI1Ls0K50tqsOkakgxrkawxtmscHC5dQ6Sb60z4m3HImucbKC9aeWbSnCZrHrHzYKmFLUJZxZvNnXfionDwYpTIJe7LOpZTrPofX/HovxFpv+wdZBQiIXVe0vbthmnivvLdobVhXe9NTzBsFAXQth9gESPN+Mt4rEcfdyaTYuNsP4fRvCSYhr6Om7/0aiuUo145bKIuy9HsixuokqP4/N5MlQCUdetN4fo+IyjRcNzlMYCVaoKhxWEA1BYAjtOS5lWv+4AHP3Vb1dpLS0JytJMTYt2+CkmBuv0Pe3yqBfXyc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(956004)(4326008)(9686003)(966005)(8676002)(33656002)(86362001)(52116002)(55016002)(478600001)(44832011)(2906002)(8936002)(6666004)(5660300002)(26005)(316002)(186003)(66556008)(66476007)(16526019)(6496006)(1076003)(83380400001)(66946007)(33716001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: UCg+7In5bcbzyJjbFFDEEMhEiev3t5uBccbnCkP4PmvsRFHIBVoSKF/xdDlECne4a7uIYkRxmDEVxW6ysldHYZWOhUA4aWXN46UGUBgt42HPk6SgzyBjNW2PMX45V9fFI8Yk8i+eXCLwVgZQOX6M/tMQVEp7bUXnqJqgg9/xLTWQu+QWwOqBbudlzJYZJyWsQ9EVDjrq4eFATmUIeFPNLc9KVd91lPjHrg7RHl+ywjCPlE2vfwNS/3BPq53NyCXi4g9E7MfZ1NbZN6VWD3ksD+dkcdmCnpCIhJBEol+HLZ11F8886VswYHHDxQ/art4PDueVGczq29/RRLXQehsKb4B3GWFSrak01QkMzHbAkHGLYD4h9EcKMIYJNQ/EK3Zx7eS8HKVAV/khl/nDp3CmShPB+Iu37pu2VWerhCFjHOLj0Ptha5JPSQCH93yGo0TkPshFf9yaLpQX/dGAK/h8uL7AjT1RkVL7VnmHp1pRwllAeXuajmLrE8PbqlY47bGrV6k9AnBy6Hq/qCpCG3GB5jAfCx1eM4ekz9G4bZ9/nsIpar8je7iM6bv3KQ4Y/r70AReaI/cPgiBTm6o3HLhfWc2hR1YFvJXtBCDyQqBtk0/ezc+buot0f99Fi5tkTtM75Zwd3P2n4Dl9zWq8BJzx7A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d59425-f37f-4656-d0e4-08d85f33b1d6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 20:11:30.7539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1S8psOsXtB7o1Vt8E5X3bxPEeYSt9J/hjoBLPWHNbC27wNkBCSTXjCaLnDcGT6jWCwcy9aLnXqadcF2hQvqakQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2829
Received-SPF: none client-ip=40.107.93.71; envelope-from=Ashish.Kalra@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 16:11:31
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 22 Sep 2020 16:57:09 -0400
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
Cc: thomas.lendacky@amd.com, jon.grimm@amd.com, brijesh.singh@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Alan, Paolo,

I am following up on Brijesh’s patches for SEV guest debugging support for Qemu using gdb and/or qemu monitor.
I believe that last time, Qemu SEV debug patches were not applied and have attached the link to the email thread and Paolo’s feedback below for reference [1].
I wanted to re-start a discussion on the same here with the Qemu community and seek the feedback on the approaches which we are considering :
Looking at Qemu code, I see the following interface is defined, for virtual memory access for debug : cpu_memory_rw_debug(). 
Both gdbstub (target_memory_rw_debug() ) and QMP/HMP (monitor/misc.c : memory_dump() ) use this standard and well-defined interface to access guest memory for debugging purposes. 

This internally invokes the address_space_rw() accessor functions which we had  "fixed" internally (as part of the earlier patch) to invoke memory region specific debug ops. 
In our earlier approach we were adding debug ops/callbacks to memory regions and as per comments on our earlier patches, Paolo was not happy with this debug API for
MemoryRegions and hence the SEV support for Qemu was merged without the debug support.

Now, we want to reuse this cpu_memory_rw_debug() interface or alternatively introduce a new generic debug interface/object in the Qemu. This 
debug interface should be controlled through the global machine policy.

For e.g., 
# $QEMU -machine -debug=<a debug object>
or
# $QEMU -machine -debug=sev-guest-debug

The QMP and GDB access will be updated to use the generic debug  interface. The generic debug interface or the cpu_memory_rw_debug() interace will introduce hooks to call a 
vendor specific debug object to delegate accessing the data. The vendor specific debug object may do a further checks before and after accessing the memory.

Now, looking specifically at cpu_memory_rw_debug() interface, this interface is invoked for all guest memory accesses for debugging purposes and it also does 
guest VA to GPA translation via cpu_get_phys_page_attrs_debug(), so we can again add a vendor specific callback here to do guest VA to GPA translations specific
to SEV as SEV guest debugging will also require accessing guest page table entries and decrypting them via the SEV DBG_DECRYPT APIs and additionally clearing
the C-bit on page table entries (PxEs) before using them further for page table walks.

There is still an issue with the generic cpu_memory_rw_debug() interface, though it is used for all guest memory accesses for debugging and we can also handle
guest page table walks via it (as mentioned above), there are still other gdb/monitor commands such as tlb_info_xx() and mem_info_xx() which also do guest page
table walks, but they don’t go through any generic guest memory access/debug interface, so these commands will need to be handled additionally for SEV.

The vendor specific debug object (added as a hook to generic debug object or the generic cpu_memory_rw_debug() interface) will do further checks before and after accessing the memory.

e.g., in the case of SEV,

1. Check the guest policy, if guest policy does not allow debug then return an error.

2. If its an MMIO region then access the data.

3. If its RAM region then call the PSP commands to decrypt the data.

4. If caller asked to read the PTE entry then probably clear the C-bits after reading the PTE entry.

5. many more checks

Looking fwd. to your feedback/comments on the above approach or other any other suggestions.

Thanks,
Ashish

[1] -> http://next.patchew.org/QEMU/20180308124901.83533-1-brijesh.singh@amd.com/20180308124901.83533-29-brijesh.singh@amd.com/



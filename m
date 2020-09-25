Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4B1C4727D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 23:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 286542086A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 23:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TWuqvrMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286542086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLxTU-0007Ov-6t
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 19:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ashish.Kalra@amd.com>)
 id 1kLxSP-0006wt-K3
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 19:48:53 -0400
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com
 ([40.107.92.59]:38752 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ashish.Kalra@amd.com>)
 id 1kLxSN-0001mN-LL
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 19:48:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hebU+j4wGLhPyNtv5JgpFOFGuyUlFC88xjgz5z3U8sWtVf1oPTPz7tviFVODg0I7SHM616r6l2pVvQy6pvQC7E4+fjkrxXF3rt/lwwbAZs+GjEbboMB6C0BQrtPVulgwznkLzSCPTtbz4U7dIGbBdk7Gd4mTkJw1v0/Y7yD0pmburl1nerlWxxtogkANyDufUf+IK757/oRBvoKeB8gAH9idK7GKTNkSIpRHmMO2EPvmnUw/Zvu1+Qhehosdm/QVyxxzG70ySy5umWs7QYJC4HIxdElS9Q25LxbmOLReHA0nHKqHiKruKXyCJOIpfoFq06x4VYptSdlwIXfybde57A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXWv/0dPhb7qqXviZ3mct4nxXg2/91PqWK7aE0SaK5c=;
 b=Y6dGv6Ry5O1LnuYoBTzHjS+7H8NlOd8IgK3fpfx18QZsxqciuu3u7XWj9NUdY84FK2RPD1V2uoLbaGbFEjqu+fdzQovEJD+nBRYwR2t14GiB2eyPF8mHxi4QRG6ug3XBM1v7gw6mh58h9t0Qg7N8L3tPGcriFFd+4Y/5yAmOSRC1EWnMCgWy2whSOMtHcgk51N7HDcBKAs3MRTet9wBWNcKisacX9nK+t5EJ+BXNbHFocjcdavTjxCZjO2MG7Q8xrPO+QXu26tLiPc+4J/6rq8dFBdbgtHyBIw9FdciN5lce9v3CKhyTILH/G09xTNgcBMtYm7bBT96aivy/4RIDLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXWv/0dPhb7qqXviZ3mct4nxXg2/91PqWK7aE0SaK5c=;
 b=TWuqvrMrS2g3ulwwgbiOCgqcUe0mDPIziWJmwMuIx5tNXhkfD3qIGADmfFOqcuBcKfLY7TgBsWRa+QbAS8qC63PsZtBZJV4W2F6RnwmAge/nkd4kp1Jf58fDKh1E4TqO8nGdRyGgo/wwrLUysCsjVJ2gc0uHCm/oGZ/w6UXo5sw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN6PR12MB2766.namprd12.prod.outlook.com (2603:10b6:805:78::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 25 Sep
 2020 23:48:48 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::1d50:341:16e2:84b1]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::1d50:341:16e2:84b1%6]) with mapi id 15.20.3391.027; Fri, 25 Sep 2020
 23:48:48 +0000
Date: Fri, 25 Sep 2020 23:48:41 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: SEV guest debugging support for Qemu
Message-ID: <20200925234841.GA11103@ashkalra_ubuntu_server>
References: <20200922201124.GA6606@ashkalra_ubuntu_server>
 <5a58509c-5838-f0aa-d9ab-4f85ca0ac35f@redhat.com>
 <20200925204607.GA10964@ashkalra_ubuntu_server>
 <e9b09c9b-4d4c-c6de-4cce-807effc38836@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9b09c9b-4d4c-c6de-4cce-807effc38836@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: SN4PR0801CA0011.namprd08.prod.outlook.com
 (2603:10b6:803:29::21) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 SN4PR0801CA0011.namprd08.prod.outlook.com (2603:10b6:803:29::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Fri, 25 Sep 2020 23:48:47 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 115c53fc-a072-4ddf-1714-08d861ad8c0e
X-MS-TrafficTypeDiagnostic: SN6PR12MB2766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27663FC042C2428E5EFC07E28E360@SN6PR12MB2766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dpzw0mh+PlHfyhlRxZuQfJ3L0Eu+dRPSZAzYjnShdnK58J1lTHyw7UXLYxmOrUe0QEV/Wh5gfARF9EN94Icdd78jfCRSreflNtVKQ1HY3m0Ms1bXGLbJH2X8dCJW7v6px8YE2fKtc7f7/Ds8h+tygM/Pi1Al2LiVGJj2qcWbicVaSTQIhSJ7BkH6DdbALq0kWjPVwZacPa9yx4LZpMDioljp8EUa7E87GX7Hxd33M4Be1nI2zPd4oZeG32I6Ba6KKWies6jGJIucJzs/SePeO3bC/8O2KKdjNXgDcXvHs++dR27fzPwMFPgDawSWKUOrvSxHKFT1KC8eSvmul374GUdubboE7BV0xWZi3gSwLFqqeCZ3Y3H9VWwH4U7pPJpz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(5660300002)(53546011)(44832011)(83380400001)(86362001)(6496006)(55016002)(9686003)(52116002)(2906002)(66476007)(956004)(66556008)(478600001)(6666004)(16526019)(316002)(1076003)(66946007)(186003)(6916009)(26005)(8936002)(33716001)(8676002)(4326008)(33656002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: GjKreCjb2ScxcB8oc+qNi52/OzjkII8ZFW0I4RE4Lun7IHSN3W5obaeJFeGe3TXeS6YF4jcjOsO8NLO3JXAYA8tsu5Eh4Nl9K4ahFIgD850TNDw/XUR7ILbkCfGg0bdxExIMsuDOBqVXrJTX7Nwtj7uY4RyYq6VtCxJoAiyt7rdBKNr5xPM6KNjE6WZrEx/ovKK8siH70Ao9OznvqgmU30t6FeeX2aig9xORRZcs0sCy/RGPIvz4FS/PpWPWrOBV436UI5H+TdP8tUPjqw6za7V4WRMbmgIGQZhE/HV0fc8zelhLcYH4OhTi5wNV03F+i5XQyKgC5VbU2kO//sCdXwaC6JNq4/w+aQT9MBHalE5RBx4VL+T1v7suaBsvOxMIqpw11v1YW5hYxqADzvb7SWl2j5S9JAHh4Sv3kBKSASRlTXOi+KOr2+6cHnr0h/GzIr/a+Vc61Yn/TOvpP5W9KqSCZlLvEg5cMIwk7MYeNDR1cA+9e/42GFGrc0rvXa1MLcgH4wDoXUUQhPj0EzDFwjMZf2Fu6bZD6+fp+LOeXYdWVr1m8UXEPgzbjwNVnL+wCyS+2Uv4RuLDBe3fDFmcDFmI+G6UED93DJtno4S8kH2Epp/6RAPtXBLxB2jdeT4VeWBlOwC629asUf6ts2iPfQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 115c53fc-a072-4ddf-1714-08d861ad8c0e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 23:48:48.3593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Img0pfQR/fxQcyelbxLhC1lI7NgH0eTsN/+Bs37WsqO7uUEwVJAXKyT1JCW38fDMWl2NPuIePkiUtatMVx5nRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2766
Received-SPF: none client-ip=40.107.92.59; envelope-from=Ashish.Kalra@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 19:48:49
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: thomas.lendacky@amd.com, jon.grimm@amd.com, brijesh.singh@amd.com,
 dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Paolo,

On Fri, Sep 25, 2020 at 10:56:10PM +0200, Paolo Bonzini wrote:
> On 25/09/20 22:46, Ashish Kalra wrote:
> > I was also considering abstracting this vendor/SEV specific debug
> > interface via the CPUClass object, the CPUClass object aleady has cpu
> > specific methods for doing things like guest VA to GPA translations like the
> > get_phys_page_attrs_debug() method and it will be a simple and clean
> > approach to override this method with a SEV specific
> > get_phys_page_attrs_debug() if SEV guest is active and SEV debug policy
> > is allowed. [...]
> > 
> > I can probably add new interfaces/methods to this CPUClass object for
> > guest memory read/writes for debugging purpose and then invoke the same
> > from the generic cpu_memory_rw_debug() interface. 
> > 
> > Let me know your thougts on abstracting this debug interface via the
> > CPUClass object ? 
> > 
> > Or the other option is to introduce the new MemoryDebugOps you described
> > above and additionally apply SEV/SEV-ES considerations in CPUClass
> > methods such as gdb_read_register, gdb_write_register, etc.
> 
> Yes, this makes the most sense, however you're right that you don't need
> translate in MemoryDebugOps.  I don't think read/write should be moved
> to CPUClass, however, since you can use a MemTxAttr to tell the
> read/write MemoryDebugOps whether the page is encrypted or not.
> 

Thanks for your input, i have one additional query with reference to this support :

For all explicitly unecrypted guest memory regions such as S/W IOTLB bounce buffers,
dma_decrypted() allocated regions and for guest regions marked as "__bss_decrypted",
we need to ensure that DBG_DECRYPT API calls are bypassed for such
regions and those regions are dumped as un-encrypted.

This guest memory regions encryption status is found using KVM's page encryption bitmap
support which is part of the page encryption bitmap hypercall interface of the
KVM/QEMU SEV live migration patches.

As this additional debug support is dependent on the KVM's page encryption bitmap
support, are there any updates on KVM SEV live migration patches ?

Thanks,
Ashish


Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C562C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F4BE207D8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lrAC6DiV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4BE207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtaS-0002I9-IH
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ashish.Kalra@amd.com>)
 id 1kMtPj-0007yX-DF
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:41:59 -0400
Received: from mail-co1nam11on2050.outbound.protection.outlook.com
 ([40.107.220.50]:23777 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ashish.Kalra@amd.com>)
 id 1kMtPh-0005n5-6V
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:41:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhgWCQk5gfMrRaaji6DtiiChoixAMk6IcIm30YWAGBQM1eK/0pVarGo5MQzStMUDYwY3MaHj/yi6RzoWAy24GrDYGCdD8+5iLNPKVN/5t5uqkgurbQ/2/tA+t6tD1ZZMS04kJH7gZIV65wUV84suL7bWneymSD1tcxiC9X/avVPjDpVAoWp2JKk2LqSiUm9YBXncIJ+KoBkUyioyDnvkKTcYsztP2bHpCIj6HH1dMT0nZkwW6wSsH49TA+yM+g56egogM0tIziSKi71BI9ASVFBvmdRo0Mlfv7Dg38qOgkUxHwYBI/Mw+Y5+2WwvunW0EYZsX5AqhUA2yIWXh1WQhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fatuEktX+VwVPaxow+UHiQQNHKnt+q20WzUGe7ZeaSo=;
 b=nq2PiRuVULMDAjld/w+/ZSx6LIxAB9ZgeWiVzlmgf9goVyTjlBeh9hyF/OXUq6eAbC+HXFp5eAp9PdcMWgGkwYDUbaIwG83yDw3dcP/0CkBkuxcox/Oh5KFOJa0XaxUsGIy/79Fyyhun5K8fquuL00C7V84VSA/hMih8Uw8kOrcvwZ5Gdw7hm+vAmHj1x91HhGeCMRusipJFsAgc5bVfoGooC0Ko1gBSa8V5NqQBlTu3FpX7RoKm3aU4Cfj1j3mKedVZ191jVhrlnsG0/I8HQH8SXYHyn4b9wHUaRE3RA1W5avIbMsYWW8Nn9P/qHgBfD/fGwBq88B7KD16J3HIuRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fatuEktX+VwVPaxow+UHiQQNHKnt+q20WzUGe7ZeaSo=;
 b=lrAC6DiV5RM0NEiroEv76kfEQqiJkC7hw8c0VA08KpzFfZnV2EIehLsRLVoRaoGeNy5JzCdzIyVPMcL3JZTl8aHZCiupAmBFOigcRfwiqXJKUQbeGnpONfS/gUOWdmXh3286IirI6OdUZLvJl33F2hWrcV3n/zlXLc6jKLxv8xU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SA0PR12MB4559.namprd12.prod.outlook.com (2603:10b6:806:9e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Mon, 28 Sep
 2020 13:26:47 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::1d50:341:16e2:84b1]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::1d50:341:16e2:84b1%6]) with mapi id 15.20.3412.028; Mon, 28 Sep 2020
 13:26:47 +0000
Date: Mon, 28 Sep 2020 13:26:39 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: SEV guest debugging support for Qemu
Message-ID: <20200928132639.GA13172@ashkalra_ubuntu_server>
References: <20200922201124.GA6606@ashkalra_ubuntu_server>
 <5a58509c-5838-f0aa-d9ab-4f85ca0ac35f@redhat.com>
 <20200925204607.GA10964@ashkalra_ubuntu_server>
 <e9b09c9b-4d4c-c6de-4cce-807effc38836@redhat.com>
 <20200925234841.GA11103@ashkalra_ubuntu_server>
 <6a0188c5-8dbc-e86c-6726-ba7bfb821697@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a0188c5-8dbc-e86c-6726-ba7bfb821697@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR10CA0003.namprd10.prod.outlook.com (2603:10b6:4:2::13)
 To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 DM5PR10CA0003.namprd10.prod.outlook.com (2603:10b6:4:2::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Mon, 28 Sep 2020 13:26:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ef5dde7e-c840-4628-b34a-08d863b225db
X-MS-TrafficTypeDiagnostic: SA0PR12MB4559:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB455991A7626FA7668C64DF448E350@SA0PR12MB4559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5S5bkE4P8iwtwE4DVFVyntOHh6ZNT4hO4ip6W2MbCBGEaZhBvYkJXgrrlz1ZCnUeiXzJ8MnXEd+miza6sGXCa5fzEOBDxzLEbCbnwiiIvBOb1S9gYuntEDd4NvQoc/hYl2FkbpaSD1chY2X0QjyhsXX4VTxzzApPKvp2iiTF+e5sqzXFj3ppDUyLGdmXDD/fDKRSOEN/xqYwhLYQwAyxDPPvcY9TGp81e2JfgyGyPdyvDO//oUabiiJ8S13EyE1Zn3rFnN9QxrexmcaBC4dn3xV3be840tEFmT8bwDiuMTuNZEZWGhRU+PHcqSrAhffVczbKeNPb+4gSIv6QInMGg4bNtrIzMaTXTXHRQdr3OUchyu68wPLjXj4FdS4a6z2p
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(6666004)(9686003)(1076003)(66946007)(44832011)(478600001)(956004)(8676002)(52116002)(2906002)(6916009)(8936002)(53546011)(316002)(6496006)(4326008)(186003)(16526019)(26005)(33716001)(55016002)(83380400001)(5660300002)(33656002)(66476007)(66556008)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: F/8YFUStWxc/C0JNzlu+BVXmVqeK0Tl1AgB/FqoaHqtdxHyOWaBg2j6iVCnKgVjdhaBhropYgaCowuxRZDnrR7PmkFh4R6nW+gvpFDSiOHldU9sbvDI56xPh31tjIkljCE0Q1pzlgIOh6/+058GC4Et5DrRm782nPJSEekbptUR1Mjt75Tj35Ra7SnJnxOPq23pIB6cWNQG5li/bRujzBLI0ev9dS0kbR5k3v2SZViWX2UkkYoFo1+UUwtU0b4t/Av52oqvV5Rp9sbxy/Wm4pRKj2R1uB/pIN3hUm3AWv3kU08MGevVP+5ZiM7JZnUcwdf+lxe8EBl2hrXdAxB4jPWIvmN3ru9JdHQTiDpXdaygPi5B87an4dk65GfrTuF0BcDf3AWTKh3RH6NdDwa1K20DJH7tcSkcKlqTrQgg2tD9S+dB5AYxCpgvtYQ0VtXPacIbnyrqzLUHr2O1r3T12bqFfxcy3I0sLg9vXLRfBWwMKFEa/KmgOZZnzMgj4Mn2039oLLus+nyt8TczIu9w+6B7i7NHZ4HsgG1QjJE++uHR+DqNjUTLA/7n82ESRK9R4ThezanbpDR7JgqFpXqZe0RgrBoMEnVRb24kLBhhxqIEP+Z2PDLYdsaHY2zIwMoOn+8wOCtD7rxQN2mSMOgFIZg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5dde7e-c840-4628-b34a-08d863b225db
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 13:26:47.2386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJeiwjKcFZmqaqHJqA7vQo8kUav2qsF6goKy7FG9A5+q4d1LG3iy41frXUz0jpaLZRPB2FqxVByATYm0ny6NsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4559
Received-SPF: none client-ip=40.107.220.50; envelope-from=Ashish.Kalra@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 09:41:54
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.614, SPF_HELO_PASS=-0.001,
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

On Sat, Sep 26, 2020 at 02:02:20AM +0200, Paolo Bonzini wrote:
> On 26/09/20 01:48, Ashish Kalra wrote:
> > Thanks for your input, i have one additional query with reference to this support :
> > 
> > For all explicitly unecrypted guest memory regions such as S/W IOTLB bounce buffers,
> > dma_decrypted() allocated regions and for guest regions marked as "__bss_decrypted",
> > we need to ensure that DBG_DECRYPT API calls are bypassed for such
> > regions and those regions are dumped as un-encrypted.
> 
> Yes those would be a bit different as they would be physical memory
> accesses.  Those currently go through address_space_read in memory_dump
> (monitor/misc.c), and would have to use the MemoryDebugOps instead.
> That is the place to hook into in order to read the KVM page encryption
> bitmap (which is not per-CPU, so another MemoryDebugOps entry
> get_phys_addr_attrs?); the MemTxAttrs can then be passed to the read
> function in the MemoryDebugOps.
>

Actually, currently we do this in sev_dbg_crypt() in KVM itself by
checking the page encryption bitmap and if it is an un-encrypted guest
memory region then returning the un-encrypted buffer read from user
back to it as it is.  

> > This guest memory regions encryption status is found using KVM's page encryption bitmap
> > support which is part of the page encryption bitmap hypercall interface of the
> > KVM/QEMU SEV live migration patches.
> > 
> > As this additional debug support is dependent on the KVM's page encryption bitmap
> > support, are there any updates on KVM SEV live migration patches ?
> 
> Sorry about that, I've been busy with QEMU.  I'll review them as soon as
> possible.H

Looking forward to your updates and reviews regarding the same.

Thanks,
Ashish


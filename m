Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE445C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECDAC20BED
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4Ls3ZLtT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECDAC20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLurX-0004iW-OZ
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 17:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ashish.Kalra@amd.com>)
 id 1kLuqP-0004Fi-GB
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 17:01:29 -0400
Received: from mail-eopbgr770081.outbound.protection.outlook.com
 ([40.107.77.81]:43617 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ashish.Kalra@amd.com>)
 id 1kLuqM-000897-Kk
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 17:01:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xgs8ob+v/93JAUHqS0QVXxikQHQo8b39oEaCeJjDrrUaM7YMSfKrFhjmXkPnHlvGBOD3H9xUEII5KxAHiJC4xCdPXgdelOn3fYQ9GgFCgu4M/hJa+Hf+OGuvZMCOJNNSctBAmWxa9loW+dYb9WVAWzGnq0CymwnTlOABCApcLmZqdk/gWQqv611LElCh4aAlE2lzl2UpJ+yitJkwWccVEHJGXfdYICgvpzXRJXHT7vcl1j+LJyfpKv2SMuVmLAhYhmLSmQ2dY2eYOX77K9hsc4G25kO9R74+72FFpMTsHKo/l/W82wOx1LaZ30cnKkhndEZzxXQs8ihYxW/oAAr6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaYGCJvr5EK6rK1R6VTubzRWMXrX2e6/Cu8+iVhZAk4=;
 b=WLy7yH2rz7aHukrcvUU39VS14oIXsNKzosmutuJuaivBk5AYax4IDE3jpyYNeyxGW1nKJKU9J5l97nOX5amMHX+MPGnEu5PqzORmvx6FDXLb0nrlsU/mldD3PUsYhmWDEuwz39khAovABiIvNG6EK35FCPROfpkL4UpTkmETEFWKDOC/iq3QMtwuXXrna1ApExe2FK/dErPRymnLpLHCusDkc75/75ujW0vtbnLgD2DFbxH7BRDpjFqgAM+nGsB7tQ2Z8io7nEnLCsE5DVfSbzQjpjmHzgRQ4GIAsWLnM62hV8m/nnTwR8QMuVz18reQO6uVW86dEYzQmbp/5ZmraA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaYGCJvr5EK6rK1R6VTubzRWMXrX2e6/Cu8+iVhZAk4=;
 b=4Ls3ZLtTKienJ6r3ZsKwSFtqfzqeXIyiS85mbxv0gBPYWa1Y5pRMjkM9ry5pUzGb9EkMzMx51/HQ4d3oQ9fNTBiRfnrWu9dthYF9Bj1s1ZDV7pAaqcE7cJo60n2p8SCSGKDeXm/m0ytLgNb+X3lRFNUSjQpdMwQ5xJPJUjmjVFs=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN6PR12MB2686.namprd12.prod.outlook.com (2603:10b6:805:72::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Fri, 25 Sep
 2020 20:46:21 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::1d50:341:16e2:84b1]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::1d50:341:16e2:84b1%6]) with mapi id 15.20.3391.027; Fri, 25 Sep 2020
 20:46:21 +0000
Date: Fri, 25 Sep 2020 20:46:07 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: SEV guest debugging support for Qemu
Message-ID: <20200925204607.GA10964@ashkalra_ubuntu_server>
References: <20200922201124.GA6606@ashkalra_ubuntu_server>
 <5a58509c-5838-f0aa-d9ab-4f85ca0ac35f@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a58509c-5838-f0aa-d9ab-4f85ca0ac35f@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: DM5PR12CA0056.namprd12.prod.outlook.com
 (2603:10b6:3:103::18) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by
 DM5PR12CA0056.namprd12.prod.outlook.com (2603:10b6:3:103::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 20:46:20 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 337f3a2d-e8fc-4014-2634-08d861940f4a
X-MS-TrafficTypeDiagnostic: SN6PR12MB2686:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2686EC75F154B344290CFB968E360@SN6PR12MB2686.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nsNCoQiYBw1+nnQn7tszxZFB1OGDOIKu2QrJmE5kGGHZfC3O31pwxsO9KNliDy0vJGUJukbFCT5YDzCS31vBYvlwduS+LN+Tcjkc77LxwuHrTXqisNAr+Dl/ht39N8sW6B7nRxeM9sp8i6NKKRr4243R7qDH+nHMXmTMTOP/g2/f+peNLBfiQMeNbsgGg/qToJpQR86NDO8FXc908vsYG32C3Tj7lQRchbFAQ4NO21v9PHPYD2noDHc6Xlva2Doi11OnSTsvPc+vwv01m4tJjUQ1jN3Hfdc342gq7Wmo7Kc1CwIQ00GBuV/oTq1SoY8ETtdN5q0KUnMMZ+xVYoudchMXqp49S+WYQuGi2ogFQnbZuPLB9gXDf/12f5gCtgMO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2767.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(66556008)(33656002)(66476007)(5660300002)(478600001)(33716001)(6666004)(86362001)(66946007)(83380400001)(1076003)(956004)(16526019)(8676002)(8936002)(316002)(9686003)(4326008)(44832011)(26005)(6916009)(186003)(52116002)(53546011)(6496006)(55016002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: b1aLauZWlmeN5DUs/rnj6hPdbQM11VOpTtF4x17KHHye8bLEkOr24uhYsjMbm1ER1jVH0ELv9rJu7rVV3q5032sk09MW3MTp7hUuMdsfRYH73liIBOubaQ5qqMIOFaP4VoVBTRL10zj/98u9WyuW8A2QjHf1c2i5tSlFIuXNuCPwOsNhamevGsIhuSG+2W7IgwuaHRJFL3TwSOOMyP3tLynUpRuxg0KNg7PQBuYYplXUu8RO7fNa3eroabpez3uej5nl1Onj9xRuVxkwKxIjd5t3mGXfgFZGVPRy4qWK1KtEpY/qJy3Wow53bzoa5PurlJAI5Jy2aQVYkRD3qjCWpOphIoimZRGxD/4tp4gKhDfRX57bTuu4n8sQoVTgogTlPur7Cv2OtH80+pe0+urPx+Zjv31Xtv3KlIynLFlkdX/XP4nGhPpaKmMCmJWDc8voG/0GumM7LiDs/asLfie/asIPTF/43AR3d8nTL+jIsX0iIKuyy01O4Fv1gOHuz+sT0t9T1xLzCqZPzL+6mDwduP1mxcHp63fw6OcYGQQtchN28dk6Dn/tXlWMt4ICvfdlld7wzUprrH1XoXn+zQXtb740SMiKPAqkUO+eR8U1pe7UcXLrGwg9InWTKjvrBT5GqSObS+9kG8Yw/o16wMxd0w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337f3a2d-e8fc-4014-2634-08d861940f4a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 20:46:21.5415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUjeujSX/ixKdpNtuqoHHuduPHC8c501iJZWDA48HfOtW3BhfK5U2MXXfSRnH4Bz6mqN273DYtid7bBgQWre4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2686
Received-SPF: none client-ip=40.107.77.81; envelope-from=Ashish.Kalra@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 17:01:24
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

Thanks for your response.

On Fri, Sep 25, 2020 at 10:51:05AM +0200, Paolo Bonzini wrote:
> On 22/09/20 22:11, Ashish Kalra wrote:
> > This internally invokes the address_space_rw() accessor functions
> > which we had  "fixed" internally (as part of the earlier patch) to
> > invoke memory region specific debug ops. In our earlier approach we
> > were adding debug ops/callbacks to memory regions and as per comments
> > on our earlier patches, Paolo was not happy with this debug API for 
> > MemoryRegions and hence the SEV support for Qemu was merged without
> > the debug support.
> 
> My complaint was only about hooking into address_space_read and
> address_space_write; I think the hook should not touch general-purpose
> (non-debug) code if possible, so something like this:
> 
> typedef struct MemoryDebugOps {
>     hwaddr (*translate)(CPUState *cpu, target_ulong addr,
>                         MemTxAttrs *attrs);
>     MemTxResult (*read)(AddressSpace *as, hwaddr phys_addr,
>                         MemTxAttrs attrs, void *buf,
>                         hwaddr len);
>     MemTxResult (*write)(AddressSpace *as, hwaddr phys_addr,
>                          MemTxAttrs attrs, const void *buf,
>                          hwaddr len);
> } MemoryDebugOps;
> 
> These ops would be used only by cpu_memory_rw_debug and would default to
> 
> static const MemoryDebugOps default_debug_ops = {
>     .translate = cpu_get_phys_page_attrs_debug,
>     .read = address_space_read,
>     .write = address_space_write_rom
> };
> 
> static const MemoryDebugOps *debug_ops = &default_debug_ops;
> 

Yes, this looks like a good approach to proceed with.

I was also considering abstracting this vendor/SEV specific debug
interface via the CPUClass object, the CPUClass object aleady has cpu
specific methods for doing things like guest VA to GPA translations like the
get_phys_page_attrs_debug() method and it will be a simple and clean
approach to override this method with a SEV specific
get_phys_page_attrs_debug() if SEV guest is active and SEV debug policy
is allowed. This SEV specific method will then do guest page table walks
using the DBG_DECRYPT api and also clearing the c-bit bit on PxE copies.

One thought behind abstracting this vendor/SEV specific debug
interface via the CPUClass object is that the CPUClass object also has
methods for gdb register access such as
gdb_read_register()/gdb_write_register() which are invoked whenever
gdbstub does cpu register read/write. 

As part of this debug interface we also want to consider cpu register
access for SEV-ES, etc., for instance on SEV-ES we need to reject the
register access.  Again these gdb read/write methods in CPUClass object
can be overridden with SEV-ES specific variants which will then simply
return error when invoked. 

I can probably add new interfaces/methods to this CPUClass object for
guest memory read/writes for debugging purpose and then invoke the same
from the generic cpu_memory_rw_debug() interface. 

Let me know your thougts on abstracting this debug interface via the
CPUClass object ? 

Or the other option is to introduce the new MemoryDebugOps you described
above and additionally apply SEV/SEV-ES considerations in CPUClass
methods such as gdb_read_register, gdb_write_register, etc.

Thanks,
Ashish



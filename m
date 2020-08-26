Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FEDC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 17:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 352582078D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 17:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rJgqJZPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352582078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAzIu-00070U-HN
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 13:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kAzIM-0006Yp-LV
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 13:33:10 -0400
Received: from mail-bn8nam11on2068.outbound.protection.outlook.com
 ([40.107.236.68]:15457 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kAzII-0008ET-Fx
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 13:33:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/llBU8n/jTmCmxhEMsrgrLFoPPcEpBB+7w1ba6vsyaL9hXnDfh6F72WMxaiSJq139AvDl4t8aZtJErmH5gs7ELXBeDp7NLpRoG5HUV+Urx3HSshJFE7rXhsWAdJn1Z5tU3/iketceHR83KuhCpyJfxVLEbiLrA7u18GOBt/FCVfoiFMlgUsdLr0aYg3tYWKEENiXj8sgD1ymSzmoFHh0pMMS+oRC+ZYNMF3Fgx7f8Dqvfis1KHK9GWuiyM6M7zj80dXG289s3xKIPsVGuK9HpfKpzBgcHH7PxUngnMDiFowQCeNisZThlP4uVCRfPkcreQgaENM///dtLhyZtbyvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIuYQy/hdoEYtaNqXbaWLdsLxRbI4LysF9PHBzegA7o=;
 b=gtglQ+gAtJ/ESX51Sq3/UzD0ESBmcSAwCr8xdE/1IjHqqRXQEgMXrTrBBMj+86bgF29czU0PvNOhpH3RhO9SyLc5D+mGaO28G8FLX1kA/1K108riKEqOKE29SKq+0QyBD/0VSAGmnhvu2/ZQMN0CiEJiCTAjpH3u3kWcmWruUK9TX3GLcyUqCO+g0j4bJwRn8NUJNbikBgtuXZhGL5UPaHu6Yxr3TKpFkwGluAXaR+A/ZbAun5MLEL18cLDos0dVB0tAOPGcqFfrsbX5X6STP7bCf7KhVCja5t8Lgsgj5D5ImhySMRrBcDtemtOoPk8wqAPla4BRGMI1T4iKeCatPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIuYQy/hdoEYtaNqXbaWLdsLxRbI4LysF9PHBzegA7o=;
 b=rJgqJZPmJKn74VOyibL40vuHi265Wv1x2yQEt1OjWVBHmDv8uMZmmnvMuSPZA8GPG2cQrRNfqKgGQwLSZYqOA2OkVeJammpFCe/CAi9FNVc+RRCCqd3JWAjvdrGShAAII/Bd2jp2FzDtVPV4CkFSs4kTIIky8vqmkZH0hCYEIBM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4526.namprd12.prod.outlook.com (2603:10b6:806:98::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 26 Aug
 2020 17:18:01 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3305.026; Wed, 26 Aug 2020
 17:18:01 +0000
From: Babu Moger <babu.moger@amd.com>
Subject: RE: [PATCH v5 0/8] Remove EPYC mode apicid decode and use generic
 decode
To: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
 <20200826143849.59f6970b@redhat.com> <20200826125059.GN168515@redhat.com>
 <20200826153034.115126cb@redhat.com>
Message-ID: <5c00dac9-5ea5-405c-93be-1ac903ddff62@amd.com>
Date: Wed, 26 Aug 2020 12:17:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200826153034.115126cb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0038.namprd11.prod.outlook.com
 (2603:10b6:806:d0::13) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SA0PR11CA0038.namprd11.prod.outlook.com (2603:10b6:806:d0::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 17:18:00 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e490abf6-417c-4182-2a8d-08d849e3fbf9
X-MS-TrafficTypeDiagnostic: SA0PR12MB4526:
X-Microsoft-Antispam-PRVS: <SA0PR12MB45268BE04B4E757048A1899A95540@SA0PR12MB4526.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s1tc0Qv81EI4MlM48QJTInA9th6oiB/9jrVri8ur6q+WNrm26QfdbAKobfWgxYFAyRBDwUAjl56/C0c2Yao9nNG932xUfBZXxB369BKSLFHTUjrURsxMf//3YuzOJjX80KHd2m0HTbX1bW52JVPhfsNtgiH7FCYQkuAh7lnaBXjK3TSJ/n+DTy98kP8DBIxDIMh2mAIyInBYSJa4Nbepqvy4cIy2V2FwcFZ0KCN8cG1YDqmnJZkrw3CGm75tsllV0Y6F00+gZ3PyHfGnfnBiAqcVRdQM4JiFNbBE7VVmwfQuGnb7eE20rEK13FqSn41+M6ebJf9TU+1Y52XULnyJRxPGJdQ/Ek4B1SknkpQtw+ipG9PWTZfJyAK1hUWD7Grq2NXGNpj5hLu1SVUqkcN1/iDv2ahl+ju+8RtINjkZtQY15JL8b2aYhFtck392idVLHniLfvRAw3HqA4nPNL1PBkdRmLb53F25JESbRKbctQA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(2906002)(16576012)(966005)(45080400002)(2616005)(956004)(54906003)(44832011)(53546011)(6486002)(52116002)(4326008)(83380400001)(86362001)(8676002)(26005)(8936002)(186003)(110136005)(31696002)(478600001)(316002)(66946007)(66556008)(66476007)(36756003)(31686004)(5660300002)(41533002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 9brB+o3IsXsJyO0O3XgHxSJXQbuqpbiybhapkRCWrIYw5Kc66vQsbDk1YvD21vwLTqVbyDHa8SH9yU0NjZ/BS5MNL5395cemuoWiomHtqXe6P7RQylwThL/Bm42N3txDOAYuIIwpjBzC5EInPA9Tt7Xda06oYseNKb6A/vIQIBo5HWZiQLYhmFt7YwxW/JvStGXY96K+fzfCeF69wlcuB16yWPWYHk1PiEnPeUZf63/dVwNjTVQ3eqPLMFoMEEZ34dwgPg0srIqq3GvV+1wI/UBvrol2OXQwSf0TsOAjqN8hgloKt9t9LPEOpRMHjEChHEvW9sJCKlseh7nGRQgMz3MCYEBLgfNNwjP6Je1F9LyM7D0S6f62oeTwydGpSS7X9lT0MYgn6N/umXr0vS0KG2xf3k9mYEbW1Q+Xi+xhwE7AaT/+5/SfniAUFFLtZmLsXDazrQXUtLHg+93MhAOZZROkz9NWZT2VbLOWFY3EY8PXriDhkBe/WTxxJ6kOKH5T1qSiIL4uzp/6adJhIWbWf4jx75eifIBEQEfC2bWIqTsAJCKF0xiBof5sS0jhU1+lH0eWTVM7r9sgRTIBBIw5deofVb/s2Z9WD+f6zseuIy+Nkh4hFdu+2KQ4JnRU78x5S2CaQoMC3tLY2dKxk2b0PQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e490abf6-417c-4182-2a8d-08d849e3fbf9
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 17:18:00.9927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WH0m+JyBY4CweMdAvNQVGsjkq6ICPWOqd7NSoW5q2/tiRAwWYTclGbu87mc3w216
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4526
Received-SPF: none client-ip=40.107.236.68; envelope-from=Babu.Moger@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 13:33:05
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 NICE_REPLY_A=-2.239, RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, Michal Privoznik <mprivozn@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> -----Original Message-----
> From: Igor Mammedov <imammedo@redhat.com>
> Sent: Wednesday, August 26, 2020 8:31 AM
> To: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Moger, Babu <Babu.Moger@amd.com>; pbonzini@redhat.com;
> rth@twiddle.net; ehabkost@redhat.com; qemu-devel@nongnu.org;
> mst@redhat.com; Michal Privoznik <mprivozn@redhat.com>
> Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use generic
> decode
> 
> On Wed, 26 Aug 2020 13:50:59 +0100
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Wed, Aug 26, 2020 at 02:38:49PM +0200, Igor Mammedov wrote:
> > > On Fri, 21 Aug 2020 17:12:19 -0500
> > > Babu Moger <babu.moger@amd.com> wrote:
> > >
> > > > To support some of the complex topology, we introduced EPYC mode
> apicid decode.
> > > > But, EPYC mode decode is running into problems. Also it can become
> > > > quite a maintenance problem in the future. So, it was decided to
> > > > remove that code and use the generic decode which works for
> > > > majority of the topology. Most of the SPECed configuration would
> > > > work just fine. With some non-SPECed user inputs, it will create some sub-
> optimal configuration.
> > > > Here is the discussion thread.
> > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> > > > lore.kernel.org%2Fqemu-devel%2Fc0bcc1a6-1d84-a6e7-e468-
> d5b437c1b25
> > > >
> 4%40amd.com%2F&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C8a5c
> 52f92
> > > >
> 3f04082a40808d849c43d49%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> C0
> > > >
> %7C637340454473508873&amp;sdata=VnW28H1v4XwK3GaNGFxu%2BhwiMeA
> YO%2B
> > > > 3WAzo3DeY5Ha8%3D&amp;reserved=0
> > > >
> > > > This series removes all the EPYC mode specific apicid changes and
> > > > use the generic apicid decode.
> > >
> > > the main difference between EPYC and all other CPUs is that it
> > > requires numa configuration (it's not optional) so we need an extra
No, That is not true. Because of that assumption we made all these apicid
changes. And here we are now.

AMD supports varies mixed configurations. In case of EPYC-Rome, we have
NPS1, NPS2 and NPS4(Numa Nodes per socket). In case of NPS1, basically we
have all the cores in a socket under one numa node. This is non-numa
configuration.
Looking at the various configurations and also discussing internally, it
is not advisable to have (epyc && !numa) check.

> > > patch on top of this series to enfoce that, i.e:
> > >
> > >  if (epyc && !numa)
> > >     error("EPYC cpu requires numa to be configured")
> >
> > Please no. This will break 90% of current usage of the EPYC CPU in
> > real world QEMU deployments. That is way too user hostile to introduce
> > as a requirement.
> >
> > Why do we need to force this ?  People have been successfuly using
> > EPYC CPUs without NUMA in QEMU for years now.
> >
> > It might not match behaviour of bare metal silicon, but that hasn't
> > obviously caused the world to come crashing down.
> So far it produces warning in linux kernel (RHBZ1728166), (resulting performance
> might be suboptimal), but I haven't seen anyone reporting crashes yet.
> 
> 
> What other options do we have?
> Perhaps we can turn on strict check for new machine types only, so old configs
> can keep broken topology (CPUID), while new ones would require -numa and
> produce correct topology.
> 
> 
> >
> > Regards,
> > Daniel



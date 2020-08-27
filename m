Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF12C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 23:13:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E5D0207F7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 23:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Emnqctv/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5D0207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBR5d-0001WU-OA
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 19:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kBR4z-00015L-Gp
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 19:13:13 -0400
Received: from mail-bn7nam10on2069.outbound.protection.outlook.com
 ([40.107.92.69]:63584 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kBR4x-0002zO-0g
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 19:13:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdU3V8A53gbaB3Xn9RCb0lK3/3/XFgzgeYME8A/MPTIu9+tvKcxSpgOLJiVgeToW+OtUJRM/iZQ4H6wavwHybwQRj4dE+mPp+9FS9I89oSk92wQ6Nl93KkT3AmArz1gikSKATPqi0lNLVl9+kJFGIE4/iqdf9lYK0Ioas0E9Hp8Xa5rlKtN0gABkNcWSkB37B3c4RbhOYlwMnAlESSYQpmmK0PenKnqg5Lfz+u1Xtw2fIHiZ+NkW6RpoqZyta5vYQ/hMPT9MXZXe3zmX0aLWt0oERq4qhaJ3lJm7j5v7qe/AKXZdkf7crSjGVEMcBipnIPCRJV3LYTKjbA+a3287SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZTRl5Wy8JJNE9ZMp7VEUz90+pD/CqXLERgek6XMyFM=;
 b=hJBZjwuaYu9mFs8KbBMiQ10vdYdao5NqP0tV/U2MyRuB83EVMYd3clm6B7HZy8Luqi9q38UOcSjdbHO+pRBEK/APdoTuvkBUIbz99fnid9WWfMCLylvTjnxyawWjs24k8ijPOg9rQ4wUNP1Py5JcOYwetMkhxXu0aoLy3IMpglFb2xQCJkxH6q/s+1gQFxv07UmVKXbsLTfVdA83iOnUPK+u1ARfxL1/N31jIfwemJjelyYnMqcFShtTXfAYaGc79Ju0AbokV5qKI3dsUn3aaj0L1NqsNquO6jQz60nBoT+OOX8ZBYsHUys9iHN0gLCqSns6mCIIrnQyP+fflYuu9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZTRl5Wy8JJNE9ZMp7VEUz90+pD/CqXLERgek6XMyFM=;
 b=Emnqctv/a6JnlA3MKrIbLyJKcd09v0saph+cAe16tpp7MzhnHHz4aFJhUedMpxPJVx8REtZvx2W5JiUc50Ec8eOj4HwhG5VJhanx3w86hWy8SxG03Oagu+urt1lau7qCySbOZFUAy0JwqaMRC010H7w3n+hGEWfVFuvgMsd8Ajo=
Authentication-Results: twiddle.net; dkim=none (message not signed)
 header.d=none;twiddle.net; dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2556.namprd12.prod.outlook.com (2603:10b6:907:a::11)
 by MWHPR12MB1534.namprd12.prod.outlook.com (2603:10b6:301:10::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 22:58:04 +0000
Received: from MW2PR12MB2556.namprd12.prod.outlook.com
 ([fe80::8488:291b:292c:20b9]) by MW2PR12MB2556.namprd12.prod.outlook.com
 ([fe80::8488:291b:292c:20b9%5]) with mapi id 15.20.3305.026; Thu, 27 Aug 2020
 22:58:04 +0000
Subject: RE: [PATCH v5 0/8] Remove EPYC mode apicid decode and use generic
 decode
To: Igor Mammedov <imammedo@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
 <20200824184112.GB2688@work-vm>
 <f602852c-b6af-694e-3e32-47974722e144@amd.com>
 <20200825081504.GA2646@work-vm> <20200825163846.10185087@redhat.com>
 <20200825152521.GA3574@work-vm> <20200826144324.56335302@redhat.com>
 <20200826141046.GB2727@work-vm> <20200827231907.10cfe4b7@imammedo-mac>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <f58e6200-b058-5f59-addc-13ca602ce745@amd.com>
Date: Thu, 27 Aug 2020 17:58:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200827231907.10cfe4b7@imammedo-mac>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR16CA0018.namprd16.prod.outlook.com
 (2603:10b6:3:c0::28) To MW2PR12MB2556.namprd12.prod.outlook.com
 (2603:10b6:907:a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 DM5PR16CA0018.namprd16.prod.outlook.com (2603:10b6:3:c0::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 22:58:02 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 862a638d-3b60-47c2-e709-08d84adca76d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1534:
X-Microsoft-Antispam-PRVS: <MWHPR12MB15343B1BD6C9266D013DC06195550@MWHPR12MB1534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r8sFzbAr3Kt+Q+M/GdLyHcs7VL3t3S52kL+L8KIigxUVDfRTpJrtB/z636SPu+6sabUD77emLXWC906F3VUPZ6HVgmdagvez4QsAjakVOc91WNfkRkmKf4OoR69ATerTU9KfjAl3LXVTdg0vcy+M76jl2gmGVY1Vrl15nxZ+jLt2racbN1XVBCKuP7cvCO9I74mu+xJ09nyYvmcKzFiwR5LmyFGRuNAGNrw5QRFtaGvXXmvIuonxvYHLULmC6YFliPu8amkRB5RPzQKWNKyoSL4AY80cLK25Ycc8ebf3ARLf2oci9yVIlfgT3Q3+MmcQMd3Ii4bU2FgSGIXvoyDsux4/mb6diCiEeoQgB3eLcA3jMYVTXBdPU4VqVvYOa+jXRS2UNt7qDgt7Fm3/Ah3HaUcEBZoTISR5QWmAbZJ9Ow9wOK70OSHd0Nm3Tp6+h4v7/WN09Rqrg8nOVz+uZOeEhC8UJteoXVzv/6zcsVOozDc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2556.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(52116002)(2906002)(86362001)(66556008)(44832011)(66476007)(66946007)(26005)(5660300002)(186003)(966005)(83080400001)(36756003)(2616005)(83380400001)(956004)(54906003)(45080400002)(6486002)(31696002)(31686004)(8936002)(4326008)(8676002)(16576012)(316002)(478600001)(110136005)(53546011)(41533002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 37yU3Fh3zxv4FA6ADuQsDnCxkXNPbstqNYB7cJt/JFbdYdQ6htH/YHBdIq2jJWLv8j3Z3Psg5VpODdDukUGDLO0nC1CQpzQK/r8VsbIAfROvVt5jw1YLtd8214v41FqB41L4nOb0oN3F6hF2b8/Vn/5hpRZqKkZIXpEOtROytj7NFV7ac8H/5VSggBGIoSsLNbnr8SwG+KSg9GWxPzoy7PHYAW5DxGDtEJzQerb+tGtEX2xOhL5f201PKYw36/pyZ6hK9B3ha3dXx0NW/oRf0sWPp6Mr+0rTAWS0/bLETmkgiMbrEFUSgANVw3mITtnQCnUhMsKfkNdqFQ6iGRI4c3K+g4BqHuJSUlFc5GQfb7lajpcTL7jH2Jg+qANTimdHzzZfpu6YVSJzCM/Asswtwcqi0BUlMmdSMz7EPx0vwBQFz7+NerT3q4qFnWzpVcJB7+xaGxlFC1SSgmeK0bJAqqnzMbOJfCoIH3fl/tJ7KF7Ds0QkHP98wf2yEO6bnclujMO+MYEjVYWzAw0CvT7hcu0G8LsKl6+JYgVVUcnkmCoXCZ9Nfg/Do2V+f726LA8vwGzg9yJX1LbMgPwcO97imMRNnLOSK6kPMJvqwsG3ehI2kZ+4cazRiA5TC9iHlXMZNUMAo5Gs+tRNH0oKjfFr3Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862a638d-3b60-47c2-e709-08d84adca76d
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2556.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 22:58:03.8921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1asFlU3IgKjyOgPsQU979lCnwFBHuOSK6y/np8/LMx2igevry6dV3IUJcioqZxf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1534
Received-SPF: none client-ip=40.107.92.69; envelope-from=Babu.Moger@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 19:13:09
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 NICE_REPLY_A=-1.782, RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Igor Mammedov <imammedo@redhat.com>
> Sent: Thursday, August 27, 2020 4:19 PM
> To: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: ehabkost@redhat.com; mst@redhat.com; qemu-devel@nongnu.org;
> Moger, Babu <Babu.Moger@amd.com>; pbonzini@redhat.com;
> rth@twiddle.net
> Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use
> generic decode
> 
> On Wed, 26 Aug 2020 15:10:46 +0100
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> 
> > * Igor Mammedov (imammedo@redhat.com) wrote:
> > > On Tue, 25 Aug 2020 16:25:21 +0100
> > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > >
> > > > * Igor Mammedov (imammedo@redhat.com) wrote:
> > > > > On Tue, 25 Aug 2020 09:15:04 +0100 "Dr. David Alan Gilbert"
> > > > > <dgilbert@redhat.com> wrote:
> > > > >
> > > > > > * Babu Moger (babu.moger@amd.com) wrote:
> > > > > > > Hi Dave,
> > > > > > >
> > > > > > > On 8/24/20 1:41 PM, Dr. David Alan Gilbert wrote:
> > > > > > > > * Babu Moger (babu.moger@amd.com) wrote:
> > > > > > > >> To support some of the complex topology, we introduced EPYC
> mode apicid decode.
> > > > > > > >> But, EPYC mode decode is running into problems. Also it
> > > > > > > >> can become quite a maintenance problem in the future. So,
> > > > > > > >> it was decided to remove that code and use the generic
> > > > > > > >> decode which works for majority of the topology. Most of
> > > > > > > >> the SPECed configuration would work just fine. With some
> non-SPECed user inputs, it will create some sub-optimal configuration.
> > > > > > > >> Here is the discussion thread.
> > > > > > > >> https://nam11.safelinks.protection.outlook.com/?url=https
> > > > > > > >> %3A%2F%2Flore.kernel.org%2Fqemu-devel%2Fc0bcc1a6-
> 1d84-a6e
> > > > > > > >> 7-e468-
> d5b437c1b254%40amd.com%2F&amp;data=02%7C01%7Cbabu.
> > > > > > > >>
> moger%40amd.com%7C9b15ee395daa4935640408d84acedf13%7C3dd8
> > > > > > > >>
> 961fe4884e608e11a82d994e183d%7C0%7C0%7C637341599663177545
> > > > > > > >>
> &amp;sdata=4okYGU%2F8QTYqEOZEd1EBC%2BEsIIrEV59HZrHzpbsR8s
> > > > > > > >> U%3D&amp;reserved=0
> > > > > > > >>
> > > > > > > >> This series removes all the EPYC mode specific apicid changes
> and use the generic
> > > > > > > >> apicid decode.
> > > > > > > >
> > > > > > > > Hi Babu,
> > > > > > > >   This does simplify things a lot!
> > > > > > > > One worry, what happens about a live migration of a VM from
> an old qemu
> > > > > > > > that was using the node-id to a qemu with this new scheme?
> > > > > > >
> > > > > > > The node_id which we introduced was only used internally. This
> wasn't
> > > > > > > exposed outside. I don't think live migration will be an issue.
> > > > > >
> > > > > > Didn't it become part of the APIC ID visible to the guest?
> > > > >
> > > > > Daniel asked similar question wrt hard error on start up, when
> > > > > CLI is not sufficient to create EPYC cpu.
> > > > >
> > > > >
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%
> > > > > 2Fwww.mail-archive.com%2Fqemu-
> devel%40nongnu.org%2Fmsg728536.htm
> > > > >
> l&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C9b15ee395daa49356
> 404
> > > > >
> 08d84acedf13%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63734
> 1
> > > > >
> 599663177545&amp;sdata=OnHz23W4F4TdYwlxPZwC%2B8YRY1K3qJ5U9Sfdo
> Oc
> > > > > GXtw%3D&amp;reserved=0
> > > > >
> > > > > Migration might fall into the same category.
> > > > > Also looking at the history, 5.0 commit
> > > > >   247b18c593ec29 target/i386: Enable new apic id encoding for
> > > > > EPYC based cpus models silently broke APIC ID (without versioning),
> for all EPYC models (that's were 1 new and 1 old one).
> > > > >
> > > > > (I'm not aware of somebody complaining about it)
> > > > >
> > > > > Another commit ed78467a21459, changed CPUID_8000_001E without
> versioning as well.
> > > > >
> > > > >
> > > > > With current EPYC apicid code, if all starts align (no numa or 1
> > > > > numa node only on CLI and no -smp dies=) it might produce a valid
> CPU (apicid+CPUID_8000_001E).
> > > > > No numa is gray area, since EPYC spec implies that it has to be numa
> machine in case of real EPYC cpus.
> > > > > Multi-node configs would be correct only if user assigns cpus to
> > > > > numa nodes by duplicating internal node_id algorithm that this series
> removes.
> > > > >
> > > > > There might be other broken cases that I don't recall anymore
> > > > > (should be mentioned in previous versions of this series)
> > > > >
> > > > >
> > > > > To summarize from migration pov (ignoring ed78467a21459 change):
> > > > >
> > > > >  1) old qemu pre-5.0 ==>  qemu 5.0, 5.1 - broken migration
> > > >
> > > > Oh ....
> > > >
> > > > >  2) with this series (lets call it qemu 5.2)
> > > > >      pre-5.0 ==> qemu 5.2 - should work as series basically rollbacks
> current code to pre-5.0
> > > > >      qemu 5.0, 5.1 ==> qemu 5.2 - broken
> > > > >
> > > > > It's all about picking which poison to choose, I'd preffer 2nd
> > > > > case as it lets drop a lot of complicated code that doesn't work
> > > > > as expected.
> > > >
> > > > I think that would make our lives easier for other reasons; so I'm
> > > > happy to go with that.
> > >
> > > to make things less painful for users, me wonders if there is a way
> > > to block migration if epyc and specific QEMU versions are used?
> >
> > We have no way to block based on version - and that's a pretty painful
> > thing to do; we can block based on machine type.
> >
> > But before we get there; can we understand in which combinations that
> > things break and why exactly - would it break on a 1 or 2 vCPU guest -
> > or would it only break when we get to the point the upper bits start
> > being used for example?  Why exaclty would it break - i.e. is it going
> > to change the name of sections in the migration stream - or are the
> > values we need actually going to migrate OK?
> 
> it's values of APIC ID, where 4.2 and 5.0 QEMU use different values if numa is
> enabled.
> I'd expect guest to be very confused in when this happens.
> 
> here is an example:
> qemu-4.2 -cpu EPYC -smp 8,sockets=1,cores=8 -numa node,cpus=0-3 -numa
> node,cpus=4-7
> 
> (QEMU) qom-get path=/machine/unattached/device[8] property=apic-id {
>     "return": 7
> }
> 
> vs
> 
> qemu-5.1 -cpu EPYC -smp 8,sockets=1,cores=8 -numa node,cpus=0-3 -numa
> node,cpus=4-7
> (QEMU) qom-get path=/machine/unattached/device[8] property=apic-id {
>     "return": 15
> }
> 
> we probably can't do anything based on machine type versions, as
> 4.2 and older versions on qemu-5.0 and newer use different algorithm to
> calculate apic-id.
> 
> Hence was suggestion to leave 5.0/5.1 with broken apic id and revert back to
> 4.2 algorithm, which should encode APIC ID correctly when '-smp dies' is
> used.

That is correct. When we revert all the node_id related changes, we will
go back to 4.2 algorithm. It will work fine with user passing "-smp
dies=n". It also keeps the code simple. That is why I kept the decoding of
0x8000001e like this below. This will also match apicid decoding.

*ecx = ((topo_info->dies_per_pkg - 1) << 8) |  ((cpu->apic_id >>
apicid_die_offset(topo_info)) & 0xFF);


Still not clear if we need to add a warning when numa nodes != dies.
Worried about adding that check and remove it again later.

What about auto_enable_numa? Do we still need it?

I can send the patches tomorrow if these things are clarified.
Thanks

> 
> 
> > Dave
> >
> >
> > > > > PS:
> > > > >  I didn't review it yet, but with this series we aren't  making
> > > > > up internal node_ids that should match user provided numa node ids
> somehow.
> > > > >  It seems series lost the patch that would enforce numa in case
> > > > > -smp dies>1,  but otherwise it heads in the right direction.
> > > >
> > > > Dave
> > > >
> > > > > >
> > > > > > Dave
> > > > > >
> > > > >
> > >



Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFB0C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:54:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD2D207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sDhMyREC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD2D207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBflQ-00080Y-4d
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kBfHT-0007Hk-2B
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:23:03 -0400
Received: from mail-dm6nam11on2044.outbound.protection.outlook.com
 ([40.107.223.44]:47584 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kBfHP-0005ix-Ki
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:23:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBmZmwvVs5AsW56DiB0C/APv2gAH9/3fTeuP3rQXbMUDxVxVzwI7pnlGFMkPfn4NzedQQs9xd11IuyTMxJl3VZ1UAOUFioGM44r03YAoZ49drGIu+hd7HwFMPljcpIaOTlPFZVc0/fXwq1N53esE4Ra7SoxkW3YCrQcj8G7Luqi5vuG6o4/DH6ZSJrJdxESMiZ5Wfh17oxtzw+XPdByMBkCv/+IuY+WYOM5OK8r02BsBGs2bHHEDOb2xuUpkv1ynnbWbsuXwbhPBU2SAQbRl4BTVf/CHt2Zj513AKJGU8qVrrWSz3bV0HvEDTokhZVfuuCtaN6x4tF/e4FbhMgGePg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAu1ZI99+/RaGpAk2u5nPLbAY5UARsSWhDthmNoE/T8=;
 b=bTG/ewldTRLKbjSOHoeA/yd4oGRw1fKLCXs8I0cXGnG2xS5ZAX/XvcKHkW3ye67PPWjIQPSuQBOVp0TRRdVjzRGmuVpjWdEgLGAP5k8nq2xuQtHlzRLrptn5xxn6AOlvDqx5yabe7jEjM1PAgFMCnpGekG+mUhvrd3mZ9XAAXjd9iaAa9TaarOli5JYMsr/BJZ3/qwH5xTd7gnGFWgAH52D8wcDhzNdFiR+KeIRmEayhb30lcIgzHGoQ4QWqNPBvLFI0cFFthuM62qOjyZ1Pdl6ulLg3dFBfEPnFdcGd9Yuiv1AGay+tZhtI7dfUFN80zT+bQXCpkXbQMTiFzTFPXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAu1ZI99+/RaGpAk2u5nPLbAY5UARsSWhDthmNoE/T8=;
 b=sDhMyRECnQ3/JGtblnE46ToNZrLZsBk4y1NeAcDBJket17md1KftvhyGSqY+lh6/qfFl+noLuAPUN5mAubIecbp7drfhFHiE7LUYzmyyLaNMdx3HQ8QUz6/Uaa79DnGYb+8zmmIocCNb1ertwUgR/mpZy1olo0FPjifTwKL8ifU=
Authentication-Results: twiddle.net; dkim=none (message not signed)
 header.d=none;twiddle.net; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2525.namprd12.prod.outlook.com (2603:10b6:802:29::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 28 Aug
 2020 14:22:56 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3326.023; Fri, 28 Aug 2020
 14:22:56 +0000
From: Babu Moger <babu.moger@amd.com>
Subject: RE: [PATCH v5 0/8] Remove EPYC mode apicid decode and use generic
 decode
To: Igor Mammedov <imammedo@redhat.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
 <20200824184112.GB2688@work-vm>
 <f602852c-b6af-694e-3e32-47974722e144@amd.com>
 <20200825081504.GA2646@work-vm> <20200825163846.10185087@redhat.com>
 <20200825152521.GA3574@work-vm> <20200826144324.56335302@redhat.com>
 <20200826141046.GB2727@work-vm> <20200827231907.10cfe4b7@imammedo-mac>
 <f58e6200-b058-5f59-addc-13ca602ce745@amd.com>
 <20200828104249.04c39c12@redhat.com>
Message-ID: <7ba8d539-de13-6a65-abe8-e1d2863a1820@amd.com>
Date: Fri, 28 Aug 2020 09:22:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200828104249.04c39c12@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR22CA0001.namprd22.prod.outlook.com
 (2603:10b6:3:101::11) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 DM5PR22CA0001.namprd22.prod.outlook.com (2603:10b6:3:101::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 14:22:56 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ea5b7e3-c4b6-4ef9-628a-08d84b5ddbde
X-MS-TrafficTypeDiagnostic: SN1PR12MB2525:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2525972ED34F4A46A817665595520@SN1PR12MB2525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xa2pgHgcOfE5El8LwDyw2OXKrWpRinNyFL+wGknJsd2DLjzf7gVB0UqXUPbRV60SMw6xtgpaQrJtg+eKeNOg5O1uis1Q5Nh2hur8cQG7L9/HbIfaU9b5KD+Fcj1njYeextyJotGuy3cSl1UfTTTjxdONOrpMxQTZooalSLZeoeTbIgur7r02aQDDbM6dgJU18jPbwzusLago990yLNlXAIZL5e9A3ERYF+aZtNKJ4VpE9VPf1qZ2GhtsrRW8tZBoFSP+FMb/0XXdEp7uPxCtIJGJsOF1X8lo1urDqh3WQfUpMVSFVcY8TwLhUNx2J+M3RzWyvspgnkKTTT1Z8VGcTWGEAex0WZE6Jfa0AQRWy2+s5R4UxxVWPQcj8OhdUdziiF+ha+0nPyTyx0EdzF1c7tzTV3ulHqIdkKt+3nsLafQNRsJtvIhU9RO6QxegczQyxF4/MMGGUyBES/oQq/Xz8rr5DmjZ1V+iIdVLcl9Hzgo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(478600001)(16576012)(186003)(316002)(8936002)(66946007)(66476007)(30864003)(6486002)(966005)(8676002)(54906003)(26005)(5660300002)(31696002)(66556008)(956004)(31686004)(86362001)(83080400001)(44832011)(45080400002)(2616005)(6916009)(4326008)(53546011)(2906002)(36756003)(52116002)(83380400001)(41533002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 63Mq9Ix/wIHC5jL2QvEg6e1JRxu4NJG5bI5KgHoAccmXOZ6IKjQ8dhXhD7Vr8SFcL7X+A/YvYZQ3KwxmOtomH/1eldbNU1pi/6YDiaWAj+g+acP7QVu8mfi7mVAyhudn0mBYw3ZDaNsPnL5+X2P/Eg+9JqOItROYWu3wwRfddQokz+6YjOX9vgOJvH6znDeO+EC0k3Nyoi8xkIrcxhMMAcHIgfz89I1vhGJQGuhq+E1HlvlHLOP0UVLWi9y1tCo44SegsO3E9UX+VKaBZucB7GaDaPN/qBgIn/Vl6QlYVq8DQClzgKaljuPGwnCvskz0OZdbqq8qBZTD1cGfLYnaFPr49YoYk5MqMA13IL82FjHYSUg36cIIp8q5cKBlmD2UnHTY2X3pve8wEVWqkmEDgoH9tHTO3xJ/jiRrkLnqsI2PDaWBzVHC5rrnnoLgc0BY7KLXF4bJI5bzKz1K6wPZNgtk3EAS5Oa81xSlS14D5yLKnQGCywrvORx3/nQ22T2g3EJnr8wioDZGn4LKey16oRw+wFCAX8JxcQ8lOmX8ilgqfepIOCp2sPP+7BQorQ99GdVdIJQrWA75nJLs0Mnkxk57ndFoPied2UKaC0s3T1gF7BsYyBu47pZcNbM90q62bZIuaLfQr4lRi2Lnkr/hig==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea5b7e3-c4b6-4ef9-628a-08d84b5ddbde
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 14:22:56.6630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClJhsjtLMS4eGjY+Le1fikJvRAEcnTEHV3oCHux4f7W5Jcq1fMsWvRsHnFb0uk2X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2525
Received-SPF: none client-ip=40.107.223.44; envelope-from=Babu.Moger@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 10:22:58
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 NICE_REPLY_A=-0.809, RCVD_ILLEGAL_IP=1.3, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Igor Mammedov <imammedo@redhat.com>
> Sent: Friday, August 28, 2020 3:43 AM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>; ehabkost@redhat.com;
> mst@redhat.com; qemu-devel@nongnu.org; pbonzini@redhat.com;
> rth@twiddle.net
> Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use
> generic decode
> 
> On Thu, 27 Aug 2020 17:58:01 -0500
> Babu Moger <babu.moger@amd.com> wrote:
> 
> > > -----Original Message-----
> > > From: Igor Mammedov <imammedo@redhat.com>
> > > Sent: Thursday, August 27, 2020 4:19 PM
> > > To: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > Cc: ehabkost@redhat.com; mst@redhat.com; qemu-devel@nongnu.org;
> > > Moger, Babu <Babu.Moger@amd.com>; pbonzini@redhat.com;
> > > rth@twiddle.net
> > > Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use
> > > generic decode
> > >
> > > On Wed, 26 Aug 2020 15:10:46 +0100
> > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > >
> > > > * Igor Mammedov (imammedo@redhat.com) wrote:
> > > > > On Tue, 25 Aug 2020 16:25:21 +0100 "Dr. David Alan Gilbert"
> > > > > <dgilbert@redhat.com> wrote:
> > > > >
> > > > > > * Igor Mammedov (imammedo@redhat.com) wrote:
> > > > > > > On Tue, 25 Aug 2020 09:15:04 +0100 "Dr. David Alan Gilbert"
> > > > > > > <dgilbert@redhat.com> wrote:
> > > > > > >
> > > > > > > > * Babu Moger (babu.moger@amd.com) wrote:
> > > > > > > > > Hi Dave,
> > > > > > > > >
> > > > > > > > > On 8/24/20 1:41 PM, Dr. David Alan Gilbert wrote:
> > > > > > > > > > * Babu Moger (babu.moger@amd.com) wrote:
> > > > > > > > > >> To support some of the complex topology, we
> > > > > > > > > >> introduced EPYC
> > > mode apicid decode.
> > > > > > > > > >> But, EPYC mode decode is running into problems. Also
> > > > > > > > > >> it can become quite a maintenance problem in the
> > > > > > > > > >> future. So, it was decided to remove that code and
> > > > > > > > > >> use the generic decode which works for majority of
> > > > > > > > > >> the topology. Most of the SPECed configuration would
> > > > > > > > > >> work just fine. With some
> > > non-SPECed user inputs, it will create some sub-optimal configuration.
> > > > > > > > > >> Here is the discussion thread.
> > > > > > > > > >> https://nam11.safelinks.protection.outlook.com/?url=h
> > > > > > > > > >> ttps
> > > > > > > > > >> %3A%2F%2Flore.kernel.org%2Fqemu-devel%2Fc0bcc1a6-
> > > 1d84-a6e
> > > > > > > > > >> 7-e468-
> > > d5b437c1b254%40amd.com%2F&amp;data=02%7C01%7Cbabu.
> > > > > > > > > >>
> > > moger%40amd.com%7C9b15ee395daa4935640408d84acedf13%7C3dd8
> > > > > > > > > >>
> > > 961fe4884e608e11a82d994e183d%7C0%7C0%7C637341599663177545
> > > > > > > > > >>
> > > &amp;sdata=4okYGU%2F8QTYqEOZEd1EBC%2BEsIIrEV59HZrHzpbsR8s
> > > > > > > > > >> U%3D&amp;reserved=0
> > > > > > > > > >>
> > > > > > > > > >> This series removes all the EPYC mode specific apicid
> > > > > > > > > >> changes
> > > and use the generic
> > > > > > > > > >> apicid decode.
> > > > > > > > > >
> > > > > > > > > > Hi Babu,
> > > > > > > > > >   This does simplify things a lot!
> > > > > > > > > > One worry, what happens about a live migration of a VM
> > > > > > > > > > from
> > > an old qemu
> > > > > > > > > > that was using the node-id to a qemu with this new scheme?
> > > > > > > > >
> > > > > > > > > The node_id which we introduced was only used
> > > > > > > > > internally. This
> > > wasn't
> > > > > > > > > exposed outside. I don't think live migration will be an issue.
> > > > > > > >
> > > > > > > > Didn't it become part of the APIC ID visible to the guest?
> > > > > > >
> > > > > > > Daniel asked similar question wrt hard error on start up,
> > > > > > > when CLI is not sufficient to create EPYC cpu.
> > > > > > >
> > > > > > >
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%25
> > > > > > > 2Fwww.mail-archive.com%2Fqemu-
> > > devel%40nongnu.org%2Fmsg728536.htm
> > > > > > >
> > >
> l&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C9b15ee395daa49356
> > > 404
> > > > > > >
> > >
> 08d84acedf13%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63734
> > > 1
> > > > > > >
> > >
> 599663177545&amp;sdata=OnHz23W4F4TdYwlxPZwC%2B8YRY1K3qJ5U9Sfdo
> > > Oc
> > > > > > > GXtw%3D&amp;reserved=0
> > > > > > >
> > > > > > > Migration might fall into the same category.
> > > > > > > Also looking at the history, 5.0 commit
> > > > > > >   247b18c593ec29 target/i386: Enable new apic id encoding
> > > > > > > for EPYC based cpus models silently broke APIC ID (without
> > > > > > > versioning),
> > > for all EPYC models (that's were 1 new and 1 old one).
> > > > > > >
> > > > > > > (I'm not aware of somebody complaining about it)
> > > > > > >
> > > > > > > Another commit ed78467a21459, changed CPUID_8000_001E
> > > > > > > without
> > > versioning as well.
> > > > > > >
> > > > > > >
> > > > > > > With current EPYC apicid code, if all starts align (no numa
> > > > > > > or 1 numa node only on CLI and no -smp dies=) it might
> > > > > > > produce a valid
> > > CPU (apicid+CPUID_8000_001E).
> > > > > > > No numa is gray area, since EPYC spec implies that it has to
> > > > > > > be numa
> > > machine in case of real EPYC cpus.
> > > > > > > Multi-node configs would be correct only if user assigns
> > > > > > > cpus to numa nodes by duplicating internal node_id algorithm
> > > > > > > that this series
> > > removes.
> > > > > > >
> > > > > > > There might be other broken cases that I don't recall
> > > > > > > anymore (should be mentioned in previous versions of this
> > > > > > > series)
> > > > > > >
> > > > > > >
> > > > > > > To summarize from migration pov (ignoring ed78467a21459
> change):
> > > > > > >
> > > > > > >  1) old qemu pre-5.0 ==>  qemu 5.0, 5.1 - broken migration
> > > > > >
> > > > > > Oh ....
> > > > > >
> > > > > > >  2) with this series (lets call it qemu 5.2)
> > > > > > >      pre-5.0 ==> qemu 5.2 - should work as series basically
> > > > > > > rollbacks
> > > current code to pre-5.0
> > > > > > >      qemu 5.0, 5.1 ==> qemu 5.2 - broken
> > > > > > >
> > > > > > > It's all about picking which poison to choose, I'd preffer
> > > > > > > 2nd case as it lets drop a lot of complicated code that
> > > > > > > doesn't work as expected.
> > > > > >
> > > > > > I think that would make our lives easier for other reasons; so
> > > > > > I'm happy to go with that.
> > > > >
> > > > > to make things less painful for users, me wonders if there is a
> > > > > way to block migration if epyc and specific QEMU versions are used?
> > > >
> > > > We have no way to block based on version - and that's a pretty
> > > > painful thing to do; we can block based on machine type.
> > > >
> > > > But before we get there; can we understand in which combinations
> > > > that things break and why exactly - would it break on a 1 or 2
> > > > vCPU guest - or would it only break when we get to the point the
> > > > upper bits start being used for example?  Why exaclty would it
> > > > break - i.e. is it going to change the name of sections in the
> > > > migration stream - or are the values we need actually going to migrate
> OK?
> > >
> > > it's values of APIC ID, where 4.2 and 5.0 QEMU use different values
> > > if numa is enabled.
> > > I'd expect guest to be very confused in when this happens.
> > >
> > > here is an example:
> > > qemu-4.2 -cpu EPYC -smp 8,sockets=1,cores=8 -numa node,cpus=0-3
> > > -numa
> > > node,cpus=4-7
> > >
> > > (QEMU) qom-get path=/machine/unattached/device[8] property=apic-id
> {
> > >     "return": 7
> > > }
> > >
> > > vs
> > >
> > > qemu-5.1 -cpu EPYC -smp 8,sockets=1,cores=8 -numa node,cpus=0-3
> > > -numa
> > > node,cpus=4-7
> > > (QEMU) qom-get path=/machine/unattached/device[8] property=apic-id
> {
> > >     "return": 15
> > > }
> > >
> > > we probably can't do anything based on machine type versions, as
> > > 4.2 and older versions on qemu-5.0 and newer use different algorithm
> > > to calculate apic-id.
> > >
> > > Hence was suggestion to leave 5.0/5.1 with broken apic id and revert
> > > back to
> > > 4.2 algorithm, which should encode APIC ID correctly when '-smp
> > > dies' is used.
> >
> > That is correct. When we revert all the node_id related changes, we
> > will go back to 4.2 algorithm. It will work fine with user passing
> > "-smp dies=n". It also keeps the code simple. That is why I kept the
> > decoding of 0x8000001e like this below. This will also match apicid decoding.
> >
> > *ecx = ((topo_info->dies_per_pkg - 1) << 8) |  ((cpu->apic_id >>
> > apicid_die_offset(topo_info)) & 0xFF);
> that will work when there is no -numa on CLI, when -numa is used, we
> should use node id that user provided.
> like you did in previous revision
>    "[PATCH v4 1/3] i386: Simplify CPUID_8000_001E for AMD"

This might be a problem in the future with new BIOS options to change the
NPS(Nodes per Socket). Nodes and dies may not match. Then we will end up
with wrong CPUID_8000_001E encoding. That is why I wanted to keep both of
them separate. Users have the option to configure the way it matches their
bios config.


> 
> > Still not clear if we need to add a warning when numa nodes != dies.
> > Worried about adding that check and remove it again later.
> Since there is objection wrt making it error and I'd go with warning for now, it
> makes life of person who have to figure what's wrong a bit easier.
> 
> > What about auto_enable_numa? Do we still need it?
> >
> >
> > I can send the patches tomorrow if these things are clarified.
> > Thanks
> With auto_enable_numa it would be cleaner as you can reuse the same
> numa code to set 0x8000001e.ecx vs hardcodding it as above.
> 
> Maybe post series without auto_enable_numa so we fix migration
> regression ASAP and then switch to auto_enable_numa on top.
> 
> 
> >
> > >
> > >
> > > > Dave
> > > >
> > > >
> > > > > > > PS:
> > > > > > >  I didn't review it yet, but with this series we aren't
> > > > > > > making up internal node_ids that should match user provided
> > > > > > > numa node ids
> > > somehow.
> > > > > > >  It seems series lost the patch that would enforce numa in
> > > > > > > case -smp dies>1,  but otherwise it heads in the right direction.
> > > > > >
> > > > > > Dave
> > > > > >
> > > > > > > >
> > > > > > > > Dave
> > > > > > > >
> > > > > > >
> > > > >
> >



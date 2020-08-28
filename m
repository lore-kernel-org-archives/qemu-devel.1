Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A026AC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:18:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537B020848
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="O5UzBC8o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537B020848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfD5-0006eh-Jz
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kBfCP-00069q-Tl
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:17:50 -0400
Received: from mail-dm6nam10on2084.outbound.protection.outlook.com
 ([40.107.93.84]:47840 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1kBfCN-0004qS-IB
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:17:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3y7//A3zAnJFDyyVtKP5oEJ7QRq8f+1uLeX+7SL+Cc+Ga1g2J5EiWN8w2fKD6IIxBs44Yd3vS5qpFJeJA9eyyVn+CKUvrfOu6OHSvfZSBvm+NylpVykpgrMQ9pLnJsBiCVK1s8aFP124PV8B0a30p0OsN+RQKahl4IPO1EvvebCYY/tzpMpIV0iL3Rdf+GGOqtwwiJ2JPgjeO+NkkfxIEcxZeiBI61Z1Yref6Y0X6gRCSVwNDT1xkSUWV7NohzsjUDVx/udX90+zBRjBTAjSoQvQ5aXbwuQEjbv2VxsZ6hOEOnLbkjMCKhHFRAsNf2xz6TM4uuHh88E9G005rZkuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESygBqL41dmvyM4zdMrllxqBYMmZC12eCbx9Pni7oYw=;
 b=Td14QrGweCpv42AUaHVxiYco7cAzii1R/PITCmIv36au1yNtT6DT4MosH9BzmNIgRIrCSZwUF+AwfT4tChEkCaqmPE1UNpHcRdwhVqXM/gDPnCRHavdbo5ob804M+/weRKxv8PTPJrH0OsGdQqMqqZu/lvun8QTR7FwlwGubPTEjTdNnzDQPWzC6ckcwCsP8gH/a+Cy2h5jqWxQPw3Ub7EjPJ1cWjeOmY75gnkXK2IhLwWP7bveQ3r4V5yGXVDSBW7qAYK+/K98L8q+8tyhIG2WSNr6RiWpG2+IheYMD8Z6jGGq3MNyNcli6KUlgg1uJFK4kS9gpOUDfT7vT4MlR9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESygBqL41dmvyM4zdMrllxqBYMmZC12eCbx9Pni7oYw=;
 b=O5UzBC8oGrAfKbqgBYN0K/Kf1zGkI3ETH1lsQL4HNL+xodHPMTyIvBLs4hIqdicjz6ao7tYOptj9DSGQT9wihVzGF9qvZ7aJi1n63vuVeKmV5NSpzjdARV5FNsPHnnkn66wo15ciNaKF5nnCirXs1O9OtMX5etS+UuciSXuIRLU=
Authentication-Results: twiddle.net; dkim=none (message not signed)
 header.d=none;twiddle.net; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2557.namprd12.prod.outlook.com (2603:10b6:802:22::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Fri, 28 Aug
 2020 14:17:44 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::ccd9:728:9577:200d%4]) with mapi id 15.20.3326.023; Fri, 28 Aug 2020
 14:17:44 +0000
Subject: RE: [PATCH v5 0/8] Remove EPYC mode apicid decode and use generic
 decode
To: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <159804762216.39954.15502128500494116468.stgit@naples-babu.amd.com>
 <20200826143849.59f6970b@redhat.com> <20200826125059.GN168515@redhat.com>
 <20200826153034.115126cb@redhat.com>
 <5c00dac9-5ea5-405c-93be-1ac903ddff62@amd.com>
 <20200826183331.GA3977@work-vm>
 <11489e5f-2285-ddb4-9c35-c9f522d603a0@amd.com>
 <20200827222110.1c2ee236@imammedo-mac> <20200828085803.GD224144@redhat.com>
 <20200828132436.63de9921@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <56d9a7fb-d88a-258d-1c67-768d63369643@amd.com>
Date: Fri, 28 Aug 2020 09:17:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200828132436.63de9921@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0201CA0026.namprd02.prod.outlook.com
 (2603:10b6:803:2e::12) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 SN4PR0201CA0026.namprd02.prod.outlook.com (2603:10b6:803:2e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Fri, 28 Aug 2020 14:17:43 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff197874-6fde-4a8c-e61d-08d84b5d217c
X-MS-TrafficTypeDiagnostic: SN1PR12MB2557:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2557968161FC51B5DDF27A5995520@SN1PR12MB2557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PsZyiB7sdE7kBpcT8REt68d5t1iXjJOGOC4vtzEwp4/CSFdL7Fna+u5Qqsedrq/x8Jflbxj1jxPkBd0AqJXqhDSXnOt8OInJ0JvS7UENukyxxkREcaqnwmmHCe4M/jhwWJdNAwMizOy/ZMzd7uMtgJk/JxeR4xrW3gNAyjC+lxhzeYhnk64lRckwR2vRhthXag/BFwWj+x2z9vGgA/Vp+ge26fAS3FYxYsJ/1RIYJVoWVzjSfLD65++VyhmA0PT87PLC1hBWC0QZGtxJ8b16Pbsb7CkRPrujp2MqZVpgSlAS2HoKGoT0gGV4JCG3FI2DO1/58zdfBr8MuJ3TxDz6DiQZp2aAJQNgGaJHt0qLc9KN+Zyl7n77nKr1Sdk3A5l77EdIDK4dH3Db7zJMjsEMIFtmQR25KmmXUrjSIxazEqvoGH35ZGBIfBnUcvzmtFLEsBffSMjyBI7xS+xd566ej2z3D54nQ8AUosX9nqGz7Dg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(8936002)(31696002)(54906003)(110136005)(2616005)(36756003)(316002)(4326008)(16576012)(45080400002)(26005)(52116002)(956004)(31686004)(53546011)(6486002)(186003)(2906002)(19627235002)(44832011)(66556008)(966005)(8676002)(83080400001)(478600001)(83380400001)(66946007)(86362001)(5660300002)(66476007)(41533002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: NHI/bdn0hy/HNq4qBdj12yhxaTorrYfQ7hI5KZez7Gctppd742he61rT+bwD+RVkmPz2Nw8QQWJ+GmteCPjZ08lSRJ1oMfZYXW8rJdaWdDeRoRALvsIbo+PM50wor5MG9koe06KeYjjDXtpWGHuivP3meyoh719hrD7v2aR03DwGbw3L6lx3eo6rAkUQ8E80iEXIXgJDSfQg7smfKZh4hzY86ge8qp8mc6WOdq0SEK79Wme7fXRqoGW6LMswQmkExeBHmJtld1ScoF1HpiS2YtyJd9cypvdCN9oUezRcrEWsguQiDGPBhvMqKQBFH7h+vu66CK2rrvGBC+d7ei3Vnnon6dBUFah/5LXwtilkVPIc+pD7ymCUXBF8koUF/1mSpCKAvXy26mOs41/gwId8kDZ1EfV1SRQZrgB5pzg5q2XuIHCqKYLg6hOrz/pZYwrP3K5q1Epz05yYYJtnAm/h4XX4rcZi6/e17lSwbOSG6HjgKWbRXXjQCWpynwEDyrYR+S0o0Evpg55D0Sa7sMKtswModzwfD+IjABzGbKlRgtBJwK0IQ0zGLLOKFZBCje31JJRIxsoG3rwAdEuM5PiGXtTbF8dOAdZZ+SyUbeI4NFsnhH8u6vHv1rvcuVVOCBGar+F8SKhK+h8hsAksjAYUMQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff197874-6fde-4a8c-e61d-08d84b5d217c
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 14:17:44.6715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0JS2Ds+SIvwysDu8UUYLIxzBsjjZtjlQxAL9Q2Xxt2Pe5A1Xr2FdkFGPG6Xo49K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2557
Received-SPF: none client-ip=40.107.93.84; envelope-from=Babu.Moger@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 10:17:45
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
 "mst@redhat.com" <mst@redhat.com>, Michal Privoznik <mprivozn@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Igor Mammedov <imammedo@redhat.com>
> Sent: Friday, August 28, 2020 6:25 AM
> To: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Moger, Babu <Babu.Moger@amd.com>; Dr. David Alan Gilbert
> <dgilbert@redhat.com>; ehabkost@redhat.com; mst@redhat.com; Michal
> Privoznik <mprivozn@redhat.com>; qemu-devel@nongnu.org;
> pbonzini@redhat.com; rth@twiddle.net
> Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and use
> generic decode
> 
> On Fri, 28 Aug 2020 09:58:03 +0100
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Thu, Aug 27, 2020 at 10:21:10PM +0200, Igor Mammedov wrote:
> > > On Wed, 26 Aug 2020 13:45:51 -0500
> > > Babu Moger <babu.moger@amd.com> wrote:
> > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > > Sent: Wednesday, August 26, 2020 1:34 PM
> > > > > To: Moger, Babu <Babu.Moger@amd.com>
> > > > > Cc: Igor Mammedov <imammedo@redhat.com>; Daniel P. Berrangé
> > > > > <berrange@redhat.com>; ehabkost@redhat.com; mst@redhat.com;
> > > > > Michal Privoznik <mprivozn@redhat.com>; qemu-
> devel@nongnu.org;
> > > > > pbonzini@redhat.com; rth@twiddle.net
> > > > > Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode and
> > > > > use generic decode
> > > > >
> > > > > * Babu Moger (babu.moger@amd.com) wrote:
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Igor Mammedov <imammedo@redhat.com>
> > > > > > > Sent: Wednesday, August 26, 2020 8:31 AM
> > > > > > > To: Daniel P. BerrangÃ© <berrange@redhat.com>
> > > > > > > Cc: Moger, Babu <Babu.Moger@amd.com>;
> pbonzini@redhat.com;
> > > > > > > rth@twiddle.net; ehabkost@redhat.com; qemu-
> devel@nongnu.org;
> > > > > > > mst@redhat.com; Michal Privoznik <mprivozn@redhat.com>
> > > > > > > Subject: Re: [PATCH v5 0/8] Remove EPYC mode apicid decode
> > > > > > > and use generic decode
> > > > > > >
> > > > > > > On Wed, 26 Aug 2020 13:50:59 +0100 Daniel P. BerrangÃ©
> > > > > > > <berrange@redhat.com> wrote:
> > > > > > >
> > > > > > > > On Wed, Aug 26, 2020 at 02:38:49PM +0200, Igor Mammedov
> wrote:
> > > > > > > > > On Fri, 21 Aug 2020 17:12:19 -0500 Babu Moger
> > > > > > > > > <babu.moger@amd.com> wrote:
> > > > > > > > >
> > > > > > > > > > To support some of the complex topology, we introduced
> > > > > > > > > > EPYC mode
> > > > > > > apicid decode.
> > > > > > > > > > But, EPYC mode decode is running into problems. Also
> > > > > > > > > > it can become quite a maintenance problem in the
> > > > > > > > > > future. So, it was decided to remove that code and use
> > > > > > > > > > the generic decode which works for majority of the
> > > > > > > > > > topology. Most of the SPECed configuration would work
> > > > > > > > > > just fine. With some non-SPECed user inputs, it will
> > > > > > > > > > create some sub-
> > > > > > > optimal configuration.
> > > > > > > > > > Here is the discussion thread.
> > > > > > > > > > https://nam11.safelinks.protection.outlook.com/?url=ht
> > > > > > > > > > tps%3A%252
> > > > > > > > > > F%2F
> > > > > > > > > > lore.kernel.org%2Fqemu-devel%2Fc0bcc1a6-1d84-a6e7-
> e468
> > > > > > > > > > -
> > > > > > > d5b437c1b25
> > > > > > > > > >
> > > > > > >
> > > > >
> 4%40amd.com%2F&amp;data=02%7C01%7Cbabu.moger%40amd.com%7C8a
> 5c
> > > > > > > 52f92
> > > > > > > > > >
> > > > > > >
> > > > >
> 3f04082a40808d849c43d49%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> > > > > > > C0
> > > > > > > > > >
> > > > > > >
> > > > >
> %7C637340454473508873&amp;sdata=VnW28H1v4XwK3GaNGFxu%2BhwiMe
> A
> > > > > > > YO%2B
> > > > > > > > > > 3WAzo3DeY5Ha8%3D&amp;reserved=0
> > > > > > > > > >
> > > > > > > > > > This series removes all the EPYC mode specific apicid
> > > > > > > > > > changes and use the generic apicid decode.
> > > > > > > > >
> > > > > > > > > the main difference between EPYC and all other CPUs is
> > > > > > > > > that it requires numa configuration (it's not optional)
> > > > > > > > > so we need an extra
> > > > > > No, That is not true. Because of that assumption we made all
> > > > > > these apicid changes. And here we are now.
> > > > > >
> > > > > > AMD supports varies mixed configurations. In case of
> > > > > > EPYC-Rome, we have NPS1, NPS2 and NPS4(Numa Nodes per
> socket).
> > > > > > In case of NPS1, basically we have all the cores in a socket
> > > > > > under one numa node. This is non-numa configuration.
> > > > > > Looking at the various configurations and also discussing
> > > > > > internally, it is not advisable to have (epyc && !numa) check.
> > > > >
> > > > > Indeed on real hardware, I don't think we always see NUMA; my
> > > > > single socket,
> > > > > 16 core/32 thread 7302P Dell box, shows the kernel printing 'No
> > > > > NUMA configuration found...Faking a node.'
> > > looks like firmware bug or maybe it's feature and there is a knob in
> > > fw to turn it on/off in case used OS doesn't like it for some reason.
> > >
> > >
> > > > > So if real hardware hasn't got a NUMA node, what's the real problem?
> > > >
> > > > I don't see any problem once we revert all these changes(patch 1-7).
> > > > We don't need if (epyc && !numa) error check or
> > > > auto_enable_numa=true unconditionally.
> > >
> > > We need revert to unbreak migration from QEMU < 5.0, everything else
> > > (fixes for CPUID_Fn8000001E) could go on top.
> > >
> > > So what's on top (because old code also wasn't correct when
> > > CPUID_Fn8000001E is taken in account, tha's why we are at this
> > > point),
> > >
> > > When starting QEMU without -numa
> > > Indeed we can skip "if (epyc && !numa) error check or
> > > auto_enable_numa=true", in case where there is 1 die (NPS1).
> > > (1) User however may set core/threads number bigger than possible by
> spec,
> > >     in which case CPUID_Fn8000001E_EBX/CPUID_Fn8000001E_ECX will not
> be
> > >     valid spec vise and could trigger OPPs in guest kernel.
> > >     Given we allow go out of spec, perhaps we should add a warning at
> > >     realize time saying that used -smp config is not supported since it
> > >     doesn't match AMD EPYC spec and might not work.
> > >
> > > (2) Earlier we agreed that we can reuse existing die_id instead of internal
> > >     (topo_ids.node_id in current code)
> > >     (It's is called DIE_ID and NODE ID in spec interchangeably)
> > >     Same as (1) add a warning when '-smp dies' goes beyond spec limits.
> > >
> > > (3) "-smp dies>1" ''if'' we allow to run it without -numa,
> > >     then system wide NUMA node id in CPUID_Fn8000001E_ECX probably
> doesn't matter.
> > >     could be something like in spec but taking in account die offset, to
> produce
> > >     unique id.
> > >
> > >     Same, add a warning that there are more than 1 dies but numa is not
> enabled,
> > >     suggest to enable numa.
> > >
> > >     With current code it produces invalid APIC ID for valid '-smp'
> combination,
> > >     however if we revert it and switch to die_id than it should produce
> > >     valid APIC ID once again (as in 4.2).
> > >     Given it produces invalid APIC id, maybe we should just ditch the case
> and
> > >     fold it in (4) (i.e. require -numa if "-smp dies>1")
> > >
> > > (4) -numa is used (RHBZ1728166)
> > >     we need to ensure that socket*dies == ms->numa_state->num_nodes
> > >      and make sure that CPUID_Fn8000001E_ECX consistent with
> > >     cpu mapping provided with "-numa cpu=" option.
> >
> > Why do we need to socket*dies == ms->numa_state->num_nodes ? That
> > doesn't seem to be the case in bare metal EPYC nodes I've used which
> > lets you configure how many NUMA nodes in firmware.
> 
> (From dumps Babu has provided earlier, it was dies == nodes and
> CPUID_Fn8000001E_ECX == numa node ids in SRAT.)

Yes, That is correct. In most cases dies == nodes.

But that is going to change. In future(even in EPYC-Rome) with new f/w
BIOS option, users can configure their numa node. It will give the option
to keep NPS1, SPS2 or NSP4(Nodes per socket). In those cases dies and
nodes will not match. That is why I wanted to keep them separate. User can
change dies or -numa to match their bios config.

> 
> dumping CPUID_Fn8000001E and SRAT table for such configs will help us to
> figure out if we need socket*dies != nodes and how to compose config were
> SRAT differs from CPUID_Fn8000001E_ECX.
> 
> Babu, can you provide CPUID_Fn8000001E and SRAT dumps for above configs
> combinations? Or to some spec/guide how it should be.

I dont have the config right now. But I will try to get one.

> 
> 
> >
> >
> > Regards,
> > Daniel



Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC831C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 15:03:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66F620578
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 15:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N8CzZYAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66F620578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzzn-0005WD-Qr
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 11:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1juzyP-00041H-UY
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 11:02:29 -0400
Received: from mail-mw2nam12on2044.outbound.protection.outlook.com
 ([40.107.244.44]:6212 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1juzyN-0007si-Cr
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 11:02:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhU4/FA9hwW9vAAcamCZuprhdgpF2muBc8HcuGI31NcaEUH8lU8HpCGUfVUUtkDFe775GKWmqHV/90HUqcgn9eL48OGqXdjC/BOLW8ELQxlbTMZRxEFbIm5ksm1GVDv3MddJHxeaHQOMVqBAlREQHXIRsMGBgd6glMnyfF/yNv9jbiEr0s+sNrzqfGJ/5xAcmT/6MA9LJXQfDwj/QFOPCGYK84T4ik5XLXNl7RAuosgtDtOhTJAU+FPl73QjqxX2WFABJQFh6MVYIeYzLKLmF/fDot457IbOQhFJpymVOe3Ra3reVUDwGXHk+xH2hw3AwYGHcfBdQj56MrvgX7LR7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+RN1XhqVtCvGcPbQvtVlD7f+6DRENbKieMsxZTvOmA=;
 b=eaKCnX3+41uTuodS+hyE1fsj9dpy/Ia2S357gwYLXPNIAeXSShZ8Ni+04Dww2T1zD1rvUWQBI8DA/pZn6P643gorfhuG6U6QT1tYzSKrFvfhOzZj6RzgipjbBF6qjPIbmHF5ZhEe1CDWW3jBfGar7hXs7ZMKROSMe348gr1WdtFZpNs7GcBBEBqFyQTIeoAlvluDMZcqX+qesZUSIJUpy9nSEegAkdY8MY95iIPcYhOalZl3cLj+IQfO/oT3/26B5eXPr96KMAOdE7LGog5HJsd4cO4WjkcHBqcQAClYmK0o71HmbK2B6znlfhU1qBm7sdF8HYDcWwFwxRMOk1165Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+RN1XhqVtCvGcPbQvtVlD7f+6DRENbKieMsxZTvOmA=;
 b=N8CzZYAdl0jOcmRCusbWgjQe2f6kgE9VSIY5Dcnf75y8XIALBF2m1BBon4c7AhH6nElwfREvqHRCnmodNFVNtdSw4FYbWMRj2eR87BCOoDDPhY8WKNTrN4f8F4ipEkjCkzjwpq36gbpdiu0QiWslElOafsFHc4W1w8df60qDCUQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN6PR12MB2624.namprd12.prod.outlook.com (2603:10b6:805:70::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Mon, 13 Jul
 2020 15:02:24 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 15:02:24 +0000
Subject: RE: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
 CpuInstanceProperties
To: Igor Mammedov <imammedo@redhat.com>
References: <159362436285.36204.986406297373871949.stgit@naples-babu.amd.com>
 <159362466108.36204.3751851750959980962.stgit@naples-babu.amd.com>
 <20200713110822.5495e1c6@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <78809d9f-a491-8c99-3f35-7f012c7d75bf@amd.com>
Date: Mon, 13 Jul 2020 10:02:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200713110822.5495e1c6@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0140.namprd07.prod.outlook.com
 (2603:10b6:3:13e::30) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by
 DM5PR07CA0140.namprd07.prod.outlook.com (2603:10b6:3:13e::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20 via Frontend Transport; Mon, 13 Jul 2020 15:02:23 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7429c115-d3e5-41ef-78bb-08d8273dbfe3
X-MS-TrafficTypeDiagnostic: SN6PR12MB2624:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2624802923556F9BF8DF4EB195600@SN6PR12MB2624.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kbaGQFksunP1zjR13ou5k/HjrUEBAAfMa0fykq3jxycPOlPfxz5QFJ10SiqafvS1DfONXuyXAPeEq/L/JCjaGHGhmNjN1dVChZJcjuN7PtnBTLhorG4RI66i0B9Z10zzHwsOLJqWgDu+wOagt/VeIAfGLSWEvCHCSfeKsjYJ/vK8LN9FDvxLFLix9vBlEI3s9x7eZHuA7KkzMtGhxaFEDbjtpptIH9A8UzakWVMJXnn71BlcZckFmsCX2hUusk3sQwO9Lg2IzKyOGW8AtUmvDhYsvjxZjBo0hVJBK4izHXkthLBhQMzkeVQI8+frNrA9Zw7cGGsJOqWgWZ006w2wxRmRA+j8SSW0FESiGvsQx5o/2wn08nKVG7LDUvaTXVfG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(31686004)(8676002)(956004)(83380400001)(5660300002)(478600001)(2616005)(26005)(6486002)(186003)(16526019)(54906003)(36756003)(52116002)(8936002)(4326008)(2906002)(316002)(31696002)(44832011)(16576012)(86362001)(66476007)(66946007)(66556008)(53546011)(6916009)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0D9QqOShxmmHra7O5LamYUbJR6ENBdMTEN/GPVx4mq1v0u+d7v6Zrx25ez37JSVvnvxbO+BdOuBlrPKaNeD2dYXOinoBonkcii16br0qVcbRcHWtZ2xBEevNFTg3wpRAKM3oMqiN/uY1j4aENlzYMDxIthlg56KU5NAT214rQWNi/vdD8/S6ETCxfIVzi8eW447otdwj+Ifo8O2drGNg45Upp6iyb0idff087LFe1YOMeZqD92DChvMgH5Snp/5v0qIfL7RNbzL3PA8SCtLYKOTC0TcDwLSZRH58ols34kCYkrfslLk5wB9H1FLnDAqIbKChx3rbTHDrFFeCDGq8UVzZMv2h0KPSGP1X5WhG8Uktl3iPPQzTEG5oTBSGxSBA5RA96u2QuwRV6OUZYpLnZrwvU4X6fjb6opIjPoVe4i/Xf3HxvPqn8nwyOOvgTteGsj/xz6JTdBcGy4w8Frml54IMjxz5W3wQ3ZmnRR3MyzY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7429c115-d3e5-41ef-78bb-08d8273dbfe3
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 15:02:24.1717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1JrDh2hd8sU/XwwAWMHiHNPHfCuMJB+mWCbLZfw2g9KZBM9CA2FYQZQnXvLAFKd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2624
Received-SPF: none client-ip=40.107.244.44; envelope-from=Babu.Moger@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 11:02:25
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Igor Mammedov <imammedo@redhat.com>
> Sent: Monday, July 13, 2020 4:08 AM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com; qemu-
> devel@nongnu.org
> Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
> CpuInstanceProperties
> 
> On Wed, 01 Jul 2020 12:31:01 -0500
> Babu Moger <babu.moger@amd.com> wrote:
> 
> > This is in preparation to build the apic_id from user provided
> > topology information.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  include/hw/i386/topology.h |   19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> > index 07239f95f4..7cb21e9c82 100644
> > --- a/include/hw/i386/topology.h
> > +++ b/include/hw/i386/topology.h
> > @@ -40,6 +40,7 @@
> >
> >
> >  #include "qemu/bitops.h"
> > +#include "qapi/qapi-types-machine.h"
> >
> >  /* APIC IDs can be 32-bit, but beware: APIC IDs > 255 require x2APIC support
> >   */
> > @@ -196,6 +197,24 @@ static inline void
> x86_topo_ids_from_apicid_epyc(apic_id_t apicid,
> >      topo_ids->pkg_id = apicid >> apicid_pkg_offset_epyc(topo_info);
> >  }
> >
> > +
> > +/*
> > + * Initialize topo_ids from CpuInstanceProperties
> > + * node_id in CpuInstanceProperties(or in CPU device) is a sequential
> > + * number, but while building the topology
> 
> >we need to separate it for
> > + * each socket(mod nodes_per_pkg).
> could you clarify a bit more on why this is necessary?

If you have two sockets and 4 numa nodes, node_id in CpuInstanceProperties
will be number sequentially as 0, 1, 2, 3.  But in EPYC topology, it will
be  0, 1, 0, 1( Basically mod % number of nodes per socket).


> > + */
> > +static inline void x86_init_topo_ids(X86CPUTopoInfo *topo_info,
> > +                                     CpuInstanceProperties props,
> > +                                     X86CPUTopoIDs *topo_ids) {
> > +    topo_ids->smt_id = props.has_thread_id ? props.thread_id : 0;
> > +    topo_ids->core_id = props.has_core_id ? props.core_id : 0;
> > +    topo_ids->die_id = props.has_die_id ? props.die_id : 0;
> > +    topo_ids->node_id = props.has_node_id ?
> > +                        props.node_id % MAX(topo_info->nodes_per_pkg, 1) : 0;
> > +    topo_ids->pkg_id = props.has_socket_id ? props.socket_id : 0; }
> >  /*
> >   * Make APIC ID for the CPU 'cpu_index'
> >   *
> >



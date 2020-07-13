Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67285C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 15:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CAAA2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 15:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bTpWy2pW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CAAA2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv0C1-0003KI-8n
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 11:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jv0BA-0002rY-GH
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 11:15:41 -0400
Received: from mail-eopbgr700075.outbound.protection.outlook.com
 ([40.107.70.75]:39841 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1jv0B7-0002Fo-JE
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 11:15:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlxte2ZdYcSlhOocshp8CgCPR2VoKkg+8gXvSHzOUMAGROj/lu5N2JbX2NQpiOzoLIUb64yZvpeLk7mNRjohjfNggiI6Ax25bIyn0OujVlMzI1rsDr2iaXTE5UspX2bES1elzg5rTMIe9Doy6gaJ4f2tSBqXUFN9NfWeNxjl31wnOGcG83Ai7fffyBjil/0+qJMDRIQ/v7TEcKdTAvUUx5TxOegfjw1T/ZPjfKapQTSXbfR0+FIaP8zjY41INRAQjGW5c+v740bumwn+gDW3y74teblMBIsQDiM8/FVgsWh0lQrW1DuTKnpQXvt/moHTpEZ5l+8zt7O4tU10CL6wXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnNy2nZb4cLSefZQJ8kTeVQmvvqAhL2tjmidWhEMHgA=;
 b=XJprMnifxCxekc9tGMKz8CI4jtG4KYeQJR8zOkXeZh/SKuph6AdhQ/lPTpi9hS5Ro0ny+gF0ff/TcxsH4D1/QJntFXX2Ds+a6ajVxx4HL2J6SU9QDCc4e/WpQmQyWHMXhGHM4T1zEcHFtSb0/PTJX/qWXooHAu7Zmgg2RiUuw7Vk/eSH7weMI7xI56kKf9ykCzuQAaPeDeeFVhyHgV7vkyRFxLAJqzDZTu+r0m0b5I82130J1zjismV9vOYTNCc3DriyoDRIOHUcNMuZwXz9Fg25Xld7B1v8PXtL9LSb+qFRMPFzuoRZtWjGi8YpqqupaOjxj4pMq2EN9BHRtWxMow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnNy2nZb4cLSefZQJ8kTeVQmvvqAhL2tjmidWhEMHgA=;
 b=bTpWy2pWs094CMCu+8X2V8AioCqlCY2X6gkxqJup9YfgSLFVmCAfvRdkKQhq8XMHxc3ufnkwk99+BkENhsGuxhGfc4NuzWlHnqxq+ddawhtBvN+4GNwTWCCjURhHibEFTLHB4vZoiblC65rt0KaID7toIqxxKcCPwlBmY6xtXKI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.24; Mon, 13 Jul
 2020 15:00:33 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 15:00:32 +0000
Subject: RE: [PATCH v2 2/3] hw/i386: Build apic_id from CpuInstanceProperties
To: Igor Mammedov <imammedo@redhat.com>
References: <159362436285.36204.986406297373871949.stgit@naples-babu.amd.com>
 <159362466828.36204.14044362989991188460.stgit@naples-babu.amd.com>
 <20200713111527.23bf98a8@redhat.com>
From: Babu Moger <babu.moger@amd.com>
Message-ID: <13317f5e-7bd6-8e12-efba-c1d01b3ebc32@amd.com>
Date: Mon, 13 Jul 2020 10:00:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200713111527.23bf98a8@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0125.namprd07.prod.outlook.com
 (2603:10b6:3:13e::15) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by
 DM5PR07CA0125.namprd07.prod.outlook.com (2603:10b6:3:13e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Mon, 13 Jul 2020 15:00:31 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4f5eb613-728c-40d2-c4e2-08d8273d7d70
X-MS-TrafficTypeDiagnostic: SA0PR12MB4463:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4463DB490F6E56F1BA3AB44B95600@SA0PR12MB4463.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +zd9KmMzXKhG3c9R7RvN78yqtF4Bg09BZrJnHBxAkYOVl1LTOGM/m/rIWZn/DpMD9PE/3/gHHu3gp0fkSBH1umfeo7rv3C7c+Ji0ROcnli5yRJkkuXZgRAb0he+UtFC8fn9t5lXcW2iYetXPItYHIMCBb1cVV6nGO9s/QIxg/0wY9Pt7WsUIYZfcBNhJgBrE/wf7RZGbMFZZEkVREAHL5jMcb8zbe4Ao5JsU2H6DJlVykw9m33bN1+x4vYxwllHufHngHgU1k28N5XKeltdbGbhO4T1JazKMVDG/in6V7MG7A1suOiDp/1sQ4+yP7Qd6wu7B1BpKgpjjguGXYzdtY9vIQSkYvVcNNb6PuLm6k3boI21ow5bMM0qZtPtKhcqP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(478600001)(31686004)(5660300002)(316002)(54906003)(8676002)(16576012)(6486002)(53546011)(4326008)(26005)(6916009)(8936002)(36756003)(186003)(30864003)(44832011)(16526019)(956004)(2616005)(2906002)(52116002)(66946007)(66556008)(66476007)(83380400001)(31696002)(86362001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /G3+D2mK+u3eex7mTNhAqTImicVGSyfJe0wRTPjxqcfRrKIbsblUo5QSrK8gcuBGLqBr682bR4v1JXSsleH39Kmg3gpw5TE9Rqg+rCH5WQTMl+IJFyBXhA9nHXa1rl9Ant+LhX8bjNc2ZdSOpyWvt+7gRaPmuBnipwZ61h0xsPr+Alg99TDCJ37f/YIFYpi5/PDslSVfXFbvBD4N0ngpkyOxozGkGB1ErI4OES4ueK3ymTODYO6Ip77HEVGJ9tlhvmrj60LdjeMDLok7ZnTJnggfyzcYqOrPZtoqbcCfS4HXIPcAgjaOZ6ADp9GkcU4rxkmHBmAIcrKNpeS1+6MooEMh3fDaCfRPumgI6w1CHqbczJpn75K9NIPfH7XPyaZZai8/O/CkS3NMBqwPIIF3dqQzmdAwXIZV4C49mkif+NvW5UInIb22/GRzFP3dHcSqur4VS5b01sgRZntsKza/DXRt7Y4A3eAQ9NKSP49A7ss=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5eb613-728c-40d2-c4e2-08d8273d7d70
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 15:00:32.5954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swkbVTCxJLTjowMlZY9RRKaT1IHAIKOvP7ovnZL088P/ZWwev8daTT4romnVEtAH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463
Received-SPF: none client-ip=40.107.70.75; envelope-from=Babu.Moger@amd.com;
 helo=NAM04-SN1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 11:15:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FORGED_SPF_HELO=1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
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
> Sent: Monday, July 13, 2020 4:15 AM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com; qemu-
> devel@nongnu.org
> Subject: Re: [PATCH v2 2/3] hw/i386: Build apic_id from CpuInstanceProperties
> 
> On Wed, 01 Jul 2020 12:31:08 -0500
> Babu Moger <babu.moger@amd.com> wrote:
> 
> > Build apic_id from CpuInstanceProperties if numa configured.
> > Use the node_id from user provided numa information. This will avoid
> > conflicts between numa information and apic_id generated.
> >
> > Re-arranged the code little bit to make sure CpuInstanceProperties is
> > initialized before calling.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  hw/i386/pc.c               |    6 +++++-
> >  hw/i386/x86.c              |   19 +++++++++++++------
> >  include/hw/i386/topology.h |   14 +++++++++++---
> >  include/hw/i386/x86.h      |    6 ++++--
> >  tests/test-x86-cpuid.c     |   39 ++++++++++++++++++++-------------------
> >  5 files changed, 53 insertions(+), 31 deletions(-)
> >
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c index d103b8c0ab..e613b2299f
> > 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -800,13 +800,17 @@ void pc_smp_parse(MachineState *ms, QemuOpts
> > *opts)  void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error
> > **errp)  {
> >      X86MachineState *x86ms = X86_MACHINE(ms);
> > -    int64_t apic_id = x86_cpu_apic_id_from_index(x86ms, id);
> > +    CpuInstanceProperties props;
> > +    int64_t apic_id;
> >      Error *local_err = NULL;
> >
> >      if (id < 0) {
> >          error_setg(errp, "Invalid CPU id: %" PRIi64, id);
> >          return;
> >      }
> > +    props = ms->possible_cpus->cpus[id].props;
> > +
> > +    apic_id = x86_cpu_apic_id_from_index(x86ms, id, props);
> >
> >      if (apic_id >= ACPI_CPU_HOTPLUG_ID_LIMIT) {
> >          error_setg(errp, "Unable to add CPU: %" PRIi64 diff --git
> > a/hw/i386/x86.c b/hw/i386/x86.c index 34229b45c7..7554416ae0 100644
> > --- a/hw/i386/x86.c
> > +++ b/hw/i386/x86.c
> > @@ -93,7 +93,8 @@ static void x86_set_epyc_topo_handlers(MachineState
> *machine)
> >   * all CPUs up to max_cpus.
> >   */
> >  uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
> > -                                    unsigned int cpu_index)
> > +                                    unsigned int cpu_index,
> > +                                    CpuInstanceProperties props)
> >  {
> >      X86MachineClass *x86mc = X86_MACHINE_GET_CLASS(x86ms);
> >      X86CPUTopoInfo topo_info;
> > @@ -102,7 +103,7 @@ uint32_t
> > x86_cpu_apic_id_from_index(X86MachineState *x86ms,
> >
> >      init_topo_info(&topo_info, x86ms);
> >
> > -    correct_id = x86ms->apicid_from_cpu_idx(&topo_info, cpu_index);
> > +    correct_id = x86ms->apicid_from_cpu_idx(&topo_info, cpu_index,
> > + props);
> >      if (x86mc->compat_apic_id_mode) {
> >          if (cpu_index != correct_id && !warned && !qtest_enabled()) {
> >              error_report("APIC IDs set in compatibility mode, "
> > @@ -136,6 +137,8 @@ void x86_cpus_init(X86MachineState *x86ms, int
> default_cpu_version)
> >      const CPUArchIdList *possible_cpus;
> >      MachineState *ms = MACHINE(x86ms);
> >      MachineClass *mc = MACHINE_GET_CLASS(x86ms);
> > +    CpuInstanceProperties props;
> > +
> >
> >      /* Check for apicid encoding */
> >      if (cpu_x86_use_epyc_apic_id_encoding(ms->cpu_type)) { @@ -144,6
> > +147,8 @@ void x86_cpus_init(X86MachineState *x86ms, int
> > default_cpu_version)
> >
> >      x86_cpu_set_default_version(default_cpu_version);
> >
> > +    possible_cpus = mc->possible_cpu_arch_ids(ms);
> > +
> >      /*
> >       * Calculates the limit to CPU APIC ID values
> >       *
> > @@ -152,13 +157,15 @@ void x86_cpus_init(X86MachineState *x86ms, int
> default_cpu_version)
> >       *
> >       * This is used for FW_CFG_MAX_CPUS. See comments on
> fw_cfg_arch_create().
> >       */
> > -    x86ms->apic_id_limit = x86_cpu_apic_id_from_index(x86ms,
> > -                                                      ms->smp.max_cpus - 1) + 1;
> > -    possible_cpus = mc->possible_cpu_arch_ids(ms);
> > +    props = ms->possible_cpus->cpus[ms->smp.max_cpus - 1].props;
> >
> > +    x86ms->apic_id_limit = x86_cpu_apic_id_from_index(x86ms,
> > +                                                      ms->smp.max_cpus - 1,
> > +                                                      props) + 1;
> >      for (i = 0; i < ms->possible_cpus->len; i++) {
> > +        props = ms->possible_cpus->cpus[i].props;
> >          ms->possible_cpus->cpus[i].arch_id =
> > -            x86_cpu_apic_id_from_index(x86ms, i);
> > +            x86_cpu_apic_id_from_index(x86ms, i, props);
> >      }
> >
> >      for (i = 0; i < ms->smp.cpus; i++) { diff --git
> > a/include/hw/i386/topology.h b/include/hw/i386/topology.h index
> > 7cb21e9c82..a800fc905f 100644
> > --- a/include/hw/i386/topology.h
> > +++ b/include/hw/i386/topology.h
> > @@ -221,10 +221,17 @@ static inline void
> x86_init_topo_ids(X86CPUTopoInfo *topo_info,
> >   * 'cpu_index' is a sequential, contiguous ID for the CPU.
> >   */
> >  static inline apic_id_t x86_apicid_from_cpu_idx_epyc(X86CPUTopoInfo
> *topo_info,
> > -                                                     unsigned cpu_index)
> > +                                                     unsigned cpu_index,
> > +
> > + CpuInstanceProperties props)
> >  {
> >      X86CPUTopoIDs topo_ids;
> > -    x86_topo_ids_from_idx_epyc(topo_info, cpu_index, &topo_ids);
> > +
> > +    if (props.has_node_id) {
> > +        x86_init_topo_ids(topo_info, props, &topo_ids);
> > +    } else {
> > +        x86_topo_ids_from_idx_epyc(topo_info, cpu_index, &topo_ids);
> why this branch is needed?

I have added it to make sure to handle the case if this function is called
without initializing the props. I have to check if that case can happen.

> 
> > +    }
> > +
> >      return x86_apicid_from_topo_ids_epyc(topo_info, &topo_ids);  }
> >  /* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID @@
> > -280,7 +287,8 @@ static inline void x86_topo_ids_from_apicid(apic_id_t
> apicid,
> >   * 'cpu_index' is a sequential, contiguous ID for the CPU.
> >   */
> >  static inline apic_id_t x86_apicid_from_cpu_idx(X86CPUTopoInfo *topo_info,
> > -                                                unsigned cpu_index)
> > +                                                unsigned cpu_index,
> > +                                                CpuInstanceProperties
> > + props)
> >  {
> >      X86CPUTopoIDs topo_ids;
> >      x86_topo_ids_from_idx(topo_info, cpu_index, &topo_ids); diff
> > --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h index
> > b79f24e285..3109f39554 100644
> > --- a/include/hw/i386/x86.h
> > +++ b/include/hw/i386/x86.h
> > @@ -65,7 +65,8 @@ typedef struct {
> >
> >      /* Apic id specific handlers */
> >      uint32_t (*apicid_from_cpu_idx)(X86CPUTopoInfo *topo_info,
> > -                                    unsigned cpu_index);
> > +                                    unsigned cpu_index,
> > +                                    CpuInstanceProperties props);
> >      void (*topo_ids_from_apicid)(apic_id_t apicid, X86CPUTopoInfo
> *topo_info,
> >                                   X86CPUTopoIDs *topo_ids);
> >      apic_id_t (*apicid_from_topo_ids)(X86CPUTopoInfo *topo_info, @@
> > -93,7 +94,8 @@ typedef struct {  void init_topo_info(X86CPUTopoInfo
> > *topo_info, const X86MachineState *x86ms);
> >
> >  uint32_t x86_cpu_apic_id_from_index(X86MachineState *pcms,
> > -                                    unsigned int cpu_index);
> > +                                    unsigned int cpu_index,
> > +                                    CpuInstanceProperties props);
> >
> >  void x86_cpu_new(X86MachineState *pcms, int64_t apic_id, Error
> > **errp);  void x86_cpus_init(X86MachineState *pcms, int
> > default_cpu_version); diff --git a/tests/test-x86-cpuid.c
> > b/tests/test-x86-cpuid.c index 049030a50e..a1308e214b 100644
> > --- a/tests/test-x86-cpuid.c
> > +++ b/tests/test-x86-cpuid.c
> > @@ -29,6 +29,7 @@
> >  static void test_topo_bits(void)
> >  {
> >      X86CPUTopoInfo topo_info = {0};
> > +    CpuInstanceProperties props = {0};
> >
> >      /* simple tests for 1 thread per core, 1 core per die, 1 die per package */
> >      topo_info = (X86CPUTopoInfo) {0, 1, 1, 1}; @@ -37,10 +38,10 @@
> > static void test_topo_bits(void)
> >      g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
> >
> >      topo_info = (X86CPUTopoInfo) {0, 1, 1, 1};
> > -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
> > -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
> > -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
> > -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 3), ==, 3);
> > +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0, props), ==, 0);
> > +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1, props), ==, 1);
> > +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2, props), ==, 2);
> > +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 3, props),
> > + ==, 3);
> >
> >
> >      /* Test field width calculation for multiple values @@ -92,38
> > +93,38 @@ static void test_topo_bits(void)
> >      g_assert_cmpuint(apicid_pkg_offset(&topo_info), ==, 5);
> >
> >      topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
> > -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
> > -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
> > -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
> > +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0, props), ==, 0);
> > +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1, props), ==, 1);
> > +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2, props),
> > + ==, 2);
> >
> >      topo_info = (X86CPUTopoInfo) {0, 1, 6, 3};
> > -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 0), ==,
> > +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 0,
> > + props), ==,
> >                       (1 << 2) | 0);
> > -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 1), ==,
> > +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 1,
> > + props), ==,
> >                       (1 << 2) | 1);
> > -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 2), ==,
> > +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 2,
> > + props), ==,
> >                       (1 << 2) | 2);
> >
> > -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 0), ==,
> > +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 0,
> > + props), ==,
> >                       (2 << 2) | 0);
> > -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 1), ==,
> > +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 1,
> > + props), ==,
> >                       (2 << 2) | 1);
> > -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 2), ==,
> > +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2 * 3 + 2,
> > + props), ==,
> >                       (2 << 2) | 2);
> >
> > -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 0), ==,
> > +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 0,
> > + props), ==,
> >                       (5 << 2) | 0);
> > -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 1), ==,
> > +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 1,
> > + props), ==,
> >                       (5 << 2) | 1);
> > -    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 2), ==,
> > +    g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 5 * 3 + 2,
> > + props), ==,
> >                       (5 << 2) | 2);
> >
> >      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info,
> > -                     1 * 6 * 3 + 0 * 3 + 0), ==, (1 << 5));
> > +                     1 * 6 * 3 + 0 * 3 + 0, props), ==, (1 << 5));
> >      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info,
> > -                     1 * 6 * 3 + 1 * 3 + 1), ==, (1 << 5) | (1 << 2) | 1);
> > +                     1 * 6 * 3 + 1 * 3 + 1, props), ==, (1 << 5) | (1
> > + << 2) | 1);
> >      g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info,
> > -                     3 * 6 * 3 + 5 * 3 + 2), ==, (3 << 5) | (5 << 2) | 2);
> > +                     3 * 6 * 3 + 5 * 3 + 2, props), ==, (3 << 5) | (5
> > + << 2) | 2);
> >  }
> >
> >  int main(int argc, char **argv)
> >



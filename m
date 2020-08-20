Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40F3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C482076E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agJn5hYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C482076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8lb1-0008Py-IZ
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 10:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k8lZr-0007TJ-IL
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 10:30:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k8lZp-0001Cd-8F
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 10:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597933799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9bKFcEEcBwp3RDoUr/uH7nknw2u181Ar41jp3mh+GHg=;
 b=agJn5hYONmrOQNCwhi2pq0pjHeG92N2ZRkgCLFsCfi6pqzJDvsCGX9H7QTDYyaBLnLhSix
 5fm1177t8legVxOYaRfYRrN36Oz1oZ9R53+9cCDkN8G1MbaZhnD91d0siJrk97f5umegUc
 d++ZwSSJyluGMZE5IyYkvEGco4MjD0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-3U3U6KclN4mqWFubVS1mUw-1; Thu, 20 Aug 2020 10:29:58 -0400
X-MC-Unique: 3U3U6KclN4mqWFubVS1mUw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5EFF1885D8A;
 Thu, 20 Aug 2020 14:29:56 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 166785DA78;
 Thu, 20 Aug 2020 14:29:54 +0000 (UTC)
Date: Thu, 20 Aug 2020 16:29:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 02/10] numa: introduce
 MachineClass::forbid_asymmetrical_numa
Message-ID: <20200820162953.3201c6ee@redhat.com>
In-Reply-To: <6086c921-9eb5-5bc6-7af3-b914f13f1f2f@gmail.com>
References: <20200814205424.543857-1-danielhb413@gmail.com>
 <20200814205424.543857-3-danielhb413@gmail.com>
 <20200820011726.GF271315@yekko.fritz.box>
 <20200820021128.GC642093@habkost.net>
 <20200820041504.GN271315@yekko.fritz.box>
 <6086c921-9eb5-5bc6-7af3-b914f13f1f2f@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 09:00:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Aug 2020 07:33:00 -0300
Daniel Henrique Barboza <danielhb413@gmail.com> wrote:

> On 8/20/20 1:15 AM, David Gibson wrote:
> > On Wed, Aug 19, 2020 at 10:11:28PM -0400, Eduardo Habkost wrote:  
> >> On Thu, Aug 20, 2020 at 11:17:26AM +1000, David Gibson wrote:  
> >>> On Fri, Aug 14, 2020 at 05:54:16PM -0300, Daniel Henrique Barboza wrote:  
> >>>> The pSeries machine does not support asymmetrical NUMA
> >>>> configurations.  
> >>>
> >>> This seems a bit oddly specific to have as a global machine class
> >>> property.
> >>>
> >>> Would it make more sense for machines with specific NUMA constraints
> >>> to just verify those during their initialization?  
> >>
> >> This would be much simpler.  However, I like the idea of
> >> representing machine-specific configuration validation rules as
> >> data that can eventually be exported to management software.  
> > 
> > Ah, ok, so basically the usual tradeoff between flexibility and
> > advertisability.  
> 
> 
> 
> To provide context, what I did here was inspired by this commit:
> 
> commit 0533ef5f2089f4f12a0ec5c8035e5e15ba0b5556
> Author: Tao Xu <tao3.xu@intel.com>
> Date:   Thu Sep 5 16:32:38 2019 +0800
> 
>      numa: Introduce MachineClass::auto_enable_numa for implicit NUMA node
> 
> 
> In this commit, exclusive NUMA code from spapr.c was taken and put it
> into numa.c, with a flag being set in spapr machine_init.

We have too many auto_enable_numa*, we probably should merge them into
just one auto_enable_numa if it's possible.

> 
> Thanks,
> 
> 
> DHB
> 
> 
> > 
> > So, in that case, I guess the question is whether we envisage "no
> > assymmetry" as a constraint common enough that it's worth creating an
> > advertisable rule or not.  If we only ever have one user, then we
> > haven't really done any better than hard coding the constraint in the
> > manageent software.
> > 
> > Of course to complicate matters, in the longer term we're looking at
> > removing that constraint from pseries - but doing so will be dependent
> > on the guest kernel understanding a new format for the NUMA
> > information in the device tree.  So qemu alone won't have enough
> > information to tell if such a configuration is possible or not.

If it's guest limitiation, then it doesn't sound like QEMU material to me.
It would be more appropriate to validate at mgmt level which knows what
guest is being used.

> >   
> >> (CCing John Snow, who had spent some time thinking about
> >> configuration validation recently.)
> >>
> >>  
> >>>>
> >>>> CC: Eduardo Habkost <ehabkost@redhat.com>
> >>>> CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> >>>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> >>>> ---
> >>>>   hw/core/numa.c      | 7 +++++++
> >>>>   hw/ppc/spapr.c      | 1 +
> >>>>   include/hw/boards.h | 1 +
> >>>>   3 files changed, 9 insertions(+)
> >>>>
> >>>> diff --git a/hw/core/numa.c b/hw/core/numa.c
> >>>> index d1a94a14f8..1e81233c1d 100644
> >>>> --- a/hw/core/numa.c
> >>>> +++ b/hw/core/numa.c
> >>>> @@ -547,6 +547,7 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
> >>>>    */
> >>>>   static void validate_numa_distance(MachineState *ms)
> >>>>   {
> >>>> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> >>>>       int src, dst;
> >>>>       bool is_asymmetrical = false;
> >>>>       int nb_numa_nodes = ms->numa_state->num_nodes;
> >>>> @@ -575,6 +576,12 @@ static void validate_numa_distance(MachineState *ms)
> >>>>       }
> >>>>   
> >>>>       if (is_asymmetrical) {
> >>>> +        if (mc->forbid_asymmetrical_numa) {
> >>>> +            error_report("This machine type does not support "
> >>>> +                         "asymmetrical numa distances.");
> >>>> +            exit(EXIT_FAILURE);
> >>>> +        }
> >>>> +
> >>>>           for (src = 0; src < nb_numa_nodes; src++) {
> >>>>               for (dst = 0; dst < nb_numa_nodes; dst++) {
> >>>>                   if (src != dst && numa_info[src].distance[dst] == 0) {
> >>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>>> index dd2fa4826b..3b16edaf4c 100644
> >>>> --- a/hw/ppc/spapr.c
> >>>> +++ b/hw/ppc/spapr.c
> >>>> @@ -4512,6 +4512,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
> >>>>        */
> >>>>       mc->numa_mem_align_shift = 28;
> >>>>       mc->auto_enable_numa = true;
> >>>> +    mc->forbid_asymmetrical_numa = true;
> >>>>   
> >>>>       smc->default_caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
> >>>>       smc->default_caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_ON;
> >>>> diff --git a/include/hw/boards.h b/include/hw/boards.h
> >>>> index bc5b82ad20..dc6cdd1c53 100644
> >>>> --- a/include/hw/boards.h
> >>>> +++ b/include/hw/boards.h
> >>>> @@ -215,6 +215,7 @@ struct MachineClass {
> >>>>       bool nvdimm_supported;
> >>>>       bool numa_mem_supported;
> >>>>       bool auto_enable_numa;
> >>>> +    bool forbid_asymmetrical_numa;
> >>>>       const char *default_ram_id;
> >>>>   
> >>>>       HotplugHandler *(*get_hotplug_handler)(MachineState *machine,  
> >>>  
> >>
> >>
> >>  
> >   
> 



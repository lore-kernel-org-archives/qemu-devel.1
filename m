Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69695C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 14:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F15AC2086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 14:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15AC2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hydgh-00005N-SO
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 10:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1hydg6-000873-3Z
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 10:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hydg4-0001qN-Op
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 10:58:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47712)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hydg4-0001pf-Hd
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 10:58:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7DF7BC04FFE0;
 Fri, 16 Aug 2019 14:58:03 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BAD117AB4;
 Fri, 16 Aug 2019 14:58:00 +0000 (UTC)
Date: Fri, 16 Aug 2019 16:57:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Message-ID: <20190816165758.47042712@redhat.com>
In-Reply-To: <CAPcyv4h-WmFPSsPMfPz5AALm=MyxGzyU5Ju0iSKsxORVh1wV7Q@mail.gmail.com>
References: <20190809065731.9097-1-tao3.xu@intel.com>
 <20190809065731.9097-6-tao3.xu@intel.com>
 <20190813170027.0617b129@redhat.com>
 <CAPcyv4j=wBtBcscJBtrMNDDz=d6+HYYDF=4QLU69d0EPMkTTqg@mail.gmail.com>
 <a73f7c81-0363-c10f-8ae1-9344abc55449@intel.com>
 <CAPcyv4jCuy6zvM8NcacXhvpUBUyp_BYMcEtBuA_ck3AhkyGNsQ@mail.gmail.com>
 <789df028-9dd9-884a-2493-aecc9a646e63@intel.com>
 <CAPcyv4h-WmFPSsPMfPz5AALm=MyxGzyU5Ju0iSKsxORVh1wV7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 16 Aug 2019 14:58:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v9 05/11] numa: Extend CLI to provide
 initiator information for numa nodes
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, Tao Xu <tao3.xu@intel.com>, "Du,
 Fan" <fan.du@intel.com>, Qemu Developers <qemu-devel@nongnu.org>,
 "daniel@linux.ibm.com" <daniel@linux.ibm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 14 Aug 2019 19:31:27 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Wed, Aug 14, 2019 at 6:57 PM Tao Xu <tao3.xu@intel.com> wrote:
> >
> > On 8/15/2019 5:29 AM, Dan Williams wrote:  
> > > On Tue, Aug 13, 2019 at 10:14 PM Tao Xu <tao3.xu@intel.com> wrote:  
> > >>
> > >> On 8/14/2019 10:39 AM, Dan Williams wrote:  
> > >>> On Tue, Aug 13, 2019 at 8:00 AM Igor Mammedov <imammedo@redhat.com> wrote:  
> > >>>>
> > >>>> On Fri,  9 Aug 2019 14:57:25 +0800
> > >>>> Tao <tao3.xu@intel.com> wrote:
> > >>>>  
> > >>>>> From: Tao Xu <tao3.xu@intel.com>
> > >>>>>  
> > [...]  
> > >>>>> +    for (i = 0; i < machine->numa_state->num_nodes; i++) {
> > >>>>> +        if (numa_info[i].initiator_valid &&
> > >>>>> +            !numa_info[numa_info[i].initiator].has_cpu) {  
> > >>>>                             ^^^^^^^^^^^^^^^^^^^^^^ possible out of bounds read, see bellow
> > >>>>  
> > >>>>> +            error_report("The initiator-id %"PRIu16 " of NUMA node %d"
> > >>>>> +                         " does not exist.", numa_info[i].initiator, i);
> > >>>>> +            error_printf("\n");
> > >>>>> +
> > >>>>> +            exit(1);
> > >>>>> +        }  
> > >>>> it takes care only about nodes that have cpus or memory-only ones that have
> > >>>> initiator explicitly provided on CLI. And leaves possibility to have
> > >>>> memory-only nodes without initiator mixed with nodes that have initiator.
> > >>>> Is it valid to have mixed configuration?
> > >>>> Should we forbid it?  
> > >>>
> > >>> The spec talks about the "Proximity Domain for the Attached Initiator"
> > >>> field only being valid if the memory controller for the memory can be
> > >>> identified by an initiator id in the SRAT. So I expect the only way to
> > >>> define a memory proximity domain without this local initiator is to
> > >>> allow specifying a node-id that does not have an entry in the SRAT.
> > >>>  
> > >> Hi Dan,
> > >>
> > >> So there may be a situation for the Attached Initiator field is not
> > >> valid? If true, I would allow user to input Initiator invalid.  
> > >
> > > Yes it's something the OS needs to consider because the platform may
> > > not be able to meet the constraint that a single initiator is
> > > associated with the memory controller for a given memory target. In
> > > retrospect it would have been nice if the spec reserved 0xffffffff for
> > > this purpose, but it seems "not in SRAT" is the only way to identify
> > > memory that is not attached to any single initiator.
> > >  
> > But As far as I konw, QEMU can't emulate a NUMA node "not in SRAT". I am
> > wondering if it is effective only set Initiator invalid?  
> 
> You don't need to emulate a NUMA node not in SRAT. Just put a number
> in this HMAT entry larger than the largest proximity domain number
> found in the SRAT.
> >  
> 

So behavior is really not defined in the spec
(well I wasn't able to convince myself that above behavior is in the spec).

In this case I'd go with a strict check for now not allowing invalid initiator
(we can easily relax check and allow it point to nonsense later but no other way around)


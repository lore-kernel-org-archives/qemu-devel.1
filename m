Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56983C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:09:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F9320679
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F9320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvbT-0003cv-0N
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 10:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iIvPb-00061m-Hb
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iIvPZ-0007tX-Tu
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:56:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20672)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iIvPZ-0007sf-L1
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:56:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 078A710CC205;
 Fri, 11 Oct 2019 13:56:51 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77D0D60C18;
 Fri, 11 Oct 2019 13:56:49 +0000 (UTC)
Date: Fri, 11 Oct 2019 15:56:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v12 06/11] numa: Extend CLI to provide memory latency
 and bandwidth information
Message-ID: <20191011155647.5b3fdf27@redhat.com>
In-Reply-To: <5bfe9d25-89a1-90a6-75fb-a6aecf4844c0@intel.com>
References: <20190920074349.2616-1-tao3.xu@intel.com>
 <20190920074349.2616-7-tao3.xu@intel.com>
 <20191002171619.04a11347@redhat.com>
 <5bfe9d25-89a1-90a6-75fb-a6aecf4844c0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Fri, 11 Oct 2019 13:56:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, "Williams, Dan
 J" <dan.j.williams@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 9 Oct 2019 14:39:46 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> On 10/2/2019 11:16 PM, Igor Mammedov wrote:
> > On Fri, 20 Sep 2019 15:43:44 +0800
> > Tao Xu <tao3.xu@intel.com> wrote:
> >   
> [...]
> >> +struct HMAT_LB_Info {
> >> +    /* Indicates it's memory or the specified level memory side cache. */
> >> +    uint8_t     hierarchy;
> >> +
> >> +    /* Present the type of data, access/read/write latency or bandwidth. */
> >> +    uint8_t     data_type;
> >> +
> >> +    /* Array to store the latencies */  
> > specify units it's stored in
> >   
> >> +    uint64_t    *latency;
> >> +
> >> +    /* Array to store the bandwidthes */  
> > ditto
> >   
> >> +    uint64_t    *bandwidth;  
> > btw:
> > 
> > what was the reason for picking uint64_t for storing above values?
> > 
> > it seems in this patch you dumb down bandwidth to MB/s above but
> > store latency as is.  
> 
> Because I want to store the bandwidth or latency value (minimum unit) 
> that user input. In HMAT, the minimum unit of bandwidth is MB/s, but in 
> QAPI, the minimum unit of size is Byte. So I convert size into MB/s and 
> time unit is "ps", need not convert.
Just be consistent and store (user input) raw values for both fields
(i.e. B/s PS/s) and post-process them later to uint16_t.

> > and then in 9/11 build_hmat_lb you divide that on 'base' units,
> > where are guaranties that value stored here will fit into 2 bytes
> > used in HMAT to store it in the table?
> >   
> For HMAT spec, for a matrix of bandwidth or latency, there is only one 
> base (in order to save ACPI tables space). We need to extract base for a 
> matrix, but user input bandwidth or latency line by line. So after all 
> data input, we can extract the base (as in 9/11).
> 
> There is another benefit. If user input different but similar units, 
> such as "10ns" and "100ps", we can also store them. Only If user input 
> big gap units, such as "1ps" and "1000ms". we can't store them and raise 
> error.
No disagreement here,

but I suggest to move verification and base calculation from 09/11
into a separate patch (right after this one) and doing it at
numa_complete_configuration() time.
To store calculated base you can add a common_base field to
sub-table structure (HMAT_LB_Info) and use it when building ACPI
table without extra calculations.

> > if this structure should store values in terms on HMAT table it should
> > probably use uint16_t and check that user provided value won't overflow
> > at the time of CLI parsing.
> >   
> 



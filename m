Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65119C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9226B207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9226B207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bwidawsk.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXREU-0006id-IE
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 11:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben@bwidawsk.net>) id 1kXR9t-0003QI-4G
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:45:13 -0400
Received: from zangief.bwidawsk.net ([107.170.211.233]:47104
 helo=mail.bwidawsk.net)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben@bwidawsk.net>) id 1kXR9r-0003vM-Hq
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:45:12 -0400
Received: by mail.bwidawsk.net (Postfix, from userid 5001)
 id 35F5F123937; Tue, 27 Oct 2020 08:45:09 -0700 (PDT)
Received: from mail.bwidawsk.net (c-73-37-61-164.hsd1.or.comcast.net
 [73.37.61.164])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (Client did not present a certificate)
 by mail.bwidawsk.net (Postfix) with ESMTPSA id B32B6123936;
 Tue, 27 Oct 2020 08:45:06 -0700 (PDT)
Date: Tue, 27 Oct 2020 08:45:05 -0700
From: Ben Widawsky <ben@bwidawsk.net>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 2/2] acpi/crs: Support ranges > 32b for hosts
Message-ID: <20201027154505.346awd3dicockef7@mail.bwidawsk.net>
References: <20201026193924.985014-1-ben.widawsky@intel.com>
 <20201026193924.985014-2-ben.widawsky@intel.com>
 <20201027153612.35e9faac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027153612.35e9faac@redhat.com>
Received-SPF: none client-ip=107.170.211.233; envelope-from=ben@bwidawsk.net;
 helo=mail.bwidawsk.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 11:45:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, KHOP_HELO_FCRDNS=0.4,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, mst@redhat.com, jusual@redhat.com,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20-10-27 15:36:12, Igor Mammedov wrote:
> On Mon, 26 Oct 2020 12:39:24 -0700
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > According to PCIe spec 5.0 Type 1 header space Base Address Registers
> > are defined by 7.5.1.2.1 Base Address Registers (same as Type 0). The
> > _CRS region should allow for the same range (up to 64b). Prior to this
> > change, any host bridge utilizing more than 32b for the BAR would have
> > the address truncated and likely lead to conflicts when the operating
> > systems reads the _CRS object.
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> 
> Looks good to me, so
> 
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
> 
> CCing,
> Michael to have a send pair of eyes on it 
> 
> but I wonder how/why ivshm (which might have quite large BAR) works.

I think this will only hit things that subclass TYPE_PCI_HOST_BRIDGE. AFAICT,
ivshm is a regular TYPE_PCI_DEVICE. Is there a _CRS created for ivshm?

> 
> PS:
> please use git's --cover-letter option to create multi-patch series,
> in the future

Will do. I wasn't sure what the cutoff was, but the wiki is pretty clear that
"multiple" is the cutoff and it's important to CI.
> 
> > 
> > ---
> > I don't think this effects any code currently in QEMU. You'd need to
> > have a host bridge which has a BAR, and that BAR wants to be > 32b. I've
> > hit this because I have a modified PXB device that does advertise a 64b
> > BAR. Also, you'd need a platform that cares about ACPI, which, many do
> > not.
> > ---
> >  hw/i386/acpi-build.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index df13abecf4..75604bdc74 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -789,8 +789,14 @@ static Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set)
> >                  crs_range_insert(temp_range_set.io_ranges,
> >                                   range_base, range_limit);
> >              } else { /* "memory" */
> > -                crs_range_insert(temp_range_set.mem_ranges,
> > -                                 range_base, range_limit);
> > +                uint64_t length = range_limit - range_base + 1;
> > +                if (range_limit <= UINT32_MAX && length <= UINT32_MAX) {
> > +                    crs_range_insert(temp_range_set.mem_ranges, range_base,
> > +                                     range_limit);
> > +                } else {
> > +                    crs_range_insert(temp_range_set.mem_64bit_ranges,
> > +                                     range_base, range_limit);
> > +                }
> >              }
> >          }
> >  
> 
> 


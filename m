Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407B4C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13874206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13874206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs15X-0002ua-A8
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 04:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47407)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hs13h-0001Y5-Ip
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hs13g-0001Kc-Kp
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:31:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50814)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hs13g-0001K5-Eq
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:31:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8AB1B30C34D6;
 Mon, 29 Jul 2019 08:31:03 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7ED5E60872;
 Mon, 29 Jul 2019 08:30:58 +0000 (UTC)
Date: Mon, 29 Jul 2019 10:30:56 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190729103056.42f423ff@redhat.com>
In-Reply-To: <690fd825-3553-6dee-5ff4-2ad7652afe46@redhat.com>
References: <20190728131304.1282-1-richardw.yang@linux.intel.com>
 <20190728131304.1282-4-richardw.yang@linux.intel.com>
 <690fd825-3553-6dee-5ff4-2ad7652afe46@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 29 Jul 2019 08:31:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] memory-device: break the loop if tmp
 exceed the hinted range
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
Cc: mst@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jul 2019 09:49:37 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 28.07.19 15:13, Wei Yang wrote:
> > The memory-device list built by memory_device_build_list is ordered by
> > its address, this means if the tmp range exceed the hinted range, all
> > the following range will not overlap with it.
> > 
> > Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> > ---
> >  hw/mem/memory-device.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> > index 413b514586..aea47ab3e8 100644
> > --- a/hw/mem/memory-device.c
> > +++ b/hw/mem/memory-device.c
> > @@ -180,7 +180,7 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
> >                  range_make_empty(&new);
> >                  break;
> >              }
> > -        } else if (!hint) {
> > +        } else if (!hint || range_lob(&tmp) > range_upb(&new)) {
> >              break;
> >          }
> >      }
> >   
> 
> Lower bound is inclusive, upper bound is exclusive. Shouldn't this be
> 
> range_lob(&tmp) >= range_upb(&new)
> 
> Also, I wonder if patch #2 is now really needed?
Indeed, it looks like 3/3 will break early in both hinted and
non-hinted cases so 2/3 looks not necessary (in case 2/3 is dropped
this commit message needs to be amended). 



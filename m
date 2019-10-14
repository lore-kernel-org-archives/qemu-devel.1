Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16207C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9732133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9732133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK1w7-0006zP-T3
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 11:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iK1v3-0005o5-Vr
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iK1v2-0008Ol-1z
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:05:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23991)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iK1v1-0008NQ-SR
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:05:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 86D2018C8929;
 Mon, 14 Oct 2019 15:05:54 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21E8A5C231;
 Mon, 14 Oct 2019 15:05:48 +0000 (UTC)
Date: Mon, 14 Oct 2019 12:05:47 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] refine memory_device_get_free_addr
Message-ID: <20191014150547.GR4084@habkost.net>
References: <20190730003740.20694-1-richardw.yang@linux.intel.com>
 <20190913234746.jb5a5vlwl6cebudz@master>
 <20190914154026-mutt-send-email-mst@kernel.org>
 <20191012090209.GA6047@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191012090209.GA6047@richard>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Mon, 14 Oct 2019 15:05:54 +0000 (UTC)
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
Cc: imammedo@redhat.com, Wei Yang <richard.weiyang@gmail.com>, david@redhat.com,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 12, 2019 at 05:02:09PM +0800, Wei Yang wrote:
> On Sat, Sep 14, 2019 at 03:40:41PM -0400, Michael S. Tsirkin wrote:
> >On Fri, Sep 13, 2019 at 11:47:46PM +0000, Wei Yang wrote:
> >> On Tue, Jul 30, 2019 at 08:37:38AM +0800, Wei Yang wrote:
> >> >When we iterate the memory-device list to get the available range, it is not
> >> >necessary to iterate the whole list.
> >> >
> >> >1) no more overlap for hinted range if tmp exceed it
> >> >
> >> >v2:
> >> >   * remove #2 as suggested by Igor and David
> >> >   * add some comment to inform address assignment stay the same as before
> >> >     this change 
> >> >
> >> >Wei Yang (2):
> >> >  memory-device: not necessary to use goto for the last check
> >> >  memory-device: break the loop if tmp exceed the hinted range
> >> >
> >> > hw/mem/memory-device.c | 3 ++-
> >> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >> >
> >> 
> >> Would someone take this patch set?
> >
> >yes looks good to me too.
> >Eduardo?
> >
> 
> Hmm... I don't see this any where. May I ask the status?

Sorry, I hadn't seen Michael's message.  Queued on machine-next.
Thanks!

-- 
Eduardo


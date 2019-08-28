Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AE5C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 18:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66EC420644
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 18:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EC420644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i32bK-0006b3-JO
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 14:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mtosatti@redhat.com>) id 1i32aR-0005td-Hl
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 14:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mtosatti@redhat.com>) id 1i32aP-0000fd-Di
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 14:22:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44726)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1i32aP-0000d3-8s
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 14:22:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5576F30821DF;
 Wed, 28 Aug 2019 18:22:23 +0000 (UTC)
Received: from amt.cnet (ovpn-112-8.gru2.redhat.com [10.97.112.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10A73100194E;
 Wed, 28 Aug 2019 18:22:23 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
 by amt.cnet (Postfix) with ESMTP id 46A86105140;
 Wed, 28 Aug 2019 15:22:08 -0300 (BRT)
Received: (from marcelo@localhost)
 by amt.cnet (8.14.7/8.14.7/Submit) id x7SIM3hP021933;
 Wed, 28 Aug 2019 15:22:03 -0300
Date: Wed, 28 Aug 2019 15:22:03 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Mark Kanda <mark.kanda@oracle.com>
Message-ID: <20190828182202.GA21924@amt.cnet>
References: <1563374298-17323-1-git-send-email-mark.kanda@oracle.com>
 <277b5916-4e46-1aef-6368-a414de4d2149@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <277b5916-4e46-1aef-6368-a414de4d2149@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 28 Aug 2019 18:22:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v2] Only enable the halt poll
 control MSR if it is supported by the host
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 28, 2019 at 12:22:59PM -0500, Mark Kanda wrote:
> Gentle ping - I would like to confirm this patch is acceptable.
> 
> Thanks/regards,
> -Mark

ACK

> 
> On 7/17/2019 9:38 AM, Mark Kanda wrote:
> >The halt poll control MSR should only be enabled on hosts which
> >support it.
> >
> >Fixes: ("kvm: i386: halt poll control MSR support")
> >
> >Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
> >
> >---
> >v2: Remove unnecessary hunks which break migration with older hosts (Paolo)
> >---
> >  target/i386/cpu.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> >diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >index a8bafdb8b9..543bc25f64 100644
> >--- a/target/i386/cpu.c
> >+++ b/target/i386/cpu.c
> >@@ -2838,7 +2838,6 @@ static PropValue kvm_default_props[] = {
> >      { "kvm-asyncpf", "on" },
> >      { "kvm-steal-time", "on" },
> >      { "kvm-pv-eoi", "on" },
> >-    { "kvm-poll-control", "on" },
> >      { "kvmclock-stable-bit", "on" },
> >      { "x2apic", "on" },
> >      { "acpi", "off" },
> >


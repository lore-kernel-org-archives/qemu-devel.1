Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF067C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 08:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C912339E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 08:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C912339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzzm9-0006wZ-R3
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 04:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <abologna@redhat.com>) id 1hzzlU-0006Ri-UD
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 04:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <abologna@redhat.com>) id 1hzzlT-0004X9-Tb
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 04:45:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36480)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <abologna@redhat.com>) id 1hzzlT-0004WX-No
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 04:45:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4914F51EE4;
 Tue, 20 Aug 2019 08:45:14 +0000 (UTC)
Received: from kinshicho (unknown [10.43.2.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B0D018B66;
 Tue, 20 Aug 2019 08:45:12 +0000 (UTC)
Message-ID: <31906efac93bec3cd5aceddcd79ff4e62bb64391.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
To: Andrew Jones <drjones@redhat.com>, "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Date: Tue, 20 Aug 2019 10:45:11 +0200
In-Reply-To: <20190820075328.ew6kfiozom2ptcjv@kamzik.brq.redhat.com>
References: <8898674D84E3B24BA3A2D289B872026A78C0BF32@G01JPEXMBKW03>
 <20190820075328.ew6kfiozom2ptcjv@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 20 Aug 2019 08:45:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 00/15] target/arm/kvm: enable SVE in
 guests
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
Cc: "Mizuma, Masayoshi" <masayoshi.mizuma@fujitsu.com>, "Okamoto,
 Takayuki" <tokamoto@jp.fujitsu.com>,
 "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-08-20 at 09:53 +0200, Andrew Jones wrote:
> On Tue, Aug 20, 2019 at 06:08:04AM +0000, Zhang, Lei wrote:
> > Hi Andrew,
> > 
> > I have tested your patch on kernel- 5.2.7 + QEMU (4.0.94 + patch).
> 
> Thanks for the testing! I guess it's time for me to get back to this
> series and spin a v4 (so we can test some more :-)
> 
> > This patch series works fine for my tests when use qemu-system-aarch64 directly.
> > But I can't startup kvm when I use virsh[1].
> > 
> > Command I executed.
> > # virsh start test1
> > 
> > The error message is [internal error: CPU features not supported by hypervisor for aarch64 architecture.]
> > Do you have any ideas for this error? 
> 
> I've CC'ed Andrea.

I've specifically patched out that check in my series... Are you
sure you're using the modified libvirt version, and that your guest
is configured to use the modified QEMU binary?

Anyway, once v4 has been posted I'll respin the libvirt series as
well, since in the meantime conflicts have popped up and it no longer
applies cleanly on top of master.

-- 
Andrea Bolognani / Red Hat / Virtualization



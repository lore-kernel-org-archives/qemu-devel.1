Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E120C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 18:28:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0999420815
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 18:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0999420815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52194 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRhao-0000x4-4a
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 14:28:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hRhYH-0006d9-Ni
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hRhOK-00082o-N7
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:15:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hRhOK-000823-Ho
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:15:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DF6330C0DCD;
	Fri, 17 May 2019 18:15:29 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 41B7260BE0;
	Fri, 17 May 2019 18:15:25 +0000 (UTC)
Date: Fri, 17 May 2019 15:15:23 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: whiteheadm@acm.org
Message-ID: <20190517181523.GL4189@habkost.net>
References: <CAP8WD_bf=0=tyCumcNpVLtneio+vbd4JuFMmtWqSwXWFC-7PMg@mail.gmail.com>
	<6da0c28c-ef4f-8199-1cee-bf1f08387ff1@redhat.com>
	<ea9cf5ec-f259-9a23-eae1-1b2250c367b0@redhat.com>
	<CAP8WD_ZUVZJKk-tEfG8+yd6t_U9+A3a4s5_ohjU5KLP0tY5YwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8WD_ZUVZJKk-tEfG8+yd6t_U9+A3a4s5_ohjU5KLP0tY5YwQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Fri, 17 May 2019 18:15:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Pentium Pro Feature Bugs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 16, 2019 at 08:30:27PM -0400, tedheadster wrote:
> Paolo,
>   I am running the kvm32 machine and I see a problem. Here is the
> output of /proc/cpuinfo :
> 
> flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca
> cmov constant_tsc
> 
> I see something rather important missing: cpuid.
> 
> A lot of stuff breaks without cpuid, and I am fairly sure that qemu is
> supposed to 'hard code' in support for it. It is present with both my
> i486 and i586 virtual machines.

Are you running the same kernel version on all VMs?
X86_FEATURE_CPUID was added in Linux v4.11.

-- 
Eduardo


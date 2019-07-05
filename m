Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED394C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 21:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CDF82063F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 21:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CDF82063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjW3p-0006sZ-Cb
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 17:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50137)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hjW0i-0006E7-9Z
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 17:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hjW0h-0004c5-91
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 17:44:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hjW0h-0004bj-3d
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 17:44:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 63E3B308FC4A;
 Fri,  5 Jul 2019 21:44:50 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE1E8226FC;
 Fri,  5 Jul 2019 21:44:47 +0000 (UTC)
Date: Fri, 5 Jul 2019 18:44:46 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190705214446.GI5198@habkost.net>
References: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
 <1562079681-19204-2-git-send-email-pbonzini@redhat.com>
 <20190705203728.GE5198@habkost.net>
 <0c1f3a3f-c59d-9866-7fc9-3d9c99af17e5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c1f3a3f-c59d-9866-7fc9-3d9c99af17e5@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 05 Jul 2019 21:44:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/7] target/i386: handle filtered_features
 in a new function mark_unavailable_features
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
Cc: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 05, 2019 at 11:32:07PM +0200, Paolo Bonzini wrote:
> On 05/07/19 22:37, Eduardo Habkost wrote:
> > Filtering and reporting is separate because
> > x86_cpu_filter_features() is also called from a QMP command
> > handler that is not supposed to generate any warnings on stderr
> > (query-cpu-model-expansion).
> 
> But that one should not set check_cpuid or enforce_cpuid, should it?

check_cpuid is set to true by default.

> 
> (I can still split the filtering and reporting if you prefer).

Maybe it will work if we just add a 'bool verbose' parameter to
x86_cpu_filter_features().

x86_cpu_realizefn() would call:
  x86_cpu_filter_features(cpu, cpu->check_cpuid);

x86_cpu_class_check_missing_features() would call:
  x86_cpu_filter_features(cpu, false);

-- 
Eduardo


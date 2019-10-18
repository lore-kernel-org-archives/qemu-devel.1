Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE91CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F3B221897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3B221897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLT8H-0007Cz-6E
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jdenemar@redhat.com>) id 1iLSpo-0002Q1-T1
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:02:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jdenemar@redhat.com>) id 1iLSpn-0002vf-Pj
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:02:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47878)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jdenemar@redhat.com>) id 1iLSpn-0002vQ-Jv
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:02:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D9C0969094;
 Fri, 18 Oct 2019 14:02:26 +0000 (UTC)
Received: from virval.usersys.redhat.com (unknown [10.43.2.188])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 365B5100EBD5;
 Fri, 18 Oct 2019 14:02:21 +0000 (UTC)
Received: by virval.usersys.redhat.com (Postfix, from userid 500)
 id E0202101CE9; Fri, 18 Oct 2019 16:02:19 +0200 (CEST)
Date: Fri, 18 Oct 2019 16:02:19 +0200
From: Jiri Denemark <jdenemar@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Default CPU models on s390x and ppc64
Message-ID: <20191018140219.GS4204@orkuz.int.mamuti.net>
References: <20191017151606.GA1880840@orkuz.int.mamuti.net>
 <82ea23ea-be23-c374-3f10-65d8f6e79432@redhat.com>
 <CAFEAcA-pkD_LCh++TWoO77=Bu9mYe7HOkaeyCXjLopAmqhpi-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-pkD_LCh++TWoO77=Bu9mYe7HOkaeyCXjLopAmqhpi-g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 18 Oct 2019 14:02:26 +0000 (UTC)
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
Cc: David Gibson <dgibson@redhat.com>, David Hildenbrand <dhildenb@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 17, 2019 at 17:13:10 +0100, Peter Maydell wrote:
> On Thu, 17 Oct 2019 at 17:09, David Hildenbrand <david@redhat.com> wrote:
> > The default model under KVM is "host", under TCG it's "qemu". We should
> > not use "qemu" under KVM, although it might work on some setups ...
> 
> Possibly a tangent, but on Arm the approach we used to deal
> with "'-cpu host' only works for kvm" was to define a "-cpu max"
> meaning "best thing you can give me", which is an alias for
> -cpu host with KVM and an alias for a CPU with all the extra
> features we have emulation support under TCG. Then users can
> use '-cpu max' and have something that generally will DTRT
> regardless of accelerator.

This thread is not really about a CPU model that users could universally
use for both TCG or KVM. It's about checking what CPU model is used by
QEMU if no CPU model is specified on the command line.

BTW, I was told aarch64 is a bit different and QEMU fails to start with
KVM unless -cpu host is explicitly specified. Is that correct?

Jirka


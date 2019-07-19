Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81435C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 22:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5504C2084D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 22:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5504C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hob0w-0005do-IA
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 18:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39494)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hob0m-0005DF-U1
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 18:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hob0l-0002wN-NQ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 18:05:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44370)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hob0l-0002vj-5Y
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 18:05:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4C34530A7C5D;
 Fri, 19 Jul 2019 22:05:53 +0000 (UTC)
Received: from localhost (ovpn-116-109.gru2.redhat.com [10.97.116.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62AD019C77;
 Fri, 19 Jul 2019 22:05:52 +0000 (UTC)
Date: Fri, 19 Jul 2019 19:05:50 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190719220550.GC26800@habkost.net>
References: <20190718134537.22356-1-den@openvz.org>
 <20190719205358.GB26800@habkost.net>
 <9583f8ad-67c8-d351-3763-4ede9fbf4acc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9583f8ad-67c8-d351-3763-4ede9fbf4acc@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 19 Jul 2019 22:05:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/1] x86: add CPU flags supported inside
 libvirt
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
Cc: Peter Krempa <pkrempa@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>,
 "Denis V. Lunev" <den@openvz.org>, Jiri Denemark <jdenemar@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 19, 2019 at 11:44:57PM +0200, Paolo Bonzini wrote:
> On 19/07/19 22:53, Eduardo Habkost wrote:
> > This is one is named "cqm" on Linux (X86_FEATURE_CQM).  I prefer
> > to keep consistency with the name already in use by Linux than
> > the one in libvirt that was never used.
> > 
> > You can still add a "cmt" alias property if you think it would be
> > useful.
> 
> Actually KVM does not mark it as supported:
> 
>         const u32 kvm_cpuid_7_0_ebx_x86_features =
>                 F(FSGSBASE) | F(BMI1) | F(HLE) | F(AVX2) | F(SMEP) |
>                 F(BMI2) | F(ERMS) | f_invpcid | F(RTM) | f_mpx | F(RDSEED) |
>                 F(ADX) | F(SMAP) | F(AVX512IFMA) | F(AVX512F) | F(AVX512PF) |
>                 F(AVX512ER) | F(AVX512CD) | F(CLFLUSHOPT) | F(CLWB) | F(AVX512DQ) |
>                 F(SHA_NI) | F(AVX512BW) | F(AVX512VL) | f_intel_pt;

We can still add the feature name if we also set it on
.unmigratable_features, but I don't see why it would be useful.
Is anybody working to support exposing RDT-M to guests?

-- 
Eduardo


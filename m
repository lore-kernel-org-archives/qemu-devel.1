Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976D1C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 11:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 668CA206C2
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 11:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668CA206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxrao-0005qA-Cg
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 07:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jdenemar@redhat.com>) id 1hxraD-0005Ob-8H
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 07:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jdenemar@redhat.com>) id 1hxraB-0003z2-RM
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 07:36:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42640)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jdenemar@redhat.com>) id 1hxra9-0003xi-Qx
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 07:36:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2D53D30C061A;
 Wed, 14 Aug 2019 11:36:44 +0000 (UTC)
Received: from virval.usersys.redhat.com (unknown [10.43.2.188])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EEFF81001B35;
 Wed, 14 Aug 2019 11:36:43 +0000 (UTC)
Received: by virval.usersys.redhat.com (Postfix, from userid 500)
 id 9DFD0103011; Wed, 14 Aug 2019 13:36:42 +0200 (CEST)
Date: Wed, 14 Aug 2019 13:36:42 +0200
From: Jiri Denemark <jdenemar@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Message-ID: <20190814113642.GB1359272@orkuz.int.mamuti.net>
References: <20190718134537.22356-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718134537.22356-1-den@openvz.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 14 Aug 2019 11:36:44 +0000 (UTC)
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
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 18, 2019 at 16:45:37 +0300, Denis V. Lunev wrote:
> There are the following flags available in libvirt inside cpu_map.xm
>     <feature name='cvt16'>
>       <cpuid function='0x80000001' ecx='0x00040000'/>
>     </feature>
>     <feature name='cmt'> <!-- cqm -->
>       <cpuid eax_in='0x07' ecx_in='0x00' ebx='0x00001000'/>
>     </feature>
> We have faced the problem that QEMU does not start once these flags are
> present in the domain.xml.

Libvirt should not add this to the XML by itself (when using host-model
CPU, for example) so the user must have asked for the feature
explicitly. Thus I don't see any problem with QEMU refusing to start
with such configuration. And the workaround is easy, just don't do it.

I'm not sure about cvt16, but IIRC cmt and mbm_* features were added as
a way to detect whether the host CPU supports perf monitoring counters.
I think tt was not the brightest idea, but there's no reason why QEMU
should support enabling these features. Unless it actually makes sense
for QEMU.

If there are any issues with libvirt passing these features to QEMU
without explicit request from the user, we should address them in
libvirt.

Jirka


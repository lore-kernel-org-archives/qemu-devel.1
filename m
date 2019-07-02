Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAB9C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D2A206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D2A206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiJvD-0006Hv-WC
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 10:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51162)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hiJuN-0005la-Ci
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hiJuM-0001LV-DR
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:37:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38180)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hiJuJ-0001G1-2j; Tue, 02 Jul 2019 10:37:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E551586671;
 Tue,  2 Jul 2019 14:37:12 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-50.ams2.redhat.com
 [10.36.117.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32B955D6A9;
 Tue,  2 Jul 2019 14:37:11 +0000 (UTC)
Date: Tue, 2 Jul 2019 16:37:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <20190702143709.GB7894@localhost.localdomain>
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
 <20190528143727.10529-4-dplotnikov@virtuozzo.com>
 <20190628115720.GH5179@dhcp-200-226.str.redhat.com>
 <5a970b37-ef08-3d53-3d53-3abb9c3e97e0@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a970b37-ef08-3d53-3d53-3abb9c3e97e0@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 02 Jul 2019 14:37:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v0 3/3] qcow2: add zstd cluster compression
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 02.07.2019 um 14:49 hat Denis Plotnikov geschrieben:
> On 28.06.2019 14:57, Kevin Wolf wrote:
> > Am 28.05.2019 um 16:37 hat Denis Plotnikov geschrieben:
> >> diff --git a/configure b/configure
> >> index 1c563a7027..c90716189c 100755
> >> --- a/configure
> >> +++ b/configure
> >> @@ -433,6 +433,7 @@ opengl_dmabuf="no"
> >>   cpuid_h="no"
> >>   avx2_opt=""
> >>   zlib="yes"
> >> +zstd="yes"
> > 
> > This should be zstd="" so that a missing library will automatically
> > disable it instead of producing an error. (Building QEMU without zlib is
> > impossible, but building it without ZSTD should work.)
> But if we add zstd for clusters compression we have to build with zstd 
> each time. If we want to chose whether we want to build zstd we need to
> enclose all zstd related code with "ifdef"-s.
> I don't think it's good because we can end up with mess of version 
> supporting and not supporting zstd compression.

Yes, we'll need ifdefs. Or we could do it like the dmg compression
formats, a spearate source file for zstd that is compiled conditionally.

Anyway, I don't think making zstd a hard dependency for qemu is
acceptable.

> Another point is what the benefit of building qemu without zstd support 
> is since it's available and provides better performance than zlib (i.e. 
> the replacement for zlib) ?

Is it available in all relevant distros and even non-Linux platforms
that we support?

Another reason for wanting to compile it out even when it is available
is startup time. Each shared library to be loaded takes some time, and
there are use cases where you want a minimal guest to boot up really
fast.

Kevin


Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DA3C282DC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 07:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E6120835
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 07:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E6120835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48637 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGfQE-0007qz-RF
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 03:55:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hGfPQ-0007S5-4S
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 03:55:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hGfPP-000799-24
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 03:55:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hGfPO-00077x-N8; Wed, 17 Apr 2019 03:55:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E30627DCD7;
	Wed, 17 Apr 2019 07:55:04 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B5D9D60148;
	Wed, 17 Apr 2019 07:54:58 +0000 (UTC)
Date: Wed, 17 Apr 2019 09:54:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190417095456.741383a7.cohuck@redhat.com>
In-Reply-To: <20190416185301.25344-1-david@redhat.com>
References: <20190416185301.25344-1-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Wed, 17 Apr 2019 07:55:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 00/41] s390x/tcg: Vector Instruction
 Support Part 2
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417075456.Z7slqUeomyGOnjICvMHZ8GeE2IQRmUtzZyoQh9fxAec@z>

On Tue, 16 Apr 2019 20:52:20 +0200
David Hildenbrand <david@redhat.com> wrote:

> This is the second part of vector instruction support for s390x. It is
> based on the series soon to land upstream:
>     [PATCH 0/9] tcg: Add tcg_gen_extract2_{i32,i64}
> 
> Part 1: Vector Support Instructions
> Part 2: Vector Integer Instructions
> Part 3: Vector String Instructions
> Part 4: Vector Floating-Point Instructions
> 
> The current state can be found at (kept updated):
>     https://github.com/davidhildenbrand/qemu/tree/vx
> 
> With the current state I can boot Linux kernel + user space compiled with
> SIMD support. This allows to boot distributions compiled exclusively for
> z13, requiring SIMD support. Also, it is now possible to build a complete
> kernel using rpmbuild as quite some issues have been sorted out.
> 
> In this part, all Vector Integer Instructions introduced with the
> "Vector Facility" are added. Some instructions part of the Vector Extension
> Facilities are also added.
> 
> v1 -> v2:
> - Many suggestions and fixes as outlined by Richard H.
> -- Mostly avoid oom helpers for 128-bit add/sub variants
> -- New vector helpers are not considered for now

FWIW, I'd prefer a pull request for that over picking 41 patches :)
(I'm unlikely to be able to provide more insightful review anyway ;)


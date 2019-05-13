Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB467C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B050320873
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B050320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54061 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ7LK-0001fC-OU
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 05:33:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1hQ7KM-0001LY-Qo
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:33:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1hQ7KL-0008Q0-MP
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:32:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>)
	id 1hQ7KI-0008Lg-M0; Mon, 13 May 2019 05:32:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E23E3092648;
	Mon, 13 May 2019 09:32:52 +0000 (UTC)
Received: from kinshicho (unknown [10.43.2.73])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 041EF19C68;
	Mon, 13 May 2019 09:32:47 +0000 (UTC)
Message-ID: <9f57bfa56715b3128c1823150457ddb866e6054c.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org, 
	qemu-arm@nongnu.org
Date: Mon, 13 May 2019 11:32:46 +0200
In-Reply-To: <20190512083624.8916-1-drjones@redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 13 May 2019 09:32:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 00/13] target/arm/kvm: enable SVE in guests
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
	alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 2019-05-12 at 10:36 +0200, Andrew Jones wrote:
[...]
>    CPU type | accel | sve-max-vq | sve-vls-map
>    -------------------------------------------
>  1)     max | tcg   |  $MAX_VQ   |  $VLS_MAP
>  2)     max | kvm   |  $MAX_VQ   |  $VLS_MAP
>  3)    host | kvm   |  N/A       |  $VLS_MAP
> 
> Where for (1) $MAX_VQ sets the maximum vq and smaller vqs are
> all supported when $VLS_MAP is zero, or when the vqs are selected
> in $VLS_MAP.

I'm a bit confused by the nomenclature here. VL clearly stands for
Vector Length, but what does VQ stand for? You seem to be using the
two terms pretty much interchangeably throughout the cover letter.

[...]
> There is never any need to provide both properties, but if both
> are provided then they are checked for consistency.

I would personally just error out when both are provided.

> The QMP query returns a list of valid vq lists. For example, if
> a guest can use vqs 1, 2, 3, and 4, then the following list will
> be returned
> 
>  [ [ 1 ], [ 1, 2 ], [ 1, 2, 3 ], [ 1, 2, 3, 4 ] ]
> 
> Another example might be 1, 2, 4, as the architecture states 3
> is optional. In that case the list would be
> 
>  [ [ 1 ], [ 1, 2 ], [ 1, 2, 4 ] ]

I think the proposed QMP command is problematic, because it reports
the valid vector lengths for either KVM or TCG based on which
accelerator is currently enabled: it should report all information
at all times instead, similarly to how query-gic-capabilities does
it.

[...]
> And now for what might be a bit more controversial; how we input
> the valid vector set with sve-vls-map. Well, sve-vls-map is a
> 64-bit bitmap, which is admittedly not user friendly and also not
> the same size as KVM's vls bitmap (which is 8 64-bit words). Here's
> the justification:
> 
>  1) We want to use the QEMU command line in order for the information
>     to be migrated without needing to add more VM state.
>  2) It's not easy/pretty to input arrays on the QEMU command line.
>  3) We already need to use the QMP query to get a valid set, which
>     isn't user friendly either, meaning we're already in libvirt
>     territory.
>  4) A 64-bit map (supporting up to 8192-bit vectors) is likely big
>     enough for quite some time (currently KVM and TCG only support
>     2048-bit vectors).
>  5) If user friendliness is needed more than migratability then
>     the 'max' cpu type can be used with the sve-max-vq property.
>  6) It's possible to probe the full valid vector set from the
>     command line by using something like sve-vls-map=0xffff and
>     then, when it fails, the error message will state the correct
>     map, e.g. 0xb.

I don't have a problem with having to use a bitmap internally,
though libvirt will clearly want to expose a more approachable
interface to users.

However, QMP reporting the information in the current format means
we'd have to build an additional parser on top of the bitmap handling
and conversion routines we'll clearly need to make this work; plus it
just feels weird that the information reported by QMP can't be used
on the command line without going through some tranformation first.

Wouldn't it make more sense to both accept and report bitmaps?

-- 
Andrea Bolognani / Red Hat / Virtualization



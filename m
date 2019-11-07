Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC321C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 08:59:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 974A3214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 08:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCKhFlO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974A3214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSddC-0004wl-Md
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 03:59:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iSdUm-0000zY-GZ
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 03:50:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iSdUj-0007lQ-EB
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 03:50:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36279
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iSdUj-0007Zv-7v
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 03:50:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573116619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oBYm62S+mFLWS831hy80z/RWlVTtY3Fob09yp/WmBlA=;
 b=TCKhFlO4z1dOUJBZP/yg4o456wfg7+Nw/IAWvpo9ULNA3ZrGa1Wc5cVRIJs8GMEiX3sl9D
 ng4NpDYg4/c8fWJ5OaN1FIpijCesFNqmEN+1MiWH/4WGW02sRbjm6YwEX9RCmbqWuzgj3P
 llbGMGtK5RkUFm56DRYzquRBN01rWyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-xWsmakw_PwWG5rFTz12Wlg-1; Thu, 07 Nov 2019 03:50:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28BB2800C61;
 Thu,  7 Nov 2019 08:50:14 +0000 (UTC)
Received: from gondolin (ovpn-117-222.ams2.redhat.com [10.36.117.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F037A600D3;
 Thu,  7 Nov 2019 08:50:08 +0000 (UTC)
Date: Thu, 7 Nov 2019 09:50:06 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Guoheyi <guoheyi@huawei.com>
Subject: Re: [RFC v2 02/14] standard-headers: import arm_sdei.h
Message-ID: <20191107095006.16ebe25e.cohuck@redhat.com>
In-Reply-To: <059c6396-bbfb-2dd3-f7cc-7c64bc2d3ccb@huawei.com>
References: <20191105091056.9541-1-guoheyi@huawei.com>
 <20191105091056.9541-3-guoheyi@huawei.com>
 <20191106185240.3f5e2c2a.cohuck@redhat.com>
 <059c6396-bbfb-2dd3-f7cc-7c64bc2d3ccb@huawei.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: xWsmakw_PwWG5rFTz12Wlg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, James Morse <james.morse@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, wanghaibin.wang@huawei.com,
 Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 7 Nov 2019 09:40:49 +0800
Guoheyi <guoheyi@huawei.com> wrote:

> On 2019/11/7 1:52, Cornelia Huck wrote:
> > On Tue, 5 Nov 2019 17:10:44 +0800
> > Heyi Guo <guoheyi@huawei.com> wrote:
> > =20
> >> Import Linux header file include/uapi/linux/arm_sdei.h from kernel v5.=
4-rc5.
> >>
> >> This is to prepare for qemu SDEI emulation.
> >>
> >> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> >> Cc: Peter Maydell <peter.maydell@linaro.org>
> >> Cc: Dave Martin <Dave.Martin@arm.com>
> >> Cc: Marc Zyngier <marc.zyngier@arm.com>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: James Morse <james.morse@arm.com>
> >> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >> Cc: Cornelia Huck <cohuck@redhat.com>
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >>
> >> Notes:
> >>      v2:
> >>      - Import arm_sdei.h by running update-linux-headers.sh
> >>
> >>   include/standard-headers/linux/arm_sdei.h | 73 +++++++++++++++++++++=
++
> >>   1 file changed, 73 insertions(+)
> >>   create mode 100644 include/standard-headers/linux/arm_sdei.h =20
> > Just a remark that I find it a bit odd that that a header that looks
> > arm-specific is in the generic linux/ directory (already in the kernel,
> > I know.) Is this for sharing between arm and arm64, maybe? =20
> I don't think arm platforms will use this header. In section 4.1 of SDEI=
=20
> spec, it says " Both the client and dispatcher of SDEI must execute in=20
> AArch64 state."
> So shall we move it to include/standard-headers/asm-arm64/?

Well, the kernel already put it into the generic directory... I'd just
leave it like that, then; moving it in the kernel is probably too much
churn.



Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC15C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 08:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC52F20848
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 08:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UsFXN9z6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC52F20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j29j4-0004lh-6e
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 03:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1j29iJ-0004Fn-Do
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 03:19:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1j29iH-0007q8-OY
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 03:19:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60687
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1j29iH-0007pl-FW
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 03:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581581948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pM2dKSlUEnPtF1tY6boVjueZAba43ctUUtN+SPTBqb4=;
 b=UsFXN9z6Wfy+Sm9en7gEsORPckUlS08M/ZG4SDsDAGGOeZYm7F1a9zstso96zyl5QDZ22H
 RYDWLHnSVw/NWajvW8p+L/24zybbtSnCNBEi/737C2YvMyn5NSURpi+rEv9zaRdkNNgFQi
 pxnceUbVl5ltoIo20WAlVxPj40B2+S4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-S04n7xo-Px6BNdagtnlFwg-1; Thu, 13 Feb 2020 03:19:03 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99A7C8017CC;
 Thu, 13 Feb 2020 08:19:01 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F36AD5C1BB;
 Thu, 13 Feb 2020 08:18:56 +0000 (UTC)
Date: Thu, 13 Feb 2020 09:18:54 +0100
From: Andrew Jones <drjones@redhat.com>
To: Ying Fang <fangying1@huawei.com>
Subject: Re: [PATCH v2 0/4] arm64: Add the cpufreq device to show cpufreq
 info to guest
Message-ID: <20200213081854.ewkk23yhnog23upj@kamzik.brq.redhat.com>
References: <20200213073630.2125-1-fangying1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200213073630.2125-1-fangying1@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: S04n7xo-Px6BNdagtnlFwg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com, mst@redhat.com,
 i.mitsyanko@gmail.com, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, guoheyi@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 13, 2020 at 03:36:26PM +0800, Ying Fang wrote:
> On ARM64 platform, cpu frequency is retrieved via ACPI CPPC.
> A virtual cpufreq device based on ACPI CPPC is created to
> present cpu frequency info to the guest.
>=20
> The default frequency is set to host cpu nominal frequency,
> which is obtained from the host CPPC sysfs. Other performance
> data are set to the same value, since we don't support guest
> performance scaling here.
>=20
> Performance counters are also not emulated and they simply
> return 1 if read, and guest should fallback to use desired
> performance value as the current performance.
>=20
> Guest kernel version above 4.18 is required to make it work.
>

This is v2 of the series, but I don't see a changelog.

Can you please describe the motivation for this? If I understand
correctly, all of this is just to inform the guest of the host's
CPU0 nominal or max (if nominal isn't present?) frequency. Why
do that? What happens if the guest migrates somewhere where the
frequency is different? If this is for a special use case, then
why not come up with a different channel (guest agent?) to pass
this information?

Thanks,
drew



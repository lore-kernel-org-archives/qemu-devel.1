Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC502C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818A220673
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 07:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818A220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDkKF-0008Dp-L7
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 03:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iDk6q-0001ie-5g
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:52:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iDk6p-0003oQ-29
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 02:52:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48754)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1iDk6m-0003hv-HL; Fri, 27 Sep 2019 02:52:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EF88FC06512C;
 Fri, 27 Sep 2019 06:52:02 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EE17B5C21F;
 Fri, 27 Sep 2019 06:51:58 +0000 (UTC)
Date: Fri, 27 Sep 2019 08:51:56 +0200
From: Andrew Jones <drjones@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 4/9] target/arm/cpu64: max cpu: Introduce sve<N>
 properties
Message-ID: <20190927065156.zzlx54nmhmnbc4of@kamzik.brq.redhat.com>
References: <20190924113105.19076-1-drjones@redhat.com>
 <20190924113105.19076-5-drjones@redhat.com>
 <2beb840f-99cf-d928-0926-c284933c78d9@linaro.org>
 <877e5uaa74.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <877e5uaa74.fsf@linaro.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 27 Sep 2019 06:52:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, armbru@redhat.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 27, 2019 at 12:50:55AM +0100, Alex Benn=E9e wrote:
>=20
> Richard Henderson <richard.henderson@linaro.org> writes:
>=20
> > On 9/24/19 4:31 AM, Andrew Jones wrote:
> <snip>
> >
> >> +#if __SIZEOF_LONG__ =3D=3D 8
> >> +#define BIT(n) (1UL << (n))
> >> +#else
> >> +#define BIT(n) (1ULL << (n))
> >> +#endif
> >
> > There's no reason not to always use 1ULL is there?
>=20
> Also we already have this helper in bitops.h so should just use that.

bitops.h BIT() uses UL, but we need ULL. FWIW, the kernel has a BIT_ULL()
that we could mimic in QEMU. I guess I could even add that for this patch=
,
if you'd like.

Thanks,
drew


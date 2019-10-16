Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E7FFA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA08221925
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA08221925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKiK3-0002WL-4o
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 08:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iKiIn-0001l3-JT
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iKiIm-0004FF-Ny
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:21:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56810)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1iKiIk-0004EP-7B; Wed, 16 Oct 2019 08:21:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4EE8BA3CD8A;
 Wed, 16 Oct 2019 12:21:12 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F346860852;
 Wed, 16 Oct 2019 12:21:05 +0000 (UTC)
Date: Wed, 16 Oct 2019 14:21:03 +0200
From: Andrew Jones <drjones@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v6 2/9] tests: arm: Introduce cpu feature tests
Message-ID: <20191016122103.l6vz423k3gpdr2bv@kamzik.brq.redhat.com>
References: <20191016085408.24360-1-drjones@redhat.com>
 <20191016085408.24360-3-drjones@redhat.com>
 <cec54f08-9508-13e5-600f-3442962a1642@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <cec54f08-9508-13e5-600f-3442962a1642@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Wed, 16 Oct 2019 12:21:12 +0000 (UTC)
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, armbru@redhat.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, alex.bennee@linaro.org,
 Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 16, 2019 at 02:05:24PM +0200, Philippe Mathieu-Daud=E9 wrote:
> > +static void test_query_cpu_model_expansion_kvm(const void *data)
> > +{
> > +    QTestState *qts;
> > +
> > +    qts =3D qtest_init(MACHINE "-accel kvm -cpu host");
> > +
> > +    assert_has_feature(qts, "host", "pmu");
>=20
> Have you tried this on a ARM host? I wanted to but don't have access to=
 one
> :(
>

Yes. All code in this series has been tested; covering these
configurations

 - TCG aarch64
 - TCG arm
 - KVM aarch64 without SVE
 - KVM aarch64 with SVE
 - compile tested arm code with CONFIG_KVM enabled

Thanks,
drew


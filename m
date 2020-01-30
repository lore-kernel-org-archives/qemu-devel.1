Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0831BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:10:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7679206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VysxDlUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7679206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixDKb-0000fW-1V
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 12:10:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ixDJb-0008WI-SB
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:09:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ixDJZ-0007LD-NU
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:09:14 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25552
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ixDJZ-0007KP-Jv
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580404152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yc0EOddCh1PJemVn7n/U7k7QKGyui3kb44LOBC9BSu8=;
 b=VysxDlUhBcPGNjriGPI5/yGY5kFvNQBQyyQbIDhX4Wrg0uW0Xpp68k/qDzU4ZUPMVS7nii
 uGU9KvsyDoPnR65k/YdUqMjAKHPCqpoJALshdgjdcYwVJWI3tXZL4fPqQhT5Q+fcTlhehC
 hZzuUBzeammOIY/Yycusc/nfS8Rp5UM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-JCK8Oe8WP0GqDFI7HdjoAQ-1; Thu, 30 Jan 2020 12:09:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C544C8C8A82;
 Thu, 30 Jan 2020 17:09:08 +0000 (UTC)
Received: from gondolin (ovpn-117-199.ams2.redhat.com [10.36.117.199])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D60B060BE0;
 Thu, 30 Jan 2020 17:09:02 +0000 (UTC)
Date: Thu, 30 Jan 2020 18:08:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 04/29] tests/acceptance: Use 'version-min' tag to
 verify QEMU binary version
Message-ID: <20200130180859.43954c22.cohuck@redhat.com>
In-Reply-To: <ee877d12-c0a4-4f82-5d59-2e0235158479@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-5-philmd@redhat.com>
 <20200130132625.533fb4ca.cohuck@redhat.com>
 <ee877d12-c0a4-4f82-5d59-2e0235158479@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: JCK8Oe8WP0GqDFI7HdjoAQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jan 2020 14:28:19 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 1/30/20 1:26 PM, Cornelia Huck wrote:
> > On Wed, 29 Jan 2020 22:23:20 +0100
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> >  =20
> >> Introduce the 'version-min' tag.
> >> Tests can set it to the minimum version of QEMU they require.
> >> If QEMU is older, the tests will be cancelled (skipped):
> >>
> >>    $ python -m avocado --show=3Dapp run tests/acceptance/x86_cpu_model=
_versions.py
> >>     (01/11) X86CPUModelAliases.test_4_0_alias_compatibility: CANCEL: T=
est expects version '4.1' but QEMU binary is '3.1.1' (0.10 s)
> >>     (02/11) X86CPUModelAliases.test_4_1_alias: CANCEL: Test expects ve=
rsion '4.1' but QEMU binary is '3.1.1' (0.10 s)
> >>     (03/11) X86CPUModelAliases.test_none_alias: CANCEL: Test expects v=
ersion '4.1' but QEMU binary is '3.1.1' (0.10 s)
> >>     ...
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >> ---
> >>   tests/acceptance/avocado_qemu/__init__.py | 18 ++++++++++++++++++
> >>   1 file changed, 18 insertions(+) =20
> >=20
> > Hm... this might cause headaches if someone tries to backport tests on
> > distro versions; but we probably won't be able to test for the feature
> > in many cases anyway?
> >  =20
>=20
> Are you saying a distro version might not match upstream version when a=
=20
> feature is introduced? Isn't it the point of versioning? If you are=20
> thinking of some case you point me at it so I can improve this patch?

Something like the following:

- a feature together with a test is introduced in QEMU version n
- a distro is using m (where m < n), but wants the new feature and
  backports it

If that distro now wants to include the acceptance test as well (to run
in their internal testing), they need to adapt the version check as
well, or the test simply won't run. Depending on how this is reported,
it might not be easily noticed. If the test depends on another feature
(but the feature does not), it might get a bit more complicated.

It's probably not a big problem, but I wanted to point it out.



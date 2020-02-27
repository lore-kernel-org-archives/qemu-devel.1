Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A28C52D2F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:14:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E0F4246AC
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 14:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbL5Kcve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E0F4246AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Jvx-0006aB-M0
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 09:14:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j7Juj-0004eP-Qa
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:13:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j7Jui-0007Ul-QG
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:13:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31519
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j7Jui-0007UM-Ln
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 09:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582812800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+eWiKI/VVlEEq63rGQvQJ+kE6pcSeHfnXA0xz1Tbp8k=;
 b=AbL5Kcve3GB4aIKy5FfNe2oRVra6ceZ72iwnLMMLG/ikQNAQk9GsGIOAF8cwaSCEZWOOM0
 /AA6jj40LHlXiSw+Yzp1+qBF/kgKQ424D+cDfnmcNc2e8MF/BxkTgz0qo1X6vBWlwMncTE
 qd/cW6JtlNPTss4FdOpZjF0N0Ur+k1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-eYHn4upUMDquFVFqigMpTw-1; Thu, 27 Feb 2020 09:13:18 -0500
X-MC-Unique: eYHn4upUMDquFVFqigMpTw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC73518C8C01;
 Thu, 27 Feb 2020 14:13:16 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 823C96E3EE;
 Thu, 27 Feb 2020 14:13:15 +0000 (UTC)
Date: Thu, 27 Feb 2020 15:13:13 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v1 4/4] accel/tcg: increase default code gen buffer size
 for 64 bit
Message-ID: <20200227151313.7b2f188b@redhat.com>
In-Reply-To: <56f5e355-9357-e212-e92b-9db1d8424dea@linaro.org>
References: <20200226181020.19592-1-alex.bennee@linaro.org>
 <20200226181020.19592-5-alex.bennee@linaro.org>
 <2ca7b55b-5674-370d-5c4d-dc8b7782ca64@linaro.org>
 <87pne0w6rt.fsf@linaro.org>
 <56f5e355-9357-e212-e92b-9db1d8424dea@linaro.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Feb 2020 04:56:46 -0800
Richard Henderson <richard.henderson@linaro.org> wrote:

> On 2/27/20 4:31 AM, Alex Benn=C3=A9e wrote:
> >> It does not make sense for a linux-user chroot, running make -jN, on j=
ust about
> >> any host.  For linux-user, I could be happy with a modest increase, bu=
t not all
> >> the way out to 2GiB.
> >>
> >> Discuss. =20
> >=20
> > Does it matter that much? Surely for small programs the kernel just
> > never pages in the used portions of the mmap? =20
>=20
> That's why I used the example of a build under the chroot, because the co=
mpiler
> is not a small program.
>=20
> Consider when the memory *is* used, and N * 2GB implies lots of paging, w=
here
> the previous N * 32MB did not.
>=20
> I'm saying that we should consider a setting more like 128MB or so, since=
 the
> value cannot be changed from the command-line, or through the environment=
.

That's what BSD guys force tb-size to, to speed up system emulation.

>=20
>=20
> r~
>=20



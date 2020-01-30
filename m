Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC16C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A3C6206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 12:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qv7QOjDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3C6206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix8uk-0002qv-IT
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 07:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ix8uD-0002SI-19
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:26:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ix8uC-0004qg-39
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:26:44 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27848
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ix8uB-0004qL-WB
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 07:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580387203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=70RqZy7s9xLDgNk2ERx301qO0PYw1je6OlxbarV9Uwo=;
 b=Qv7QOjDQDX4153d+wf2vBwfQYlTJj3waj97C0SV/Y3OninGvDtbvBMArHu0X5WkwTuieKq
 k+Zk6CYFj1YVUbH33nNcjYbl4S4nUJl9xdQahBtxp99tzPqUEVw/ONXc0c1uSMCM/J1cuf
 v/p9XKG1TE3l1uW3htI9Pxu6Dqw69M8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-esMCWEs2NCCZlP_7t5GiHw-1; Thu, 30 Jan 2020 07:26:39 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D497E18FE862;
 Thu, 30 Jan 2020 12:26:38 +0000 (UTC)
Received: from gondolin (ovpn-117-199.ams2.redhat.com [10.36.117.199])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F3905C1B2;
 Thu, 30 Jan 2020 12:26:27 +0000 (UTC)
Date: Thu, 30 Jan 2020 13:26:25 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 04/29] tests/acceptance: Use 'version-min' tag to
 verify QEMU binary version
Message-ID: <20200130132625.533fb4ca.cohuck@redhat.com>
In-Reply-To: <20200129212345.20547-5-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-5-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: esMCWEs2NCCZlP_7t5GiHw-1
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Jan 2020 22:23:20 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Introduce the 'version-min' tag.
> Tests can set it to the minimum version of QEMU they require.
> If QEMU is older, the tests will be cancelled (skipped):
>=20
>   $ python -m avocado --show=3Dapp run tests/acceptance/x86_cpu_model_ver=
sions.py
>    (01/11) X86CPUModelAliases.test_4_0_alias_compatibility: CANCEL: Test =
expects version '4.1' but QEMU binary is '3.1.1' (0.10 s)
>    (02/11) X86CPUModelAliases.test_4_1_alias: CANCEL: Test expects versio=
n '4.1' but QEMU binary is '3.1.1' (0.10 s)
>    (03/11) X86CPUModelAliases.test_none_alias: CANCEL: Test expects versi=
on '4.1' but QEMU binary is '3.1.1' (0.10 s)
>    ...
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/acceptance/avocado_qemu/__init__.py | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Hm... this might cause headaches if someone tries to backport tests on
distro versions; but we probably won't be able to test for the feature
in many cases anyway?



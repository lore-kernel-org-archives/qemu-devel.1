Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB85C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 10:02:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5593F20CC7
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 10:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQUoqQfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5593F20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50853 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixT8F-00017B-IP
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 05:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ixT6b-0000Yc-QP
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 05:00:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ixT6V-0003RC-98
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 05:00:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46013
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ixT6V-0003Nv-5h
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 05:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580464846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YyAsFrGXeqqoHKcwxLgosxmLU67JK1VI8c9NjatvuUg=;
 b=LQUoqQfOEcoW57uhKO4NfZ1/TwwfBB8p+N4dv3BXT6PhL6rSi/FUOeS16/sFztBxwZWQlj
 tQtZOUHGUrc1zytJDcz+i8McV91dfq8FxfGKZ9eiZNC2KVV6PFoF+B3rt/+CwQnWrx1R8c
 ksTWkXdVhZ/SSgdM9dlZzlOxb9vCWAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-xrUb5g4eO9mFoSNzY6E3ug-1; Fri, 31 Jan 2020 05:00:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8BF2800D41;
 Fri, 31 Jan 2020 10:00:41 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E64085D9E5;
 Fri, 31 Jan 2020 10:00:35 +0000 (UTC)
Date: Fri, 31 Jan 2020 11:00:33 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 09/29] tests/acceptance: Use 'machine' tag to check
 if available in QEMU binary
Message-ID: <20200131110033.63a6c17f.cohuck@redhat.com>
In-Reply-To: <20200129212345.20547-10-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-10-philmd@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: xrUb5g4eO9mFoSNzY6E3ug-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Jan 2020 22:23:25 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> We already use the 'machine' tag in Avocado tests.
> If the requested machine is not available in the QEMU binary,
> the tests will be cancelled (skipped):
>=20
>   $ python -m avocado --show=3Dapp run tests/acceptance/x86_cpu_model_ver=
sions.py
>    ...
>    (04/11) CascadelakeArchCapabilities.test_4_1: CANCEL: Test expects mac=
hine 'pc-i440fx-4.1' which is missing from QEMU binary (0.10 s)
>    (05/11) CascadelakeArchCapabilities.test_4_0: CANCEL: Test expects mac=
hine 'pc-i440fx-4.0' which is missing from QEMU binary (0.11 s)
>    ...
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/acceptance/avocado_qemu/__init__.py | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>



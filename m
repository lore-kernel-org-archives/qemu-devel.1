Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9721C3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 18:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD79E2087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 18:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD79E2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5aO9-0005zD-ND
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 14:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i5aNU-0005aG-L9
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 14:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i5aNS-0004yT-Ad
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 14:51:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41904)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i5aNS-0004xu-4n
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 14:51:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B421C51EE9
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 18:51:32 +0000 (UTC)
Received: from localhost (ovpn-116-88.ams2.redhat.com [10.36.116.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 11D361001959;
 Wed,  4 Sep 2019 18:51:31 +0000 (UTC)
Date: Wed, 4 Sep 2019 19:51:30 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190904185130.GE26826@stefanha-x1.localdomain>
References: <20190904130047.25808-1-thuth@redhat.com>
 <20190904130047.25808-6-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UnaWdueM1EBWVRzC"
Content-Disposition: inline
In-Reply-To: <20190904130047.25808-6-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 04 Sep 2019 18:51:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 5/6] tests/libqtest: Move global_test
 wrapper function into a separate header
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--UnaWdueM1EBWVRzC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 04, 2019 at 03:00:46PM +0200, Thomas Huth wrote:
> diff --git a/tests/libqtest-single.h b/tests/libqtest-single.h
> new file mode 100644
> index 0000000000..49259558a5
> --- /dev/null
> +++ b/tests/libqtest-single.h
> @@ -0,0 +1,311 @@
> +/*
> + * QTest - wrappers for test with single QEMU instances
> + *
> + * Copyright IBM, Corp. 2012
> + * Copyright Red Hat, Inc. 2012
> + * Copyright SUSE LINUX Products GmbH 2013
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +#ifndef LIBQTEST_SINGLE_H
> +#define LIBQTEST_SINGLE_H
> +
> +/**
> + * qtest_start:
> + * @args: other arguments to pass to QEMU
> + *
> + * Start QEMU and assign the resulting #QTestState to a global variable.
> + * The global variable is used by "shortcut" functions documented below.
> + *
> + * Returns: #QTestState instance.
> + */
> +static inline QTestState *qtest_start(const char *args)
> +{
> +    global_qtest = qtest_init(args);

Where are global_qtest and qtest_init() declared?  I would expect
compilation to fail if a .c file included just "libqtest-single.h".
Missing #include?

If this header is not supposed to be included by .c files, please
include at least a comment or use a magic #define + #ifdef to prevent
inclusion.

--UnaWdueM1EBWVRzC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1wB7IACgkQnKSrs4Gr
c8gPoQf9GrgvT1FLJgP07EWWv4o6fuH+AcVXcXGQINNRt5wkLm0yvl2kH6ljR9Mi
7f0v5Qxcsj4h5yuaSWnTfsEuCXUE2D6pu0Ur0QK80OFMjdBtFbN9yTQ2EMDCJncR
WDyrrNF/gvWkUrmAE3420utjegT9Y7rKPcjaP+GMyEcN6jeQQ88lmV1Mq60V+3l+
Hd+yvjsLnNdOvOkf/CKHBHrwWeQnIgfFDcFUzx6BXqmnPaGBti5regQX2So2RxOK
a6iLDs8QUE7KOIXaKauIR9ZGbTw222WrM06MDH+43fxbTmhck6oz4U8qW92Wo4Iv
rKIx1qJJIyBX4Hc4kp+6ZXNe84jfCA==
=s7Nw
-----END PGP SIGNATURE-----

--UnaWdueM1EBWVRzC--


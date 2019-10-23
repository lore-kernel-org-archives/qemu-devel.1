Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BF6CA9EAE
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 07:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F79B214B2
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 07:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/MccXcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F79B214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNB5O-0008Bv-2y
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 03:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iNB3v-0006g3-39
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 03:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iNB3s-0000FF-Lv
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 03:28:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54007
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iNB3s-0000F0-IM
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 03:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571815683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fxI3Sgmv2zHRMqnpedJz0YEl9A4xm4FuZj9oG6tfL6w=;
 b=S/MccXcMBxyM7uqPaI984XasbyhAJPx3KQu5gsmKUYOpNaBW/07LXLHEEQBptI74VexuB2
 ynQTfhMI3p1vaJnE144Jj4cn0Y8zS31iVnFpOMwH9l6UTDA+zIv+l4QbvNdSkpYfHxFBBN
 ng/ERPZ1BP3Cx5NTtoPQ6tPosMsXsRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-OylmNtXnPViddpmV5zO9xA-1; Wed, 23 Oct 2019 03:28:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2594880183E;
 Wed, 23 Oct 2019 07:27:59 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1584619C78;
 Wed, 23 Oct 2019 07:27:59 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 3EB5A180B536;
 Wed, 23 Oct 2019 07:27:58 +0000 (UTC)
Date: Wed, 23 Oct 2019 03:27:57 -0400 (EDT)
From: Thomas Huth <thuth@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Message-ID: <2020367759.8121043.1571815677935.JavaMail.zimbra@redhat.com>
In-Reply-To: <20191022191704.6134-8-alex.bennee@linaro.org>
References: <20191022191704.6134-1-alex.bennee@linaro.org>
 <20191022191704.6134-8-alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 07/19] cirrus.yml: reduce scope of MacOS build
MIME-Version: 1.0
X-Originating-IP: [149.14.88.107, 10.4.196.9, 10.5.101.130, 10.4.195.21]
Thread-Topic: cirrus.yml: reduce scope of MacOS build
Thread-Index: i+PpcRD6mku3lSanC1QG223ETh8HkQ==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: OylmNtXnPViddpmV5zO9xA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: fam@euphon.net, berrange@redhat.com, pbonzini@redhat.com,
 stefanb@linux.vnet.ibm.com, richard henderson <richard.henderson@linaro.org>,
 f4bug@amsat.org, qemu-devel@nongnu.org, cota@braap.org, stefanha@redhat.com,
 marcandre lureau <marcandre.lureau@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

----- Original Message -----
> From: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
> Sent: Tuesday, October 22, 2019 9:16:52 PM
>=20
> The MacOS build can time out on Cirrus running to almost an hour.
> Reduce the scope to the historical MacOS architectures much the same
> way we do on Travis.

Oh, really? For me, the builds on Cirrus-CI work reasonable fast and almost=
 always finish within 20 minutes, e.g.:

https://cirrus-ci.com/build/4976412120842240

Also the last macos_task from the official QEMU mirror on github finished w=
ithin 15 minutes:

https://github.com/qemu/qemu/runs/269964092

... so was your issue maybe just a temporary dropout?

 Thomas



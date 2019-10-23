Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1327CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 07:33:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E192064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 07:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSZlp1ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E192064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNB97-0003u5-IS
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 03:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iNAwI-0007RQ-R3
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 03:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iNAwH-000456-EC
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 03:20:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42953
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iNAwH-000431-AV
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 03:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571815212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rLzrSN5UGkJg8k3j538uT/Pi7uAWc4m/QM/nuB+fqW0=;
 b=aSZlp1cabYDYfOfFkG266G7+iGe2FU9X38Ud9Zhu8+nkEzTcNfYSeRqtKRDpBITtYT17ZC
 tSu2ZRkbtsUQQjalWbdyt5MQdr7cbwlaUlZJSmVeVdGWwycMIp7wnDF6Q8OCCq09xTaKYt
 SZyS3B3mclH8o+LWZRVhnd6X/VZyswQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-kc7mTz2nMECchcI55Z_3ww-1; Wed, 23 Oct 2019 03:20:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1974107AD31;
 Wed, 23 Oct 2019 07:20:05 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A73286012E;
 Wed, 23 Oct 2019 07:20:05 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 981CC18089C8;
 Wed, 23 Oct 2019 07:20:05 +0000 (UTC)
Date: Wed, 23 Oct 2019 03:20:05 -0400 (EDT)
From: Thomas Huth <thuth@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Message-ID: <381938133.8120078.1571815205455.JavaMail.zimbra@redhat.com>
In-Reply-To: <20191022191704.6134-1-alex.bennee@linaro.org>
References: <20191022191704.6134-1-alex.bennee@linaro.org>
Subject: Re: [PATCH for 4.2 v1 00/19] testing/next before softfreeze
MIME-Version: 1.0
X-Originating-IP: [149.14.88.107, 10.4.196.28, 10.5.101.130, 10.4.195.27]
Thread-Topic: testing/next before softfreeze
Thread-Index: cFPZlpiPDRZhgRID6eIr7SY0M5ZUvw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: kc7mTz2nMECchcI55Z_3ww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

----- Original Message -----
> From: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
> Sent: Tuesday, October 22, 2019 9:16:45 PM
>=20
> Hi,
>=20
> This is the current status of testing/next. I dropped the Travis arm64
> build due to stability concerns. As far as I can tell Thomas' latest
> iotest updates are working fine. If there are any other patches worth
> considering before the softfreeze now is the time to shout.

Feel free to include:

https://lists.nongnu.org/archive/html/qemu-devel/2019-10/msg03912.html
("gitlab-ci.yml: Use libvdeplug-dev to compile-test the VDE network backend=
")

I'm not sure whether I'll find some spare time to send a pull request for t=
hat patch before/during KVM forum, so it would be nice if you could include=
 it.

 Thomas



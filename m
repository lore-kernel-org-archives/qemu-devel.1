Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353E2C33CA3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 19:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0444E2051A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 19:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqS8i5kf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0444E2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipzjN-0003Hf-UV
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 14:14:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ipziU-0002Fc-6y
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:13:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ipziT-0008Uz-0o
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:13:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57134
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ipziS-0008GH-Ry
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:13:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578683581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nne5sI9RuQm0lbEV86jJCWp7cqnBw/7RHxIld+I9yjk=;
 b=LqS8i5kfjKlTFgYziIPVS3zGVWbqhN0uhzDFfPYcnApQ5V7KyitQdHcHTHodyoPXq8wTPt
 T0jxwjTnMAIbNc5Ad+YDn+XqaeKmsfCWWsYF4UINK+WBrlNYmDT7FueaL8EV2TSteRCxGM
 SRKz+0QR5ngARn4SZmWCys06hVpkaSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-JFTXvBk2Ojq1MOas-Kgr1A-1; Fri, 10 Jan 2020 14:13:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C9DE10054E3;
 Fri, 10 Jan 2020 19:12:59 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-73.gru2.redhat.com
 [10.97.116.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D76D978E77;
 Fri, 10 Jan 2020 19:12:55 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/1] travis.yml: Missing genisoimage package
Date: Fri, 10 Jan 2020 16:12:53 -0300
Message-Id: <20200110191254.11303-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: JFTXvBk2Ojq1MOas-Kgr1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: fam@euphon.net, alex.bennee@linaro.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's install genisoimage package on Travis build environments so that
the cdrom-test tests run (currently they skip due the missing dependency).

As an example, on
https://travis-ci.org/qemu/qemu/jobs/635375718:

```
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=3Daarch64-softmmu/qemu-system-aarch64
QTEST_QEMU_IMG=3Dqemu-img tests/cdrom-test -m=3Dquick -k --tap < /dev/null =
|
./scripts/tap-driver.pl --test-name=3D"cdrom-test"=20

SKIP
```

Now with this change on
https://travis-ci.org/wainersm/qemu/jobs/635358843:

```
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST_Q=
EMU_BINARY=3Daarch64-softmmu/qemu-system-aarch64 QTEST_QEMU_IMG=3Dqemu-img =
tests/cdrom-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-driver.pl =
--test-name=3D"cdrom-test"=20

PASS 1 cdrom-test /aarch64/cdrom/param/realview-eb

PASS 2 cdrom-test /aarch64/cdrom/param/realview-eb-mpcore

PASS 3 cdrom-test /aarch64/cdrom/param/realview-pb-a8

PASS 4 cdrom-test /aarch64/cdrom/param/realview-pbx-a9

PASS 5 cdrom-test /aarch64/cdrom/param/versatileab

PASS 6 cdrom-test /aarch64/cdrom/param/versatilepb

PASS 7 cdrom-test /aarch64/cdrom/param/vexpress-a15

PASS 8 cdrom-test /aarch64/cdrom/param/vexpress-a9

PASS 9 cdrom-test /aarch64/cdrom/param/virt
```

Wainer dos Santos Moschetta (1):
  travis.yml: Install genisoimage package

 .travis.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

--=20
2.23.0



Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE25C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28650206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DI8ED5fJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28650206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVy5T-0007Y7-Co
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jVxxx-0004CW-EF
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:50:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45422
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jVxxw-0002g9-Jc
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588686631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9dcddmb3LrH5fvm2DTG9ipbFQvclqoz3go83ipR0Qpo=;
 b=DI8ED5fJjQHZ0bkDlHhtaadmlMVGXF15cC4fDxqWEg7THlVO81/dRpxdlsAOVerPj3Dxfg
 URIEaK0C4+C7IXSJZ6BO0iNoUe2iDKSJ9wmXprXhty1M5W4YFPfdsnER8RgzPudWFauLJ5
 r08Vlo95G0WVKlMjVdU3wDGed4iUdV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96--fqCKincO_ucHraZky0mRw-1; Tue, 05 May 2020 09:50:30 -0400
X-MC-Unique: -fqCKincO_ucHraZky0mRw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FFBC460;
 Tue,  5 May 2020 13:50:29 +0000 (UTC)
Received: from localhost (ovpn-112-219.ams2.redhat.com [10.36.112.219])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E988F5D9DA;
 Tue,  5 May 2020 13:50:28 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-s390x@nongnu.org
Subject: [PATCH 0/3] s390x: improve documentation
Date: Tue,  5 May 2020 15:50:22 +0200
Message-Id: <20200505135025.14614-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The documentation for the s390x system emulation target still has quite
a bit of room for improvement, so I started adding some device documentatio=
n.

I'm not quite happy with the long command/output lines in the 3270 and
vfio-ccw sections, but don't know how to make that more readable. Suggestio=
ns
welcome.

Cornelia Huck (3):
  docs/s390x: document the virtual css
  docs/s390x: document 3270
  docs/s390x: document vfio-ccw

 docs/system/s390x/3270.rst     | 32 +++++++++++++++++
 docs/system/s390x/css.rst      | 64 ++++++++++++++++++++++++++++++++++
 docs/system/s390x/vfio-ccw.rst | 58 ++++++++++++++++++++++++++++++
 docs/system/target-s390x.rst   |  3 ++
 4 files changed, 157 insertions(+)
 create mode 100644 docs/system/s390x/3270.rst
 create mode 100644 docs/system/s390x/css.rst
 create mode 100644 docs/system/s390x/vfio-ccw.rst

--=20
2.21.3



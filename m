Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE99AC11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:21:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884B0206E2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+MvUPJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884B0206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4mhX-0001lO-Ne
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 09:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1j4mga-0000OJ-LB
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1j4mgX-0004fM-WD
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:20:15 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21050
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1j4mgV-0004dS-Jj
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582208410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=65r4OG8CIrEsg+mrcDkutbiGM6BeEHVYlqT+dO5IcY8=;
 b=F+MvUPJzG0DAyLfroCnH7scs5l+L8VNyKUF9e8R9sqkbPkd6g0FB4OYnDcaeAwzOcGFN3U
 MEvZuwOi++fpiq9jTWUz2YcPTC9lZH0sXpq2r+LWK/qJIz4coqDHQ8C+T7i1CbITx69Pis
 qTSTfDEJerdDrfAscCgXpI8OBJx37YY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-RK8rL-hPPkmcIBXdGqbX2Q-1; Thu, 20 Feb 2020 09:20:08 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 121A2107B118;
 Thu, 20 Feb 2020 14:20:07 +0000 (UTC)
Received: from paraplu.localdomain (unknown [10.36.118.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EAC0A9076D;
 Thu, 20 Feb 2020 14:20:03 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] qemu-cpu-models: Convert to rST;
 document other MSR bits
Date: Thu, 20 Feb 2020 15:19:59 +0100
Message-Id: <20200220142001.20774-1-kchamart@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: RK8rL-hPPkmcIBXdGqbX2Q-1
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
Cc: peter.maydell@linaro.org, berrange@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, kchamart@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In v3:
 - Address the comments from Peter Maydell, from here:
   https://lists.nongnu.org/archive/html/qemu-devel/2020-02/msg05155.html

This small series does two things:

(1) Convert the original qemu-cpu-models.texi to rST

(2) In a separate patch, incorporate the additional new content from
    this:
    https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg06455.html
    ([PATCH v3] qemu-cpu-models: Document -noTSX, mds-no, taa-no, and
    tsx-ctrl)

Sphinx rendering of the converted doc is here:

    https://kashyapc.fedorapeople.org/QEMU_v4.2.0-1301-gb082353c5e_docs/sys=
tem/qemu-cpu-models.html

Kashyap Chamarthy (2):
  docs: Convert qemu-cpu-models.texi to rST
  qemu-cpu-models.rst: Document -noTSX, mds-no, taa-no, and tsx-ctrl

 MAINTAINERS                     |   2 +-
 Makefile                        |  10 +-
 docs/qemu-cpu-models.texi       | 677 --------------------------------
 docs/system/conf.py             |   3 +
 docs/system/index.rst           |   1 +
 docs/system/qemu-cpu-models.rst | 571 +++++++++++++++++++++++++++
 qemu-doc.texi                   |   5 -
 7 files changed, 581 insertions(+), 688 deletions(-)
 delete mode 100644 docs/qemu-cpu-models.texi
 create mode 100644 docs/system/qemu-cpu-models.rst

--=20
2.21.0



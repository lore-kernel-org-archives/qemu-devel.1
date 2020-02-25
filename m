Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DDCC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 568292082F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuBKbhBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568292082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6dWl-0004VW-Cc
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 11:57:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1j6dVZ-0003bj-Ae
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:56:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1j6dVX-0002kA-GI
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:56:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49799
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1j6dVX-0002jq-Ch
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582649790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=p+/VAiuEJpGpmCAUa1I1RYerUKwRIPwa4zwkr3N/80w=;
 b=EuBKbhBvBsme4f0sZYg4skFvaZRVX+nnKdAvsI5KWpeL7Qi4CEZYId0bQUQAiBEzXzBCUw
 3yHr0dOzAcrn+4HODOJd62S8M2coD+PO4nm9E2sko3dRAZCpp6UxpyyVkXRzBqj05pA+UK
 2mQyEC6crtzsKVY2ZeLWDVGienQl+h4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-hmTm-aakMqyauAaTYDHdtw-1; Tue, 25 Feb 2020 11:56:22 -0500
X-MC-Unique: hmTm-aakMqyauAaTYDHdtw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46026100726F;
 Tue, 25 Feb 2020 16:56:21 +0000 (UTC)
Received: from paraplu.redhat.com (ovpn-117-203.ams2.redhat.com
 [10.36.117.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 353BF90535;
 Tue, 25 Feb 2020 16:56:18 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/2] qemu-cpu-models: Convert to rST;
 document other MSR bits
Date: Tue, 25 Feb 2020 17:56:16 +0100
Message-Id: <20200225165618.6571-1-kchamart@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, kchamart@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In v4:
 - Correctly use the 'define-man-page' rule for qemu-cpu-models.7
   [pm215]
 - Fix author attribution as per the thread:
   Message-ID:
   <CAFEAcA8dTR6xkQnsf32HAo6aDXf5Z0UmkhL3+257KWLj1ES6Sw@mail.gmail.com>
   [danpb, pm215]
 - Don't reverse the existing order of the list of CPU models [pm215]
 - Use rST "definition lists" consistently throughout the document.
 - Consistently capitalize the phrase: "The QEMU Project Developers"
 - Update the year of copyright to 2020 in docs/conf.py
 - Fix two minor rST-related things [pbonzini]

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

Sphinx rendering of v4:

    https://kashyapc.fedorapeople.org/QEMU_v4.2.0-1858-gdb736e0437/system/q=
emu-cpu-models.html

        - - -

(Note to self: The comma-separated list of CPU models are not terribly
legible that they are all different CPU models.  Wonder if we should do
something about it...)

Kashyap Chamarthy (2):
  docs: Convert qemu-cpu-models.texi to rST; related fixes
  qemu-cpu-models.rst: Document -noTSX, mds-no, taa-no, and tsx-ctrl

 MAINTAINERS                     |   2 +-
 Makefile                        |  12 +-
 docs/conf.py                    |   2 +-
 docs/qemu-cpu-models.texi       | 677 --------------------------------
 docs/system/conf.py             |   5 +-
 docs/system/index.rst           |   1 +
 docs/system/qemu-cpu-models.rst | 535 +++++++++++++++++++++++++
 qemu-doc.texi                   |   5 -
 8 files changed, 548 insertions(+), 691 deletions(-)
 delete mode 100644 docs/qemu-cpu-models.texi
 create mode 100644 docs/system/qemu-cpu-models.rst

--=20
2.21.0



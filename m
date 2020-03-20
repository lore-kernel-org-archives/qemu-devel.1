Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14317C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 09:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE70A20739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 09:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjBZyenN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE70A20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFDoO-0001JT-VF
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 05:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jFDn9-0007qB-Vh
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jFDn8-00082C-BY
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:18:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22576)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jFDn8-00080j-73
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584695889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=E+53zgBxvJTB9v6VQiedjiaKoXm0h62HFm2n0D2LWxA=;
 b=MjBZyenNGzWQEbxlURndIPciU0Izc+zyDdIyD1drCFS+a6/HJupw8KOxNPS0jas3XVQ2kv
 odKepF1GwYh1BUKPSxkI1d35j3W/mio8u25hdmqRj57IgmUDtswAWxyM+cXua4nQpyxDvk
 JwAhjBXpXdjT1IhPL60mta480kzpuoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493--Yaht6GlP_66Kb_JkSH97w-1; Fri, 20 Mar 2020 05:18:07 -0400
X-MC-Unique: -Yaht6GlP_66Kb_JkSH97w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7A23800EBD;
 Fri, 20 Mar 2020 09:18:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 768EB1001925;
 Fri, 20 Mar 2020 09:18:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0607E1138404; Fri, 20 Mar 2020 10:18:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] qapi: A section heading bug fix, and maybe an improvement
Date: Fri, 20 Mar 2020 10:18:03 +0100
Message-Id: <20200320091805.5585-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: peter.maydell@linaro.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PATCH 1 fixes an old defect in the doc comment parser.  I figure it'll
simplify the rST generator's job.

PATCH 2 might simplify it further.  It's RFC because I'm not sure it
does.  Peter, you tell me :)


Markus Armbruster (2):
  qapi: Reject section markup in definition documentation
  [RFC] qapi: Make section headings start a new doc comment block

 docs/devel/qapi-code-gen.txt           |  2 ++
 scripts/qapi/parser.py                 | 24 +++++++++++++++++-------
 tests/qapi-schema/doc-bad-section.err  |  1 +
 tests/qapi-schema/doc-bad-section.json |  3 +--
 tests/qapi-schema/doc-bad-section.out  | 24 ------------------------
 tests/qapi-schema/doc-good.out         |  3 ++-
 6 files changed, 23 insertions(+), 34 deletions(-)

--=20
2.21.1



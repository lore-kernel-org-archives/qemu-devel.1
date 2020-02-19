Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200ACC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 12:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA2224654
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 12:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDXvMrrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA2224654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4O9C-0008DI-3F
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 07:08:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1j4O8L-0007CH-EF
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 07:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1j4O8J-0004b6-HK
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 07:07:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49690
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1j4O8J-0004aV-Ci
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 07:07:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582114034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PDFKHGdoEdLqa8HtIEqHvginBLOLITdXYm784cCIIFM=;
 b=fDXvMrrN5CVwG5VviOHJH3Q3qOW4oIz8yNHSeJmXY3/QhOsOZiaFS2OgjXVuzZTeZfqvxT
 +6eU3UrYzEVGboyP3ZNunbsCUCf2ZwtQ6vl5S0wpvz2uTeykws3MI2FDKpJr4iJRDRt1qn
 kqvJElKAObwbN3k+J/Oxyx9a8BszeKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-dOk3aU6MMO2o_8ANc0o8Mw-1; Wed, 19 Feb 2020 07:07:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 698AB801F9D;
 Wed, 19 Feb 2020 12:07:11 +0000 (UTC)
Received: from paraplu.localdomain (unknown [10.36.118.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 618563A5;
 Wed, 19 Feb 2020 12:07:04 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 6DD5F3E04F0; Wed, 19 Feb 2020 13:07:02 +0100 (CET)
Date: Wed, 19 Feb 2020 13:07:02 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Subject: qemu-cpu-models: Convert to rST; document other MSR bits [Was: Re:
 [PATCH v2 0/2] This small series does two things:]
Message-ID: <20200219120702.GX24572@paraplu>
References: <20200219114607.1855-1-kchamart@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200219114607.1855-1-kchamart@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: dOk3aU6MMO2o_8ANc0o8Mw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Fix the subject line of the cover letter; sorry, it was my first time
(mis-)use of `git-publish`.]

On Wed, Feb 19, 2020 at 12:46:05PM +0100, Kashyap Chamarthy wrote:
> (1) Convert the original qemu-cpu-models.texi to rST
>=20
> (2) In a separate patch, incorporate the additional new content from
>     this:
>     https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg06455.htm=
l
>     ([PATCH v3] qemu-cpu-models: Document -noTSX, mds-no, taa-no, and
>     tsx-ctrl)
>=20
> A Sphinx rendering of the converted doc is here:
>=20
>     https://kashyapc.fedorapeople.org/qemu_v4.2.0-1300-g5da20ed7e3_docs/s=
ystem/qemu-cpu-models.html
>=20
> Kashyap Chamarthy (2):
>   docs: Convert qemu-cpu-models.texi to rST
>   qemu-cpu-models.rst: Document -noTSX, mds-no, taa-no, and tsx-ctrl
>=20
>  docs/qemu-cpu-models.texi       | 677 --------------------------------
>  docs/system/index.rst           |   1 +
>  docs/system/qemu-cpu-models.rst | 547 ++++++++++++++++++++++++++
>  3 files changed, 548 insertions(+), 677 deletions(-)
>  delete mode 100644 docs/qemu-cpu-models.texi
>  create mode 100644 docs/system/qemu-cpu-models.rst
>=20
> --=20
> 2.21.0
>=20

--=20
/kashyap



Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018FEC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDCD620881
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCD620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhtBY-0001ip-4L
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 06:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55512)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ppandit@redhat.com>) id 1hht5P-0006TN-8Y
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1hht5N-000875-1l
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:58:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38424)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1hht5I-00080p-PD
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:58:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EF20A7FDC9;
 Mon,  1 Jul 2019 09:58:36 +0000 (UTC)
Received: from kaapi (unknown [10.33.36.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9315D7DF6A;
 Mon,  1 Jul 2019 09:58:32 +0000 (UTC)
Date: Mon, 1 Jul 2019 15:28:30 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
In-Reply-To: <20190701094353.GF3573@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1907011527460.31268@xnncv>
References: <20190701090904.31312-1-ppandit@redhat.com>
 <20190701090904.31312-2-ppandit@redhat.com>
 <20190701094353.GF3573@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 01 Jul 2019 09:58:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qemu-bridge-helper: restrict
 interface name to IFNAMSIZ
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
Cc: Riccardo Schirone <rschiron@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Mon, 1 Jul 2019, Daniel P. Berrang=C3=A9 wrote --+
| > +        if (strcmp(cmd, "include") && strlen(arg) >=3D IFNAMSIZ) {
| > +            fprintf(stderr, "name `%s' too long: %lu\n", arg, strlen=
(arg));
|=20
| strlen returns size_t, which does not match %lu - it needs %zu - we can
| ignore the non-portability of %zu to windows, since this code is UNIX
| only.
|=20
| I'd prefer also !g_str_equal(cmd, "include")  as to me it reads more
| easily.

Okay. Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F

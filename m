Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96410C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 05:48:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 693B5218DA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 05:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693B5218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqA8Z-0003ZH-Ks
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 01:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47343)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ppandit@redhat.com>) id 1hqA8P-0003BD-L6
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 01:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1hqA8O-0001YG-Me
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 01:48:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52438)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1hqA8O-0001XJ-Aq
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 01:48:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E055D3C938;
 Wed, 24 Jul 2019 05:48:14 +0000 (UTC)
Received: from kaapi (unknown [10.33.36.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D10760605;
 Wed, 24 Jul 2019 05:48:11 +0000 (UTC)
Date: Wed, 24 Jul 2019 11:18:09 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Stefan Hajnoczi <stefanha@gmail.com>
In-Reply-To: <CAKXe6S+pXN0d6K9Vw=kxsy51bVz1PxXBHYEmTesUnYo8u8vcYg@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1907241116470.10049@xnncv>
References: <20190723104754.29324-1-ppandit@redhat.com>
 <20190723104754.29324-4-ppandit@redhat.com>
 <20190723130326.GC5445@stefanha-x1.localdomain>
 <CAKXe6S+pXN0d6K9Vw=kxsy51bVz1PxXBHYEmTesUnYo8u8vcYg@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 24 Jul 2019 05:48:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v4 3/3] net: tap: replace snprintf with
 g_strdup_printf calls
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
Cc: =?ISO-8859-15?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Tue, 23 Jul 2019, Li Qiang wrote --+
| Stefan Hajnoczi <stefanha@gmail.com> =E4=BA=8E2019=E5=B9=B47=E6=9C=8823=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=889:03=E5=86=99=E9=81=93=EF=BC=
=9A
| > On Tue, Jul 23, 2019 at 04:17:54PM +0530, P J P wrote:
| > > -            snprintf(helper_cmd, sizeof(helper_cmd), "%s %s %s %s"=
,
| > > -                     helper, "--use-vnet", fd_buf, br_buf);
| > > +            helper_cmd =3D g_strdup_printf("%s %s %s %s", helper,
| > > +                            "--use-vnet", fd_buf, br_buf ? br_buf =
: "");
| >
| > The change to the br_buf argument isn't covered in the commit
| > description.  Why did you change this, was it a bug, etc?
|=20
| IIUC, if we pass the NULL argument in g_strdup_printf, the 'helper_cmd'=
 will=20
| contain the '(null)' char.

Yep, right.

| Reviewed-by: Li Qiang <liq3ea@gmail.com>

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F

Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D29C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 11:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA9F20674
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 11:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA9F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3IO2-0003I0-EU
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 07:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ppandit@redhat.com>) id 1i3INL-0002j1-6l
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 07:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1i3INJ-0008K3-0s
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 07:13:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36464)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>)
 id 1i3INI-0008If-RW; Thu, 29 Aug 2019 07:13:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7F5EF881341;
 Thu, 29 Aug 2019 11:13:55 +0000 (UTC)
Received: from kaapi (ovpn-116-71.ams2.redhat.com [10.36.116.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C40D5D712;
 Thu, 29 Aug 2019 11:13:44 +0000 (UTC)
Date: Thu, 29 Aug 2019 16:43:40 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Samuel Thibault <samuel.thibault@gnu.org>
In-Reply-To: <20190825225403.vwg2fhfff6i7gnwd@function>
Message-ID: <nycvar.YSQ.7.76.1908291635010.28885@xnncv>
References: <20190822144134.23521-1-philmd@redhat.com>
 <20190822144134.23521-2-philmd@redhat.com>
 <20190822183313.pptfwjsnrpdi6tfp@function>
 <14216968-a066-6abf-1952-3cff3aa3eee3@redhat.com>
 <20190825225403.vwg2fhfff6i7gnwd@function>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Thu, 29 Aug 2019 11:13:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Slirp] [PATCH 1/2] Do not reassemble fragments
 pointing outside of the original payload
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
Cc: slirp@lists.freedesktop.org, Petr Matousek <pmatouse@redhat.com>,
 Vishnu Dev TJ <vishnudevtj@gmail.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Mon, 26 Aug 2019, Samuel Thibault wrote --+
| Philippe Mathieu-Daud=C3=A9, le ven. 23 ao=C3=BBt 2019 17:15:32 +0200, =
a ecrit:
| > > Did you make your test with commit 126c04acbabd ("Fix heap overflow=
 in
| > > ip_reass on big packet input") applied?
| >=20
| > Yes, unfortunately it doesn't fix the issue.
|=20
| Ok.
|=20
| Could you try the attached patch?  There was a use-after-free.  Without
| it, I can indeed crash qemu with the given exploit.  With it I don't
| seem to be able to crash it (trying in a loop for several minutes).

Considering that earlier fix was released/pulled into upstream QEMU v4.1.=
0, we=20
need to treat this one as a separate issue.

   commit c59279437eda91841b9d26079c70b8a540d41204
   Author: Samuel Thibault <samuel.thibault@ens-lyon.org>
   Date:   Mon Aug 26 00:55:03 2019 +0200

   ip_reass: Fix use after free
  =20
   Using ip_deq after m_free might read pointers from an allocation reuse=
.

I'll follow-up on that.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F

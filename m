Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43F0C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B7FD2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7FD2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgqeN-0000ij-SG
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 09:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39750)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ppandit@redhat.com>) id 1hgqCR-0003ny-S1
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1hgqCQ-0007nO-6H
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:41:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45414)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1hgqCQ-0007mb-0D
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:41:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 57F4788306;
 Fri, 28 Jun 2019 12:03:07 +0000 (UTC)
Received: from kaapi (ovpn-116-191.sin2.redhat.com [10.67.116.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B660F5C5BB;
 Fri, 28 Jun 2019 12:02:53 +0000 (UTC)
Date: Fri, 28 Jun 2019 17:32:50 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
In-Reply-To: <20190628113220.GD23344@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1906281725370.18180@xnncv>
References: <20190628094901.13347-1-ppandit@redhat.com>
 <20190628110457.GA23344@redhat.com>
 <nycvar.YSQ.7.76.1906281639120.18180@xnncv>
 <20190628113220.GD23344@redhat.com>
MIME-Version: 1.0
Content-ID: <nycvar.YSQ.7.76.1906281726020.18180@xnncv>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 28 Jun 2019 12:03:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] qemu-bridge-helper: restrict bridge name
 to IFNAMSIZ
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
Cc: Riccardo Schirone <rschiron@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Fri, 28 Jun 2019, Daniel P. Berrang=E9 wrote --+
| Ok, so we should explicitly report an error if the user supplied bridge=
 name=20
| is too long, not silently truncate it.
|=20
| We should also report an error if config file has too long a bridge nam=
e.

Okay, ie. report error and exit?

+-- On Fri, 28 Jun 2019, Li Qiang wrote --+
| I think we should cleanup the bridge in the final.

I did free(bridge) first, it showed build error because 'bridge' is decla=
red=20
as const char *, not sure why, didn't want to make patch too intrusive. I=
f we=20
exit like Dan suggests above, guess it wouldn't be required.


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F

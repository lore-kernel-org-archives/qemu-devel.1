Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B24C5B57A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 12:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35BE72063F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 12:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BE72063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgqS1-00089W-Fx
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 08:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37476)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ppandit@redhat.com>) id 1hgq7g-00068P-QV
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1hgq7e-0005YM-Pl
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:37:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43450)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1hgq7d-0005Vf-G9
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:36:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A220D8553B
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 11:21:42 +0000 (UTC)
Received: from kaapi (ovpn-116-191.sin2.redhat.com [10.67.116.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 412D619C70;
 Fri, 28 Jun 2019 11:21:36 +0000 (UTC)
Date: Fri, 28 Jun 2019 16:51:31 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
In-Reply-To: <20190628110457.GA23344@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1906281639120.18180@xnncv>
References: <20190628094901.13347-1-ppandit@redhat.com>
 <20190628110457.GA23344@redhat.com>
MIME-Version: 1.0
Content-ID: <nycvar.YSQ.7.76.1906281642220.18180@xnncv>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 28 Jun 2019 11:21:42 +0000 (UTC)
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
Cc: Riccardo Schirone <rschiron@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Fri, 28 Jun 2019, Daniel P. Berrang=E9 wrote --+
| Can you elaborate on the way to exploit this as I'm not seeing
| any way that doesn't involve mis-configuration of the ACL
| config file data.

True, it depends on having an 'allow all' rule. If the bridge.conf had an=
=20
'allow all' rule below

=3D=3D
deny BridgeLength0xF
allow all
=3D=3D

And user supplied name as --br=3DBridgeLength0xFun

    if (strcmp(bridge, acl_rule->iface) =3D=3D 0) {

the strcmp(3) above would not match the deny ACL rule, because given brid=
ge=20
name is longer. And qemu-bridge-helper would go on to connect the tap dev=
ice=20
with a bridge that is configured to have access denied.


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F

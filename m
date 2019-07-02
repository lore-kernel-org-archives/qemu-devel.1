Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BD2C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC97206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC97206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiDrp-0003wr-Mn
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 04:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50813)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ppandit@redhat.com>) id 1hiDql-0003CL-ON
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1hiDqk-0001ki-6D
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:09:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37604)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1hiDqj-0001kH-DP
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:09:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D0AE130001E2;
 Tue,  2 Jul 2019 08:09:11 +0000 (UTC)
Received: from kaapi (ovpn-116-87.phx2.redhat.com [10.3.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47CD2F6CC;
 Tue,  2 Jul 2019 08:09:05 +0000 (UTC)
Date: Tue, 2 Jul 2019 13:38:58 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Li Qiang <liq3ea@gmail.com>
In-Reply-To: <CAKXe6SJTGdM9dE5uq+s5mEU87NiAjg-UH9u3xZTXE4M0i7g-Pw@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1907012308390.3639@xnncv>
References: <20190701123558.30512-1-ppandit@redhat.com>
 <20190701123558.30512-4-ppandit@redhat.com>
 <CAKXe6SJTGdM9dE5uq+s5mEU87NiAjg-UH9u3xZTXE4M0i7g-Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 02 Jul 2019 08:09:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 3/3] net: tap: refactor
 net_bridge_run_helper routine
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
 =?ISO-8859-15?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hello Li,

+-- On Mon, 1 Jul 2019, Li Qiang wrote --+
| You do two things here(avoid buffer formatting and get rid of calling 
| shell), I would suggest you split these into split patch.

Both are related, 'helper_cmd' formatting was used with the shell invocation 
as:

  helper_cmd = "qemu-bridge-helper --use-vnet --fd=sv[1] --br=bridge"
  execv("/bin/sh", "sh", "-c", helper_cmd, NULL);

The 'else' part wherein 'helper' is a /path/to/qemu-bridge-helper binary, it 
is invoked without shell "sh" and 'helper_cmd' formatting.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F


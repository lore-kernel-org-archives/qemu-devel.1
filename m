Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F7AC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 06:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B6FB20C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 06:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6FB20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvyce-0007Ju-Mw
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 02:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47191)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ppandit@redhat.com>) id 1hvybr-0006dX-3G
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:42:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1hvybq-0007wc-7E
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:42:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57508)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1hvybq-0007w2-27
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:42:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5CCBEC0546FC;
 Fri,  9 Aug 2019 06:42:41 +0000 (UTC)
Received: from kaapi (unknown [10.74.10.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55D37600CC;
 Fri,  9 Aug 2019 06:42:28 +0000 (UTC)
Date: Fri, 9 Aug 2019 12:12:21 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
In-Reply-To: <84440ce1-374d-e612-c7a9-184e55242ffe@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1908091211050.24050@xnncv>
References: <20190808090652.2478-1-ppandit@redhat.com>
 <39a5c98f-f402-2985-2d49-800e73f53f4f@redhat.com>
 <20190808134646.GA6915@amt.cnet>
 <84440ce1-374d-e612-c7a9-184e55242ffe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 09 Aug 2019 06:42:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2] scsi: lsi: exit infinite loop while
 executing script (CVE-2019-12068)
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
Cc: Fam Zheng <fam@euphon.net>, Marcelo Tosatti <mtosatti@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Bugs SysSec <bugs-syssec@rub.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+-- On Thu, 8 Aug 2019, Philippe Mathieu-Daud=C3=A9 wrote --+
| >>     trace_lsi_execute_script_tc_illegal();
| >>     lsi_script_dma_interrupt(s, LSI_DSTAT_IID);
|
| So we agree using DSTAT.IID is the correct thing to do. Any volunteer t=
o fix=20
| this? :)

Sent patch v3. Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F

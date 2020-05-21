Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0173C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 10:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F292072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 10:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apzkrkGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F292072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbi90-0006dJ-IG
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 06:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jbi8K-0005e0-HJ
 for qemu-devel@nongnu.org; Thu, 21 May 2020 06:09:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56452
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jbi8J-000858-If
 for qemu-devel@nongnu.org; Thu, 21 May 2020 06:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590055737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EE9RpIUk4k84fxKEl2qNdBkbibhOM4bc/KHygE+AhDg=;
 b=apzkrkGY7JE3nKGPY9UzYlyVRqR4eplOtb1qvPxlrZbWWbyANgYOqn4CyKJV+LaOtIsLtD
 rm5o4BpmwnzfjlFlfE1UGtYCquL4XAjD2FKkC5c9645I3YXqdMetoeq37i73IiyrAQvaEJ
 TF9HicrYdCSGYoz3vL1QgLdniuvXFLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-_FbL9MGSMe6GVEzEof7FMg-1; Thu, 21 May 2020 06:08:54 -0400
X-MC-Unique: _FbL9MGSMe6GVEzEof7FMg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 127EC1005512;
 Thu, 21 May 2020 10:08:53 +0000 (UTC)
Received: from kaapi (unknown [10.33.36.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56C8E105912E;
 Thu, 21 May 2020 10:08:47 +0000 (UTC)
Date: Thu, 21 May 2020 15:38:44 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 2/2] sd: disable sdhci-pci device by default
In-Reply-To: <431930bb-ac30-62fb-11f0-c388c0e9c763@redhat.com>
Message-ID: <nycvar.YSQ.7.77.849.2005211536510.62159@xnncv>
References: <20200520152450.200362-1-ppandit@redhat.com>
 <20200520152450.200362-3-ppandit@redhat.com>
 <CAFEAcA_WbJR9PWpw4f2jWecouSn7U0y9=0t4ek1rGwxtM6tXBQ@mail.gmail.com>
 <431930bb-ac30-62fb-11f0-c388c0e9c763@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed;
 boundary="-1463810047-1586791112-1590055732=:62159"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
---1463810047-1586791112-1590055732=:62159
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

+-- On Wed, 20 May 2020, Philippe Mathieu-Daudé wrote --+
| Prasad, I once tried to remove it, and Kevin said he was using it:
| 
| https://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg02765.html
| 
|   I do find qemu's PCI SDHCI support useful for testing.
|   SeaBIOS can launch an OS from PCI SDHCI (qemu-system-x86_64
|   -device sdhci-pci -device sd-card,drive=drive0 -drive
|   id=drive0,if=none,file=dos-drivec) and linux has drivers for
|   it as well.  A number of the Chromebooks ship with PCI SDHCI
|   devices on them, so it's not an unheard of configuration.
| 
| Prasad, again back at that time I tried to remove this (as the device appears
| unused) Paolo told me after asking explanation for his comment "PCI devices
| can be created with -device, they don't have to be added by
| boards." [*] - I guess it was on IRC - to check commit 224d10ff5ae, this
| device was added with RH PCI ID because it was useful for testing:
| 
|     ...
| 
| This device is also nicely used as example for the qgraph testing (see
| tests/test-qgraph.c added in fc281c80202).
| 
| [*] https://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg02819.html
| 
| Peter, indeed the Kconfig was added to allow distributions to disable piece of
| code, and we want to keep this device in mainstream QEMU.
| Distributions are free to disable it setting SDHCI_PCI=n
| 
| So to this patch:
| 
| Nack.

Right, okay. (I half expected it ;)

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
---1463810047-1586791112-1590055732=:62159--



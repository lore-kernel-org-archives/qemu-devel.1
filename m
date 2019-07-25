Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590E2C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA1322BF5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA1322BF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqc1I-0007YY-EN
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 07:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50734)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dovgaluk@ispras.ru>) id 1hqc10-0006Rh-D7
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1hqc0z-0001zr-Fv
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:34:30 -0400
Received: from mail.ispras.ru ([83.149.199.45]:48922)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1hqc0z-0001yF-7Z
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:34:29 -0400
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id DEF6E54006A;
 Thu, 25 Jul 2019 14:34:26 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: "'Paolo Bonzini'" <pbonzini@redhat.com>,
 "'Pavel Dovgalyuk'" <pavel.dovgaluk@gmail.com>, <qemu-devel@nongnu.org>
References: <156404424989.18669.12696116045723475173.stgit@pasha-Precision-3630-Tower>
 <156404429499.18669.13404064982854123855.stgit@pasha-Precision-3630-Tower>
 <ee05a066-194a-5a5b-7989-cb5690c85ebf@redhat.com>
In-Reply-To: <ee05a066-194a-5a5b-7989-cb5690c85ebf@redhat.com>
Date: Thu, 25 Jul 2019 14:34:29 +0300
Message-ID: <000d01d542dc$ec7a8b30$c56fa190$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: ru
Thread-Index: AdVC3Dsn99wHj9lLRrOKjDQE7NRuvAAAKKog
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: Re: [Qemu-devel] [for-4.2 PATCH v2 8/8] icount: remove unnecessary
 gen_io_end calls
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com,
 crosthwaite.peter@gmail.com, armbru@redhat.com, mreitz@redhat.com,
 alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com,
 kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com,
 artem.k.pisarenko@gmail.com, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 25/07/19 10:44, Pavel Dovgalyuk wrote:
> > Prior patch resets can_do_io flag at the TB entry. Therefore there is no
> > need in resetting this flag at the end of the block.
> > This patch removes redundant gen_io_end calls.
> 
> Nice.  I don't think the comments are particularly useful, I'll move
> them to gen-icount.h if you agree.

Ok, thanks.

Pavel Dovgalyuk



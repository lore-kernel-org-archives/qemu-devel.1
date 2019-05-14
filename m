Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A49C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 11:34:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 292EF208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 11:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292EF208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46061 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQVhx-0007PB-C4
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 07:34:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1hQVgd-0006o8-18
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1hQVgc-0002G3-1r
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:33:35 -0400
Received: from mail.ispras.ru ([83.149.199.45]:47480)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1hQVgb-0002ET-R0
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:33:34 -0400
Received: from PASHAISP (unknown [85.142.117.226])
	by mail.ispras.ru (Postfix) with ESMTPSA id 7BE2B540089;
	Tue, 14 May 2019 14:33:30 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: "'Markus Armbruster'" <armbru@redhat.com>
References: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>	<004401d503db$9e66b530$db341f90$@ru>
	<874l669lnw.fsf@dusky.pond.sub.org>
In-Reply-To: <874l669lnw.fsf@dusky.pond.sub.org>
Date: Tue, 14 May 2019 14:33:31 +0300
Message-ID: <000f01d50a48$dc15d8c0$94418a40$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdUFAMPGVd4vdh7iRGmcsZHWzLMgVQFR5bTA
Content-Language: ru
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: Re: [Qemu-devel] [PATCH for-4.1 00/24] Fix record/replay and add
 reverse debugging
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com,
	boost.lists@gmail.com, artem.k.pisarenko@gmail.com,
	crosthwaite.peter@gmail.com, ciro.santilli@gmail.com,
	jasowang@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
	mreitz@redhat.com, 'Pavel Dovgalyuk' <pavel.dovgaluk@gmail.com>,
	maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com,
	pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com,
	pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com,
	rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Markus Armbruster [mailto:armbru@redhat.com]
> "Pavel Dovgalyuk" <dovgaluk@ispras.ru> writes:
> 
> > Ping.
> > Can anyone PULL these patches?
> 
> Paolo?

Is there anything new?

Pavel Dovgalyuk



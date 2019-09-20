Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50275C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:42:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19BB42086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="aFLvXoCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BB42086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBFRI-0005kW-AR
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 05:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhlb29@foxmail.com>) id 1iBFP6-0002c0-OX
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhlb29@foxmail.com>) id 1iBFOy-0004lg-Le
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:40:33 -0400
Received: from smtpbgbr2.qq.com ([54.207.22.56]:50813)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhlb29@foxmail.com>) id 1iBFOx-0004ii-65
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1568972404;
 bh=7pLhU3ylNn7j5ugZL0+4F5IeDPvTpaRHU1EOVwvDcDs=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=aFLvXoCzk9a7baNpLcWnAk/2tfjuQAGG8gmzWdVjkfUpaBUk47noPKDZlTahIAJpa
 nvZMFS/+HAis8B1bYEvfUkIS0UPxdGGjAeMDdwsbkhnXHjZXlSh8op9cOcWb7DIUrH
 2Tn1CEj3lhygpl1zX4G3Ov3l3UbQHOb8ydZBnIe8=
X-QQ-SSF: 00000000000000F000000000000000G
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 124.200.70.7
X-QQ-STYLE: 
X-QQ-mid: webenglish1t1568972402t223835
From: "=?ISO-8859-1?B?TGlibyBaaG91?=" <zhlb29@foxmail.com>
To: "=?ISO-8859-1?B?cWVtdS1kZXZlbA==?=" <qemu-devel@nongnu.org>
Subject: Initialize data memory in user space emulation 
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date: Fri, 20 Sep 2019 17:40:02 +0800
X-Priority: 3
Message-ID: <tencent_2E230C3B4383FB605550C90D@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Fri, 20 Sep 2019 17:40:03 +0800 (CST)
Feedback-ID: webenglish:foxmail.com:bgforeign:bgforeign4
X-QQ-Bgrelay: 1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 54.207.22.56
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgYWxsLAoKSSBuZWVkIGEgd2F5IHRvIG1hbmlwdWxhdGUgZGF0YSBzYXZlZCBpbiBhIHJl
c2VydmVkIG1lbW9yeSByZWdpb24gaW4gbGludXggdXNlciBzcGFjZSBlbXVsYXRpb24uIEkg
Zm91bmQgdGhlIC1CIG9wdGlvbiB2ZXJ5IHByb21pc2luZy4gIERvY3VtZW50YXRpb24gc2F5
cyBpdCBpcyB1c2VmdWwgd2hlbiB0aGUgYWRkcmVzcyByZWdpb24gcmVxdWlyZWQgYnkgZ3Vl
c3QgYXBwbGljYXRpb25zIGlzIHJlc2VydmVkIG9uIHRoZSBob3N0LgoKQnV0IGhvdyBjYW4g
SSBpbml0aWFsaXplIHRoYXQgbWVtb3J5IHdpdGggZGF0YT8KClRoYW5rcywKTGlibyBaaG91






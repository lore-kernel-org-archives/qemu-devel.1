Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D76C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 13:08:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B0620720
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 13:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fudan.edu.cn header.i=@fudan.edu.cn header.b="ml9vL1Pw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B0620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=fudan.edu.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juFFE-0005Pk-BB
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 09:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <19210240159@fudan.edu.cn>)
 id 1juEcF-0005VE-9I
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 08:28:27 -0400
Received: from mail.fudan.edu.cn ([202.120.224.73]:38955 helo=fudan.edu.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <19210240159@fudan.edu.cn>) id 1juEc1-0006fG-Kl
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 08:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fudan.edu.cn; s=dkim; h=Received:Date:From:To:Subject:
 Content-Type:MIME-Version:Message-ID; bh=WCqurNbaTRsOrWKbMJoed5D
 C15Ua91RIq2C6TBBQHYc=; b=ml9vL1PwanSL95PayiDIHHK0ykos6s2qjs80tVb
 p05a8YcxlIr4cBbs8A1RAgvEa0f56SWZE7M9iZGWwCBZ27jMXjkv8wa7jod/xpra
 HBRNb7kd7scL5HRF7tta4CBYi5sRhQKTwd3jBePpYnmf8IluUmTqDs+3Cb9Yzyhg
 PP4k=
Received: by ajax-webmail-app2 (Coremail) ; Sat, 11 Jul 2020 20:28:02 +0800
 (GMT+08:00)
X-Originating-IP: [39.191.9.201]
Date: Sat, 11 Jul 2020 20:28:02 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?5p6X5aWV5biG?= <19210240159@fudan.edu.cn>
To: qemu-devel@nongnu.org
Subject: cve patch wanted
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT3.0.8 dev build
 20190909(dad6f454) Copyright (c) 2002-2020 www.mailtech.cn fudan.edu.cn
X-SendMailWithSms: false
X-CM-CTRLDATA: Eo68DmZvb3Rlcl9odG09MjQyOjE0JmZvb3Rlcl90eHQ9MjIyOjEw
Content-Type: multipart/alternative; 
 boundary="----=_Part_105418_199813722.1594470482194"
MIME-Version: 1.0
Message-ID: <42a0ee9.78e1.1733dd8c113.Coremail.19210240159@fudan.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: XQUFCgD3XwNSsAlfoXGRAQ--.25835W
X-CM-SenderInfo: irzsiiysuqikmz6i3vldqovvfxof0/1tbiAQ8OB1Kp4eF-ngAAsd
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
Received-SPF: pass client-ip=202.120.224.73;
 envelope-from=19210240159@fudan.edu.cn; helo=fudan.edu.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/11 08:28:03
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_LOCAL_DIGITS=0.001, FROM_LOCAL_HEX=0.006, HTML_MESSAGE=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 11 Jul 2020 09:07:52 -0400
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

------=_Part_105418_199813722.1594470482194
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGVsbG8KICAgSSBhbSBhIHN0dWRlbnQgZnJvbSBGdWRhbiBVbml2ZXJzaXR5IGluIENoaW5hLiBJ
IGFtIGRvaW5nIHJlc2VhcmNoIG9uIENWRSBwYXRjaCByZWNlbnRseS4gQnV0IGkgY2FuIG5vdCBm
aW5kIHRoZSBQQVRDSCBDT01NSVQgb2YgQ1ZFLTIwMTktMTIyNDcgY3ZlLTIwMTktMTIxNTUgY3Zl
LTIwMTktNjc3OC5DYW4geW91IGdpdmUgbWUgdGhlIGNvbW1pdCBmaXggdGhpcyBjdmU/DQoNCg0K
DQoNCg==
------=_Part_105418_199813722.1594470482194
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

SGVsbG88ZGl2PiZuYnNwOyAmbmJzcDtJIGFtIGEgc3R1ZGVudCBmcm9tIEZ1ZGFuIFVuaXZlcnNp
dHkgaW4gQ2hpbmEuIEkgYW0gZG9pbmcgcmVzZWFyY2ggb24gQ1ZFIHBhdGNoIHJlY2VudGx5LiBC
dXQgaSBjYW4gbm90IGZpbmQgdGhlIFBBVENIIENPTU1JVCBvZiBDVkUtMjAxOS0xMjI0NyBjdmUt
MjAxOS0xMjE1NSBjdmUtMjAxOS02Nzc4LkNhbiB5b3UgZ2l2ZSBtZSB0aGUgY29tbWl0IGZpeCB0
aGlzIGN2ZT88L2Rpdj48YnI+PGJyPg0KDQoNCg==
------=_Part_105418_199813722.1594470482194--



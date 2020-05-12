Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E62C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C49320733
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SIGL2o7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C49320733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qq.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYPXe-0002BT-Eo
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 03:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1482995675@qq.com>) id 1jYPWx-0001le-OK
 for qemu-devel@nongnu.org; Tue, 12 May 2020 03:40:47 -0400
Received: from smtpbg513.qq.com ([203.205.250.40]:45983 helo=smtpbg.qq.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1482995675@qq.com>) id 1jYPWs-0008V5-Jf
 for qemu-devel@nongnu.org; Tue, 12 May 2020 03:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1589269231; bh=Z7vIBCI0Hpo0rXirXHNrlp+srm8kXrqXEKq+jZeyIjE=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=SIGL2o7NQAC525m27NBb5KkQVcTvOqEiHg52KIBYr8b1pfMyLhv1mqe3L/n6e/Won
 p9Y0wuU8BkrJogqUqLtWhTps4UHE+d/GuJseD5SBef27JAr02WYJNg99DIVLmnc+3W
 Fwm76T7oio/hbChQI9W0xWAmSd9Fipm32ZO5bJVk=
X-QQ-FEAT: LukZvA942xBJrFwvtBfn5/oaK4AEifvbAeukkS7llZmZ3Wku5A1Y8FlWfzvwj
 7/n6IXiFG6eKhmM1srXzgUfvqHWHqAiL2Av2w1iDpePV7lBpq24tZOFRsHTgjYfdyxp/uTR
 Cu3bBeoJzvXkD6DFNSPuEFO/Q759Y7uUgmT058B+f00Rd51pxObhtWvQei284CpljLm0KgG
 SG4MHYpSOOICw9S2kFMyP0yr2m0lDg6YG8HBDxlxlqArw+xadHt3x4ZHuhbMK6dQ7mpNZDH
 vZtw==
X-QQ-SSF: 00010000000000F000000000000000D
X-QQ-XMAILINFO: Murorf+dkePAtFDFyueoWouGripxu5QNbf4mWUgftnRKe0S8IyCiO97MQfdrHk
 1OyrxSFXlV+kxQdaN+6z/DFrvXg6wMocQMKYqY9BvJwwF5fd/LrVLuofytf7cAclnjfIA1/6J2aZ2
 bxRSrREEcScLfuj/KBVdKNyE4zVNJfj8bEI3wW2fj8ViUDjseBsFtLbIrksgtj+oX6D4Hw2ItUqZl
 r0J1p2zUYxC/6NCyN27WarNUzLtTqyHYoVTEwEnmtQzLOIUqgjSoBm3BnkcD3Ad0ssdnKDCobyBIG
 SmZPguv9pNYW2/dP9IlF9Lf14YYR4rFlR4+yKpmWv/eYMWxMR1EKCX7NMipkp7cn8uoteSLN1vJTi
 Gim86SbjnAe8yja2lxfRYyUd1n6wFk7TjMkwfVRg0sRh1VwSST+f7O7WD7+jy5f5pIBNjxqaAanQ0
 P8Glfvtyib2EtRJJWve7jXb90BYqQUDZPxL2YRYZ6tyW2vpWMmXqdJQmOrXg68/GnyiuGHHrqkJZ2
 dcpagSdv431Tpf6iY7JQqLmbiao7BY/JPINHdqOuF5Xb14yl3xSKgXVcyUe6JChvSY+FtXxn9wtpR
 a3KYbtvknb6NmdG08n5cmmhSLcImVxIMGoMbwHDh+Ki3YhsWBeK90ZxWugDq/a7DQu3XiQZXwxNm8
 7L0O7q
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 124.64.24.103
X-QQ-STYLE: 
X-QQ-mid: webmail725t1589269230t7615156
From: "=?ISO-8859-1?B?eGlhb2xlaQ==?=" <1482995675@qq.com>
To: "=?ISO-8859-1?B?cWVtdS1kZXZlbA==?=" <qemu-devel@nongnu.org>
Subject: how to extend to load COFF executable image file 
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date: Tue, 12 May 2020 15:40:30 +0800
X-Priority: 3
Message-ID: <tencent_A0D32CA7B0D4D56FF2B2182DAA3EB6BC6508@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Tue, 12 May 2020 15:40:31 +0800 (CST)
Feedback-ID: webmail:qq.com:bgweb:bgweb4
Received-SPF: pass client-ip=203.205.250.40; envelope-from=1482995675@qq.com;
 helo=smtpbg.qq.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 03:40:32
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_EXCESS_BASE64=0.979,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgYWxsLAogIEkgYXR0ZW1wdCB0byBhZGQgRFNQIGFyY2hpdGVjdHVyZSBzdXBwb3J0IGZv
ciBzb21lIFRJIHByb2Nlc3NvciwgYmFzZWQgb24gUUVNVSA0LjIuCiAgV2hlbiBJIHdvcmsg
b24gdGhlIGV4ZWN1dGFibGUgZmlsZSBsb2FkaW5nICwgSSB0cnkgdG8gbG9hZCBDT0ZGIGV4
ZWN1dGFibGUgIGZpbGUuIEZvbGxvd2luZyB0aGUgRUxGIGZpbGUgcHJvY2Vzc2luZyBzY2hl
bWUsIEkgdGhvdWdodCBJIGNvdWxkIHdyaXRlIGEgZnVuY3Rpb24gc2ltaWxhciB0byA6CiAg
ICAgICByb21fYWRkX2VsZl9wcm9ncmFtKGxhYmVsLCBtYXBwZWRfZmlsZSwgZGF0YSwgZmls
ZV9zaXplLCBtZW1fc2l6ZSwgYWRkciwgYXMpOwogIEJ1dCBJIGdvdCBsb3N0IHdoZW4gSSB0
cmFjayBkb3duIHRoZSB1c2FnZSB0byB0aGUgZ2xvYmFsIHZhcmlhYmxlICA6c3RhdGljIFFU
QUlMUV9IRUFEKCwgUm9tKSByb21zOwogIEkgZGlkIG5vdCBnZXQgd2hlcmUgdGhpcyAncm9t
cycgIGlzIHVzZWQgZm9yIHByb2dyYW0gbG9hZGluZywgYW5kIGhvdyB0aGUgbG9hZGVkIHBy
b2dyYW0gZ2V0IHRvIHJ1biBldmVudHVhbGx5LiAgQ2FuIHNvbWVvbmUgZ2l2ZSBtZSBzb21l
IGhpbnRzPwoKICBBbHNvLCB0aGUgQ09GRiBmaWxlIGZvcm1hdCBkaWZmZXJzIGZyb20gdGhl
IEVMRiwgdGhlcmUgaXMgbm8gcHJvZ3JhbSBoZWFkZXIuIEkgd29uZGVyIGlmIEkgY291bGQg
cmV1c2UgdGhlICdyb20nIHN0cnVjdHVyZSBsaWtlIGxvYWRpbmcgYSBFTEYuIE9yIHRoZXJl
IGlzIGEgYmV0dGVyIHdheSB0byBkbyBpdC4KCnN0cnVjdCBSb20gewogICAgY2hhciAqbmFt
ZTsKICAgIGNoYXIgKnBhdGg7CgogICAgLyogZGF0YXNpemUgaXMgdGhlIGFtb3VudCBvZiBt
ZW1vcnkgYWxsb2NhdGVkIGluICJkYXRhIi4gSWYgZGF0YXNpemUgaXMgbGVzcwogICAgICog
dGhhbiByb21zaXplLCBpdCBtZWFucyB0aGF0IHRoZSBhcmVhIGZyb20gZGF0YXNpemUgdG8g
cm9tc2l6ZSBpcyBmaWxsZWQKICAgICAqIHdpdGggemVyb3MuCiAgICAgKi8KICAgIHNpemVf
dCByb21zaXplOyAgICAgIC8vP2hvdyB0byBmaWxsIHJvbXNpemUgZm9yIGNvZmYgZmlsZSAK
ICAgIHNpemVfdCBkYXRhc2l6ZTsgICAgLy8/aG93IHRvIGZpbGwgZGF0YXNpemUgZm9yIGNv
ZmYgZmlsZSAKICAgIHVpbnQ4X3QgKmRhdGE7ICAgICAgLy8/IGZvciBjb2ZmIGZpbGUgCiAg
ICBNZW1vcnlSZWdpb24gKm1yOwogICAgQWRkcmVzc1NwYWNlICphczsKICAgIGludCBpc3Jv
bTsKICAgIGNoYXIgKmZ3X2RpcjsKICAgIGNoYXIgKmZ3X2ZpbGU7CiAgICBHTWFwcGVkRmls
ZSAqbWFwcGVkX2ZpbGU7CiAgICBib29sIGNvbW1pdHRlZDsKICAgIGh3YWRkciBhZGRyOwog
ICAgUVRBSUxRX0VOVFJZKFJvbSkgbmV4dDsKfTsgCiAgICBBbnkgYWR2aXNlIHdvdWxkIGJl
IGFwcHJlY2lhdGVkISEKCnJlZ2FyZHMsCgp4aWFvbGVpIGN1aQ==



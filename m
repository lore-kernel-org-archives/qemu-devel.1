Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9408DC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C162166E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADZUgDk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C162166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFZzN-0004wB-4j
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 05:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFZyM-0003Ql-9R
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:31:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55841
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFZyJ-0001w0-O2
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599557486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HJ79G03FlqlrUugYcwO7HWydjJ0d8ZaK+oD2oFYuAxc=;
 b=ADZUgDk+Xh5iJ2H0831wHFdRS/VJ8rOlZQMw2PXL3Od4tZHJAbBjVmODzwDZkNM5IQ0pub
 vvMtEMwruxcR6v8DaLmWiwAFxmMhvDWj6FpJY8BCGB+m2LIy3NZwDAXDrOzjnKQgHWqO6+
 X/nu9HwQrHWPseGJXkEs/tlpIt6msKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-mJXQ4KYDMiqrqspIqJ7N2Q-1; Tue, 08 Sep 2020 05:31:24 -0400
X-MC-Unique: mJXQ4KYDMiqrqspIqJ7N2Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B8D980734C;
 Tue,  8 Sep 2020 09:31:23 +0000 (UTC)
Received: from localhost (ovpn-114-244.ams2.redhat.com [10.36.114.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A84827C29;
 Tue,  8 Sep 2020 09:31:20 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] docs: lift block-core.json rST header into parents
Date: Tue,  8 Sep 2020 10:31:10 +0100
Message-Id: <20200908093113.47564-2-stefanha@redhat.com>
In-Reply-To: <20200908093113.47564-1-stefanha@redhat.com>
References: <20200908093113.47564-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Kashyap Chamarthy <kchamart@redhat.com>,
 afrosi@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

YmxvY2stY29yZS5qc29uIGlzIGluY2x1ZGVkIGZyb20gc2V2ZXJhbCBwbGFjZXMuIEl0IGhhcyBu
byB3YXkgb2YKa25vd2luZyB3aGF0IGhlYWRlciBsZXZlbCAoaDEsIGgyLCAuLi4pIGlzIGFwcHJv
cHJpYXRlLiBTcGhpbnggcmVwb3J0cwplcnJvcnMgd2hlbiBpdCBlbmNvdW50ZXJzIGFuIGgyIGhl
YWRlciB3aGVyZSBpdCBleHBlY3RzIGFuIGgxIGhlYWRlci4KVGhpcyBpc3N1ZSBwcmV2ZW50cyB0
aGUgbmV4dCBwYXRjaCBmcm9tIGdlbmVyYXRpbmcgZG9jdW1lbnRhdGlvbiBmb3IKcWVtdS1zdG9y
YWdlLWRhZW1vbiBRTVAgY29tbWFuZHMuCgpNb3ZlIHRoZSBoZWFkZXIgaW50byBwYXJlbnRzIHNv
IHRoYXQgdGhlIGNvcnJlY3QgaGVhZGVyIGxldmVsIGNhbiBiZQp1c2VkLiBOb3RlIHRoYXQgdHJh
bnNhY3Rpb24uanNvbiBpcyBub3QgdXBkYXRlZCBzaW5jZSBpdCBkb2Vzbid0IHNlZW0gdG8KbmVl
ZCBhIGhlYWRlci4KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVk
aGF0LmNvbT4KLS0tCiBkb2NzL2ludGVyb3AvZmlybXdhcmUuanNvbiB8IDQgKysrKwogcWFwaS9i
bG9jay1jb3JlLmpzb24gICAgICAgfCA0IC0tLS0KIHFhcGkvYmxvY2suanNvbiAgICAgICAgICAg
IHwgMSArCiAzIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kb2NzL2ludGVyb3AvZmlybXdhcmUuanNvbiBiL2RvY3MvaW50ZXJvcC9m
aXJtd2FyZS5qc29uCmluZGV4IDk4OWYxMGI2MjYuLjQ4YWYzMjdmOTggMTAwNjQ0Ci0tLSBhL2Rv
Y3MvaW50ZXJvcC9maXJtd2FyZS5qc29uCisrKyBiL2RvY3MvaW50ZXJvcC9maXJtd2FyZS5qc29u
CkBAIC0xNSw2ICsxNSwxMCBAQAogIyMKIAogeyAnaW5jbHVkZScgOiAnbWFjaGluZS5qc29uJyB9
CisKKyMjCisjID09IEJsb2NrIGRldmljZXMKKyMjCiB7ICdpbmNsdWRlJyA6ICdibG9jay1jb3Jl
Lmpzb24nIH0KIAogIyMKZGlmZiAtLWdpdCBhL3FhcGkvYmxvY2stY29yZS5qc29uIGIvcWFwaS9i
bG9jay1jb3JlLmpzb24KaW5kZXggNTViNThiYTg5Mi4uZTk4NjM0MTk5NyAxMDA2NDQKLS0tIGEv
cWFwaS9ibG9jay1jb3JlLmpzb24KKysrIGIvcWFwaS9ibG9jay1jb3JlLmpzb24KQEAgLTEsMTAg
KzEsNiBAQAogIyAtKi0gTW9kZTogUHl0aG9uIC0qLQogIyB2aW06IGZpbGV0eXBlPXB5dGhvbgog
Ci0jIwotIyA9PSBCbG9jayBjb3JlIChWTSB1bnJlbGF0ZWQpCi0jIwotCiB7ICdpbmNsdWRlJzog
J2NvbW1vbi5qc29uJyB9CiB7ICdpbmNsdWRlJzogJ2NyeXB0by5qc29uJyB9CiB7ICdpbmNsdWRl
JzogJ2pvYi5qc29uJyB9CmRpZmYgLS1naXQgYS9xYXBpL2Jsb2NrLmpzb24gYi9xYXBpL2Jsb2Nr
Lmpzb24KaW5kZXggYzU0YTM5M2NmMy4uNDczYjI5NGEzYiAxMDA2NDQKLS0tIGEvcWFwaS9ibG9j
ay5qc29uCisrKyBiL3FhcGkvYmxvY2suanNvbgpAQCAtMyw2ICszLDcgQEAKIAogIyMKICMgPSBC
bG9jayBkZXZpY2VzCisjID09IEJsb2NrIGNvcmUgKFZNIHVucmVsYXRlZCkKICMjCiAKIHsgJ2lu
Y2x1ZGUnOiAnYmxvY2stY29yZS5qc29uJyB9Ci0tIAoyLjI2LjIKCg==



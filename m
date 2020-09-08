Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDF2C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:30:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A0102166E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGvMR5Rf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0102166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFY5a-0002gH-2c
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 03:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFY4h-0001Bc-0G
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:29:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54392
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFY4e-0003jo-0g
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599550190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4qjgmT+2PpqDhz2Kw7+V76zyEdF2wqZ/WDAPe2ZVP5I=;
 b=aGvMR5RfDR0wH4D27ZO3rwoinjUz3hJgdTo/mg85hT8nKAXQvQmXT+lRr/f7pbC2w9YB/t
 8sMWU7vZEoHpjr1QZtIwOC07wFqbfKuxzm2vJ9sscn9m+AzT92umDZ4TxM1TCWyLBs5DIT
 CmFIWPZlycKZn691ucfHP+xlGEI3UEc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-5SMpaElqOb2G9slCeO238Q-1; Tue, 08 Sep 2020 03:29:47 -0400
X-MC-Unique: 5SMpaElqOb2G9slCeO238Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E04F18B9ECB
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 07:29:46 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-122.ams2.redhat.com
 [10.36.112.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FCFA811BC;
 Tue,  8 Sep 2020 07:29:45 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu devel list <qemu-devel@nongnu.org>
Subject: [PATCH 01/10] Makefile: remove obsolete edk2 exception from "clean"
 rule
Date: Tue,  8 Sep 2020 09:29:30 +0200
Message-Id: <20200908072939.30178-2-lersek@redhat.com>
In-Reply-To: <20200908072939.30178-1-lersek@redhat.com>
References: <20200908072939.30178-1-lersek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZpbGUgIkJhc2VUb29scy9Tb3VyY2UvUHl0aG9uL1VQVC9EbGwvc3FsaXRlMy5kbGwiIHdh
cyByZW1vdmVkIGluIGVkazIKY29tbWl0IDI2ZTJiMjk1ZWM3YSAoIkJhc2VUb29sczpSZW1vdmUg
dW51c2VkCkJhc2VUb29sc1xTb3VyY2VcUHl0aG9uXFVQVFxEbGwiLCAyMDE5LTA1LTA4KSwgcGFy
dCBvZiBlZGsyLXN0YWJsZTIwMTkwNSwKc28gc2tpcHBpbmcgaXQgaW4gdGhlIG91dGVybW9zdCBp
bi10cmVlICJjbGVhbiIgcnVsZSBpcyB1bm5lY2Vzc2FyeS4KClJlbW92ZSB0aGUgb2Jzb2xldGUg
cGF0aG5hbWUgcmVmZXJlbmNlLgoKQ2M6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRA
cmVkaGF0LmNvbT4KUmVmOiBodHRwczovL2J1Z3MubGF1bmNocGFkLm5ldC9xZW11LytidWcvMTg1
MjE5NgpTaWduZWQtb2ZmLWJ5OiBMYXN6bG8gRXJzZWsgPGxlcnNla0ByZWRoYXQuY29tPgotLS0K
IE1ha2VmaWxlIHwgMSAtCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL01ha2VmaWxlIGIvTWFrZWZpbGUKaW5kZXggZWQzNTRjNDNiMGJhLi40ODVmNTZkMzM2ZmUg
MTAwNjQ0Ci0tLSBhL01ha2VmaWxlCisrKyBiL01ha2VmaWxlCkBAIC0yMDEsNyArMjAxLDYgQEAg
Y2xlYW46IHJlY3Vyc2UtY2xlYW4gbmluamEtY2xlYW4gY2xlYW4tY3RsaXN0CiAJZmluZCAuIFwo
IC1uYW1lICcqLnNvJyAtbyAtbmFtZSAnKi5kbGwnIC1vIC1uYW1lICcqLltvZGFdJyBcKSAtdHlw
ZSBmIFwKIAkJISAtcGF0aCAuL3JvbXMvZWRrMi9Bcm1Qa2cvTGlicmFyeS9HY2NMdG8vbGlibHRv
LWFhcmNoNjQuYSBcCiAJCSEgLXBhdGggLi9yb21zL2VkazIvQXJtUGtnL0xpYnJhcnkvR2NjTHRv
L2xpYmx0by1hcm0uYSBcCi0JCSEgLXBhdGggLi9yb21zL2VkazIvQmFzZVRvb2xzL1NvdXJjZS9Q
eXRob24vVVBUL0RsbC9zcWxpdGUzLmRsbCBcCiAJCS1leGVjIHJtIHt9ICsKIAlybSAtZiBUQUdT
IGNzY29wZS4qICoucG9kICp+ICovKn4KIAlybSAtZiBmc2Rldi8qLnBvZCBzY3NpLyoucG9kCi0t
IAoyLjE5LjEuMy5nMzAyNDdhYTVkMjAxCgoK



Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1B0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:02:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857C92075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 08:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8yReCEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857C92075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaxCy-0005tq-MZ
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 04:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jaxBp-0004C6-QO
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:01:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39779
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jaxBo-0001ZN-HX
 for qemu-devel@nongnu.org; Tue, 19 May 2020 04:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589875287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p18x6C54SGKmxq+JayRm7gDnKXzElPntaH2y58zMtes=;
 b=O8yReCElC0IuRl8qHABAfC0/MPitONK6robldWjdzuWrUiO4UHPzDih2BciKTZknmBkJAa
 5ehjWbp6g5OWCOd8VMNVgb+JoigPoOzAJeKVi9xgUEDzNjGnGYAeWfvXmBc8H+WE6DIt0i
 kn+827NAtUdBQYkiaMAWcpMihqo/Grs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-0TcB_bctNS2iB2XueUERTA-1; Tue, 19 May 2020 04:01:25 -0400
X-MC-Unique: 0TcB_bctNS2iB2XueUERTA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E31783DB37;
 Tue, 19 May 2020 08:01:24 +0000 (UTC)
Received: from localhost (ovpn-114-215.ams2.redhat.com [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44E205D9DD;
 Tue, 19 May 2020 08:01:21 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/8] tests/fuzz: Add missing space in test description
Date: Tue, 19 May 2020 09:00:49 +0100
Message-Id: <20200519080054.146495-4-stefanha@redhat.com>
In-Reply-To: <20200519080054.146495-1-stefanha@redhat.com>
References: <20200519080054.146495-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKU2lnbmVk
LW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgpNZXNz
YWdlLWlkOiAyMDIwMDUxNDE0MzQzMy4xODU2OS00LXBoaWxtZEByZWRoYXQuY29tClNpZ25lZC1v
ZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiB0ZXN0cy9x
dGVzdC9mdXp6L2k0NDBmeF9mdXp6LmMgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0cy9xdGVzdC9mdXp6
L2k0NDBmeF9mdXp6LmMgYi90ZXN0cy9xdGVzdC9mdXp6L2k0NDBmeF9mdXp6LmMKaW5kZXggYWI1
ZjExMjU4NC4uOTZmZWQ5ZmYxMiAxMDA2NDQKLS0tIGEvdGVzdHMvcXRlc3QvZnV6ei9pNDQwZnhf
ZnV6ei5jCisrKyBiL3Rlc3RzL3F0ZXN0L2Z1enovaTQ0MGZ4X2Z1enouYwpAQCAtMTU5LDcgKzE1
OSw3IEBAIHN0YXRpYyB2b2lkIHJlZ2lzdGVyX3BjaV9mdXp6X3RhcmdldHModm9pZCkKICAgICAv
KiBVc2VzIHNpbXBsZSBxdGVzdCBjb21tYW5kcyBhbmQgcmVib290cyB0byByZXNldCBzdGF0ZSAq
LwogICAgIGZ1enpfYWRkX3RhcmdldCgmKEZ1enpUYXJnZXQpewogICAgICAgICAgICAgICAgIC5u
YW1lID0gImk0NDBmeC1xdGVzdC1yZWJvb3QtZnV6eiIsCi0gICAgICAgICAgICAgICAgLmRlc2Ny
aXB0aW9uID0gIkZ1enogdGhlIGk0NDBmeCB1c2luZyByYXcgcXRlc3QgY29tbWFuZHMgYW5kIgor
ICAgICAgICAgICAgICAgIC5kZXNjcmlwdGlvbiA9ICJGdXp6IHRoZSBpNDQwZnggdXNpbmcgcmF3
IHF0ZXN0IGNvbW1hbmRzIGFuZCAiCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInJl
Ym9vdGluZyBhZnRlciBlYWNoIHJ1biIsCiAgICAgICAgICAgICAgICAgLmdldF9pbml0X2NtZGxp
bmUgPSBpNDQwZnhfYXJndiwKICAgICAgICAgICAgICAgICAuZnV6eiA9IGk0NDBmeF9mdXp6X3F0
ZXN0fSk7CkBAIC0xNjcsNyArMTY3LDcgQEAgc3RhdGljIHZvaWQgcmVnaXN0ZXJfcGNpX2Z1enpf
dGFyZ2V0cyh2b2lkKQogICAgIC8qIFVzZXMgbGlicW9zIGFuZCBmb3JrcyB0byBwcmV2ZW50IHN0
YXRlIGxlYWthZ2UgKi8KICAgICBmdXp6X2FkZF9xb3NfdGFyZ2V0KCYoRnV6elRhcmdldCl7CiAg
ICAgICAgICAgICAgICAgLm5hbWUgPSAiaTQ0MGZ4LXFvcy1mb3JrLWZ1enoiLAotICAgICAgICAg
ICAgICAgIC5kZXNjcmlwdGlvbiA9ICJGdXp6IHRoZSBpNDQwZnggdXNpbmcgcmF3IHF0ZXN0IGNv
bW1hbmRzIGFuZCIKKyAgICAgICAgICAgICAgICAuZGVzY3JpcHRpb24gPSAiRnV6eiB0aGUgaTQ0
MGZ4IHVzaW5nIHJhdyBxdGVzdCBjb21tYW5kcyBhbmQgIgogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICJyZWJvb3RpbmcgYWZ0ZXIgZWFjaCBydW4iLAogICAgICAgICAgICAgICAgIC5w
cmVfdm1faW5pdCA9ICZmb3JrX2luaXQsCiAgICAgICAgICAgICAgICAgLmZ1enogPSBpNDQwZnhf
ZnV6el9xb3NfZm9yayx9LApAQCAtMTgyLDcgKzE4Miw3IEBAIHN0YXRpYyB2b2lkIHJlZ2lzdGVy
X3BjaV9mdXp6X3RhcmdldHModm9pZCkKICAgICAgKi8KICAgICBmdXp6X2FkZF9xb3NfdGFyZ2V0
KCYoRnV6elRhcmdldCl7CiAgICAgICAgICAgICAgICAgLm5hbWUgPSAiaTQ0MGZ4LXFvcy1ub3Jl
c2V0LWZ1enoiLAotICAgICAgICAgICAgICAgIC5kZXNjcmlwdGlvbiA9ICJGdXp6IHRoZSBpNDQw
ZnggdXNpbmcgcmF3IHF0ZXN0IGNvbW1hbmRzIGFuZCIKKyAgICAgICAgICAgICAgICAuZGVzY3Jp
cHRpb24gPSAiRnV6eiB0aGUgaTQ0MGZ4IHVzaW5nIHJhdyBxdGVzdCBjb21tYW5kcyBhbmQgIgog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJyZWJvb3RpbmcgYWZ0ZXIgZWFjaCBydW4i
LAogICAgICAgICAgICAgICAgIC5mdXp6ID0gaTQ0MGZ4X2Z1enpfcW9zLH0sCiAgICAgICAgICAg
ICAgICAgImk0NDBGWC1wY2lob3N0IiwKLS0gCjIuMjUuMwoK



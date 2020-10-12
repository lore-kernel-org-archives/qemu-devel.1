Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E557C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 18:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C548020735
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 18:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="McRx6EM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C548020735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS2hu-0004lZ-Sq
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 14:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kS2Z4-0003bO-FL
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 14:28:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45486)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kS2Yx-0004A8-U9
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 14:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602527324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y/QaICRTtUjVw31Cvb/YXTFs03cILgUQrqLB/7tUTCo=;
 b=McRx6EM2V1sNf0r28t1TcUYCOP2Vi6ezf7gxi+ryAYyW/RGWaKZ6vP/KnKplZujWdfJnWh
 VJ9CafQ3J3PmT96ScLe+US6Z0oMZGHp0/oruG7cM9LNYc04vqy8NbmPge1+2JVLzAtvwKP
 LAtoUH2NAe/pFTJ5ESkTIzbB2tN6FkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-NygVKUB8OFaugJRNQg0JpQ-1; Mon, 12 Oct 2020 14:28:41 -0400
X-MC-Unique: NygVKUB8OFaugJRNQg0JpQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF63D107B467;
 Mon, 12 Oct 2020 18:28:40 +0000 (UTC)
Received: from localhost (ovpn-115-4.ams2.redhat.com [10.36.115.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DF2C19C78;
 Mon, 12 Oct 2020 18:28:40 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL v2 08/30] MAINTAINERS: Add vhost-user block device backend
 server maintainer
Date: Mon, 12 Oct 2020 19:27:38 +0100
Message-Id: <20201012182800.157697-9-stefanha@redhat.com>
In-Reply-To: <20201012182800.157697-1-stefanha@redhat.com>
References: <20201012182800.157697-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogQ29pYnkgWHUgPGNvaWJ5Lnh1QGdtYWlsLmNvbT4KClN1Z2dlc3RlZC1ieTogU3RlZmFu
byBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBDb2lieSBY
dSA8Y29pYnkueHVAZ21haWwuY29tPgpSZXZpZXdlZC1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVm
YW5oYUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5k
cmUubHVyZWF1QHJlZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAwOTE4MDgwOTEyLjMyMTI5OS04
LWNvaWJ5Lnh1QGdtYWlsLmNvbQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZh
bmhhQHJlZGhhdC5jb20+Ci0tLQogTUFJTlRBSU5FUlMgfCA4ICsrKysrKysrCiAxIGZpbGUgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJ
TkVSUwppbmRleCBlOWQ4NWNjODczLi4yODI2MjMxOWRiIDEwMDY0NAotLS0gYS9NQUlOVEFJTkVS
UworKysgYi9NQUlOVEFJTkVSUwpAQCAtMzA2OCw2ICszMDY4LDE0IEBAIEw6IHFlbXUtYmxvY2tA
bm9uZ251Lm9yZwogUzogU3VwcG9ydGVkCiBGOiB0ZXN0cy9pbWFnZS1mdXp6ZXIvCiAKK1Zob3N0
LXVzZXIgYmxvY2sgZGV2aWNlIGJhY2tlbmQgc2VydmVyCitNOiBDb2lieSBYdSA8Q29pYnkuWHVA
Z21haWwuY29tPgorUzogTWFpbnRhaW5lZAorRjogYmxvY2svZXhwb3J0L3Zob3N0LXVzZXItYmxr
LXNlcnZlci5jCitGOiB1dGlsL3Zob3N0LXVzZXItc2VydmVyLmMKK0Y6IHRlc3RzL3F0ZXN0L3Zo
b3N0LXVzZXItYmxrLXRlc3QuYworRjogdGVzdHMvcXRlc3QvbGlicW9zL3Zob3N0LXVzZXItYmxr
LmMKKwogUmVwbGljYXRpb24KIE06IFdlbiBDb25neWFuZyA8d2VuY29uZ3lhbmcyQGh1YXdlaS5j
b20+CiBNOiBYaWUgQ2hhbmdsb25nIDx4aWVjaGFuZ2xvbmcuZEBnbWFpbC5jb20+Ci0tIAoyLjI2
LjIKCg==



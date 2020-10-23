Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F51C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2783B20E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVWWktiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2783B20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzCc-0005ts-1p
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVytz-0005XB-Ac
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:22:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVytv-0000gI-GB
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603466562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OyzXXXUV/sAhoBXlnm3q9a66iFE6VdwaUdCJgCR3f3o=;
 b=WVWWktiAmJ9ymMU3VtyvheGSkjWt32KhzIZ2L8D9GVBCoxntihz1oQYOJvDqfE6VsNxZG3
 BDce9sIgvTZbLHk+3aaWLkJ0wgp8safVjL8cHrKbSJg7uyqAYaimgbW54AFEl7IXYdwGze
 CyevdN99UH+mafpaYQPgIkqIeSwwPkU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-sY2aBz2rNW21TDBLRvchyg-1; Fri, 23 Oct 2020 11:22:39 -0400
X-MC-Unique: sY2aBz2rNW21TDBLRvchyg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EFDE5F9DA;
 Fri, 23 Oct 2020 15:22:38 +0000 (UTC)
Received: from localhost (ovpn-114-178.ams2.redhat.com [10.36.114.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B6051A925;
 Fri, 23 Oct 2020 15:22:37 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v3 07/28] MAINTAINERS: Add vhost-user block device backend
 server maintainer
Date: Fri, 23 Oct 2020 16:21:26 +0100
Message-Id: <20201023152147.1016281-8-stefanha@redhat.com>
In-Reply-To: <20201023152147.1016281-1-stefanha@redhat.com>
References: <20201023152147.1016281-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogQ29pYnkgWHUgPGNvaWJ5Lnh1QGdtYWlsLmNvbT4KClN1Z2dlc3RlZC1ieTogU3RlZmFu
byBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBDb2lieSBY
dSA8Y29pYnkueHVAZ21haWwuY29tPgpSZXZpZXdlZC1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVm
YW5oYUByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5k
cmUubHVyZWF1QHJlZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAwOTE4MDgwOTEyLjMyMTI5OS04
LWNvaWJ5Lnh1QGdtYWlsLmNvbQpbUmVtb3ZlZCByZWZlcmVuY2UgdG8gdmhvc3QtdXNlci1ibGst
dGVzdC5jLCBpdCB3aWxsIGJlIHNlbnQgaW4gYQpzZXBhcmF0ZSBwdWxsIHJlcXVlc3QuCi0tU3Rl
ZmFuXQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+
Ci0tLQogTUFJTlRBSU5FUlMgfCA3ICsrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTCmluZGV4IDZhMTk3
YmQzNTguLjI3ODk5NTJhMzAgMTAwNjQ0Ci0tLSBhL01BSU5UQUlORVJTCisrKyBiL01BSU5UQUlO
RVJTCkBAIC0zMDY5LDYgKzMwNjksMTMgQEAgTDogcWVtdS1ibG9ja0Bub25nbnUub3JnCiBTOiBT
dXBwb3J0ZWQKIEY6IHRlc3RzL2ltYWdlLWZ1enplci8KIAorVmhvc3QtdXNlciBibG9jayBkZXZp
Y2UgYmFja2VuZCBzZXJ2ZXIKK006IENvaWJ5IFh1IDxDb2lieS5YdUBnbWFpbC5jb20+CitTOiBN
YWludGFpbmVkCitGOiBibG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmMKK0Y6IHV0
aWwvdmhvc3QtdXNlci1zZXJ2ZXIuYworRjogdGVzdHMvcXRlc3QvbGlicW9zL3Zob3N0LXVzZXIt
YmxrLmMKKwogUmVwbGljYXRpb24KIE06IFdlbiBDb25neWFuZyA8d2VuY29uZ3lhbmcyQGh1YXdl
aS5jb20+CiBNOiBYaWUgQ2hhbmdsb25nIDx4aWVjaGFuZ2xvbmcuZEBnbWFpbC5jb20+Ci0tIAoy
LjI2LjIKCg==



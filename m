Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17270C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7762206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUTVHpBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7762206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmFtB-0005Xs-6B
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFkM-0000z6-N1
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:03:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38720
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFkK-0006oS-Sr
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592568228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NFmMeVxmSIW4Arwn2cib6W11cBFL25NKZfzq55jS/B4=;
 b=gUTVHpBzWzc561HMNcT4uJNh0f/fHvZ4qvxc/pmiV41eu+FC7qN5doUOvMDRwKzGNOzZh/
 /EdgysSpNlVn9VInhFlYtOOj0g2OFyhDnZI4N9ooIZVDJqxxjGAV+mXaZhVCuSw3/mtqaU
 l+bkLH2SIjgiw7rT0f9DMYKCutGx0gk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-sKnWv1q8OuSmauJowEd_9w-1; Fri, 19 Jun 2020 08:03:46 -0400
X-MC-Unique: sKnWv1q8OuSmauJowEd_9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 787711005512;
 Fri, 19 Jun 2020 12:03:45 +0000 (UTC)
Received: from localhost (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3492419C79;
 Fri, 19 Jun 2020 12:03:42 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: [PATCH 2/2] vhost-user-blk-server: rename check_logical_block_size()
 to check_block_size()
Date: Fri, 19 Jun 2020 13:03:32 +0100
Message-Id: <20200619120332.2422664-2-stefanha@redhat.com>
In-Reply-To: <20200619120332.2422664-1-stefanha@redhat.com>
References: <20200614183907.514282-5-coiby.xu@gmail.com>
 <20200619120332.2422664-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 03:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

U2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0K
IGJsb2NrL2V4cG9ydC92aG9zdC11c2VyLWJsay1zZXJ2ZXIuYyB8IDIgKy0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Jsb2NrL2V4
cG9ydC92aG9zdC11c2VyLWJsay1zZXJ2ZXIuYyBiL2Jsb2NrL2V4cG9ydC92aG9zdC11c2VyLWJs
ay1zZXJ2ZXIuYwppbmRleCBiZWQzYzQzNzM3Li5mM2ZhZGE1YjM3IDEwMDY0NAotLS0gYS9ibG9j
ay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmMKKysrIGIvYmxvY2svZXhwb3J0L3Zob3N0
LXVzZXItYmxrLXNlcnZlci5jCkBAIC01OTMsNyArNTkzLDcgQEAgc3RhdGljIHZvaWQgdnVfc2V0
X2Jsa19zaXplKE9iamVjdCAqb2JqLCBWaXNpdG9yICp2LCBjb25zdCBjaGFyICpuYW1lLAogICAg
ICAgICBnb3RvIG91dDsKICAgICB9CiAKLSAgICBjaGVja19sb2dpY2FsX2Jsb2NrX3NpemUob2Jq
ZWN0X2dldF90eXBlbmFtZShvYmopLCBuYW1lLCB2YWx1ZSwgJmxvY2FsX2Vycik7CisgICAgY2hl
Y2tfYmxvY2tfc2l6ZShvYmplY3RfZ2V0X3R5cGVuYW1lKG9iaiksIG5hbWUsIHZhbHVlLCAmbG9j
YWxfZXJyKTsKICAgICBpZiAobG9jYWxfZXJyKSB7CiAgICAgICAgIGdvdG8gb3V0OwogICAgIH0K
LS0gCjIuMjYuMgoK



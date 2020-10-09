Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAF7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BEFC22282
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iktj7xLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEFC22282
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQyPA-0001Kq-UD
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 15:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyC0-0001F3-HA
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:36:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyBw-0002xM-9U
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602272195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fBAo34y8IZy6i4vlyxcbwiJeF2wKoXyDiuWrsX4YWro=;
 b=iktj7xLtFeYGtXQhk5ETt/1VmcsU03ctB8Y4nXH/DuXJljnQn6wuBMO+0SuOoeAG/vomKQ
 4WWtSZezH33XTi2ih5BZsi0WwD8BBSf+D8AWxlBJ7ZqjMeWKYX6xJ998cuXxXLffuQAWQh
 EIngF4hbcvimCH80xlfQdmZN9j9GPbA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-j4VfGCBPNom1AYOGHPsUtg-1; Fri, 09 Oct 2020 15:36:31 -0400
X-MC-Unique: j4VfGCBPNom1AYOGHPsUtg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57CD92ED6;
 Fri,  9 Oct 2020 19:36:30 +0000 (UTC)
Received: from localhost (ovpn-112-20.ams2.redhat.com [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EB996EF6D;
 Fri,  9 Oct 2020 19:36:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 09/30] util/vhost-user-server: s/fileds/fields/ typo fix
Date: Fri,  9 Oct 2020 20:35:08 +0100
Message-Id: <20201009193529.322822-10-stefanha@redhat.com>
In-Reply-To: <20201009193529.322822-1-stefanha@redhat.com>
References: <20201009193529.322822-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

U2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpNZXNz
YWdlLWlkOiAyMDIwMDkyNDE1MTU0OS45MTM3MzctMy1zdGVmYW5oYUByZWRoYXQuY29tClNpZ25l
ZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiB1dGls
L3Zob3N0LXVzZXItc2VydmVyLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS91dGlsL3Zob3N0LXVzZXItc2VydmVyLmMg
Yi91dGlsL3Zob3N0LXVzZXItc2VydmVyLmMKaW5kZXggN2I1MGEyYjFmZC4uMmNkMGNmODI3NyAx
MDA2NDQKLS0tIGEvdXRpbC92aG9zdC11c2VyLXNlcnZlci5jCisrKyBiL3V0aWwvdmhvc3QtdXNl
ci1zZXJ2ZXIuYwpAQCAtNDA3LDcgKzQwNyw3IEBAIGJvb2wgdmhvc3RfdXNlcl9zZXJ2ZXJfc3Rh
cnQoVnVTZXJ2ZXIgKnNlcnZlciwKICAgICAgICAgcmV0dXJuIGZhbHNlOwogICAgIH0KIAotICAg
IC8qIHplcm8gb3V0IHVuc3BlY2lmaWVkIGZpbGVkcyAqLworICAgIC8qIHplcm8gb3V0IHVuc3Bl
Y2lmaWVkIGZpZWxkcyAqLwogICAgICpzZXJ2ZXIgPSAoVnVTZXJ2ZXIpIHsKICAgICAgICAgLmxp
c3RlbmVyICAgICAgICAgICAgICA9IGxpc3RlbmVyLAogICAgICAgICAudnVfaWZhY2UgICAgICAg
ICAgICAgID0gdnVfaWZhY2UsCi0tIAoyLjI2LjIKCg==



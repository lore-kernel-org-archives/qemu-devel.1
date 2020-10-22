Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8909CC388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D116D2225F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AvwOGDXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D116D2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVYus-0008GQ-Nr
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 07:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVYlg-0004PW-L1
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:28:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVYlf-000544-1K
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603366106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdbjx4jC6RspLuWlx++Rq0O/3VtjqAWAahM++epM/XA=;
 b=AvwOGDXCODhLf/LZMDWHmEfADnqC8gt/gP/piYqQV/p8q+baV67oJsVLi0SaT8Oce1LDLa
 tO7kZq4NaUI/cyIxWGA41+n3jXzNsjy00HzB8ACRHDCc4nSWuahITvipscgdnmGMEDb6Uk
 oAiMUdUDiEfkWc+5Ix9t8gCjsX7vscA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-lfBU8mVgPg698_aZBXqjfA-1; Thu, 22 Oct 2020 07:28:23 -0400
X-MC-Unique: lfBU8mVgPg698_aZBXqjfA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 543FF1009E2B;
 Thu, 22 Oct 2020 11:28:22 +0000 (UTC)
Received: from localhost (ovpn-114-229.ams2.redhat.com [10.36.114.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE6495D9D5;
 Thu, 22 Oct 2020 11:28:18 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 08/28] util/vhost-user-server: s/fileds/fields/ typo fix
Date: Thu, 22 Oct 2020 12:27:06 +0100
Message-Id: <20201022112726.736757-9-stefanha@redhat.com>
In-Reply-To: <20201022112726.736757-1-stefanha@redhat.com>
References: <20201022112726.736757-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 06:53:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

U2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpNZXNz
YWdlLWlkOiAyMDIwMDkyNDE1MTU0OS45MTM3MzctMy1zdGVmYW5oYUByZWRoYXQuY29tClNpZ25l
ZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiB1dGls
L3Zob3N0LXVzZXItc2VydmVyLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS91dGlsL3Zob3N0LXVzZXItc2VydmVyLmMg
Yi91dGlsL3Zob3N0LXVzZXItc2VydmVyLmMKaW5kZXggYjE4OTk0NDg1Ni4uOWJkMzNlMGZkYiAx
MDA2NDQKLS0tIGEvdXRpbC92aG9zdC11c2VyLXNlcnZlci5jCisrKyBiL3V0aWwvdmhvc3QtdXNl
ci1zZXJ2ZXIuYwpAQCAtNDA3LDcgKzQwNyw3IEBAIGJvb2wgdmhvc3RfdXNlcl9zZXJ2ZXJfc3Rh
cnQoVnVTZXJ2ZXIgKnNlcnZlciwKICAgICAgICAgcmV0dXJuIGZhbHNlOwogICAgIH0KIAotICAg
IC8qIHplcm8gb3V0IHVuc3BlY2lmaWVkIGZpbGVkcyAqLworICAgIC8qIHplcm8gb3V0IHVuc3Bl
Y2lmaWVkIGZpZWxkcyAqLwogICAgICpzZXJ2ZXIgPSAoVnVTZXJ2ZXIpIHsKICAgICAgICAgLmxp
c3RlbmVyICAgICAgICAgICAgICA9IGxpc3RlbmVyLAogICAgICAgICAudnVfaWZhY2UgICAgICAg
ICAgICAgID0gdnVfaWZhY2UsCi0tIAoyLjI2LjIKCg==



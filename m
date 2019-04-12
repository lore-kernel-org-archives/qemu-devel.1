Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D64C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB5362084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5362084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34180 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEtjp-00057I-2M
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 06:48:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hEtit-0004i9-Fb
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hEtin-0002az-D0
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:47:52 -0400
Resent-Date: Fri, 12 Apr 2019 06:47:50 -0400
Resent-Message-Id: <E1hEtin-0002az-D0@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hEtih-0002Cz-Np
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:47:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1555066015; cv=none; d=zoho.com; s=zohoarc; 
	b=INWzYH7kkp1cwVTHPRmzt/fCvC/Yv6lkgPlijiPJAs+HC64Y2WF/FDsyB2Q2Uu1CeLyMGXDLbLp4DaN6qBGIDWiDnw58IUAK7L+jO4bX8Pgv4R3bTffFv82EaAV3AWuQDkKV/uUbE6a9Nq/H/WgLNV+lPwBcXVBA1l6gopv+DAU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1555066015;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=1NrmqeFqo71fe4kb9R0E59oJjqv3yI6wSudRZujy04E=; 
	b=NYGU5zCDr60WaHK4lyChgvxloPSpLJMRKXn6WDkvK3SQSjI5yeM7Xsd7acuSXRKuZQAeesNOJdrJkqxJSxmHvg7D/Sv/X0BT4av6qyokhrfscWMrlkWElH3/JB+BdbPxuHshPguG7DY70ygbk+ufy+XY4HWQVeHon1oTCUFX3Z4=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1555066013141513.229967535293;
	Fri, 12 Apr 2019 03:46:53 -0700 (PDT)
Message-ID: <155506601107.12882.12624101475902826075@76452e4e88f2>
In-Reply-To: <20190412100354.6409-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eric.auger@redhat.com
Date: Fri, 12 Apr 2019 03:46:53 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [RFC v3 00/27] vSMMUv3/pSMMUv3 2 stage VFIO
 integration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: fam@euphon.net, peter.maydell@linaro.org, yi.l.liu@intel.com,
	mst@redhat.com, jean-philippe.brucker@arm.com,
	qemu-devel@nongnu.org, peterx@redhat.com, eric.auger@redhat.com,
	alex.williamson@redhat.com, qemu-arm@nongnu.org,
	vincent.stehle@arm.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412104653.iofomCnbaf5R5ToGQZ417pveF9feM8XQ2Pk-aG-OFFo@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQxMjEwMDM1NC42NDA5
LTEtZXJpYy5hdWdlckByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVk
b3JhIFNIT1dfRU5WPTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAg
Q0MgICAgICBhYXJjaDY0LXNvZnRtbXUvaHcvYXJtL21jaW14N2Qtc2FicmUubwogIENDICAgICAg
YWFyY2g2NC1zb2Z0bW11L2h3L2FybS9zbW11LWNvbW1vbi5vCiAgQ0MgICAgICBhYXJjaDY0LXNv
ZnRtbXUvaHcvYXJtL3NtbXV2My5vCi90bXAvcWVtdS10ZXN0L3NyYy9ody9hcm0vc21tdXYzLmM6
MTk6MTA6IGZhdGFsIGVycm9yOiBsaW51eC9pb21tdS5oOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0
b3J5CiAjaW5jbHVkZSAibGludXgvaW9tbXUuaCIKICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fgpj
b21waWxhdGlvbiB0ZXJtaW5hdGVkLgoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0
cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA0MTIxMDAzNTQuNjQwOS0xLWVyaWMuYXVnZXJAcmVk
aGF0LmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=



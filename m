Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE798C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8127C2074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8127C2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEBq6-0004ZS-NJ
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 09:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kEBpP-0003Xg-H2; Fri, 04 Sep 2020 09:32:31 -0400
Resent-Date: Fri, 04 Sep 2020 09:32:31 -0400
Resent-Message-Id: <E1kEBpP-0003Xg-H2@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kEBpM-0004fR-7E; Fri, 04 Sep 2020 09:32:31 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1599226331; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KVyuhG/bBMbKFjGk6tBcdZFWW3SV1mQGubxpArWbXt3BjFEeS7B8str1my65f3zKBZW2L+bmhpHUi3IbIHP/ns0bCkL+hEGJzP0Gc6Xjq8+yal6VnyTz/s1//UX3ySkwbWSSzLdTI27VhYuGRQHUuMoktcYsQ5DgOn51dGZn5FU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1599226331;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=hSKvuSqyl1CbValAjc8y+DEQHaqcMN9YwYBaq9CgPiY=; 
 b=Urm3pWmFqQI48qQs0ejE5X/LLetGY5K6M7tzKotm+7i0y08T9EY3W+2VDYhm48I8UzCiuPxNQLARPOiB8qI5WXmn9KAM+OxqMgS820DN5mNYPeaVHVWUxzsm46a+P+QB6ZA+B8wXLIz8h25adnqbRhFWyPdQQUSKQkjNzzP0ezk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1599226329593454.973130602914;
 Fri, 4 Sep 2020 06:32:09 -0700 (PDT)
Subject: Re: [PATCH 0/4] nbd reconnect new fixes
Message-ID: <159922632826.11986.14148820580932678804@66eaa9a8a123>
In-Reply-To: <20200903190301.367620-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Fri, 4 Sep 2020 06:32:09 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 09:24:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkwMzE5MDMwMS4zNjc2
MjAtMS12c2VtZW50c292QHZpcnR1b3p6by5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVk
IGJ1aWxkIHRlc3Qgb24gRnJlZUJTRCBob3N0LiBQbGVhc2UgZmluZCB0aGUgZGV0YWlscyBiZWxv
dy4KCgoKCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcv
bG9ncy8yMDIwMDkwMzE5MDMwMS4zNjc2MjAtMS12c2VtZW50c292QHZpcnR1b3p6by5jb20vdGVz
dGluZy5GcmVlQlNELz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIg
ZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D95C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63C4A217BA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C4A217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmIWg-0002Q0-JG
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 11:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jmIV4-00014Q-Ob
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:00:14 -0400
Resent-Date: Fri, 19 Jun 2020 11:00:14 -0400
Resent-Message-Id: <E1jmIV4-00014Q-Ob@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jmIV1-000567-LB
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:00:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592578640; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ccj9OUZRoDpXYPV9+8GR1N3P/ErYg+XJ/flSteBTY2qGvD7YAAK2YeUGyZNINXkBZDJQWDWH/POhO0lu9YcVbkvS3a6u8NMqaSwyJawVEpIiNPySlREaS6s+1vH7RgBPAPsNCOJhzqtOJBN5UEPQfd4/QBo3dCnoFTJAs87l2gc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592578640;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=l/R6IOxGXGVxwIn5xJaxl1IqJlsOrI2OxttfjTQsFXM=; 
 b=MBzIzxxsmkJVNHnbCwlL6AabTR3cN3NWUK7XTGtEFPYzMMepFyT8/EAVKu3j6DGQT3uDGEC5lCZkN7ZP2YJv/wKVHO5bUmwpXq9004zWHCIYgr+IfxIurLKJSLODXHC5qu1xiGlMDsaRkYC6xzbnX66Nw67o3I4ihPcNfmcAZuI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15925785489525.102460055368397;
 Fri, 19 Jun 2020 07:55:48 -0700 (PDT)
Message-ID: <159257854765.2784.16350997545735677944@d1fd068a5071>
Subject: Re: [RFC PATCH] docs/devel: add some notes on tcg-icount for
 developers
In-Reply-To: <20200619135844.23307-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Fri, 19 Jun 2020 07:55:48 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 10:14:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, dovgaluk@ispras.ru, pbonzini@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxOTEzNTg0NC4yMzMw
Ny0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBhc2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0
aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4g
cHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEg
Vj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtZGVidWdAZmVkb3JhIFRBUkdFVF9M
SVNUPXg4Nl82NC1zb2Z0bW11IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09
CgogIENDICAgICAgdWkvdHJhY2UubwogIENDICAgICAgaHcvY29yZS90cmFjZS5vCgpXYXJuaW5n
LCB0cmVhdGVkIGFzIGVycm9yOgovdG1wL3FlbXUtdGVzdC9zcmMvZG9jcy9kZXZlbC90Y2ctaWNv
dW50LnJzdDpkb2N1bWVudCBpc24ndCBpbmNsdWRlZCBpbiBhbnkgdG9jdHJlZQogIENDICAgICAg
aHcvZGlzcGxheS90cmFjZS5vCiAgQ0MgICAgICBxYXBpL3RyYWNlLm8KLS0tCiAgQ0MgICAgICBz
dHVicy9ydW5zdGF0ZS1jaGVjay5vCiAgQ0MgICAgICBzdHVicy9zZW1paG9zdC5vCiAgQ0MgICAg
ICBzdHVicy9zZXQtZmQtaGFuZGxlci5vCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTA4ODogZG9jcy9k
ZXZlbC9pbmRleC5odG1sXSBFcnJvciAyCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVk
IGpvYnMuLi4uClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rl
c3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2OSwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlz
ZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nl
c3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJl
bCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTRiNzExNjQ1NmQ4NDQxMjY4ZDUyMmU4NDM0ODcy
NjA0JywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVk
JywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9eDg2XzY0LXNvZnRtbXUnLCAnLWUnLCAnRVhU
UkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVC
VUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNo
ZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIv
dG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC13Z3JpZjhn
Yy9zcmMvZG9ja2VyLXNyYy4yMDIwLTA2LTE5LTEwLjUxLjM0Ljg1MTE6L3Zhci90bXAvcWVtdTp6
LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtZGVidWcnXScg
cmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNv
bS5xZW11Lmluc3RhbmNlLnV1aWQ9NGI3MTE2NDU2ZDg0NDEyNjhkNTIyZTg0MzQ4NzI2MDQKbWFr
ZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5
IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtd2dyaWY4Z2Mvc3JjJwptYWtlOiAqKiogW2Rv
Y2tlci1ydW4tdGVzdC1kZWJ1Z0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgNG0xNC41ODdzCnVz
ZXIgICAgMG04LjExOHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRj
aGV3Lm9yZy9sb2dzLzIwMjAwNjE5MTM1ODQ0LjIzMzA3LTEtYWxleC5iZW5uZWVAbGluYXJvLm9y
Zy90ZXN0aW5nLmFzYW4vP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


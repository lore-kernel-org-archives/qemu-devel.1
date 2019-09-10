Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00F3C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 20:39:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C205B21479
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 20:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C205B21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7mv3-0003hu-UB
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 16:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i7muI-0003C6-Ei
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 16:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i7muH-0005dw-Dm
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 16:38:34 -0400
Resent-Date: Tue, 10 Sep 2019 16:38:34 -0400
Resent-Message-Id: <E1i7muH-0005dw-Dm@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21514)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i7muH-0005dT-6m
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 16:38:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568147879; cv=none; d=zoho.com; s=zohoarc; 
 b=kJw+hRmIEYHMGnDWXhXibm5m6+Gh963Cpgx/t0PWQAjut+pzkvW/AozqyazaYjf4iNwIHUOgAx6obZzRUqEwEbPqA+sQxlsjyq7jusgdvyIeV0yfxf0STdXoenbt/pIknrZi3wHpLN/1yvuLDCV6mLBZI6ePmmLNrj2ik3zf2uM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568147879;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=V57h6giQVNcPjHcsJU0TrCU80tnYD7vNn2ROyF+Noz0=; 
 b=hty4EyuVahdgzY+E3o4sjUIefvFeDzW/wfIa5Bgi/taJHaA540+77jiH0721M8e5ZE2ssGzmmhmrBRdzKaU4krwaJlXDnTj3QRx44EHnyFui1cHzxq3rg7DJIuvgSMAZuGumCtp/VWoRfALnVl1YckgrwMQnDYvfzf/vozD/Le8=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568147878755689.2876852025386;
 Tue, 10 Sep 2019 13:37:58 -0700 (PDT)
In-Reply-To: <20190910162724.79574-1-vsementsov@virtuozzo.com>
Message-ID: <156814787725.15929.11693446479791530766@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Tue, 10 Sep 2019 13:37:58 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH 0/3] proper locking on bitmap add/remove
 paths
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org,
 den@openvz.org, mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxMDE2MjcyNC43OTU3
NC0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcg
Vj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VO
Vj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpsaWJ1ZGV2ICAgICAg
ICAgICBubwpkZWZhdWx0IGRldmljZXMgICB5ZXMKCndhcm5pbmc6IFB5dGhvbiAyIHN1cHBvcnQg
aXMgZGVwcmVjYXRlZAp3YXJuaW5nOiBQeXRob24gMyB3aWxsIGJlIHJlcXVpcmVkIGZvciBidWls
ZGluZyBmdXR1cmUgdmVyc2lvbnMgb2YgUUVNVQoKTk9URTogY3Jvc3MtY29tcGlsZXJzIGVuYWJs
ZWQ6ICAnY2MnCiAgR0VOICAgICB4ODZfNjQtc29mdG1tdS9jb25maWctZGV2aWNlcy5tYWsudG1w
Ci0tLQogIENDICAgICAgYmxvY2svcWVkLWNsdXN0ZXIubwogIENDICAgICAgYmxvY2svcWVkLWNo
ZWNrLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jOiBJbiBmdW5jdGlv
biAncWNvdzJfY29fcmVtb3ZlX3BlcnNpc3RlbnRfZGlydHlfYml0bWFwJzoKL3RtcC9xZW11LXRl
c3Qvc3JjL2Jsb2NrL3Fjb3cyLWJpdG1hcC5jOjUwMjo4OiBlcnJvcjogJ2JtJyBtYXkgYmUgdXNl
ZCB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFs
aXplZF0KICAgICBpZiAoYm0gPT0gTlVMTCkgewogICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3Jj
L2Jsb2NrL3Fjb3cyLWJpdG1hcC5jOjE0MTM6MTg6IG5vdGU6ICdibScgd2FzIGRlY2xhcmVkIGhl
cmUKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dz
LzIwMTkwOTEwMTYyNzI0Ljc5NTc0LTEtdnNlbWVudHNvdkB2aXJ0dW96em8uY29tL3Rlc3Rpbmcu
ZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNl
bmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=



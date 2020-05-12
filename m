Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8605DC47077
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:26:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC61206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC61206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYZbm-0001j3-Gy
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 14:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jYZa1-00006N-BT; Tue, 12 May 2020 14:24:37 -0400
Resent-Date: Tue, 12 May 2020 14:24:37 -0400
Resent-Message-Id: <E1jYZa1-00006N-BT@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jYZZz-00065e-07; Tue, 12 May 2020 14:24:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589307857; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=T5TcihGyPO0QGUcgb1vElj8YNnUoNIExvPv11o1GWX2JKKSZ4ygYegBOotF+nU1ApXrPmxAQ5Kr9k5XWbgSIL3F7co34OLgvklMS9Qvc9sZfbLfGtTJK1ijHyZ9DX1puZ8VelrB8brpUExLs+JOL+fd+/teG8HMm5/lrA4w78S4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589307857;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Ha2khwwHmaAxd/KPNqbse82XjAft4jbrIB4FwVQoDoM=; 
 b=P2NCvCBXZ2hrS98rmEp5gEpaoL4WfN3V26Dsxoxrhngty9DN39HTbHmUgptlXl6MS4mA0qgvqEauxOczCRRkVJC0zDAeV/sN78nmcBK1qIlCWRax5B8bZmqRLQ4Dqonicegooh04TvRRTG44z1gy004SmMLVGPhXtD+FKgTyWJw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589307855908539.2428953384153;
 Tue, 12 May 2020 11:24:15 -0700 (PDT)
Message-ID: <158930785409.4397.10025093916225196968@45ef0f9c86ae>
In-Reply-To: <1589295196-773454-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: Re: [PATCH v3 00/15] Apply COR-filter to the block-stream permanently
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: andrey.shinkevich@virtuozzo.com
Date: Tue, 12 May 2020 11:24:15 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 14:20:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, den@openvz.org, andrey.shinkevich@virtuozzo.com,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTg5Mjk1MTk2LTc3MzQ1NC0x
LWdpdC1zZW5kLWVtYWlsLWFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20vCgoKCkhpLAoK
VGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBhc2FuIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0
ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tl
ciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtl
IGRvY2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3Qt
ZGVidWdAZmVkb3JhIFRBUkdFVF9MSVNUPXg4Nl82NC1zb2Z0bW11IEo9MTQgTkVUV09SSz0xCj09
PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgc2NzaS91dGlscy5vCiAgQ0MgICAgICBz
Y3NpL3ByLW1hbmFnZXIubwogIENDICAgICAgc2NzaS9wci1tYW5hZ2VyLWhlbHBlci5vCi90bXAv
cWVtdS10ZXN0L3NyYy9ibG9jay9jb3B5LW9uLXJlYWQuYzoyOToxMDogZmF0YWwgZXJyb3I6ICdi
bG9jay9jb3B5LW9uLXJlYWQuaCcgZmlsZSBub3QgZm91bmQKI2luY2x1ZGUgImJsb2NrL2NvcHkt
b24tcmVhZC5oIgogICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+CjEgZXJyb3IgZ2VuZXJh
dGVkLgptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IGJsb2NrL2Nv
cHktb24tcmVhZC5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpv
YnMuLi4uCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9zdHJlYW0uYzoyMjoxMDogZmF0YWwgZXJy
b3I6ICdibG9jay9jb3B5LW9uLXJlYWQuaCcgZmlsZSBub3QgZm91bmQKI2luY2x1ZGUgImJsb2Nr
L2NvcHktb24tcmVhZC5oIgogICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+CjEgZXJyb3Ig
Z2VuZXJhdGVkLgptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IGJs
b2NrL3N0cmVhbS5vXSBFcnJvciAxClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToK
ICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2NCwgaW4gPG1vZHVsZT4K
ICAgIHN5cy5leGl0KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0
Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRv
JywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51
dWlkPTAxMTZjZDFmMjE0ODRkODA5Y2UxYmJmMDlkOGYyZDEzJywgJy11JywgJzEwMDMnLCAnLS1z
ZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VU
X0xJU1Q9eDg2XzY0LXNvZnRtbXUnLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1l
JywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScs
ICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3
Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC05ODBma2YzOC9zcmMvZG9ja2VyLXNyYy4yMDIwLTA1
LTEyLTE0LjIxLjA5LjEwNzMzOi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcv
dmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LWRlYnVnJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQg
c3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTAx
MTZjZDFmMjE0ODRkODA5Y2UxYmJmMDlkOGYyZDEzCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0g
RXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0
ZXItdG1wLTk4MGZrZjM4L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtZGVidWdAZmVk
b3JhXSBFcnJvciAyCgpyZWFsICAgIDNtNS4yMzZzCnVzZXIgICAgMG04LjQwMXMKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1ODkyOTUxOTYt
NzczNDU0LTEtZ2l0LXNlbmQtZW1haWwtYW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbS90
ZXN0aW5nLmFzYW4vP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNh
bGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


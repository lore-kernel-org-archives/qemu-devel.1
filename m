Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77FFC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 22:14:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB79205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 22:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB79205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYzeA-0001dh-Nt
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 18:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jYzdB-0000Ta-27; Wed, 13 May 2020 18:13:37 -0400
Resent-Date: Wed, 13 May 2020 18:13:37 -0400
Resent-Message-Id: <E1jYzdB-0000Ta-27@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jYzd9-0003XC-EA; Wed, 13 May 2020 18:13:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589408004; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JeFbrgMNxztG2NTDXYJkH4USlBZpPcmqgZsKXC8/jPeqatMCu0arGsePC4kRGXUDJr60SpWB1nBKD0q9AHLSm5uMjTXl4v9ZdsJzXFuxJFjZ8+fFM8RHqjTfml8QzoO+kjJ14SYvy2+p4dnjq3O/SSs0f4uOX0LaOurGn8T9cqM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589408004;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=JGDiE5VDngc4w2ITS2EpidQqDYH37drK9gRWpiBsm/0=; 
 b=XusdZB5Bg1nbHbhjj0103iD0SPfM93TGpYLBwkOJrrGf/mqJ/yPOnupgNofZlqOsExEuItFW4AAbIHiWaPoh0aOY/GtbzXx1MHQPqqrWlW0xrpWnsM6z86prp7C3zYB8sR6UrqFLIxlX78YGEowSkL+OP0lXs3gyCAAHfmG7K38=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589408001985146.68004995467618;
 Wed, 13 May 2020 15:13:21 -0700 (PDT)
Message-ID: <158940800045.13639.7060966543907777257@45ef0f9c86ae>
In-Reply-To: <20200513133629.18508-1-eyal.moscovici@oracle.com>
Subject: Re: [PATCH v3 0/4] Additional parameters for qemu_img map
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eyal.moscovici@oracle.com
Date: Wed, 13 May 2020 15:13:21 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 18:13:31
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
Cc: kwolf@redhat.com, eyal.moscovici@oracle.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, liran.alon@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUxMzEzMzYyOS4xODUw
OC0xLWV5YWwubW9zY292aWNpQG9yYWNsZS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVk
IHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBk
b2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1p
bmd3QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAg
ICAgIHg4Nl82NC1zb2Z0bW11L2lvcG9ydC5vCiAgQ0MgICAgICB4ODZfNjQtc29mdG1tdS9xdGVz
dC5vCi90bXAvcWVtdS10ZXN0L3NyYy9xZW11LWltZy5jOiBJbiBmdW5jdGlvbiAnY3Z0bnVtX2Z1
bGwnOgovdG1wL3FlbXUtdGVzdC9zcmMvcWVtdS1pbWcuYzo0ODg6NjM6IGVycm9yOiBmb3JtYXQg
JyVsZCcgZXhwZWN0cyBhcmd1bWVudCBvZiB0eXBlICdsb25nIGludCcsIGJ1dCBhcmd1bWVudCAz
IGhhcyB0eXBlICdpbnQ2NF90JyB7YWthICdsb25nIGxvbmcgaW50J30gWy1XZXJyb3I9Zm9ybWF0
PV0KICAgICAgICAgZXJyb3JfcmVwb3J0KCJJbnZhbGlkICVzIHNwZWNpZmllZC4gTXVzdCBiZSBi
ZXR3ZWVuICVsZCBieXRlcyAiCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB+fl4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICVsbGQKICAgICAgICAgICAgICAgICAgICAg
ICJ0byAlbGQgYnl0ZXMuIiwgbmFtZSwgbWluLCBtYXgpOwogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB+fn4gICAgICAgICAgICAgICAgCi90bXAvcWVtdS10ZXN0
L3NyYy9xZW11LWltZy5jOjQ4ODoyMjogZXJyb3I6IGZvcm1hdCAnJWxkJyBleHBlY3RzIGFyZ3Vt
ZW50IG9mIHR5cGUgJ2xvbmcgaW50JywgYnV0IGFyZ3VtZW50IDQgaGFzIHR5cGUgJ2ludDY0X3Qn
IHtha2EgJ2xvbmcgbG9uZyBpbnQnfSBbLVdlcnJvcj1mb3JtYXQ9XQogICAgICAgICBlcnJvcl9y
ZXBvcnQoIkludmFsaWQgJXMgc3BlY2lmaWVkLiBNdXN0IGJlIGJldHdlZW4gJWxkIGJ5dGVzICIK
ICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+CiAgICAgICAgICAgICAgICAgICAgICAidG8gJWxkIGJ5dGVzLiIsIG5h
bWUsIG1pbiwgbWF4KTsKLS0tCiAgICAgICAgICAgICAgICAgICAgICAgICAgfn5eCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgJWxsZApjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFz
IGVycm9ycwptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IHFlbXUt
aW1nLm9dIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4K
ICBDQyAgICAgIGFhcmNoNjQtc29mdG1tdS9kdW1wL2R1bXAubwogIENDICAgICAgeDg2XzY0LXNv
ZnRtbXUvbWVtb3J5Lm8KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwg
Y21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1u
JywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTMz
ZjgzYjdkNjEyMjRhZDc5MzU1ZmVlMDIzMTJlZTljJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0
eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9
JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0
JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0v
dmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2Vy
LWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rl
ci10bXAtejRmdmNiaXEvc3JjL2RvY2tlci1zcmMuMjAyMC0wNS0xMy0xOC4xMC40My4zMjQ6L3Zh
ci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rl
c3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmls
dGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MzNmODNiN2Q2MTIyNGFkNzkzNTVmZWUw
MjMxMmVlOWMKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZp
bmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtejRmdmNiaXEvc3JjJwpt
YWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAg
Mm0zNi42MzhzCnVzZXIgICAgMG03LjcyMHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNTEzMTMzNjI5LjE4NTA4LTEtZXlhbC5tb3Nj
b3ZpY2lAb3JhY2xlLmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20=


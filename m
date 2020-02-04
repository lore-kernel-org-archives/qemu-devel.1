Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E3DC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:20:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B933F20730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B933F20730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyxBb-00055k-VR
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 07:20:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iyx85-0002Yh-Rw
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iyx83-00025k-KI
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:16:33 -0500
Resent-Date: Tue, 04 Feb 2020 07:16:32 -0500
Resent-Message-Id: <E1iyx83-00025k-KI@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21187)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iyx82-0001rL-2a
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:16:31 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1580818578789508.7206577065041;
 Tue, 4 Feb 2020 04:16:18 -0800 (PST)
In-Reply-To: <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
Subject: Re: [RFC 0/9] Add an interVM memory sharing device
Message-ID: <158081857760.23546.9693812250648734148@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: i.kotrasinsk@partner.samsung.com
Date: Tue, 4 Feb 2020 04:16:18 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: peter.maydell@linaro.org, i.kotrasinsk@partner.samsung.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTgwODE1ODUxLTI4ODg3LTEt
Z2l0LXNlbmQtZW1haWwtaS5rb3RyYXNpbnNrQHBhcnRuZXIuc2Ftc3VuZy5jb20vCgoKCkhpLAoK
VGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBs
ZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElm
IHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0
CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQg
QVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBt
YWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKICBDQyAgICAgIGJsb2NrL2Jsa3JlcGxheS5vCiAgQ0MgICAgICBibG9jay9w
YXJhbGxlbHMubwogIENDICAgICAgYmxvY2svYmxrbG9nd3JpdGVzLm8KL3RtcC9xZW11LXRlc3Qv
c3JjL2RvY3MvLi4vaW5jbHVkZS9leGVjL21lbW9yeS5oOjkyMzogd2FybmluZzogRnVuY3Rpb24g
cGFyYW1ldGVyIG9yIG1lbWJlciAnbW1hcF9vZmZzZXQnIG5vdCBkZXNjcmliZWQgaW4gJ21lbW9y
eV9yZWdpb25faW5pdF9yYW1fZnJvbV9mZCcKCldhcm5pbmcsIHRyZWF0ZWQgYXMgZXJyb3I6Ci90
bXAvcWVtdS10ZXN0L3NyYy9kb2NzLy4uL2luY2x1ZGUvZXhlYy9tZW1vcnkuaDoxOTIzOlVuZXhw
ZWN0ZWQgaW5kZW50YXRpb24uCiAgQ0MgICAgICBibG9jay9ibG9jay1iYWNrZW5kLm8KICBDQyAg
ICAgIGJsb2NrL3NuYXBzaG90Lm8KLS0tCiAgQ0MgICAgICBibG9jay9jcmVhdGUubwogIENDICAg
ICAgYmxvY2svdGhyb3R0bGUtZ3JvdXBzLm8KICBDQyAgICAgIGJsb2NrL25iZC5vCm1ha2U6ICoq
KiBbTWFrZWZpbGU6MTA0MzogZG9jcy9kZXZlbC9pbmRleC5odG1sXSBFcnJvciAyCm1ha2U6ICoq
KiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFjayAobW9zdCByZWNlbnQg
Y2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2Miwg
aW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21k
KQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywg
J2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTRlMGNl
NGJjMDA2NTQ2YzZhN2U0NzcwMTcxMmFhNTcxJywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1v
cHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9Jywg
Jy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0Jywg
Jy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFy
L3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2Nh
Y2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRt
cC1nc2E3X200eC9zcmMvZG9ja2VyLXNyYy4yMDIwLTAyLTA0LTA3LjE0LjIyLjIwMjQzOi92YXIv
dG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0
LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRl
cj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTRlMGNlNGJjMDA2NTQ2YzZhN2U0NzcwMTcx
MmFhNTcxCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5n
IGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWdzYTdfbTR4L3NyYycKbWFr
ZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDFt
NTUuNDIxcwp1c2VyICAgIDBtOC40NzhzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApo
dHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTgwODE1ODUxLTI4ODg3LTEtZ2l0LXNlbmQtZW1haWwt
aS5rb3RyYXNpbnNrQHBhcnRuZXIuc2Ftc3VuZy5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVk
b3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQ
YXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


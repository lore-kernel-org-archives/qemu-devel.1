Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3A8C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 04:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96DCA2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 04:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DCA2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7WZk-0006D6-Ol
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 00:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k7WYi-0005VR-HK
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 00:15:45 -0400
Resent-Date: Mon, 17 Aug 2020 00:15:44 -0400
Resent-Message-Id: <E1k7WYi-0005VR-HK@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k7WYe-0008SE-FU
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 00:15:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597637734; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ljh0NxF0TRZqHNzsKEfvBSXpchk3y7eWNp0FCt1GD2i4O6UjIcFpqDSkQB3Yh/epdboIoTQmQ8EemLxtd91sankrZ4XSCHM5/qxSw6VdXnAuZGGSDRea8FggHX3ScU1AU46nPCu/EysyD8WvF3lJaQeLBCym9VUGi+ed0XyyFEo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597637734;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=oWoC+4pBCUfcito+gIjMi0cq9YN0N8XFPaUtQwJf0Jw=; 
 b=iGDaodTfI5om2m6VvG+b30aYEKBfrI5BZ9+wIbNIsmyeYNUJEle363E2Gl+yJ3ykdM7oDA9Nz59NNEBTrCXTO7Nw7wss9nrCk9NbIwu22W3YPPIFRtiIw9wKLyFUmRwNz19c62zPDTxsC9uUJAaTUaUoUgmKBFaBvJm9Y7qYgnI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597637732004965.8826856134606;
 Sun, 16 Aug 2020 21:15:32 -0700 (PDT)
Subject: Re: [PATCH] ide:do nothing for identify cmd if no any device attached
Message-ID: <159763773082.28013.6258821676677959176@66eaa9a8a123>
In-Reply-To: <20200817033803.14014-1-RockCui-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: RockCui-oc@zhaoxin.com
Date: Sun, 16 Aug 2020 21:15:32 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 00:15:37
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: CobeChen@zhaoxin.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxNzAzMzgwMy4xNDAx
NC0xLVJvY2tDdWktb2NAemhhb3hpbi5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGlu
ZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5z
dGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9
MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9
MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBURVNUICAgIGNoZWNr
LXVuaXQ6IHRlc3RzL3Rlc3QtY2hhcgpVbmV4cGVjdGVkIGVycm9yIGluIG9iamVjdF9wcm9wZXJ0
eV90cnlfYWRkKCkgYXQgL3RtcC9xZW11LXRlc3Qvc3JjL3FvbS9vYmplY3QuYzoxMTgxOgphdHRl
bXB0IHRvIGFkZCBkdXBsaWNhdGUgcHJvcGVydHkgJ3NlcmlhbC1pZCcgdG8gb2JqZWN0ICh0eXBl
ICdjb250YWluZXInKQpFUlJPUiB0ZXN0LWNoYXIgLSB0b28gZmV3IHRlc3RzIHJ1biAoZXhwZWN0
ZWQgMzgsIGdvdCA5KQptYWtlOiAqKiogW2NoZWNrLXVuaXRdIEVycm9yIDEKbWFrZTogKioqIFdh
aXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBURVNUICAgIGNoZWNrLXF0ZXN0LXg4Nl82
NDogdGVzdHMvcXRlc3QvaGQtZ2VvLXRlc3QKICBURVNUICAgIGNoZWNrLXF0ZXN0LXg4Nl82NDog
dGVzdHMvcXRlc3QvYm9vdC1vcmRlci10ZXN0Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vy
cm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQg
J1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5z
dGFuY2UudXVpZD04YzM2ZmIxNzI3NTc0YzA2OWIyZjE0NDMyYzJiZGRmNycsICctdScsICcxMDAx
JywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywg
J1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0n
LCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScs
ICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNo
ZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAv
cGF0Y2hldy10ZXN0ZXItdG1wLTBjbWMxdjkwL3NyYy9kb2NrZXItc3JjLjIwMjAtMDgtMTctMDAu
MDMuMTYuMTg1OTY6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXUvY2VudG9zNycsICcvdmFyL3Rt
cC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVz
IDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPThjMzZmYjE3
Mjc1NzRjMDY5YjJmMTQ0MzJjMmJkZGY3Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3Ig
MQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1w
LTBjbWMxdjkwL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10g
RXJyb3IgMgoKcmVhbCAgICAxMm0xNC43ODVzCnVzZXIgICAgMG04LjkwMnMKCgpUaGUgZnVsbCBs
b2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwODE3MDMzODAz
LjE0MDE0LTEtUm9ja0N1aS1vY0B6aGFveGluLmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50
b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQ
YXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


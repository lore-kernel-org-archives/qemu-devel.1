Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CD7C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 08:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46EEF2068E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 08:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46EEF2068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVsqL-0008AY-Gi
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 04:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jVspI-0007Kc-Jo; Tue, 05 May 2020 04:21:16 -0400
Resent-Date: Tue, 05 May 2020 04:21:16 -0400
Resent-Message-Id: <E1jVspI-0007Kc-Jo@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21361)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jVspH-0007jY-IJ; Tue, 05 May 2020 04:21:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588666847; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=aYlNpBrvL6cxqA9PT/oqinQT7qk3PWfl/U/XfyuqQv3UZ6a8ObQ63Y5iUma4+reYtEP/m2GPB/yJ2y8EEBVMuEEZfLhDOqm8UUjWgsgCw6t8cE9krwwrBjv0mKRAoCr1sRXUsj2sPJnKCyBbQjTxk8Htm9XBzek/TjecVst+N9k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588666847;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=bpCBdwjsH4fC2bde/hMm1gZMNIFoUz3A85e7Y8PM/yU=; 
 b=idGLsq+5Y16qZ8tnoP4+O+7VVJ7s0vQ7glgGVrNOlYKX0/64xfwaEGMjCbmD3HU6bd07Ji3t6FmNbsxH1zNaKs22lb4P4iZDgy2pu/+sbu/BW+zcG8ATSyziP/qvwhBVAvO+ENg4XPFTWqygPnq9jd7x05Ku8vVDh7lE2rF59hc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588666845237893.9266656505989;
 Tue, 5 May 2020 01:20:45 -0700 (PDT)
Message-ID: <158866684391.24779.12676166219061996884@45ef0f9c86ae>
In-Reply-To: <20200504142308.10446-1-berto@igalia.com>
Subject: Re: [PATCH v2] qcow2: Avoid integer wraparound in qcow2_co_truncate()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berto@igalia.com
Date: Tue, 5 May 2020 01:20:45 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 04:16:46
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUwNDE0MjMwOC4xMDQ0
Ni0xLWJlcnRvQGlnYWxpYS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMjAwNTA0MTQyMzA4LjEwNDQ2LTEtYmVydG9AaWdhbGlh
LmNvbQpTdWJqZWN0OiBbUEFUQ0ggdjJdIHFjb3cyOiBBdm9pZCBpbnRlZ2VyIHdyYXBhcm91bmQg
aW4gcWNvdzJfY29fdHJ1bmNhdGUoKQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlz
dG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNU
IFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJk
ODg4NzEzMzg0CmZhdGFsOiB1bmFibGUgdG8gd3JpdGUgbmV3IGluZGV4IGZpbGUKVHJhY2ViYWNr
IChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgInBhdGNoZXctdGVzdGVyL3NyYy9wYXRj
aGV3LWNsaSIsIGxpbmUgNTIxLCBpbiB0ZXN0X29uZQogICAgZ2l0X2Nsb25lX3JlcG8oY2xvbmUs
IHJbInJlcG8iXSwgclsiaGVhZCJdLCBsb2dmLCBUcnVlKQogIEZpbGUgInBhdGNoZXctdGVzdGVy
L3NyYy9wYXRjaGV3LWNsaSIsIGxpbmUgNTcsIGluIGdpdF9jbG9uZV9yZXBvCiAgICBjd2Q9Y2xv
bmUpCiAgRmlsZSAiL29wdC9yaC9yaC1weXRob24zNi9yb290L3Vzci9saWI2NC9weXRob24zLjYv
c3VicHJvY2Vzcy5weSIsIGxpbmUgMjkxLCBpbiBjaGVja19jYWxsCiAgICByYWlzZSBDYWxsZWRQ
cm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjog
Q29tbWFuZCAnWydnaXQnLCAnY2hlY2tvdXQnLCAncmVmcy90YWdzL3BhdGNoZXcvMjAyMDA1MDQx
NDIzMDguMTA0NDYtMS1iZXJ0b0BpZ2FsaWEuY29tJywgJy1iJywgJ3Rlc3QnXScgcmV0dXJuZWQg
bm9uLXplcm8gZXhpdCBzdGF0dXMgMTI4LgoKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNTA0MTQyMzA4LjEwNDQ2LTEtYmVydG9AaWdh
bGlhLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVy
YXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxl
YXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


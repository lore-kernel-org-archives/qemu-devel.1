Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937CEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 23:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 650762072D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 23:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650762072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeRaa-0004ig-If
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 19:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jeRZb-00039m-Bz
 for qemu-devel@nongnu.org; Thu, 28 May 2020 19:04:27 -0400
Resent-Date: Thu, 28 May 2020 19:04:27 -0400
Resent-Message-Id: <E1jeRZb-00039m-Bz@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jeRZZ-0004tN-9c
 for qemu-devel@nongnu.org; Thu, 28 May 2020 19:04:26 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590707033; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SrSrkSRvU02sLWu+7J3PvSzn6+0BXb+FKVX4USUTtaNnyWpKAWvNYUq/eNm+9ijXX8ba6GCuO0OWIiAugL7ckey8izDaV72edUk7yxM55h3zUaTnVg10bGY2bDDHQMTGbJRM9+jEcs6z0yGsgnFdWDfUlN6r+pauCafc5Gi2hBw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590707033;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=CVJnMxEvhShZN3AJodtOpnT/U3wXSo5RN7R5cO0jHUY=; 
 b=buQmWK2J9uSGg/uoTDe57ZCn+orlr1vKnTmu5I+Ff90n78+KnM7xJ1jskzJNN2CTSOqF7rOZsfoLqDY6aiXe490xiwDEkFo1zjm7tNOnBXmw67krqMd3KZAVsciCjzgdTdY1pfBlUpKOcg/N2gulx0FT7groRbMNyVp9UPgyLfc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590707031720854.0051021062983;
 Thu, 28 May 2020 16:03:51 -0700 (PDT)
Message-ID: <159070702972.20666.6607729006861632036@45ef0f9c86ae>
In-Reply-To: <20200528162011.16258-1-vishal.l.verma@intel.com>
Subject: Re: [PATCH v3 0/3] account for NVDIMM nodes during SRAT generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vishal.l.verma@intel.com
Date: Thu, 28 May 2020 16:03:51 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 19:04:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: lvivier@redhat.com, thuth@redhat.com, xiaoguangrong.eric@gmail.com,
 mst@redhat.com, jingqi.liu@intel.com, dave.hansen@linux.intel.com,
 qemu-devel@nongnu.org, imammedo@redhat.com, vishal.l.verma@intel.com,
 pbonzini@redhat.com, dan.j.williams@intel.com, rth@twiddle.net,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyODE2MjAxMS4xNjI1
OC0xLXZpc2hhbC5sLnZlcm1hQGludGVsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA1MjgxNjIwMTEuMTYyNTgtMS12aXNo
YWwubC52ZXJtYUBpbnRlbC5jb20KU3ViamVjdDogW1BBVENIIHYzIDAvM10gYWNjb3VudCBmb3Ig
TlZESU1NIG5vZGVzIGR1cmluZyBTUkFUIGdlbmVyYXRpb24KVHlwZTogc2VyaWVzCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYv
bnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
YWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJh
c2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0
ZXN0Jwo3ZTlmYTYyIHRlc3RzL2FjcGk6IHVwZGF0ZSBleHBlY3RlZCBTUkFUIGZpbGVzCmU4YzM0
MjcgaHcvYWNwaS1idWlsZDogYWNjb3VudCBmb3IgTlZESU1NIG51bWEgbm9kZXMgaW4gU1JBVAo3
NTk4ZGM5IGRpZmZzLWFsbG93ZWQ6IGFkZCB0aGUgU1JBVCBBTUwgdG8gZGlmZnMtYWxsb3dlZAoK
PT09IE9VVFBVVCBCRUdJTiA9PT0KMS8zIENoZWNraW5nIGNvbW1pdCA3NTk4ZGM5YmM5ODQgKGRp
ZmZzLWFsbG93ZWQ6IGFkZCB0aGUgU1JBVCBBTUwgdG8gZGlmZnMtYWxsb3dlZCkKMi8zIENoZWNr
aW5nIGNvbW1pdCBlOGMzNDI3NDA2MTAgKGh3L2FjcGktYnVpbGQ6IGFjY291bnQgZm9yIE5WRElN
TSBudW1hIG5vZGVzIGluIFNSQVQpCjMvMyBDaGVja2luZyBjb21taXQgN2U5ZmE2MmU5ZDI2ICh0
ZXN0cy9hY3BpOiB1cGRhdGUgZXhwZWN0ZWQgU1JBVCBmaWxlcykKRVJST1I6IERvIG5vdCBhZGQg
ZXhwZWN0ZWQgZmlsZXMgdG9nZXRoZXIgd2l0aCB0ZXN0cywgZm9sbG93IGluc3RydWN0aW9ucyBp
biB0ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LmM6IGJvdGggdGVzdHMvZGF0YS9hY3BpL3Ez
NS9TUkFULmRpbW1weG0gYW5kIHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QtYWxsb3dlZC1k
aWZmLmggZm91bmQKCkVSUk9SOiBEbyBub3QgYWRkIGV4cGVjdGVkIGZpbGVzIHRvZ2V0aGVyIHdp
dGggdGVzdHMsIGZvbGxvdyBpbnN0cnVjdGlvbnMgaW4gdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMt
dGVzdC5jOiBib3RoIHRlc3RzL2RhdGEvYWNwaS9xMzUvU1JBVC5kaW1tcHhtIGFuZCB0ZXN0cy9x
dGVzdC9iaW9zLXRhYmxlcy10ZXN0LWFsbG93ZWQtZGlmZi5oIGZvdW5kCgp0b3RhbDogMiBlcnJv
cnMsIDAgd2FybmluZ3MsIDEgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMy8zIGhhcyBzdHlsZSBwcm9i
bGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBv
c2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4g
TUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0
aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5v
cmcvbG9ncy8yMDIwMDUyODE2MjAxMS4xNjI1OC0xLXZpc2hhbC5sLnZlcm1hQGludGVsLmNvbS90
ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


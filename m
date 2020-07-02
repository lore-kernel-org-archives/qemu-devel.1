Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB38C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8821120885
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8821120885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2OG-0007qA-OO
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jr29v-0004Qu-Vh
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:59 -0400
Resent-Date: Thu, 02 Jul 2020 12:33:59 -0400
Resent-Message-Id: <E1jr29v-0004Qu-Vh@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21371)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jr29t-0000ES-9N
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593707624; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Q9VdFDSUVLTWq49yuRygbxSMEltE6He/pmb/pUSj+0aE1sOkO8oPDxjEEKrYCK3jJ7IRHfGcFUKly2qA2PTRX+lh4nOHaJdEAYk8VQA5HDfDEsjLzjLsUH7JQXT0QoGjPuphEXcg9eCar8qVj4VQHlhXXZyekK4U+QkqCcHI58s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593707624;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=s+8pVPD2IjJnoy4Ne8EUYAkzyno7ETG0HZWke0w8zy0=; 
 b=Qj+k7k9x/M/cUyz2htsoGChVy5u35gjzIOY1nw9RTfsmmW65AqnXS3WCfhMcGq6b9OfMI/t65QndKx2+5v5n/uIzgHxYfV53TQ48m9xmJTKmP2d/TtcXfdUfmTFth79jHle5K1pauXv4MyDMlWpRLLjdT8RUwbgt1Hvo2jUBBpg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593707622002980.0339644533552;
 Thu, 2 Jul 2020 09:33:42 -0700 (PDT)
Message-ID: <159370762085.5963.17288338208584224994@d1fd068a5071>
Subject: Re: [PULL v2 00/12] Linux user for 5.1 patches
In-Reply-To: <20200702152710.84602-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Thu, 2 Jul 2020 09:33:42 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 11:58:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: riku.voipio@iki.fi, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 atar4qemu@gmail.com, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwMjE1MjcxMC44NDYw
Mi0xLWxhdXJlbnRAdml2aWVyLmV1LwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUFVMTCB2MiAwMC8xMl0gTGludXggdXNlciBmb3IgNS4xIHBh
dGNoZXMKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAwNzAyMTUyNzEwLjg0NjAyLTEtbGF1
cmVudEB2aXZpZXIuZXUKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0
IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVj
a3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGcm9t
IGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogICBkMGM4Yjk1Li42NGYw
YWQ4ICBtYXN0ZXIgICAgIC0+IG1hc3RlcgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3
LXByb2plY3QvcWVtdQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMjAwNzAyMTUyNzEw
Ljg0NjAyLTEtbGF1cmVudEB2aXZpZXIuZXUgLT4gcGF0Y2hldy8yMDIwMDcwMjE1MjcxMC44NDYw
Mi0xLWxhdXJlbnRAdml2aWVyLmV1ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKOTEw
MzZmZiBNQUlOVEFJTkVSUzogdXBkYXRlIGxpbnV4LXVzZXIgbWFpbnRhaW5lcgoxMjk5MGI0IGxp
bnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnRzIG9mIGlv
Y3RsKCkKZjU1N2I0YiBsaW51eC11c2VyOiBBZGQgdGh1bmsgYXJndW1lbnQgdHlwZXMgZm9yIFNJ
T0NHU1RBTVAgYW5kIFNJT0NHU1RBTVBOUwplZGI0Y2NhIGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ug
c3VwcG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnRzIG9mIGZhbGxvY2F0ZSgpCjM2NjJiNDcgbGlu
dXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBwcmludGluZyBhcmd1bWVudHMgb2YgY2hv
d24oKS9sY2hvd24oKQpjODk0MWY5IGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3Ig
cHJpbnRpbmcgYXJndW1lbnRzIG9mIGxzZWVrKCkKNzY3OTM5NCBsaW51eC11c2VyOiBBZGQgc3Ry
YWNlIHN1cHBvcnQgZm9yIHByaW50aW5nIGFyZ3VtZW50IG9mIHN5c2NhbGxzIHVzZWQgZm9yIGV4
dGVuZGVkIGF0dHJpYnV0ZXMKZjUwM2RmOCBsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQg
Zm9yIGEgZ3JvdXAgb2Ygc3lzY2FsbHMKNmVhZGUyNiBsaW51eC11c2VyOiBFeHRlbmQgc3RyYWNl
IHN1cHBvcnQgdG8gZW5hYmxlIGFyZ3VtZW50IHByaW50aW5nIGFmdGVyIHN5c2NhbGwgZXhlY3V0
aW9uCjQ0NzcwMzQgbGludXgtdXNlcjogc3lzY2FsbDogaW9jdGxzOiBzdXBwb3J0IERSTV9JT0NU
TF9WRVJTSU9OCjYwYmI4MzUgbGludXgtdXNlci9zcGFyYzY0OiBGaXggdGhlIGhhbmRsaW5nIG9m
IHdpbmRvdyBzcGlsbCB0cmFwCjk4YzMwYmEgdGFyZ2V0L3NwYXJjOiBUcmFuc2xhdGUgZmx1c2h3
IG9wY29kZQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xMiBDaGVja2luZyBjb21taXQgOThjMzBi
YWFkODI1ICh0YXJnZXQvc3BhcmM6IFRyYW5zbGF0ZSBmbHVzaHcgb3Bjb2RlKQoyLzEyIENoZWNr
aW5nIGNvbW1pdCA2MGJiODM1ZGFlMjMgKGxpbnV4LXVzZXIvc3BhcmM2NDogRml4IHRoZSBoYW5k
bGluZyBvZiB3aW5kb3cgc3BpbGwgdHJhcCkKMy8xMiBDaGVja2luZyBjb21taXQgNDQ3NzAzNGFi
NTdjIChsaW51eC11c2VyOiBzeXNjYWxsOiBpb2N0bHM6IHN1cHBvcnQgRFJNX0lPQ1RMX1ZFUlNJ
T04pCjQvMTIgQ2hlY2tpbmcgY29tbWl0IDZlYWRlMjZhNzljOCAobGludXgtdXNlcjogRXh0ZW5k
IHN0cmFjZSBzdXBwb3J0IHRvIGVuYWJsZSBhcmd1bWVudCBwcmludGluZyBhZnRlciBzeXNjYWxs
IGV4ZWN1dGlvbikKNS8xMiBDaGVja2luZyBjb21taXQgZjUwM2RmODI0MzFiIChsaW51eC11c2Vy
OiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIGEgZ3JvdXAgb2Ygc3lzY2FsbHMpCjYvMTIgQ2hlY2tp
bmcgY29tbWl0IDc2NzkzOTQ5ZTE3ZCAobGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZv
ciBwcmludGluZyBhcmd1bWVudCBvZiBzeXNjYWxscyB1c2VkIGZvciBleHRlbmRlZCBhdHRyaWJ1
dGVzKQo3LzEyIENoZWNraW5nIGNvbW1pdCBjODk0MWY5NzdjYzEgKGxpbnV4LXVzZXI6IEFkZCBz
dHJhY2Ugc3VwcG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnRzIG9mIGxzZWVrKCkpCjgvMTIgQ2hl
Y2tpbmcgY29tbWl0IDM2NjJiNDdkMWMzOSAobGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0
IGZvciBwcmludGluZyBhcmd1bWVudHMgb2YgY2hvd24oKS9sY2hvd24oKSkKOS8xMiBDaGVja2lu
ZyBjb21taXQgZWRiNGNjYTJjNzI0IChsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9y
IHByaW50aW5nIGFyZ3VtZW50cyBvZiBmYWxsb2NhdGUoKSkKRVJST1I6IHN0b3JhZ2UgY2xhc3Mg
c2hvdWxkIGJlIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGRlY2xhcmF0aW9uCiM3MjogRklMRTog
bGludXgtdXNlci9zdHJhY2UuYzoxMTM4OgorVU5VU0VEIHN0YXRpYyBzdHJ1Y3QgZmxhZ3MgZmFs
bG9jX2ZsYWdzW10gPSB7Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDEwNCBsaW5lcyBj
aGVja2VkCgpQYXRjaCA5LzEyIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoxMC8xMiBDaGVj
a2luZyBjb21taXQgZjU1N2I0YmM1MmI4IChsaW51eC11c2VyOiBBZGQgdGh1bmsgYXJndW1lbnQg
dHlwZXMgZm9yIFNJT0NHU1RBTVAgYW5kIFNJT0NHU1RBTVBOUykKMTEvMTIgQ2hlY2tpbmcgY29t
bWl0IDEyOTkwYjRjYWUxMyAobGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBwcmlu
dGluZyBhcmd1bWVudHMgb2YgaW9jdGwoKSkKMTIvMTIgQ2hlY2tpbmcgY29tbWl0IDkxMDM2ZmY5
MzU5NCAoTUFJTlRBSU5FUlM6IHVwZGF0ZSBsaW51eC11c2VyIG1haW50YWluZXIpCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBs
b2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNzAyMTUyNzEw
Ljg0NjAyLTEtbGF1cmVudEB2aXZpZXIuZXUvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3Nh
Z2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t


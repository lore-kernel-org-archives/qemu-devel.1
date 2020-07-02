Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6315EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D23206BE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D23206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr1p8-0005i4-Ey
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jr1cB-0007W9-Lv
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:59:07 -0400
Resent-Date: Thu, 02 Jul 2020 11:59:07 -0400
Resent-Message-Id: <E1jr1cB-0007W9-Lv@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jr1c5-0007n8-C8
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:59:07 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593705526; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Lpx2km515gMGT3kgzM3+yaucwsZtPaSyG3nbz+9uggQw3Tk3dlPwoED7dbAxWBdzY8Jemva1jwcrhcf/NLMcjlk9o+DgOwj2dB1XS17aSMvr2+yGca214kfUwt8FxrKtla1fpaBCfyvCPu3/23HZUw2PBIl+EMwHpTQVfyYBLYw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593705526;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=DFkG7F3nMdFLa7dAS2cPgu8tiup4soZ33oWKNBgnfhw=; 
 b=lV+W0PTUNNFJZjIBbhQ5DZfepJBu+HPYHg8is0T0o6I49HuECbmhgwjNoR9vUdzbCo8weNCjfFq5Sk8La9X0ZfxK9zeQbENXE7qqHaJelo3z54aYd+chHXFZy9gK1pKViMzCz+yJze0lwh8BZOF8h6NRJahKn1R0ddRnRrGZdwY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593705524072714.0938991712497;
 Thu, 2 Jul 2020 08:58:44 -0700 (PDT)
Message-ID: <159370552285.5308.3321817255741552406@d1fd068a5071>
Subject: Re: [PULL v2 00/12] Linux user for 5.1 patches
In-Reply-To: <20200702152710.84602-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Thu, 2 Jul 2020 08:58:44 -0700 (PDT)
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
IGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogLSBbdGFnIHVwZGF0ZV0g
ICAgICBwYXRjaGV3LzIwMjAwNzAyMTUyNzEwLjg0NjAyLTEtbGF1cmVudEB2aXZpZXIuZXUgLT4g
cGF0Y2hldy8yMDIwMDcwMjE1MjcxMC44NDYwMi0xLWxhdXJlbnRAdml2aWVyLmV1ClN3aXRjaGVk
IHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYjgyYTlmNiBNQUlOVEFJTkVSUzogdXBkYXRlIGxpbnV4
LXVzZXIgbWFpbnRhaW5lcgpjNTI2ZGMxIGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBm
b3IgcHJpbnRpbmcgYXJndW1lbnRzIG9mIGlvY3RsKCkKMjQzNWViZiBsaW51eC11c2VyOiBBZGQg
dGh1bmsgYXJndW1lbnQgdHlwZXMgZm9yIFNJT0NHU1RBTVAgYW5kIFNJT0NHU1RBTVBOUwo1MmYw
MDAyIGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnRz
IG9mIGZhbGxvY2F0ZSgpCmU0ODcxZjcgbGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZv
ciBwcmludGluZyBhcmd1bWVudHMgb2YgY2hvd24oKS9sY2hvd24oKQphZDgyZTFhIGxpbnV4LXVz
ZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnRzIG9mIGxzZWVrKCkK
ODU2N2VmOCBsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIHByaW50aW5nIGFyZ3Vt
ZW50IG9mIHN5c2NhbGxzIHVzZWQgZm9yIGV4dGVuZGVkIGF0dHJpYnV0ZXMKZDNkNWRhMSBsaW51
eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIGEgZ3JvdXAgb2Ygc3lzY2FsbHMKODQyNmY4
OCBsaW51eC11c2VyOiBFeHRlbmQgc3RyYWNlIHN1cHBvcnQgdG8gZW5hYmxlIGFyZ3VtZW50IHBy
aW50aW5nIGFmdGVyIHN5c2NhbGwgZXhlY3V0aW9uCmM2N2ExN2IgbGludXgtdXNlcjogc3lzY2Fs
bDogaW9jdGxzOiBzdXBwb3J0IERSTV9JT0NUTF9WRVJTSU9OCmE2Y2ZiYzAgbGludXgtdXNlci9z
cGFyYzY0OiBGaXggdGhlIGhhbmRsaW5nIG9mIHdpbmRvdyBzcGlsbCB0cmFwCmU2OTkwNmUgdGFy
Z2V0L3NwYXJjOiBUcmFuc2xhdGUgZmx1c2h3IG9wY29kZQoKPT09IE9VVFBVVCBCRUdJTiA9PT0K
MS8xMiBDaGVja2luZyBjb21taXQgZTY5OTA2ZTNmNTRkICh0YXJnZXQvc3BhcmM6IFRyYW5zbGF0
ZSBmbHVzaHcgb3Bjb2RlKQoyLzEyIENoZWNraW5nIGNvbW1pdCBhNmNmYmMwNTc0YTIgKGxpbnV4
LXVzZXIvc3BhcmM2NDogRml4IHRoZSBoYW5kbGluZyBvZiB3aW5kb3cgc3BpbGwgdHJhcCkKMy8x
MiBDaGVja2luZyBjb21taXQgYzY3YTE3YjA2OGY4IChsaW51eC11c2VyOiBzeXNjYWxsOiBpb2N0
bHM6IHN1cHBvcnQgRFJNX0lPQ1RMX1ZFUlNJT04pCjQvMTIgQ2hlY2tpbmcgY29tbWl0IDg0MjZm
ODgyZGRjMiAobGludXgtdXNlcjogRXh0ZW5kIHN0cmFjZSBzdXBwb3J0IHRvIGVuYWJsZSBhcmd1
bWVudCBwcmludGluZyBhZnRlciBzeXNjYWxsIGV4ZWN1dGlvbikKNS8xMiBDaGVja2luZyBjb21t
aXQgZDNkNWRhMWJlNTNmIChsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIGEgZ3Jv
dXAgb2Ygc3lzY2FsbHMpCjYvMTIgQ2hlY2tpbmcgY29tbWl0IDg1NjdlZjg3NDA0MyAobGludXgt
dXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBwcmludGluZyBhcmd1bWVudCBvZiBzeXNjYWxs
cyB1c2VkIGZvciBleHRlbmRlZCBhdHRyaWJ1dGVzKQo3LzEyIENoZWNraW5nIGNvbW1pdCBhZDgy
ZTFhMTU0MjAgKGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3IgcHJpbnRpbmcgYXJn
dW1lbnRzIG9mIGxzZWVrKCkpCjgvMTIgQ2hlY2tpbmcgY29tbWl0IGU0ODcxZjdkNDM2YSAobGlu
dXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBwcmludGluZyBhcmd1bWVudHMgb2YgY2hv
d24oKS9sY2hvd24oKSkKOS8xMiBDaGVja2luZyBjb21taXQgNTJmMDAwMjJhNzM1IChsaW51eC11
c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIHByaW50aW5nIGFyZ3VtZW50cyBvZiBmYWxsb2Nh
dGUoKSkKRVJST1I6IHN0b3JhZ2UgY2xhc3Mgc2hvdWxkIGJlIGF0IHRoZSBiZWdpbm5pbmcgb2Yg
dGhlIGRlY2xhcmF0aW9uCiM3MjogRklMRTogbGludXgtdXNlci9zdHJhY2UuYzoxMTM4OgorVU5V
U0VEIHN0YXRpYyBzdHJ1Y3QgZmxhZ3MgZmFsbG9jX2ZsYWdzW10gPSB7Cgp0b3RhbDogMSBlcnJv
cnMsIDAgd2FybmluZ3MsIDEwNCBsaW5lcyBjaGVja2VkCgpQYXRjaCA5LzEyIGhhcyBzdHlsZSBw
cm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNl
IHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0gg
aW4gTUFJTlRBSU5FUlMuCgoxMC8xMiBDaGVja2luZyBjb21taXQgMjQzNWViZmYzOTNlIChsaW51
eC11c2VyOiBBZGQgdGh1bmsgYXJndW1lbnQgdHlwZXMgZm9yIFNJT0NHU1RBTVAgYW5kIFNJT0NH
U1RBTVBOUykKMTEvMTIgQ2hlY2tpbmcgY29tbWl0IGM1MjZkYzFlOGQ0MCAobGludXgtdXNlcjog
QWRkIHN0cmFjZSBzdXBwb3J0IGZvciBwcmludGluZyBhcmd1bWVudHMgb2YgaW9jdGwoKSkKMTIv
MTIgQ2hlY2tpbmcgY29tbWl0IGI4MmE5ZjZmN2NmZSAoTUFJTlRBSU5FUlM6IHVwZGF0ZSBsaW51
eC11c2VyIG1haW50YWluZXIpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRl
ZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRj
aGV3Lm9yZy9sb2dzLzIwMjAwNzAyMTUyNzEwLjg0NjAyLTEtbGF1cmVudEB2aXZpZXIuZXUvdGVz
dGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21h
dGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlv
dXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


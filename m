Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7856C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 17:16:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B71320883
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 17:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B71320883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56432 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDXsT-0006en-O8
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 13:16:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hDXrF-0006CJ-US
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 13:14:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hDXrC-00017G-81
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 13:14:57 -0400
Resent-Date: Mon, 08 Apr 2019 13:14:57 -0400
Resent-Message-Id: <E1hDXrC-00017G-81@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hDXrB-00016X-Tv
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 13:14:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1554742774; cv=none; d=zoho.com; s=zohoarc; 
	b=B6E/VSRRh+nXyC1M9gfetYZaAIFwJK5MF/7D9v8nE2mYmX38cHrtwdKzrhKCbBjiIIKPIUu6rN57yp3tpBr7QbXau5QVLdpSv3dlIOBWS3RnVVOjZABOtosXXBBAaV+fjFCUynJuzvXW1aI15ZeThRIHMeCnDZrIjOP+KtAlAMg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1554742774;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=spfDvz7bWDHfJpJudHtaTDC7hs/QTyucaPnf5wbMDTk=; 
	b=GXmVSAyg1Lgh6jOd6mKgOzlDgb4AoWQbuUSsDi8qhIMCAbKtc77wfjkOEu4Nr/MWBWyJERkaePvdAw9ZFDHDZdfvjiPXIRR1F7QQZ2YtxopphqpP3kylB9VL6lbOpUjj+L+rresNt6KhMmr4dTT1fBpCk55m2VuzbllcTz9wfn0=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1554742772343791.7466667457867;
	Mon, 8 Apr 2019 09:59:32 -0700 (PDT)
Message-ID: <155474277106.12882.8346453217758632698@76452e4e88f2>
In-Reply-To: <20190408145721.15881-1-sohailalvi2236@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: sohailalvi2236@gmail.com
Date: Mon, 8 Apr 2019 09:59:32 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH] qemu_system_reset_request() in hw/
 corresponding to watchdog that has triggered replaced by
 watchdog_perform_action().
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: fam@euphon.net, sohailalvi2236@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408165932.s-17MXo-r_9a9IRDJEcXZ2N8_gRzOaz8phqY0W6rsLM@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQwODE0NTcyMS4xNTg4
MS0xLXNvaGFpbGFsdmkyMjM2QGdtYWlsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA0MDgxNDU3MjEuMTU4ODEtMS1zb2hh
aWxhbHZpMjIzNkBnbWFpbC5jb20KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gcWVtdV9z
eXN0ZW1fcmVzZXRfcmVxdWVzdCgpIGluIGh3LyBjb3JyZXNwb25kaW5nIHRvIHdhdGNoZG9nIHRo
YXQgaGFzIHRyaWdnZXJlZCByZXBsYWNlZCBieSB3YXRjaGRvZ19wZXJmb3JtX2FjdGlvbigpLgpU
eXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJl
di1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3Bh
dGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGlu
ZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9n
aXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAgIGY1NWE1ODVkMTAuLjJjNTczMTA2Mjcg
IG1hc3RlciAgICAgLT4gbWFzdGVyCiAqIFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcv
MjAxOTA0MDgxNDU3MjEuMTU4ODEtMS1zb2hhaWxhbHZpMjIzNkBnbWFpbC5jb20gLT4gcGF0Y2hl
dy8yMDE5MDQwODE0NTcyMS4xNTg4MS0xLXNvaGFpbGFsdmkyMjM2QGdtYWlsLmNvbQpTd2l0Y2hl
ZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjA1Njg2ZjliOTEgcWVtdV9zeXN0ZW1fcmVzZXRfcmVx
dWVzdCgpIGluIGh3LyBjb3JyZXNwb25kaW5nIHRvIHdhdGNoZG9nIHRoYXQgaGFzIHRyaWdnZXJl
ZCByZXBsYWNlZCBieSB3YXRjaGRvZ19wZXJmb3JtX2FjdGlvbigpLgoKPT09IE9VVFBVVCBCRUdJ
TiA9PT0KRVJST1I6IE1pc3NpbmcgU2lnbmVkLW9mZi1ieTogbGluZShzKQoKdG90YWw6IDEgZXJy
b3JzLCAwIHdhcm5pbmdzLCA5MCBsaW5lcyBjaGVja2VkCgpDb21taXQgMDU2ODZmOWI5MTBkIChx
ZW11X3N5c3RlbV9yZXNldF9yZXF1ZXN0KCkgaW4gaHcvIGNvcnJlc3BvbmRpbmcgdG8gd2F0Y2hk
b2cgdGhhdCBoYXMgdHJpZ2dlcmVkIHJlcGxhY2VkIGJ5IHdhdGNoZG9nX3BlcmZvcm1fYWN0aW9u
KCkuKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2Ug
ZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIs
IHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3Qg
Y29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBh
dApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDQwODE0NTcyMS4xNTg4MS0xLXNvaGFpbGFs
dmkyMjM2QGdtYWlsLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=



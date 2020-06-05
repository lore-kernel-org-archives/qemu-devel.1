Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22342C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8C10207D8
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C10207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGSS-0003KQ-Vv
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jhGQt-0001gH-FM
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:47:07 -0400
Resent-Date: Fri, 05 Jun 2020 13:47:07 -0400
Resent-Message-Id: <E1jhGQt-0001gH-FM@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jhGQp-0005yy-Kv
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:47:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591379190; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FX38wTXXaCjDNYSWvYhzD+Ogco66boX7bEwchOfBivEWKgrPe/hOo1YVgx2gNs2OzER8zu7wypHlSnJav/kgEwBjSi9CWAbM0MVgrg8U5ANYPT+tY79YikN4Aw/sVqVd+3GPeAJ9h5PMcfc0vPY8OdUaMPx+wCbhtvnWu6hczCI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591379190;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=ScF5pwIxktt/GLKghcfezYAbonWknY8mZ/cn//Kk4Gk=; 
 b=mNF2UA9HBAEKtii+ECgPa4tZ/oeNUhxpd2aDwiX/p3UDi1f8D5exMeIRdig5wrU1ukxrUbOwkgTjFFEdIXPkrrJOw0cubb88AKEnZz5Uqt4oeXP0MDonwdLLfB8BTNhVrHHoyRmjEqPfzLQ5/3OFOMiWZjGJN0AfbcDpPqhCGgc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591379189222285.3644918305872;
 Fri, 5 Jun 2020 10:46:29 -0700 (PDT)
Message-ID: <159137918813.19958.3312068283334040313@45ef0f9c86ae>
In-Reply-To: <20200605154929.26910-1-alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 00/14] various fixes for next PR (testing, vhost,
 guest_base fixes)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Fri, 5 Jun 2020 10:46:29 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 13:46:34
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYwNTE1NDkyOS4yNjkx
MC0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMjAwNjA1MTU0OTI5LjI2OTEwLTEtYWxleC5i
ZW5uZWVAbGluYXJvLm9yZwpTdWJqZWN0OiBbUEFUQ0ggIHYxIDAwLzE0XSB2YXJpb3VzIGZpeGVz
IGZvciBuZXh0IFBSICh0ZXN0aW5nLCB2aG9zdCwgZ3Vlc3RfYmFzZSBmaXhlcykKVHlwZTogc2Vy
aWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2Ug
YmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1l
bGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAt
LWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAt
LW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1
YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNv
bS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAw
NjA1MTY1MDA3LjEyMDk1LTEtcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnIC0+IHBhdGNoZXcvMjAy
MDA2MDUxNjUwMDcuMTIwOTUtMS1wZXRlci5tYXlkZWxsQGxpbmFyby5vcmcKICogW25ldyB0YWdd
ICAgICAgICAgcGF0Y2hldy8yMDIwMDYwNTE2NTY1Ni4xNzU3OC0xLXBoaWxtZEByZWRoYXQuY29t
IC0+IHBhdGNoZXcvMjAyMDA2MDUxNjU2NTYuMTc1NzgtMS1waGlsbWRAcmVkaGF0LmNvbQpBdXRv
IHBhY2tpbmcgdGhlIHJlcG9zaXRvcnkgZm9yIG9wdGltdW0gcGVyZm9ybWFuY2UuIFlvdSBtYXkg
YWxzbwpydW4gImdpdCBnYyIgbWFudWFsbHkuIFNlZSAiZ2l0IGhlbHAgZ2MiIGZvciBtb3JlIGlu
Zm9ybWF0aW9uLgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjhjMTkyYzggbGludXgt
dXNlcjogZGV0ZWN0IG92ZXJmbG93IG9mIE1BUF9GSVhFRCBtbWFwCjM0M2IxMTQgdGVzdHMvdGNn
OiBhZGQgc2ltcGxlIGNvbW1wYWdlIHRlc3QgY2FzZQozZWE5YjZiIGxpbnV4LXVzZXI6IGRlYWwg
d2l0aCBhZGRyZXNzIHdyYXAgZm9yIEFSTV9DT01NUEFHRSBvbiAzMiBiaXQKYmQxMGRmNiBsaW51
eC11c2VyOiBwcm92aWRlIGZhbGxiYWNrIHBnZF9maW5kX2hvbGUgZm9yIGJhcmUgY2hyb290cwox
NDBhNGIwIGh3L3ZpcnRpby92aG9zdDogcmUtZmFjdG9yIHZob3N0LXNlY3Rpb24gYW5kIGFsbG93
IERJUlRZX01FTU9SWV9DT0RFCmMzZmRlYjkgZG9ja2VyOiB1cGRhdGUgVWJ1bnR1IHRvIDIwLjA0
CjM4MjdhMTcgdGVzdHMvZG9ja2VyOiBmaXggcHJlLXJlcXVpc2l0ZSBmb3IgZGViaWFuLXRyaWNv
cmUtY3Jvc3MKMDBiYTBkZiBpb3Rlc3RzOiAxOTQ6IHdhaXQgbWlncmF0aW9uIGNvbXBsZXRpb24g
b24gdGFyZ2V0IHRvbwo4MjUyZTE0IC5zaGlwcGFibGU6IHRlbXBvcmFpbHkgZGlzYWJsZSBzb21l
IGNyb3NzIGJ1aWxkcwoxMDI3YTk1IC50cmF2aXMueW1sOiBhbGxvdyBmYWlsdXJlIGZvciB1bnJl
bGlhYmxlIGhvc3RzCmQ1NDU1MTMgZXhlYzogZmx1c2ggdGhlIHdob2xlIFRMQiBpZiBhIHdhdGNo
cG9pbnQgY3Jvc3NlcyBhIHBhZ2UgYm91bmRhcnkKYzI4NjczMCB0ZXN0cy9wbHVnaW46IGNvcnJl
Y3RseSBob25vdXIgaW9fY291bnQKNTczNzQ1ZiBzY3JpcHRzL2NsZWFuLWluY2x1ZGVzOiBNYXJr
ICdxZW11L3FlbXUtcGx1Z2luLmgnIGFzIHNwZWNpYWwgaGVhZGVyCjU5MmRlNzYgcWVtdS1wbHVn
aW4uaDogYWRkIG1pc3NpbmcgaW5jbHVkZSA8c3RkZGVmLmg+IHRvIGRlZmluZSBzaXplX3QKCj09
PSBPVVRQVVQgQkVHSU4gPT09CjEvMTQgQ2hlY2tpbmcgY29tbWl0IDU5MmRlNzY2MDZhNyAocWVt
dS1wbHVnaW4uaDogYWRkIG1pc3NpbmcgaW5jbHVkZSA8c3RkZGVmLmg+IHRvIGRlZmluZSBzaXpl
X3QpCjIvMTQgQ2hlY2tpbmcgY29tbWl0IDU3Mzc0NWZhNzdjZCAoc2NyaXB0cy9jbGVhbi1pbmNs
dWRlczogTWFyayAncWVtdS9xZW11LXBsdWdpbi5oJyBhcyBzcGVjaWFsIGhlYWRlcikKMy8xNCBD
aGVja2luZyBjb21taXQgYzI4NjczMGUyZTZhICh0ZXN0cy9wbHVnaW46IGNvcnJlY3RseSBob25v
dXIgaW9fY291bnQpCjQvMTQgQ2hlY2tpbmcgY29tbWl0IGQ1NDU1MTNmMDdiNSAoZXhlYzogZmx1
c2ggdGhlIHdob2xlIFRMQiBpZiBhIHdhdGNocG9pbnQgY3Jvc3NlcyBhIHBhZ2UgYm91bmRhcnkp
CjUvMTQgQ2hlY2tpbmcgY29tbWl0IDEwMjdhOTVhMjMwMCAoLnRyYXZpcy55bWw6IGFsbG93IGZh
aWx1cmUgZm9yIHVucmVsaWFibGUgaG9zdHMpCjYvMTQgQ2hlY2tpbmcgY29tbWl0IDgyNTJlMTQ1
N2Q5MSAoLnNoaXBwYWJsZTogdGVtcG9yYWlseSBkaXNhYmxlIHNvbWUgY3Jvc3MgYnVpbGRzKQo3
LzE0IENoZWNraW5nIGNvbW1pdCAwMGJhMGRmYTM5MTEgKGlvdGVzdHM6IDE5NDogd2FpdCBtaWdy
YXRpb24gY29tcGxldGlvbiBvbiB0YXJnZXQgdG9vKQo4LzE0IENoZWNraW5nIGNvbW1pdCAzODI3
YTE3MTk5YmYgKHRlc3RzL2RvY2tlcjogZml4IHByZS1yZXF1aXNpdGUgZm9yIGRlYmlhbi10cmlj
b3JlLWNyb3NzKQo5LzE0IENoZWNraW5nIGNvbW1pdCBjM2ZkZWI5YjBhNDQgKGRvY2tlcjogdXBk
YXRlIFVidW50dSB0byAyMC4wNCkKMTAvMTQgQ2hlY2tpbmcgY29tbWl0IDE0MGE0YjBjNjc5ZiAo
aHcvdmlydGlvL3Zob3N0OiByZS1mYWN0b3Igdmhvc3Qtc2VjdGlvbiBhbmQgYWxsb3cgRElSVFlf
TUVNT1JZX0NPREUpCjExLzE0IENoZWNraW5nIGNvbW1pdCBiZDEwZGY2ZTdhZmYgKGxpbnV4LXVz
ZXI6IHByb3ZpZGUgZmFsbGJhY2sgcGdkX2ZpbmRfaG9sZSBmb3IgYmFyZSBjaHJvb3RzKQpXQVJO
SU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojNDY6IEZJTEU6IGxpbnV4LXVzZXIvZWxmbG9h
ZC5jOjIxMTY6CitzdGF0aWMgdWludHB0cl90IHBnZF9maW5kX2hvbGVfZmFsbGJhY2sodWludHB0
cl90IGd1ZXN0X3NpemUsIHVpbnRwdHJfdCBicmssIGxvbmcgYWxpZ24pCgp0b3RhbDogMCBlcnJv
cnMsIDEgd2FybmluZ3MsIDYwIGxpbmVzIGNoZWNrZWQKClBhdGNoIDExLzE0IGhhcyBzdHlsZSBw
cm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNl
IHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0gg
aW4gTUFJTlRBSU5FUlMuCjEyLzE0IENoZWNraW5nIGNvbW1pdCAzZWE5YjZiYWM4ZTggKGxpbnV4
LXVzZXI6IGRlYWwgd2l0aCBhZGRyZXNzIHdyYXAgZm9yIEFSTV9DT01NUEFHRSBvbiAzMiBiaXQp
CjEzLzE0IENoZWNraW5nIGNvbW1pdCAzNDNiMTE0MTgwNDQgKHRlc3RzL3RjZzogYWRkIHNpbXBs
ZSBjb21tcGFnZSB0ZXN0IGNhc2UpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZp
bGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzMwOiAKbmV3IGZpbGUgbW9k
ZSAxMDA2NDQKCkVSUk9SOiBVc2Ugb2Ygdm9sYXRpbGUgaXMgdXN1YWxseSB3cm9uZywgcGxlYXNl
IGFkZCBhIGNvbW1lbnQKIzU5OiBGSUxFOiB0ZXN0cy90Y2cvYXJtL2NvbW1wYWdlLmM6MjU6Cit0
eXBlZGVmIGludCAoY21weGNoZ19mbikoaW50IG9sZHZhbCwgaW50IG5ld3ZhbCwgdm9sYXRpbGUg
aW50ICpwdHIpOwoKRVJST1I6IFVzZSBvZiB2b2xhdGlsZSBpcyB1c3VhbGx5IHdyb25nLCBwbGVh
c2UgYWRkIGEgY29tbWVudAojNjU6IEZJTEU6IHRlc3RzL3RjZy9hcm0vY29tbXBhZ2UuYzozMToK
KyAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvbGF0aWxlIGludDY0X3QgKnB0cik7Cgp0b3Rh
bDogMiBlcnJvcnMsIDEgd2FybmluZ3MsIDY5IGxpbmVzIGNoZWNrZWQKClBhdGNoIDEzLzE0IGhh
cyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMK
YXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNI
RUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoxNC8xNCBDaGVja2luZyBjb21taXQgOGMxOTJjODc1
MWMzIChsaW51eC11c2VyOiBkZXRlY3Qgb3ZlcmZsb3cgb2YgTUFQX0ZJWEVEIG1tYXApCj09PSBP
VVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNjA1MTU0
OTI5LjI2OTEwLTEtYWxleC5iZW5uZWVAbGluYXJvLm9yZy90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5
cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcg
W2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRj
aGV3LWRldmVsQHJlZGhhdC5jb20=


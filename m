Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6497C28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 09:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A83FE20A8B
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 09:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83FE20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXLOO-0001AI-QS
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 05:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jXLNs-0000lT-OU
 for qemu-devel@nongnu.org; Sat, 09 May 2020 05:03:00 -0400
Resent-Date: Sat, 09 May 2020 05:03:00 -0400
Resent-Message-Id: <E1jXLNs-0000lT-OU@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21335)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jXLNq-0006QT-VU
 for qemu-devel@nongnu.org; Sat, 09 May 2020 05:03:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589014971; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lmaSD1XtGsPmQa+X0EMzhp2esLESUx2D2YLiw33AiHd9DS25ORuEa7XgFp5HAxSVq8nSqldroW37HQU4646A3dV3Ff19YY983E3uLeBhJBaNsxgAAAQiw018qtc1eb9jejIQBpz9DQwRxwAQZLlPcx0W5W3dPBMjEspTVmLRKs4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589014971;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=hCL69O+Byw8sUNqPA8K/8ZYPGRF3bbGjMqE1eouqx3I=; 
 b=A44GY8G3ExRHcmsaXAuwZK2YIz1zPcmgAJcNLlSnCA31fEvlQqbBdlXxBrkxaymgbjhUIXt4Ta4fhQIFAuKbNbxjQOjZ6howQKuBKh1jWu+PBbgmy0UMixDtzOVeY9DxCdZC0ciGAy2c2tWlslwbybwYLotISOX9WxNuChTf1gg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589014970330266.368054946802;
 Sat, 9 May 2020 02:02:50 -0700 (PDT)
Message-ID: <158901496926.29981.17086309256090783321@45ef0f9c86ae>
In-Reply-To: <20200508154359.7494-1-richard.henderson@linaro.org>
Subject: Re: [PATCH v5 00/19] target/arm: sve load/store improvements
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Sat, 9 May 2020 02:02:50 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/09 04:07:40
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUwODE1NDM1OS43NDk0
LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVt
cyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZv
cgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA1MDgxNTQzNTkuNzQ5NC0xLXJp
Y2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcKU3ViamVjdDogW1BBVENIIHY1IDAwLzE5XSB0YXJn
ZXQvYXJtOiBzdmUgbG9hZC9zdG9yZSBpbXByb3ZlbWVudHMKVHlwZTogc2VyaWVzCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYv
bnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
YWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJh
c2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIx
NjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjY0
NTllN2EgdGFyZ2V0L2FybTogUmVtb3ZlIHN2ZV9tZW1vcGlkeAo3MjA1MjQyIHRhcmdldC9hcm06
IFJldXNlIHN2ZV9wcm9iZV9wYWdlIGZvciBnYXRoZXIgbG9hZHMKZWRiYWFiOSB0YXJnZXQvYXJt
OiBSZXVzZSBzdmVfcHJvYmVfcGFnZSBmb3Igc2NhdHRlciBzdG9yZXMKNmZjMzczNCB0YXJnZXQv
YXJtOiBSZXVzZSBzdmVfcHJvYmVfcGFnZSBmb3IgZ2F0aGVyIGZpcnN0LWZhdWx0IGxvYWRzCjRh
NDlkMDUgdGFyZ2V0L2FybTogVXNlIFNWRUNvbnRMZFN0IGZvciBjb250aWd1b3VzIHN0b3Jlcwpj
M2FkYjZhIHRhcmdldC9hcm06IFVwZGF0ZSBjb250aWd1b3VzIGZpcnN0LWZhdWx0IGFuZCBuby1m
YXVsdCBsb2Fkcwo4YThiNzcwIHRhcmdldC9hcm06IFVzZSBTVkVDb250TGRTdCBmb3IgbXVsdGkt
cmVnaXN0ZXIgY29udGlndW91cyBsb2FkcwozODlkMjliIHRhcmdldC9hcm06IEhhbmRsZSB3YXRj
aHBvaW50cyBpbiBzdmVfbGQxX3IKNjNkMjYyOCB0YXJnZXQvYXJtOiBVc2UgU1ZFQ29udExkU3Qg
aW4gc3ZlX2xkMV9yCjQ2OWY5MmIgdGFyZ2V0L2FybTogQWRqdXN0IGludGVyZmFjZSBvZiBzdmVf
bGQxX2hvc3RfZm4KMTJiYmQwNyB0YXJnZXQvYXJtOiBBZGQgc3ZlIGluZnJhc3RydWN0dXJlIGZv
ciBwYWdlIGxvb2t1cAoxNGUwZTQ5IHRhcmdldC9hcm06IERyb3AgbWFudWFsIGhhbmRsaW5nIG9m
IHNldC9jbGVhcl9oZWxwZXJfcmV0YWRkcgo2MmU0MzUxIHRhcmdldC9hcm06IFVzZSBjcHVfKl9k
YXRhX3JhIGZvciBzdmVfbGRzdF90bGJfZm4KZDkwNDgwMSBhY2NlbC90Y2c6IEFkZCBlbmRpYW4t
c3BlY2lmaWMgY3B1X3tsZCwgc3R9KiBvcGVyYXRpb25zCjA1NTE0MjUgYWNjZWwvdGNnOiBBZGQg
cHJvYmVfYWNjZXNzX2ZsYWdzCjY0ZDAwMTcgYWNjZWwvdGNnOiBBZGp1c3QgcHJvYmVfYWNjZXNz
IGNhbGwgdG8gcGFnZV9jaGVja19yYW5nZQozNWZkMmZmIGFjY2VsL3RjZzogQWRkIGJsb2NrIGNv
bW1lbnQgZm9yIHByb2JlX2FjY2Vzcwo3ZWRhYTkxIGV4ZWM6IEZpeCBjcHVfd2F0Y2hwb2ludF9h
ZGRyZXNzX21hdGNoZXMgYWRkcmVzcyBsZW5ndGgKODBmOWFlYSBleGVjOiBBZGQgYmxvY2sgY29t
bWVudHMgZm9yIHdhdGNocG9pbnQgcm91dGluZXMKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMTkg
Q2hlY2tpbmcgY29tbWl0IDgwZjlhZWExNWY1NiAoZXhlYzogQWRkIGJsb2NrIGNvbW1lbnRzIGZv
ciB3YXRjaHBvaW50IHJvdXRpbmVzKQoyLzE5IENoZWNraW5nIGNvbW1pdCA3ZWRhYTkxYjJiNmIg
KGV4ZWM6IEZpeCBjcHVfd2F0Y2hwb2ludF9hZGRyZXNzX21hdGNoZXMgYWRkcmVzcyBsZW5ndGgp
CjMvMTkgQ2hlY2tpbmcgY29tbWl0IDM1ZmQyZmY3MmNmOCAoYWNjZWwvdGNnOiBBZGQgYmxvY2sg
Y29tbWVudCBmb3IgcHJvYmVfYWNjZXNzKQo0LzE5IENoZWNraW5nIGNvbW1pdCA2NGQwMDE3ZDVh
Y2YgKGFjY2VsL3RjZzogQWRqdXN0IHByb2JlX2FjY2VzcyBjYWxsIHRvIHBhZ2VfY2hlY2tfcmFu
Z2UpCjUvMTkgQ2hlY2tpbmcgY29tbWl0IDA1NTE0MjU2OTMxOCAoYWNjZWwvdGNnOiBBZGQgcHJv
YmVfYWNjZXNzX2ZsYWdzKQo2LzE5IENoZWNraW5nIGNvbW1pdCBkOTA0ODAxNTUwMTYgKGFjY2Vs
L3RjZzogQWRkIGVuZGlhbi1zcGVjaWZpYyBjcHVfe2xkLCBzdH0qIG9wZXJhdGlvbnMpCjcvMTkg
Q2hlY2tpbmcgY29tbWl0IDYyZTQzNTFjODA0YyAodGFyZ2V0L2FybTogVXNlIGNwdV8qX2RhdGFf
cmEgZm9yIHN2ZV9sZHN0X3RsYl9mbikKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhh
dCAnKicgKGN0eDpWeFYpCiM2MzogRklMRTogdGFyZ2V0L2FybS9zdmVfaGVscGVyLmM6NDAyOToK
KyAgICBUTEIoZW52LCBhZGRyLCAoVFlQRU0pKihUWVBFRSAqKSh2ZCArIEgocmVnX29mZikpLCBy
YSk7ICAgICAgICAgICAgICAgICBcCiAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCkVSUk9S
OiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJyonIChjdHg6V3hWKQojMTUzOiBGSUxFOiB0
YXJnZXQvYXJtL3N2ZV9oZWxwZXIuYzo0MTYyOgorICAgICAgICAgICAgICAgICAgICAgIHN2ZV9s
ZHN0MV90bGJfZm4gKnRsYl9mbikKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF4KCnRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5ncywgNDU1IGxpbmVzIGNoZWNrZWQKClBh
dGNoIDcvMTkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRo
ZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFp
bmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjgvMTkgQ2hlY2tpbmcgY29tbWl0
IDE0ZTBlNDk2YjM5ZCAodGFyZ2V0L2FybTogRHJvcCBtYW51YWwgaGFuZGxpbmcgb2Ygc2V0L2Ns
ZWFyX2hlbHBlcl9yZXRhZGRyKQo5LzE5IENoZWNraW5nIGNvbW1pdCAxMmJiZDA3YmQ1MDEgKHRh
cmdldC9hcm06IEFkZCBzdmUgaW5mcmFzdHJ1Y3R1cmUgZm9yIHBhZ2UgbG9va3VwKQpXQVJOSU5H
OiBCbG9jayBjb21tZW50cyB1c2UgYSBsZWFkaW5nIC8qIG9uIGEgc2VwYXJhdGUgbGluZQojMzI6
IEZJTEU6IHRhcmdldC9hcm0vc3ZlX2hlbHBlci5jOjE2MzM6CisvKiBCaWctZW5kaWFuIGhvc3Rz
IG5lZWQgdG8gZnJvYiB0aGUgYnl0ZSBpbmRpY2VzLiAgSWYgdGhlIGNvcHkKCnRvdGFsOiAwIGVy
cm9ycywgMSB3YXJuaW5ncywgMjgxIGxpbmVzIGNoZWNrZWQKClBhdGNoIDkvMTkgaGFzIHN0eWxl
IHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFs
c2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRD
SCBpbiBNQUlOVEFJTkVSUy4KMTAvMTkgQ2hlY2tpbmcgY29tbWl0IDQ2OWY5MmI3ODFhYyAodGFy
Z2V0L2FybTogQWRqdXN0IGludGVyZmFjZSBvZiBzdmVfbGQxX2hvc3RfZm4pCjExLzE5IENoZWNr
aW5nIGNvbW1pdCA2M2QyNjI4NWYxYTMgKHRhcmdldC9hcm06IFVzZSBTVkVDb250TGRTdCBpbiBz
dmVfbGQxX3IpCjEyLzE5IENoZWNraW5nIGNvbW1pdCAzODlkMjliNjVmZjIgKHRhcmdldC9hcm06
IEhhbmRsZSB3YXRjaHBvaW50cyBpbiBzdmVfbGQxX3IpCjEzLzE5IENoZWNraW5nIGNvbW1pdCA4
YThiNzcwMWFkYmEgKHRhcmdldC9hcm06IFVzZSBTVkVDb250TGRTdCBmb3IgbXVsdGktcmVnaXN0
ZXIgY29udGlndW91cyBsb2FkcykKMTQvMTkgQ2hlY2tpbmcgY29tbWl0IGMzYWRiNmFmOTM0YyAo
dGFyZ2V0L2FybTogVXBkYXRlIGNvbnRpZ3VvdXMgZmlyc3QtZmF1bHQgYW5kIG5vLWZhdWx0IGxv
YWRzKQoxNS8xOSBDaGVja2luZyBjb21taXQgNGE0OWQwNThjZTExICh0YXJnZXQvYXJtOiBVc2Ug
U1ZFQ29udExkU3QgZm9yIGNvbnRpZ3VvdXMgc3RvcmVzKQoxNi8xOSBDaGVja2luZyBjb21taXQg
NmZjMzczNGUzMzUwICh0YXJnZXQvYXJtOiBSZXVzZSBzdmVfcHJvYmVfcGFnZSBmb3IgZ2F0aGVy
IGZpcnN0LWZhdWx0IGxvYWRzKQoxNy8xOSBDaGVja2luZyBjb21taXQgZWRiYWFiOTZhYzJiICh0
YXJnZXQvYXJtOiBSZXVzZSBzdmVfcHJvYmVfcGFnZSBmb3Igc2NhdHRlciBzdG9yZXMpCjE4LzE5
IENoZWNraW5nIGNvbW1pdCA3MjA1MjQyNzY2OWEgKHRhcmdldC9hcm06IFJldXNlIHN2ZV9wcm9i
ZV9wYWdlIGZvciBnYXRoZXIgbG9hZHMpCjE5LzE5IENoZWNraW5nIGNvbW1pdCA2NDU5ZTdhMDk5
ZDcgKHRhcmdldC9hcm06IFJlbW92ZSBzdmVfbWVtb3BpZHgpCj09PSBPVVRQVVQgRU5EID09PQoK
VGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNTA4MTU0MzU5Ljc0OTQtMS1yaWNo
YXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdl
LgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==


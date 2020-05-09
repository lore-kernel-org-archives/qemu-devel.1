Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C069C38A2A
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 01:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF782184D
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 01:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF782184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXEZf-00008I-0m
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 21:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jXEZ8-0008BN-Iw
 for qemu-devel@nongnu.org; Fri, 08 May 2020 21:46:10 -0400
Resent-Date: Fri, 08 May 2020 21:46:10 -0400
Resent-Message-Id: <E1jXEZ8-0008BN-Iw@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21369)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jXEZ6-00074Z-MP
 for qemu-devel@nongnu.org; Fri, 08 May 2020 21:46:10 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588988759; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gr6qYxnT0vknbTrByUDO//csr4WNFkvcuOP9axdszNiQP4Wq028hlhUHHrT9yZ6veIIi7hd6SFWwnzSNOqtUb6ohumzVesS3QmcnHy06LBTNHB0rc1uGtBYvCGIBpZ+4j29kjOyd2S3b5lJb+PaFoAx3Y1vZRI0cJzsgKQ8KkwA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588988759;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=+R7O68eIHV7jjt14yNRIH5ZQc6oUnJK+jBWO9/xZv50=; 
 b=FnP0+4Y+Vx8ntZkM75UdFAQv4RsF+MwoYAgEQTMP2gEKMoZ9R4RltZdM/Cqoo3uhGgJk7BAZA/siLrbrIlBvPmjVtB6pBpGIKDRpwkePbGrW30ZiRZt0k/CCpMzKlvEfP26DgklKGkVPzjUWTQZFCPf3c+WPb+jgl7yL0bAcBo4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158898875875420.773406625959183;
 Fri, 8 May 2020 18:45:58 -0700 (PDT)
Message-ID: <158898875754.27125.5237040522428817731@45ef0f9c86ae>
In-Reply-To: <20200508154359.7494-1-richard.henderson@linaro.org>
Subject: Re: [PATCH v5 00/19] target/arm: sve load/store improvements
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Fri, 8 May 2020 18:45:58 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 21:46:05
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
c2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0
ZXN0Jwo1NTMxZGY2IHRhcmdldC9hcm06IFJlbW92ZSBzdmVfbWVtb3BpZHgKMzJmY2RiZSB0YXJn
ZXQvYXJtOiBSZXVzZSBzdmVfcHJvYmVfcGFnZSBmb3IgZ2F0aGVyIGxvYWRzCjE4ZTY2MzQgdGFy
Z2V0L2FybTogUmV1c2Ugc3ZlX3Byb2JlX3BhZ2UgZm9yIHNjYXR0ZXIgc3RvcmVzCjFlZDNmNGUg
dGFyZ2V0L2FybTogUmV1c2Ugc3ZlX3Byb2JlX3BhZ2UgZm9yIGdhdGhlciBmaXJzdC1mYXVsdCBs
b2FkcwpjOGM1ODA5IHRhcmdldC9hcm06IFVzZSBTVkVDb250TGRTdCBmb3IgY29udGlndW91cyBz
dG9yZXMKZmYxM2M3NCB0YXJnZXQvYXJtOiBVcGRhdGUgY29udGlndW91cyBmaXJzdC1mYXVsdCBh
bmQgbm8tZmF1bHQgbG9hZHMKN2E0ZmM5ZiB0YXJnZXQvYXJtOiBVc2UgU1ZFQ29udExkU3QgZm9y
IG11bHRpLXJlZ2lzdGVyIGNvbnRpZ3VvdXMgbG9hZHMKZTE2MjY2MyB0YXJnZXQvYXJtOiBIYW5k
bGUgd2F0Y2hwb2ludHMgaW4gc3ZlX2xkMV9yCjBhNGE3MGUgdGFyZ2V0L2FybTogVXNlIFNWRUNv
bnRMZFN0IGluIHN2ZV9sZDFfcgo2YmM5MGI1IHRhcmdldC9hcm06IEFkanVzdCBpbnRlcmZhY2Ug
b2Ygc3ZlX2xkMV9ob3N0X2ZuCjE3ZGI1OWUgdGFyZ2V0L2FybTogQWRkIHN2ZSBpbmZyYXN0cnVj
dHVyZSBmb3IgcGFnZSBsb29rdXAKYjlkYTI5MSB0YXJnZXQvYXJtOiBEcm9wIG1hbnVhbCBoYW5k
bGluZyBvZiBzZXQvY2xlYXJfaGVscGVyX3JldGFkZHIKOGZkMWViMiB0YXJnZXQvYXJtOiBVc2Ug
Y3B1XypfZGF0YV9yYSBmb3Igc3ZlX2xkc3RfdGxiX2ZuCjQ3NDYwMWEgYWNjZWwvdGNnOiBBZGQg
ZW5kaWFuLXNwZWNpZmljIGNwdV97bGQsIHN0fSogb3BlcmF0aW9ucwpiZGYwM2M4IGFjY2VsL3Rj
ZzogQWRkIHByb2JlX2FjY2Vzc19mbGFncwowYzQ4NGVkIGFjY2VsL3RjZzogQWRqdXN0IHByb2Jl
X2FjY2VzcyBjYWxsIHRvIHBhZ2VfY2hlY2tfcmFuZ2UKOGE5ODQ3ZiBhY2NlbC90Y2c6IEFkZCBi
bG9jayBjb21tZW50IGZvciBwcm9iZV9hY2Nlc3MKN2FlNTZjOCBleGVjOiBGaXggY3B1X3dhdGNo
cG9pbnRfYWRkcmVzc19tYXRjaGVzIGFkZHJlc3MgbGVuZ3RoCjNmNzlkOWEgZXhlYzogQWRkIGJs
b2NrIGNvbW1lbnRzIGZvciB3YXRjaHBvaW50IHJvdXRpbmVzCgo9PT0gT1VUUFVUIEJFR0lOID09
PQoxLzE5IENoZWNraW5nIGNvbW1pdCAzZjc5ZDlhZDQwMWQgKGV4ZWM6IEFkZCBibG9jayBjb21t
ZW50cyBmb3Igd2F0Y2hwb2ludCByb3V0aW5lcykKMi8xOSBDaGVja2luZyBjb21taXQgN2FlNTZj
ODM1Y2YwIChleGVjOiBGaXggY3B1X3dhdGNocG9pbnRfYWRkcmVzc19tYXRjaGVzIGFkZHJlc3Mg
bGVuZ3RoKQozLzE5IENoZWNraW5nIGNvbW1pdCA4YTk4NDdmNTNmYmMgKGFjY2VsL3RjZzogQWRk
IGJsb2NrIGNvbW1lbnQgZm9yIHByb2JlX2FjY2VzcykKNC8xOSBDaGVja2luZyBjb21taXQgMGM0
ODRlZDdiMTRlIChhY2NlbC90Y2c6IEFkanVzdCBwcm9iZV9hY2Nlc3MgY2FsbCB0byBwYWdlX2No
ZWNrX3JhbmdlKQo1LzE5IENoZWNraW5nIGNvbW1pdCBiZGYwM2M4NzdiMTIgKGFjY2VsL3RjZzog
QWRkIHByb2JlX2FjY2Vzc19mbGFncykKNi8xOSBDaGVja2luZyBjb21taXQgNDc0NjAxYTk1NjE0
IChhY2NlbC90Y2c6IEFkZCBlbmRpYW4tc3BlY2lmaWMgY3B1X3tsZCwgc3R9KiBvcGVyYXRpb25z
KQo3LzE5IENoZWNraW5nIGNvbW1pdCA4ZmQxZWIyOTI4ZmEgKHRhcmdldC9hcm06IFVzZSBjcHVf
Kl9kYXRhX3JhIGZvciBzdmVfbGRzdF90bGJfZm4pCkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJv
dW5kIHRoYXQgJyonIChjdHg6VnhWKQojNjM6IEZJTEU6IHRhcmdldC9hcm0vc3ZlX2hlbHBlci5j
OjQwMjk6CisgICAgVExCKGVudiwgYWRkciwgKFRZUEVNKSooVFlQRUUgKikodmQgKyBIKHJlZ19v
ZmYpKSwgcmEpOyAgICAgICAgICAgICAgICAgXAogICAgICAgICAgICAgICAgICAgICAgICAgICBe
CgpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICcqJyAoY3R4Old4VikKIzE1Mzog
RklMRTogdGFyZ2V0L2FybS9zdmVfaGVscGVyLmM6NDE2MjoKKyAgICAgICAgICAgICAgICAgICAg
ICBzdmVfbGRzdDFfdGxiX2ZuICp0bGJfZm4pCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBeCgp0b3RhbDogMiBlcnJvcnMsIDAgd2FybmluZ3MsIDQ1NSBsaW5lcyBjaGVj
a2VkCgpQYXRjaCA3LzE5IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFu
eSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUg
bWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo4LzE5IENoZWNraW5n
IGNvbW1pdCBiOWRhMjkxZjJiNmMgKHRhcmdldC9hcm06IERyb3AgbWFudWFsIGhhbmRsaW5nIG9m
IHNldC9jbGVhcl9oZWxwZXJfcmV0YWRkcikKOS8xOSBDaGVja2luZyBjb21taXQgMTdkYjU5ZTc4
MDE2ICh0YXJnZXQvYXJtOiBBZGQgc3ZlIGluZnJhc3RydWN0dXJlIGZvciBwYWdlIGxvb2t1cCkK
V0FSTklORzogQmxvY2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBhIHNlcGFyYXRlIGxp
bmUKIzMyOiBGSUxFOiB0YXJnZXQvYXJtL3N2ZV9oZWxwZXIuYzoxNjMzOgorLyogQmlnLWVuZGlh
biBob3N0cyBuZWVkIHRvIGZyb2IgdGhlIGJ5dGUgaW5kaWNlcy4gIElmIHRoZSBjb3B5Cgp0b3Rh
bDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDI4MSBsaW5lcyBjaGVja2VkCgpQYXRjaCA5LzE5IGhh
cyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMK
YXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNI
RUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjEwLzE5IENoZWNraW5nIGNvbW1pdCA2YmM5MGI1NDg1
NjkgKHRhcmdldC9hcm06IEFkanVzdCBpbnRlcmZhY2Ugb2Ygc3ZlX2xkMV9ob3N0X2ZuKQoxMS8x
OSBDaGVja2luZyBjb21taXQgMGE0YTcwZTdlMGVhICh0YXJnZXQvYXJtOiBVc2UgU1ZFQ29udExk
U3QgaW4gc3ZlX2xkMV9yKQoxMi8xOSBDaGVja2luZyBjb21taXQgZTE2MjY2M2JkZGQwICh0YXJn
ZXQvYXJtOiBIYW5kbGUgd2F0Y2hwb2ludHMgaW4gc3ZlX2xkMV9yKQoxMy8xOSBDaGVja2luZyBj
b21taXQgN2E0ZmM5ZjcyZjczICh0YXJnZXQvYXJtOiBVc2UgU1ZFQ29udExkU3QgZm9yIG11bHRp
LXJlZ2lzdGVyIGNvbnRpZ3VvdXMgbG9hZHMpCjE0LzE5IENoZWNraW5nIGNvbW1pdCBmZjEzYzc0
MWM2MzggKHRhcmdldC9hcm06IFVwZGF0ZSBjb250aWd1b3VzIGZpcnN0LWZhdWx0IGFuZCBuby1m
YXVsdCBsb2FkcykKMTUvMTkgQ2hlY2tpbmcgY29tbWl0IGM4YzU4MDk3NzcwYyAodGFyZ2V0L2Fy
bTogVXNlIFNWRUNvbnRMZFN0IGZvciBjb250aWd1b3VzIHN0b3JlcykKMTYvMTkgQ2hlY2tpbmcg
Y29tbWl0IDFlZDNmNGVjOWRmMiAodGFyZ2V0L2FybTogUmV1c2Ugc3ZlX3Byb2JlX3BhZ2UgZm9y
IGdhdGhlciBmaXJzdC1mYXVsdCBsb2FkcykKMTcvMTkgQ2hlY2tpbmcgY29tbWl0IDE4ZTY2MzQy
ZTFjMSAodGFyZ2V0L2FybTogUmV1c2Ugc3ZlX3Byb2JlX3BhZ2UgZm9yIHNjYXR0ZXIgc3RvcmVz
KQoxOC8xOSBDaGVja2luZyBjb21taXQgMzJmY2RiZTZlN2ViICh0YXJnZXQvYXJtOiBSZXVzZSBz
dmVfcHJvYmVfcGFnZSBmb3IgZ2F0aGVyIGxvYWRzKQoxOS8xOSBDaGVja2luZyBjb21taXQgNTUz
MWRmNjg1MmJjICh0YXJnZXQvYXJtOiBSZW1vdmUgc3ZlX21lbW9waWR4KQo9PT0gT1VUUFVUIEVO
RCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlz
IGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDUwODE1NDM1OS43NDk0
LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZy90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=


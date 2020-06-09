Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C431DC433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A74C206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 14:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A74C206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jif8d-0008IN-R1
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 10:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jif2G-0000mw-Ti; Tue, 09 Jun 2020 10:15:29 -0400
Resent-Date: Tue, 09 Jun 2020 10:15:28 -0400
Resent-Message-Id: <E1jif2G-0000mw-Ti@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jif2D-0007zz-RY; Tue, 09 Jun 2020 10:15:28 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591712103; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=V1knRpXtlhEU49M1/mWsidGkz61ESe+IFDpXmeI5aUOxkjA2VvIyNIBffvJkuwPszSI1YtBYnP5OeQYDvAERqSuHKJ9J4N5jlcg3XYOMt20oGj85QJA/ekwYrnj4OTOjAZaVFuq7k8e2a4Fh/4oIcnnoOF3PIx3JyhqFGwFLCjU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591712103;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=KN+9qKc3BUdcWOvFzY+vl/mFNOkGJ64DYLJYeyOH4Cc=; 
 b=WvnAWGkuOPU/v8qRpLysZt+ICFlYTuL9HHbowxl8jkKOr0az0127/0lV8BsHoRjIHhk4FocLiuYEzgsB26i3OuNX53/if0xqS/Z6eGuvP8QHKzPfCB+mBQtngoTQskmXcGKjlEURb9kXYvJpOsZwYTe2K8Yl5fpgfDyvelTXdCQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591712101642141.57590110144304;
 Tue, 9 Jun 2020 07:15:01 -0700 (PDT)
Message-ID: <159171209964.14379.13759350814032395535@45ef0f9c86ae>
In-Reply-To: <20200609125409.24179-1-eric.auger@redhat.com>
Subject: Re: [PATCH v2 0/5] TPM-TIS bios-tables-test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eric.auger@redhat.com
Date: Tue, 9 Jun 2020 07:15:01 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 10:01:59
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, mst@redhat.com,
 philmd@redhat.com, shannon.zhaosl@gmail.com, qemu-devel@nongnu.org,
 eric.auger@redhat.com, qemu-arm@nongnu.org, marcandre.lureau@redhat.com,
 imammedo@redhat.com, eric.auger.pro@gmail.com, lersek@redhat.com,
 ardb@kernel.org, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYwOTEyNTQwOS4yNDE3
OS0xLWVyaWMuYXVnZXJAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA2MDkxMjU0MDkuMjQxNzktMS1lcmljLmF1
Z2VyQHJlZGhhdC5jb20KU3ViamVjdDogW1BBVENIIHYyIDAvNV0gVFBNLVRJUyBiaW9zLXRhYmxl
cy10ZXN0ClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFz
aApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBU
cnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRz
L2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0K
CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFn
XSAgICAgICAgIHBhdGNoZXcvMjAyMDA2MDkxMjU0MDkuMjQxNzktMS1lcmljLmF1Z2VyQHJlZGhh
dC5jb20gLT4gcGF0Y2hldy8yMDIwMDYwOTEyNTQwOS4yNDE3OS0xLWVyaWMuYXVnZXJAcmVkaGF0
LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmU2YjIzNmMgYmlvcy10YWJsZXMt
dGVzdDogR2VuZXJhdGUgcmVmZXJlbmNlIHRhYmxlcyBmb3IgUTM1L1RQTS1USVMKN2E0YjlmMiBi
aW9zLXRhYmxlcy10ZXN0OiBBZGQgUTM1L1RQTS1USVMgdGVzdAo3ZmU3NmFhIHRlc3RzOiB0cG0t
ZW11OiBSZW1vdmUgYXNzZXJ0IG9uIFRQTTJfU1RfTk9fU0VTU0lPTlMKN2EwMzBiZSB0ZXN0cy9h
Y3BpOiBBZGQgdm9pZCB0YWJsZXMgZm9yIFEzNS9UUE0tVElTIGJpb3MtdGFibGVzLXRlc3QKNzYx
MGZhZCB0ZXN0L3RwbS1lbXU6IGluY2x1ZGUgc29ja2V0cyBhbmQgY2hhbm5lbCBoZWFkZXJzIGlu
IHRwbS1lbXUgaGVhZGVyCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzUgQ2hlY2tpbmcgY29tbWl0
IDc2MTBmYWQwZDlmOSAodGVzdC90cG0tZW11OiBpbmNsdWRlIHNvY2tldHMgYW5kIGNoYW5uZWwg
aGVhZGVycyBpbiB0cG0tZW11IGhlYWRlcikKMi81IENoZWNraW5nIGNvbW1pdCA3YTAzMGJlMDhh
NzggKHRlc3RzL2FjcGk6IEFkZCB2b2lkIHRhYmxlcyBmb3IgUTM1L1RQTS1USVMgYmlvcy10YWJs
ZXMtdGVzdCkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBN
QUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMTc6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKRVJS
T1I6IERvIG5vdCBhZGQgZXhwZWN0ZWQgZmlsZXMgdG9nZXRoZXIgd2l0aCB0ZXN0cywgZm9sbG93
IGluc3RydWN0aW9ucyBpbiB0ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LmM6IGJvdGggdGVz
dHMvZGF0YS9hY3BpL3EzNS9UUE0yLnRpcyBhbmQgdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVz
dC1hbGxvd2VkLWRpZmYuaCBmb3VuZAoKRVJST1I6IERvIG5vdCBhZGQgZXhwZWN0ZWQgZmlsZXMg
dG9nZXRoZXIgd2l0aCB0ZXN0cywgZm9sbG93IGluc3RydWN0aW9ucyBpbiB0ZXN0cy9xdGVzdC9i
aW9zLXRhYmxlcy10ZXN0LmM6IGJvdGggdGVzdHMvZGF0YS9hY3BpL3EzNS9UUE0yLnRpcyBhbmQg
dGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdC1hbGxvd2VkLWRpZmYuaCBmb3VuZAoKdG90YWw6
IDIgZXJyb3JzLCAxIHdhcm5pbmdzLCAzIGxpbmVzIGNoZWNrZWQKClBhdGNoIDIvNSBoYXMgc3R5
bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBm
YWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BB
VENIIGluIE1BSU5UQUlORVJTLgoKMy81IENoZWNraW5nIGNvbW1pdCA3ZmU3NmFhZjhkNjggKHRl
c3RzOiB0cG0tZW11OiBSZW1vdmUgYXNzZXJ0IG9uIFRQTTJfU1RfTk9fU0VTU0lPTlMpCjQvNSBD
aGVja2luZyBjb21taXQgN2E0YjlmMjJkZGJkIChiaW9zLXRhYmxlcy10ZXN0OiBBZGQgUTM1L1RQ
TS1USVMgdGVzdCkKNS81IENoZWNraW5nIGNvbW1pdCBlNmIyMzZjNDg4MDYgKGJpb3MtdGFibGVz
LXRlc3Q6IEdlbmVyYXRlIHJlZmVyZW5jZSB0YWJsZXMgZm9yIFEzNS9UUE0tVElTKQpFUlJPUjog
RG8gbm90IGFkZCBleHBlY3RlZCBmaWxlcyB0b2dldGhlciB3aXRoIHRlc3RzLCBmb2xsb3cgaW5z
dHJ1Y3Rpb25zIGluIHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYzogYm90aCB0ZXN0cy9k
YXRhL2FjcGkvcTM1L1RQTTIudGlzIGFuZCB0ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LWFs
bG93ZWQtZGlmZi5oIGZvdW5kCgpFUlJPUjogRG8gbm90IGFkZCBleHBlY3RlZCBmaWxlcyB0b2dl
dGhlciB3aXRoIHRlc3RzLCBmb2xsb3cgaW5zdHJ1Y3Rpb25zIGluIHRlc3RzL3F0ZXN0L2Jpb3Mt
dGFibGVzLXRlc3QuYzogYm90aCB0ZXN0cy9kYXRhL2FjcGkvcTM1L1RQTTIudGlzIGFuZCB0ZXN0
cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LWFsbG93ZWQtZGlmZi5oIGZvdW5kCgp0b3RhbDogMiBl
cnJvcnMsIDAgd2FybmluZ3MsIDEgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNS81IGhhcyBzdHlsZSBw
cm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNl
IHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0gg
aW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQg
d2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hl
dy5vcmcvbG9ncy8yMDIwMDYwOTEyNTQwOS4yNDE3OS0xLWVyaWMuYXVnZXJAcmVkaGF0LmNvbS90
ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


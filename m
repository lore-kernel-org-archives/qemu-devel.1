Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A27C388F9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:41:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3438820791
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3438820791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX5Yk-0005wh-2f
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 12:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kX5XO-00051y-1I
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:40:02 -0400
Resent-Date: Mon, 26 Oct 2020 12:40:02 -0400
Resent-Message-Id: <E1kX5XO-00051y-1I@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kX5XK-0002zv-8c
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:40:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1603730383; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PkbSAeHOkV6KbFvDi8YgtJmR9iyT+SZkPjZKOsrVGTQU14j2dKAlVqtoDOnbsKTv+aColFrBi31Owy+IWyk9sWhI6tQ6IeM+sxl0TVCyjViJjgDAwb0HHOYrywNXVxs/vtHQYvAJ0p/A0SI1wAwBgQmsUkvsREzXfz2oJUCjGqE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1603730383;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Wp40KSaTe6EungPu3DzEIvN3Vtv23ly7JQtE6iyPbXg=; 
 b=CI0PO1r/Z+87xq0BkVtWFoX7HBPEnyCuGl9+7aAjIkV1VhA/cJ4CLAdqwWniP9CUMdBQ+GcTME3n2ciloT1i9nmfAKRl7x0IhzSt3wkVpeYfXaEsgu9T8NKjthO70ET2yUrDqaysOCysO7hB3MwEhlWanHguAJ3JH10sMpnWsms=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1603730382421150.28673178371787;
 Mon, 26 Oct 2020 09:39:42 -0700 (PDT)
Subject: Re: [PULL 00/16] migration queue
Message-ID: <160373038097.1984.565441285420567282@66eaa9a8a123>
In-Reply-To: <20201026161952.149188-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dgilbert@redhat.com
Date: Mon, 26 Oct 2020 09:39:42 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 10:52:04
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: yubihong@huawei.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 peterx@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAyNjE2MTk1Mi4xNDkx
ODgtMS1kZ2lsYmVydEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDEwMjYxNjE5NTIuMTQ5
MTg4LTEtZGdpbGJlcnRAcmVkaGF0LmNvbQpTdWJqZWN0OiBbUFVMTCAwMC8xNl0gbWlncmF0aW9u
IHF1ZXVlCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFy
c2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5w
bCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4
Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHVi
LmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzE2
MDM3MDQ5ODctMjA5NzctMS1naXQtc2VuZC1lbWFpbC1rd2Fua2hlZGVAbnZpZGlhLmNvbSAtPiBw
YXRjaGV3LzE2MDM3MDQ5ODctMjA5NzctMS1naXQtc2VuZC1lbWFpbC1rd2Fua2hlZGVAbnZpZGlh
LmNvbQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAxMDI2MTYxOTUyLjE0OTE4OC0x
LWRnaWxiZXJ0QHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDIwMTAyNjE2MTk1Mi4xNDkxODgtMS1k
Z2lsYmVydEByZWRoYXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKZWVjNzE3
MyBtaWdyYXRpb24tdGVzdDogT25seSBoaWRlIGVycm9yIGlmICFRVEVTVF9MT0cKM2NmNTYxOSBt
aWdyYXRpb24vcG9zdGNvcHk6IFJlbGVhc2UgZmQgYmVmb3JlIGdvaW5nIGludG8gJ3Bvc3Rjb3B5
LXBhdXNlJwowNTgyNmQ2IG1pZ3JhdGlvbjogU3luYyByZXF1ZXN0ZWQgcGFnZXMgYWZ0ZXIgcG9z
dGNvcHkgcmVjb3ZlcnkKZTNhYjliZCBtaWdyYXRpb246IE1haW50YWluIHBvc3Rjb3B5IGZhdWx0
ZWQgYWRkcmVzc2VzCjk0YzQ3ZmQgbWlncmF0aW9uOiBJbnRyb2R1Y2UgbWlncmF0ZV9zZW5kX3Jw
X21lc3NhZ2VfcmVxX3BhZ2VzKCkKMzdmNWQxMyBtaWdyYXRpb246IFBhc3MgaW5jb21pbmcgc3Rh
dGUgaW50byBxZW11X3VmZF9jb3B5X2lvY3RsKCkKZDIxMjc3OCBtaWdyYXRpb246IHVzaW5nIHRy
YWNlXyB0byByZXBsYWNlIERQUklOVEYKNTdmZGE1OSBtaWdyYXRpb246IERlbGV0ZSByZWR1bmRh
bnQgc3BhY2VzCjViMDkzZjEgbWlncmF0aW9uOiBPcGVuIGJyYWNlICd7JyBmb2xsb3dpbmcgZnVu
Y3Rpb24gZGVjbGFyYXRpb25zIGdvIG9uIHRoZSBuZXh0IGxpbmUKMGI2MGRjYSBtaWdyYXRpb246
IERvIG5vdCBpbml0aWFsaXNlIHN0YXRpY3MgYW5kIGdsb2JhbHMgdG8gMCBvciBOVUxMCjJmMjE5
YjYgbWlncmF0aW9uOiBBZGQgYnJhY2VzIHt9IGZvciBpZiBzdGF0ZW1lbnQKM2ZkY2FiYyBtaWdy
YXRpb246IE9wZW4gYnJhY2UgJ3snIGZvbGxvd2luZyBzdHJ1Y3QgZ28gb24gdGhlIHNhbWUgbGlu
ZQo2M2JiMjZlIG1pZ3JhdGlvbjogQWRkIHNwYWNlcyBhcm91bmQgb3BlcmF0b3IKZmFkYWEzOSBt
aWdyYXRpb246IERvbid0IHVzZSAnIycgZmxhZyBvZiBwcmludGYgZm9ybWF0CmU1Njg4MjggbWln
cmF0aW9uOiBEbyBub3QgdXNlIEM5OSAvLyBjb21tZW50cwplNDc3ZDAxIG1pZ3JhdGlvbjogRHJv
cCB1bnVzZWQgVk1TVEFURV9GTE9BVDY0IHN1cHBvcnQKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEv
MTYgQ2hlY2tpbmcgY29tbWl0IGU0NzdkMDEwYmY5MyAobWlncmF0aW9uOiBEcm9wIHVudXNlZCBW
TVNUQVRFX0ZMT0FUNjQgc3VwcG9ydCkKMi8xNiBDaGVja2luZyBjb21taXQgZTU2ODgyOGMwZTYz
IChtaWdyYXRpb246IERvIG5vdCB1c2UgQzk5IC8vIGNvbW1lbnRzKQozLzE2IENoZWNraW5nIGNv
bW1pdCBmYWRhYTM5Y2ZiNDIgKG1pZ3JhdGlvbjogRG9uJ3QgdXNlICcjJyBmbGFnIG9mIHByaW50
ZiBmb3JtYXQpCjQvMTYgQ2hlY2tpbmcgY29tbWl0IDYzYmIyNmU5MzBjNCAobWlncmF0aW9uOiBB
ZGQgc3BhY2VzIGFyb3VuZCBvcGVyYXRvcikKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQg
dGhhdCAnKicgKGN0eDpXeFYpCiM2NTogRklMRTogbWlncmF0aW9uL3NhdmV2bS5jOjUyMzoKKyAg
ICAuc3Vic2VjdGlvbnMgPSAoY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uICpbXSkgewogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKdG90YWw6IDEgZXJyb3Jz
LCAwIHdhcm5pbmdzLCA1OSBsaW5lcyBjaGVja2VkCgpQYXRjaCA0LzE2IGhhcyBzdHlsZSBwcm9i
bGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBv
c2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4g
TUFJTlRBSU5FUlMuCgo1LzE2IENoZWNraW5nIGNvbW1pdCAzZmRjYWJjZTIwMTUgKG1pZ3JhdGlv
bjogT3BlbiBicmFjZSAneycgZm9sbG93aW5nIHN0cnVjdCBnbyBvbiB0aGUgc2FtZSBsaW5lKQo2
LzE2IENoZWNraW5nIGNvbW1pdCAyZjIxOWI2N2NmNjQgKG1pZ3JhdGlvbjogQWRkIGJyYWNlcyB7
fSBmb3IgaWYgc3RhdGVtZW50KQo3LzE2IENoZWNraW5nIGNvbW1pdCAwYjYwZGNhNTZmMTkgKG1p
Z3JhdGlvbjogRG8gbm90IGluaXRpYWxpc2Ugc3RhdGljcyBhbmQgZ2xvYmFscyB0byAwIG9yIE5V
TEwpCjgvMTYgQ2hlY2tpbmcgY29tbWl0IDViMDkzZjE1ZjQ4MiAobWlncmF0aW9uOiBPcGVuIGJy
YWNlICd7JyBmb2xsb3dpbmcgZnVuY3Rpb24gZGVjbGFyYXRpb25zIGdvIG9uIHRoZSBuZXh0IGxp
bmUpCjkvMTYgQ2hlY2tpbmcgY29tbWl0IDU3ZmRhNTkyZDQ0YiAobWlncmF0aW9uOiBEZWxldGUg
cmVkdW5kYW50IHNwYWNlcykKMTAvMTYgQ2hlY2tpbmcgY29tbWl0IGQyMTI3NzgxMGI0YSAobWln
cmF0aW9uOiB1c2luZyB0cmFjZV8gdG8gcmVwbGFjZSBEUFJJTlRGKQoxMS8xNiBDaGVja2luZyBj
b21taXQgMzdmNWQxM2ZhMWJiIChtaWdyYXRpb246IFBhc3MgaW5jb21pbmcgc3RhdGUgaW50byBx
ZW11X3VmZF9jb3B5X2lvY3RsKCkpCjEyLzE2IENoZWNraW5nIGNvbW1pdCA5NGM0N2ZkYzMyZjQg
KG1pZ3JhdGlvbjogSW50cm9kdWNlIG1pZ3JhdGVfc2VuZF9ycF9tZXNzYWdlX3JlcV9wYWdlcygp
KQoxMy8xNiBDaGVja2luZyBjb21taXQgZTNhYjliZGVkMzgyIChtaWdyYXRpb246IE1haW50YWlu
IHBvc3Rjb3B5IGZhdWx0ZWQgYWRkcmVzc2VzKQoxNC8xNiBDaGVja2luZyBjb21taXQgMDU4MjZk
NmVjNjJhIChtaWdyYXRpb246IFN5bmMgcmVxdWVzdGVkIHBhZ2VzIGFmdGVyIHBvc3Rjb3B5IHJl
Y292ZXJ5KQoxNS8xNiBDaGVja2luZyBjb21taXQgM2NmNTYxOWUzNzViIChtaWdyYXRpb24vcG9z
dGNvcHk6IFJlbGVhc2UgZmQgYmVmb3JlIGdvaW5nIGludG8gJ3Bvc3Rjb3B5LXBhdXNlJykKMTYv
MTYgQ2hlY2tpbmcgY29tbWl0IGVlYzcxNzNkOTg5ZCAobWlncmF0aW9uLXRlc3Q6IE9ubHkgaGlk
ZSBlcnJvciBpZiAhUVRFU1RfTE9HKQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBl
eGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8v
cGF0Y2hldy5vcmcvbG9ncy8yMDIwMTAyNjE2MTk1Mi4xNDkxODgtMS1kZ2lsYmVydEByZWRoYXQu
Y29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


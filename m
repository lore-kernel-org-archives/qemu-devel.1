Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E49C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D24C207C4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 12:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D24C207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbNQL-0008Ki-Rv
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 08:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbNPX-00078V-2m
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:01:23 -0400
Resent-Date: Wed, 20 May 2020 08:01:23 -0400
Resent-Message-Id: <E1jbNPX-00078V-2m@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbNPV-0001dP-5t
 for qemu-devel@nongnu.org; Wed, 20 May 2020 08:01:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589976069; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lmAZKyvIQz7rANXeg+EFOIfRyWw5oSslIC+kLyxvCXD5wGWL5KUig4+YG59eP4r5S3x72wciUtO9iS6YWX9OKhWvumrcJK8aAxkqQnvYqU1DZmIYIOsz1yyS77uW6usmgZ3Ei8A6tE8z2HbIt/EKxKqWDyjY29u0CNBG8tzsYcA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589976069;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=peCcVn7MlwoWpI2FnmaAXZjhGHgqUofFjRmRokDnETc=; 
 b=F0PqZhnEOeQJwK+xL6qYjxRB+ypX4ERtzm43+Hpa13E9CdqJcIAPpQrNxi+Zk/zePT+t4QyhZTTgfA3vLkHRXSJg6lRsXpUUXq5P0uG8SIc9jk1TDZfoPHqHeAEYvWZmmLS4vGg+Xivwi9X2WiA3vCt9zVRXaGLuPNb0MPr1dvI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589976066502981.5695969117479;
 Wed, 20 May 2020 05:01:06 -0700 (PDT)
Message-ID: <158997606501.25482.2234594767902255254@45ef0f9c86ae>
In-Reply-To: <20200520093629.1495-1-miaoyubo@huawei.com>
Subject: Re: [PATCH v7 0/8] pci_expander_brdige:acpi: Support pxb-pcie for ARM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: miaoyubo@huawei.com
Date: Wed, 20 May 2020 05:01:06 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 07:01:44
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, shannon.zhaosl@gmail.com,
 miaoyubo@huawei.com, imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyMDA5MzYyOS4xNDk1
LTEtbWlhb3l1Ym9AaHVhd2VpLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA1MjAwOTM2MjkuMTQ5NS0xLW1pYW95dWJvQGh1
YXdlaS5jb20KU3ViamVjdDogW1BBVENIIHY3IDAvOF0gcGNpX2V4cGFuZGVyX2JyZGlnZTphY3Bp
OiBTdXBwb3J0IHB4Yi1wY2llIGZvciBBUk0KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBl
eGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGht
IGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0g
VEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdm
NDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVt
dQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3L2FscGluZS5ERUIuMi4yMS4yMDA1MTkxNjUx
MTMwLjI3NTAyQHNzdGFiZWxsaW5pLVRoaW5rUGFkLVQ0ODBzIC0+IHBhdGNoZXcvYWxwaW5lLkRF
Qi4yLjIxLjIwMDUxOTE2NTExMzAuMjc1MDJAc3N0YWJlbGxpbmktVGhpbmtQYWQtVDQ4MHMKU3dp
dGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo4NDM5N2VhIHVuaXQtdGVzdDogQWRkIHRoZSBi
aW5hcnkgZmlsZSBhbmQgY2xlYXIgZGlmZi5oCmVmOWIyOTEgdW5pdC10ZXN0OiBBZGQgdGVzdGNh
c2UgZm9yIHB4Ygo4MDViYmY5IHVuaXQtdGVzdDogVGhlIGZpbGVzIGNoYW5nZWQuCjU0MDIyZmEg
YWNwaTogQWxpZ24gdGhlIHNpemUgdG8gMTI4awo3ZTg4NGQ1IGFjcGk6IFJlZmFjdG9yIHRoZSBz
b3VyY2Ugb2YgaG9zdCBicmlkZ2UgYW5kIGJ1aWxkIHRhYmxlcyBmb3IgcHhiCjcxZDcxMDggYWNw
aTogRXh0cmFjdCBjcnMgYnVpbGQgZm9ybSBhY3BpX2J1aWxkLmMKOWIxOGNjOCBmd19jZmc6IFdy
aXRlIHRoZSBleHRyYSByb290cyBpbnRvIHRoZSBmd19jZmcKZjllODUzYyBhY3BpOiBFeHRyYWN0
IHR3byBBUElzIGZyb20gYWNwaV9kc2R0X2FkZF9wY2kKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEv
OCBDaGVja2luZyBjb21taXQgZjllODUzYzFhMzExIChhY3BpOiBFeHRyYWN0IHR3byBBUElzIGZy
b20gYWNwaV9kc2R0X2FkZF9wY2kpCjIvOCBDaGVja2luZyBjb21taXQgOWIxOGNjODZkYjUyIChm
d19jZmc6IFdyaXRlIHRoZSBleHRyYSByb290cyBpbnRvIHRoZSBmd19jZmcpCjMvOCBDaGVja2lu
ZyBjb21taXQgNzFkNzEwOGY3OWE3IChhY3BpOiBFeHRyYWN0IGNycyBidWlsZCBmb3JtIGFjcGlf
YnVpbGQuYykKNC84IENoZWNraW5nIGNvbW1pdCA3ZTg4NGQ1ZTlmMmIgKGFjcGk6IFJlZmFjdG9y
IHRoZSBzb3VyY2Ugb2YgaG9zdCBicmlkZ2UgYW5kIGJ1aWxkIHRhYmxlcyBmb3IgcHhiKQo1Lzgg
Q2hlY2tpbmcgY29tbWl0IDU0MDIyZmFkMTVlMiAoYWNwaTogQWxpZ24gdGhlIHNpemUgdG8gMTI4
aykKNi84IENoZWNraW5nIGNvbW1pdCA4MDViYmY5Y2ExMmEgKHVuaXQtdGVzdDogVGhlIGZpbGVz
IGNoYW5nZWQuKQo3LzggQ2hlY2tpbmcgY29tbWl0IGVmOWIyOTE3YjcxMiAodW5pdC10ZXN0OiBB
ZGQgdGVzdGNhc2UgZm9yIHB4YikKOC84IENoZWNraW5nIGNvbW1pdCA4NDM5N2VhNjRlZGMgKHVu
aXQtdGVzdDogQWRkIHRoZSBiaW5hcnkgZmlsZSBhbmQgY2xlYXIgZGlmZi5oKQpXQVJOSU5HOiBh
ZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBk
YXRpbmc/CiMxMzogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CgpFUlJPUjogRG8gbm90IGFkZCBleHBl
Y3RlZCBmaWxlcyB0b2dldGhlciB3aXRoIHRlc3RzLCBmb2xsb3cgaW5zdHJ1Y3Rpb25zIGluIHRl
c3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYzogYm90aCB0ZXN0cy9kYXRhL2FjcGkvdmlydC9E
U0RULnB4YiBhbmQgdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdC1hbGxvd2VkLWRpZmYuaCBm
b3VuZAoKRVJST1I6IERvIG5vdCBhZGQgZXhwZWN0ZWQgZmlsZXMgdG9nZXRoZXIgd2l0aCB0ZXN0
cywgZm9sbG93IGluc3RydWN0aW9ucyBpbiB0ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LmM6
IGJvdGggdGVzdHMvZGF0YS9hY3BpL3ZpcnQvRFNEVC5weGIgYW5kIHRlc3RzL3F0ZXN0L2Jpb3Mt
dGFibGVzLXRlc3QtYWxsb3dlZC1kaWZmLmggZm91bmQKCnRvdGFsOiAyIGVycm9ycywgMSB3YXJu
aW5ncywgMSBsaW5lcyBjaGVja2VkCgpQYXRjaCA4LzggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVh
c2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJl
cG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVS
Uy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEK
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIw
MjAwNTIwMDkzNjI5LjE0OTUtMS1taWFveXVib0BodWF3ZWkuY29tL3Rlc3RpbmcuY2hlY2twYXRj
aC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


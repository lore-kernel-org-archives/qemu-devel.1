Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E59C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 22:59:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D080206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 22:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D080206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdM3w-0007Sd-FN
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 18:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdM3P-000740-Kd
 for qemu-devel@nongnu.org; Mon, 25 May 2020 18:58:43 -0400
Resent-Date: Mon, 25 May 2020 18:58:43 -0400
Resent-Message-Id: <E1jdM3P-000740-Kd@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdM3N-0007HO-MB
 for qemu-devel@nongnu.org; Mon, 25 May 2020 18:58:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590447484; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=S10bMRSHbDl2eYB4+QCWinYm0dSv+nvRRgwLzMn3pUFBFZhUUWbZhtbdJlNsjyls/buonvilTc9hB/QUMDB1S6IQLAY6dxwbIUStypfNkC+Um0XH9WeaKjj7x5i8pDUNCY3yUycnip4LabDPGjaJZVE0w+XxSgLdijnK2e/ecmk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590447484;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=eCUjzQmiIIS4gap9iQ/xiy+0m7qS0zpuDIuJVuWSs3U=; 
 b=ipmqUXeyKm9otsk9PFOT/3KbLEpD9wOVmSkrbTr+sl9wmhp925cDLueij/F/lpj++Y7Nzdj9A34idipZKG8dniDPrktHyExcHl5FNrxJ3+uy6gsg6Wq7ntXx3jQsl8l00zXq33suKI9QPgdocy9e46u/ew/LxMuc2Ot/s47uSGM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590447482491258.84913954084845;
 Mon, 25 May 2020 15:58:02 -0700 (PDT)
Message-ID: <159044748030.3999.4835684679891787464@45ef0f9c86ae>
In-Reply-To: <20200525145440.29728-1-cfontana@suse.de>
Subject: Re: [RFC v3 0/4] QEMU cpus.c refactoring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: cfontana@suse.de
Date: Mon, 25 May 2020 15:58:02 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 18:58:39
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 ehabkost@redhat.com, alex.bennee@linaro.org, mtosatti@redhat.com,
 qemu-devel@nongnu.org, r.bolshakov@yadro.com, haxm-team@intel.com,
 colin.xu@intel.com, pbonzini@redhat.com, sunilmut@microsoft.com,
 rth@twiddle.net, philmd@redhat.com, cfontana@suse.de, wenchao.wang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyNTE0NTQ0MC4yOTcy
OC0xLWNmb250YW5hQHN1c2UuZGUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMjAwNTI1MTQ1NDQwLjI5NzI4LTEtY2ZvbnRhbmFAc3Vz
ZS5kZQpTdWJqZWN0OiBbUkZDIHYzIDAvNF0gUUVNVSBjcHVzLmMgcmVmYWN0b3JpbmcKVHlwZTog
c2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFy
c2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5w
bCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4
Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHVi
LmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIw
MjAwNTI1MTExMDAxLjgxNDctMS1mNGJ1Z0BhbXNhdC5vcmcgLT4gcGF0Y2hldy8yMDIwMDUyNTEx
MTAwMS44MTQ3LTEtZjRidWdAYW1zYXQub3JnClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVz
dCcKMGY1ZGIwZSBjcHVzOiBleHRyYWN0IG91dCBhY2NlbC1zcGVjaWZpYyBjb2RlIHRvIGVhY2gg
YWNjZWwKMWIxMzVjZiBjcHUtdGltZXJzLCBpY291bnQ6IG5ldyBtb2R1bGVzCmNiNWM4MzQgY3B1
LXRocm90dGxlOiBuZXcgbW9kdWxlLCBleHRyYWN0ZWQgZnJvbSBjcHVzLmMKM2Q1YTA0ZCBzb2Z0
bW11OiBtb3ZlIHNvZnRtbXUgb25seSBmaWxlcyBmcm9tIHJvb3QKCj09PSBPVVRQVVQgQkVHSU4g
PT09CjEvNCBDaGVja2luZyBjb21taXQgM2Q1YTA0ZDk5NDkyIChzb2Z0bW11OiBtb3ZlIHNvZnRt
bXUgb25seSBmaWxlcyBmcm9tIHJvb3QpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVk
IGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzExMjogCnJlbmFtZSBm
cm9tIGFyY2hfaW5pdC5jCgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDc3IGxpbmVzIGNo
ZWNrZWQKClBhdGNoIDEvNCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBh
bnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhl
IG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoyLzQgQ2hlY2tpbmcg
Y29tbWl0IGNiNWM4MzQ3NzBkZCAoY3B1LXRocm90dGxlOiBuZXcgbW9kdWxlLCBleHRyYWN0ZWQg
ZnJvbSBjcHVzLmMpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRv
ZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzExMDogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDM4NiBsaW5lcyBjaGVja2VkCgpQYXRjaCAy
LzQgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVy
cm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBz
ZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KMy80IENoZWNraW5nIGNvbW1pdCAxYjEzNWNm
YTQwYzggKGNwdS10aW1lcnMsIGljb3VudDogbmV3IG1vZHVsZXMpCldBUk5JTkc6IGxpbmUgb3Zl
ciA4MCBjaGFyYWN0ZXJzCiM5NDogRklMRTogYWNjZWwvdGNnL2NwdS1leGVjLmM6MTA3OgorICAg
ICAgICAgICAgcWVtdV9wcmludGYoIldhcm5pbmc6IFRoZSBndWVzdCBpcyBub3cgbGF0ZSBieSAl
LjFmIHRvICUuMWYgc2Vjb25kc1xuIiwKCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwoj
MjY1OiBGSUxFOiBody9jb3JlL3B0aW1lci5jOjEzNzoKKyAgICBpZiAocy0+ZW5hYmxlZCA9PSAx
ICYmIChkZWx0YSAqIHBlcmlvZCA8IDEwMDAwKSAmJiAhaWNvdW50X2VuYWJsZWQoKSAmJiAhcXRl
c3RfZW5hYmxlZCgpKSB7CgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzI3NDogRklM
RTogaHcvY29yZS9wdGltZXIuYzoyMjA6CisgICAgICAgICAgICBpZiAoIW9uZXNob3QgJiYgKHMt
PmRlbHRhICogcGVyaW9kIDwgMTAwMDApICYmICFpY291bnRfZW5hYmxlZCgpICYmICFxdGVzdF9l
bmFibGVkKCkpIHsKCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRv
ZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzM4NDogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
Cgp0b3RhbDogMiBlcnJvcnMsIDIgd2FybmluZ3MsIDIzMzEgbGluZXMgY2hlY2tlZAoKUGF0Y2gg
My80IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo0LzQgQ2hlY2tpbmcgY29tbWl0IDBmNWRi
MGU3NjEyNyAoY3B1czogZXh0cmFjdCBvdXQgYWNjZWwtc3BlY2lmaWMgY29kZSB0byBlYWNoIGFj
Y2VsKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5U
QUlORVJTIG5lZWQgdXBkYXRpbmc/CiM4NjogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDog
MCBlcnJvcnMsIDEgd2FybmluZ3MsIDI0NjMgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNC80IGhhcyBz
dHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJl
IGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNL
UEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4
aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9w
YXRjaGV3Lm9yZy9sb2dzLzIwMjAwNTI1MTQ1NDQwLjI5NzI4LTEtY2ZvbnRhbmFAc3VzZS5kZS90
ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


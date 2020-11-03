Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B70C00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 03:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5949E207BB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 03:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5949E207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZmp9-00013c-AW
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 22:17:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kZmnr-0000QY-Th; Mon, 02 Nov 2020 22:16:12 -0500
Resent-Date: Mon, 02 Nov 2020 22:16:11 -0500
Resent-Message-Id: <E1kZmnr-0000QY-Th@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kZmnl-00035O-Tr; Mon, 02 Nov 2020 22:16:09 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604373350; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dz2pnW08WGLPrvQYacp4NpavcLicGHbNw19fko0cVvGhqIOQNctch2FuptRn+r6TT0DoDXhVvzphtaY8Db7HHp+i++CWADBY9eoWZm7G3ZDV7sCOh4Q36LqLMDMO/4/q4c8JikIRQsHhx22IziYs2cTR+Mht8jkj95tP+cd8T+w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1604373350;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=4LCYMXFk5wZ8YsTHcgUhmvRrnl6LaPkjYXTupNz+a6Q=; 
 b=C4pafe59FDY1mUOvzCXULEVXjcB+mJSl9P97Ug6KxsM4FOsrcGbyhGIFNZ7e8wnOyCL3LinPUOtD4L4MARYAONpt4cKyS61ZmdxTmdD0U676asK3PS6nFtSc5hTEjweiFg1IGQCsCMBfbL3BJrYHK+L9nF1tg+74T7nOPJ6KEik=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 160437334896771.077935635779;
 Mon, 2 Nov 2020 19:15:48 -0800 (PST)
Subject: Re: [PATCH] crypto: Add spaces around operator
Message-ID: <160437334755.25026.16057381426282186586@66eaa9a8a123>
In-Reply-To: <bb45d748-01e4-2fde-9fe3-32a7db4b64e7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: shiliyang@huawei.com
Date: Mon, 2 Nov 2020 19:15:48 -0800 (PST)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 20:40:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_BL_SPAMCOP_NET=1.347,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: hunongda@huawei.com, berrange@redhat.com, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org, alex.chen@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9iYjQ1ZDc0OC0wMWU0LTJmZGUt
OWZlMy0zMmE3ZGI0YjY0ZTdAaHVhd2VpLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IGJiNDVkNzQ4LTAxZTQt
MmZkZS05ZmUzLTMyYTdkYjRiNjRlN0BodWF3ZWkuY29tClN1YmplY3Q6IFtQQVRDSF0gY3J5cHRv
OiBBZGQgc3BhY2VzIGFyb3VuZCBvcGVyYXRvcgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0K
Li9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBU
IEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMz
ODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0
YWddICAgICAgICAgcGF0Y2hldy9iYjQ1ZDc0OC0wMWU0LTJmZGUtOWZlMy0zMmE3ZGI0YjY0ZTdA
aHVhd2VpLmNvbSAtPiBwYXRjaGV3L2JiNDVkNzQ4LTAxZTQtMmZkZS05ZmUzLTMyYTdkYjRiNjRl
N0BodWF3ZWkuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNTNhMDExZSBjcnlw
dG86IEFkZCBzcGFjZXMgYXJvdW5kIG9wZXJhdG9yCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJP
UjogYnJhY2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMgc3RhdGVtZW50
CiMyNDogRklMRTogY3J5cHRvL2Flcy5jOjEwODM6CisgICAgICAgIGlmIChiaXRzID09IDEyOCkK
Wy4uLl0KLSAgICAgICAgZWxzZSBpZiAoYml0cz09MTkyKQpbLi4uXQogICAgICAgICAgICAgICAg
IGtleS0+cm91bmRzID0gMTI7ClsuLi5dCgpFUlJPUjogYnJhY2VzIHt9IGFyZSBuZWNlc3Nhcnkg
Zm9yIGFsbCBhcm1zIG9mIHRoaXMgc3RhdGVtZW50CiMyNzogRklMRTogY3J5cHRvL2Flcy5jOjEw
ODU6CisgICAgICAgIGVsc2UgaWYgKGJpdHMgPT0gMTkyKQpbLi4uXQogICAgICAgICBlbHNlClsu
Li5dCgpFUlJPUjogc3BhY2UgcHJvaGliaXRlZCBhZnRlciB0aGF0IG9wZW4gcGFyZW50aGVzaXMg
JygnCiM0OTogRklMRTogY3J5cHRvL2Rlc3JmYi5jOjk2OgorICAgICAgICAgICAgICAgICAgICAg
ICAgaWYoIHBjcltwYzJbaiArIDI0XV0gKSBrbltuXSB8PSBiaWdieXRlW2pdOwoKRVJST1I6IHNw
YWNlIHByb2hpYml0ZWQgYmVmb3JlIHRoYXQgY2xvc2UgcGFyZW50aGVzaXMgJyknCiM0OTogRklM
RTogY3J5cHRvL2Rlc3JmYi5jOjk2OgorICAgICAgICAgICAgICAgICAgICAgICAgaWYoIHBjcltw
YzJbaiArIDI0XV0gKSBrbltuXSB8PSBiaWdieXRlW2pdOwoKRVJST1I6IHNwYWNlIHJlcXVpcmVk
IGJlZm9yZSB0aGUgb3BlbiBwYXJlbnRoZXNpcyAnKCcKIzQ5OiBGSUxFOiBjcnlwdG8vZGVzcmZi
LmM6OTY6CisgICAgICAgICAgICAgICAgICAgICAgICBpZiggcGNyW3BjMltqICsgMjRdXSApIGtu
W25dIHw9IGJpZ2J5dGVbal07CgpFUlJPUjogdHJhaWxpbmcgc3RhdGVtZW50cyBzaG91bGQgYmUg
b24gbmV4dCBsaW5lCiM0OTogRklMRTogY3J5cHRvL2Rlc3JmYi5jOjk2OgorICAgICAgICAgICAg
ICAgICAgICAgICAgaWYoIHBjcltwYzJbaiArIDI0XV0gKSBrbltuXSB8PSBiaWdieXRlW2pdOwoK
RVJST1I6IGJyYWNlcyB7fSBhcmUgbmVjZXNzYXJ5IGZvciBhbGwgYXJtcyBvZiB0aGlzIHN0YXRl
bWVudAojNDk6IEZJTEU6IGNyeXB0by9kZXNyZmIuYzo5NjoKKyAgICAgICAgICAgICAgICAgICAg
ICAgIGlmKCBwY3JbcGMyW2ogKyAyNF1dICkga25bbl0gfD0gYmlnYnl0ZVtqXTsKWy4uLl0KCnRv
dGFsOiA3IGVycm9ycywgMCB3YXJuaW5ncywgMzUgbGluZXMgY2hlY2tlZAoKQ29tbWl0IDUzYTAx
MWVkZjg0OCAoY3J5cHRvOiBBZGQgc3BhY2VzIGFyb3VuZCBvcGVyYXRvcikgaGFzIHN0eWxlIHBy
b2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2Ug
cG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBp
biBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdp
dGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvYmI0NWQ3NDgtMDFlNC0yZmRlLTlmZTMtMzJhN2RiNGI2NGU3QGh1YXdlaS5jb20v
dGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0
b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5k
IHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


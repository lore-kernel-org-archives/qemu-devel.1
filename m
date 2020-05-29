Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F4CC433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 02:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0EAF214F1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 02:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EAF214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeVEM-0001o4-Oj
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 22:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jeVDn-0001DP-JM
 for qemu-devel@nongnu.org; Thu, 28 May 2020 22:58:11 -0400
Resent-Date: Thu, 28 May 2020 22:58:11 -0400
Resent-Message-Id: <E1jeVDn-0001DP-JM@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jeVDl-0004iV-IH
 for qemu-devel@nongnu.org; Thu, 28 May 2020 22:58:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590721078; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=W3iKSdrUXbWnX6KqL54waUm6pJ/RkUuqk+2euLksEGeFSZZLUYWjQsIV2qMg2egAyIvWX1IlgQdRK5fl6i15rInMa510uS5x/HqnMEFWoAuvL5+II0IjbZm1ccFWgR5gm7fjUs29ScoL5edZjDVppuSZnsOmIYQQuuEZYkqwrGg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590721078;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=OZTxs62wDDgucCk+u6fiDAHb+0sVhHeGFcmW3pPwNyE=; 
 b=b/pafd5vUVF1szU0uONjkxFyVe8RhxGVkW3b1E0QDo00ZUxoi6cgQKlhotA/HBY+CN65n6eKZRrKDUjpT3noHaqXEVBZwRVI4UBSYvJ5IMm4miB+qJBaH4KNG1gp52Nr+2X72y01L1EU2IHd+Y0wavPJRjlJluL0l5NlJoUkctE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590721075874592.5796965051674;
 Thu, 28 May 2020 19:57:55 -0700 (PDT)
Message-ID: <159072107463.20666.5539780381350433554@45ef0f9c86ae>
In-Reply-To: <20200528193758.51454-1-r.bolshakov@yadro.com>
Subject: Re: [PATCH 00/13] i386: hvf: Remove HVFX86EmulatorState
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: r.bolshakov@yadro.com
Date: Thu, 28 May 2020 19:57:55 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 22:58:06
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
Cc: r.bolshakov@yadro.com, qemu-devel@nongnu.org, dirty@apple.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyODE5Mzc1OC41MTQ1
NC0xLXIuYm9sc2hha292QHlhZHJvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA1MjgxOTM3NTguNTE0NTQtMS1yLmJvbHNo
YWtvdkB5YWRyby5jb20KU3ViamVjdDogW1BBVENIIDAwLzEzXSBpMzg2OiBodmY6IFJlbW92ZSBI
VkZYODZFbXVsYXRvclN0YXRlClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dy
YW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NS
SVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYmFiZmQ3NSBpMzg2
OiBodmY6IERyb3AgSFZGWDg2RW11bGF0b3JTdGF0ZQo1NzU1N2JlIGkzODY6IGh2ZjogTW92ZSBt
bWlvX2J1ZiBpbnRvIENQVVg4NlN0YXRlCjUzYjkzNTQgaTM4NjogaHZmOiBNb3ZlIGxhenlfZmxh
Z3MgaW50byBDUFVYODZTdGF0ZQpiYTZjODIxIGkzODY6IGh2ZjogRHJvcCByZWdzIGluIEhWRlg4
NkVtdWxhdG9yU3RhdGUKNzBiMjgzOSBpMzg2OiBodmY6IERyb3AgY29weSBvZiBSRkxBR1MgZGVm
aW5lcwphZWY3Mjc4IGkzODY6IGh2ZjogRHJvcCByZmxhZ3MgZnJvbSBIVkZYODZFbXVsYXRvclN0
YXRlCjNhYTU3YWEgaTM4NjogaHZmOiBEcm9wIGZldGNoX3JpcCBmcm9tIEhWRlg4NkVtdWxhdG9y
U3RhdGUKNDRhOTRlZCBpMzg2OiBodmY6IFVzZSBJUCBmcm9tIENQVVg4NlN0YXRlCmVmNmZlNzkg
aTM4NjogaHZmOiBVc2UgaW5zX2xlbiB0byBhZHZhbmNlIElQCmVjODhiMTIgaTM4NjogaHZmOiBE
cm9wIHVudXNlZCB2YXJpYWJsZQpkZThkOTk5IGkzODY6IGh2ZjogQ2xlYW4gc3RyYXkgaW5jbHVk
ZXMgaW4gc3lzZW11CmFkMDYxYmMgaTM4NjogaHZmOiBEcm9wIHVzZWxlc3MgZGVjbGFyYXRpb25z
IGluIHN5c2VtdQowZGE2ZmJhIGkzODY6IGh2ZjogTW92ZSBIVkZTdGF0ZSBkZWZpbml0aW9uIGlu
dG8gaHZmCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzEzIENoZWNraW5nIGNvbW1pdCAwZGE2ZmJh
ZmRhNWYgKGkzODY6IGh2ZjogTW92ZSBIVkZTdGF0ZSBkZWZpbml0aW9uIGludG8gaHZmKQoyLzEz
IENoZWNraW5nIGNvbW1pdCBhZDA2MWJjN2YwMjUgKGkzODY6IGh2ZjogRHJvcCB1c2VsZXNzIGRl
Y2xhcmF0aW9ucyBpbiBzeXNlbXUpCjMvMTMgQ2hlY2tpbmcgY29tbWl0IGRlOGQ5OTk3ZTkxMSAo
aTM4NjogaHZmOiBDbGVhbiBzdHJheSBpbmNsdWRlcyBpbiBzeXNlbXUpCjQvMTMgQ2hlY2tpbmcg
Y29tbWl0IGVjODhiMTJjNGFlNyAoaTM4NjogaHZmOiBEcm9wIHVudXNlZCB2YXJpYWJsZSkKNS8x
MyBDaGVja2luZyBjb21taXQgZWY2ZmU3OTY5NzhlIChpMzg2OiBodmY6IFVzZSBpbnNfbGVuIHRv
IGFkdmFuY2UgSVApCjYvMTMgQ2hlY2tpbmcgY29tbWl0IDQ0YTk0ZWQyMWQwNiAoaTM4NjogaHZm
OiBVc2UgSVAgZnJvbSBDUFVYODZTdGF0ZSkKRVJST1I6IHVubmVjZXNzYXJ5IHdoaXRlc3BhY2Ug
YmVmb3JlIGEgcXVvdGVkIG5ld2xpbmUKIzQ0NDogRklMRTogdGFyZ2V0L2kzODYvaHZmL3g4Nl9l
bXUuYzoxNDcwOgorICAgICAgICBwcmludGYoIlVuaW1wbGVtZW50ZWQgaGFuZGxlciAoJWxseCkg
Zm9yICVkICgleCAleCkgXG4iLCBlbnYtPmVpcCwKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5n
cywgNDAzIGxpbmVzIGNoZWNrZWQKClBhdGNoIDYvMTMgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVh
c2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJl
cG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVS
Uy4KCjcvMTMgQ2hlY2tpbmcgY29tbWl0IDNhYTU3YWFiOTI3MSAoaTM4NjogaHZmOiBEcm9wIGZl
dGNoX3JpcCBmcm9tIEhWRlg4NkVtdWxhdG9yU3RhdGUpCjgvMTMgQ2hlY2tpbmcgY29tbWl0IGFl
ZjcyNzg1ZGE2OCAoaTM4NjogaHZmOiBEcm9wIHJmbGFncyBmcm9tIEhWRlg4NkVtdWxhdG9yU3Rh
dGUpCjkvMTMgQ2hlY2tpbmcgY29tbWl0IDcwYjI4MzlkOGQyZSAoaTM4NjogaHZmOiBEcm9wIGNv
cHkgb2YgUkZMQUdTIGRlZmluZXMpCjEwLzEzIENoZWNraW5nIGNvbW1pdCBiYTZjODIxZjhhN2Ug
KGkzODY6IGh2ZjogRHJvcCByZWdzIGluIEhWRlg4NkVtdWxhdG9yU3RhdGUpCjExLzEzIENoZWNr
aW5nIGNvbW1pdCA1M2I5MzU0MjQ0NDQgKGkzODY6IGh2ZjogTW92ZSBsYXp5X2ZsYWdzIGludG8g
Q1BVWDg2U3RhdGUpCjEyLzEzIENoZWNraW5nIGNvbW1pdCA1NzU1N2JlMmQxM2MgKGkzODY6IGh2
ZjogTW92ZSBtbWlvX2J1ZiBpbnRvIENQVVg4NlN0YXRlKQoxMy8xMyBDaGVja2luZyBjb21taXQg
YmFiZmQ3NTc4NzI0IChpMzg2OiBodmY6IERyb3AgSFZGWDg2RW11bGF0b3JTdGF0ZSkKPT09IE9V
VFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxs
IGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1MjgxOTM3
NTguNTE0NTQtMS1yLmJvbHNoYWtvdkB5YWRyby5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t


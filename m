Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F23BC4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:31:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E658206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E658206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLtQw-0002as-Hb
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 15:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kLtMf-00089k-7o
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:26:41 -0400
Resent-Date: Fri, 25 Sep 2020 15:26:41 -0400
Resent-Message-Id: <E1kLtMf-00089k-7o@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kLtMY-0005R6-Qq
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:26:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601061990; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ieVvw++TNhQmRdWIC0qDPNtodK53WKyE3YDY2bbu6Qqh4hif9/vPr5z4BOUAbxGCawpX9hU8lSJU9Vp7AGKFT75+i8n+efJMuv/Zr+xg1YgTkXw/NSj0UqtKS3kLIQl7cB8oYLQKazDwBh4Oi0sYZMtyoUQhunmsn8heneoybi8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601061990;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=AtJR+89X9hKtcVU3jCMVev8UvkUvgCfAurHbg8dfFME=; 
 b=AIjpI+o+jKtw1nbmsqBnkKOFxmFrW6b2NQ7TupjWdlT7YLU57dnHJZec06zV6xp10dOx70jS84CGdJyF3ZPManEs0Jt/ZBEqqPluBfYj1UGZ2q74W7xv00hLuHPhRPqg9KUdpmuQkg7eHUbjWVUCIEVL1IcB32U2su/KtYh3/pc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1601061989610128.7778653117557;
 Fri, 25 Sep 2020 12:26:29 -0700 (PDT)
Subject: Re: [PATCH 00/10] Fix scsi devices plug/unplug races w.r.t
 virtio-scsi iothread
Message-ID: <160106198842.10465.14273020261352828708@66eaa9a8a123>
In-Reply-To: <20200925172604.2142227-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Fri, 25 Sep 2020 12:26:29 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 15:25:48
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mlevitsk@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyNTE3MjYwNC4yMTQy
MjI3LTEtcGJvbnppbmlAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAwOTI1MTcyNjA0LjIx
NDIyMjctMS1wYm9uemluaUByZWRoYXQuY29tClN1YmplY3Q6IFtQQVRDSCAwMC8xMF0gRml4IHNj
c2kgZGV2aWNlcyBwbHVnL3VucGx1ZyByYWNlcyB3LnIudCB2aXJ0aW8tc2NzaSBpb3RocmVhZAoK
PT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2Ug
PiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0
IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWls
YmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0cHM6Ly9naXRodWIu
Y29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAy
MDA5MjUxNzI2MDQuMjE0MjIyNy0xLXBib256aW5pQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDIw
MDkyNTE3MjYwNC4yMTQyMjI3LTEtcGJvbnppbmlAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5l
dyBicmFuY2ggJ3Rlc3QnCjIxYzIzODAgc2NzaS9zY3NpX2J1czogZml4IHJhY2VzIGluIFJFUE9S
VCBMVU5TCmFhY2QyMzAgdmlydGlvLXNjc2k6IHVzZSBzY3NpX2RldmljZV9nZXQKZjlmOGYwOCBz
Y3NpL3Njc2lfYnVzOiBBZGQgc2NzaV9kZXZpY2VfZ2V0CmM2NjA1MGYgc2NzaS9zY3NpLWJ1czog
c2NzaV9kZXZpY2VfZmluZDogZG9uJ3QgcmV0dXJuIHVucmVhbGl6ZWQgZGV2aWNlcwpiYjlmYmQz
IGRldmljZS1jb3JlOiB1c2UgYXRvbWljX3NldCBvbiAucmVhbGl6ZWQgcHJvcGVydHkKYmQ4NzU5
MyBkZXZpY2UtY29yZTogdXNlIFJDVSBmb3IgbGlzdCBvZiBjaGlsZHJlbiBvZiBhIGJ1cwo1MWE4
ZWJlIGRldmljZV9jb3JlOiB1c2UgZHJhaW5fY2FsbF9yY3UgaW4gaW4gaG1wX2RldmljZV9kZWwv
cW1wX2RldmljZV9hZGQKYTU5NWFhMiBzY3NpL3Njc2lfYnVzOiBzd2l0Y2ggc2VhcmNoIGRpcmVj
dGlvbiBpbiBzY3NpX2RldmljZV9maW5kCjY3MzlhMjAgc2NzaTogc3dpdGNoIHRvIGJ1cy0+Y2hl
Y2tfYWRkcmVzcwpjNGVkMDc5IHFkZXY6IGFkZCAiY2hlY2sgaWYgYWRkcmVzcyBmcmVlIiBjYWxs
YmFjayBmb3IgYnVzZXMKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMTAgQ2hlY2tpbmcgY29tbWl0
IGM0ZWQwNzk1YTM2ZCAocWRldjogYWRkICJjaGVjayBpZiBhZGRyZXNzIGZyZWUiIGNhbGxiYWNr
IGZvciBidXNlcykKMi8xMCBDaGVja2luZyBjb21taXQgNjczOWEyMDVlNjgzIChzY3NpOiBzd2l0
Y2ggdG8gYnVzLT5jaGVja19hZGRyZXNzKQpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVy
IHVzZSB0YWJzCiM1MzogRklMRTogaHcvc2NzaS9zY3NpLWJ1cy5jOjEzNzoKK15JXkleSV5JICAg
ICBpbnQgY2hhbm5lbCwgaW50IHRhcmdldCwgaW50IGx1biwkCgpFUlJPUjogY29kZSBpbmRlbnQg
c2hvdWxkIG5ldmVyIHVzZSB0YWJzCiM1NDogRklMRTogaHcvc2NzaS9zY3NpLWJ1cy5jOjEzODoK
K15JXkleSV5JICAgICBTQ1NJRGV2aWNlICoqcF9kZXYpJAoKV0FSTklORzogbGluZSBvdmVyIDgw
IGNoYXJhY3RlcnMKIzY5OiBGSUxFOiBody9zY3NpL3Njc2ktYnVzLmM6MTUzOgorc3RhdGljIGJv
b2wgc2NzaV9idXNfY2hlY2tfYWRkcmVzcyhCdXNTdGF0ZSAqcWJ1cywgRGV2aWNlU3RhdGUgKnFk
ZXYsIEVycm9yICoqZXJycCkKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiM4OTog
RklMRTogaHcvc2NzaS9zY3NpLWJ1cy5jOjE3MzoKKyAgICAgICAgaWYgKCFzY3NpX2J1c19pc19h
ZGRyZXNzX2ZyZWUoYnVzLCBkZXYtPmNoYW5uZWwsIGRldi0+aWQsIGRldi0+bHVuLCAmZCkpIHsK
CldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMxMjg6IEZJTEU6IGh3L3Njc2kvc2Nz
aS1idXMuYzoxOTU6CisgICAgICAgICAgICBpc19mcmVlID0gc2NzaV9idXNfaXNfYWRkcmVzc19m
cmVlKGJ1cywgZGV2LT5jaGFubmVsLCArK2lkLCBkZXYtPmx1biwgTlVMTCk7CgpXQVJOSU5HOiBs
aW5lIG92ZXIgODAgY2hhcmFjdGVycwojMTQxOiBGSUxFOiBody9zY3NpL3Njc2ktYnVzLmM6MjA1
OgorICAgICAgICAgICAgaXNfZnJlZSA9IHNjc2lfYnVzX2lzX2FkZHJlc3NfZnJlZShidXMsIGRl
di0+Y2hhbm5lbCwgZGV2LT5pZCwgKytsdW4sIE5VTEwpOwoKdG90YWw6IDIgZXJyb3JzLCA0IHdh
cm5pbmdzLCAxODIgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi8xMCBoYXMgc3R5bGUgcHJvYmxlbXMs
IHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2
ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5U
QUlORVJTLgoKMy8xMCBDaGVja2luZyBjb21taXQgYTU5NWFhMjg4ZjE5IChzY3NpL3Njc2lfYnVz
OiBzd2l0Y2ggc2VhcmNoIGRpcmVjdGlvbiBpbiBzY3NpX2RldmljZV9maW5kKQo0LzEwIENoZWNr
aW5nIGNvbW1pdCA1MWE4ZWJlNjRjNWYgKGRldmljZV9jb3JlOiB1c2UgZHJhaW5fY2FsbF9yY3Ug
aW4gaW4gaG1wX2RldmljZV9kZWwvcW1wX2RldmljZV9hZGQpCjUvMTAgQ2hlY2tpbmcgY29tbWl0
IGJkODc1OTNmZmI2ZSAoZGV2aWNlLWNvcmU6IHVzZSBSQ1UgZm9yIGxpc3Qgb2YgY2hpbGRyZW4g
b2YgYSBidXMpCjYvMTAgQ2hlY2tpbmcgY29tbWl0IGJiOWZiZDNkN2EyNSAoZGV2aWNlLWNvcmU6
IHVzZSBhdG9taWNfc2V0IG9uIC5yZWFsaXplZCBwcm9wZXJ0eSkKNy8xMCBDaGVja2luZyBjb21t
aXQgYzY2MDUwZjY1N2FlIChzY3NpL3Njc2ktYnVzOiBzY3NpX2RldmljZV9maW5kOiBkb24ndCBy
ZXR1cm4gdW5yZWFsaXplZCBkZXZpY2VzKQo4LzEwIENoZWNraW5nIGNvbW1pdCBmOWY4ZjA4ODhl
NTggKHNjc2kvc2NzaV9idXM6IEFkZCBzY3NpX2RldmljZV9nZXQpCjkvMTAgQ2hlY2tpbmcgY29t
bWl0IGFhY2QyMzAxY2VmOCAodmlydGlvLXNjc2k6IHVzZSBzY3NpX2RldmljZV9nZXQpCjEwLzEw
IENoZWNraW5nIGNvbW1pdCAyMWMyMzgwNDJiZTcgKHNjc2kvc2NzaV9idXM6IGZpeCByYWNlcyBp
biBSRVBPUlQgTFVOUykKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdp
dGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMjAyMDA5MjUxNzI2MDQuMjE0MjIyNy0xLXBib256aW5pQHJlZGhhdC5jb20vdGVz
dGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21h
dGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlv
dXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


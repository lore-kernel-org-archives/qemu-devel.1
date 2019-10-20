Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E209CA9EAD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 15:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC0121928
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 15:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC0121928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMDJH-0004SO-Dy
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 11:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iMDIF-0003zh-Mr
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 11:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iMDIE-0003ai-4t
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 11:38:55 -0400
Resent-Date: Sun, 20 Oct 2019 11:38:55 -0400
Resent-Message-Id: <E1iMDIE-0003ai-4t@eggs.gnu.org>
Received: from sender4-of-o56.zoho.com ([136.143.188.56]:21638)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iMDID-0003Zq-Tj
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 11:38:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571585917; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WGrXweoY3HywyrWSaai8ZbipEd3dpDa0CWb5CNyJxz1k+WcDTd250nCw99dpubyztcAbAreds9iSFt9B9OHmd3vuIE8QSBP/wqOOFqPFRgAhXaxJs5xmwVKbXnMcC9woeUNvb2yOH/w19dGLgNdasMRsWXrogZfQq+2bcWdyZis=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571585917;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=1blMsVSeFTZZixdv9UT17NyI9+zwqwjbOZcoJXZy+EI=; 
 b=WuHcnDz907mQQXSGSL2pjwSCZ6znHccMogidEiRuW1+BZOIFrUQM+3OrhMRV2bF54QhAAywdoXkvRxu+32qYrRf7OeKilMP3K9IXAnaoMT8zGW8gKevcn9MEqvW7IoF+jbLlvg/MNiILPNvupcpKDCgiJ8e5xrOiSEcL7I7IeJk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15715859137311.9150104424019219;
 Sun, 20 Oct 2019 08:38:33 -0700 (PDT)
In-Reply-To: <20191020144750.1176-1-dietmar@proxmox.com>
Subject: Re: [PATCH v2] yield_until_fd_readable: make it work with any
 AioContect
Message-ID: <157158591264.24734.14699340658144444376@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dietmar@proxmox.com
Date: Sun, 20 Oct 2019 08:38:33 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.56
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, dietmar@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAyMDE0NDc1MC4xMTc2
LTEtZGlldG1hckBwcm94bW94LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHYyXSB5aWVsZF91bnRpbF9mZF9yZWFkYWJsZTog
bWFrZSBpdCB3b3JrIHdpdGggYW55IEFpb0NvbnRlY3QKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6
IDIwMTkxMDIwMTQ0NzUwLjExNzYtMS1kaWV0bWFyQHByb3htb3guY29tCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8
fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3Jp
dGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9
PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo1
ZGFiZThhIHlpZWxkX3VudGlsX2ZkX3JlYWRhYmxlOiBtYWtlIGl0IHdvcmsgd2l0aCBhbnkgQWlv
Q29udGVjdAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0
ZXJzCiM0MTogRklMRTogdXRpbC9xZW11LWNvcm91dGluZS1pby5jOjczOgorICAgIGFpb19zZXRf
ZmRfaGFuZGxlcihjdHgsIGZkLCBmYWxzZSwgKHZvaWQgKCopKHZvaWQgKikpcWVtdV9jb3JvdXRp
bmVfZW50ZXIsIE5VTEwsIE5VTEwsIHFlbXVfY29yb3V0aW5lX3NlbGYoKSk7Cgp0b3RhbDogMSBl
cnJvcnMsIDAgd2FybmluZ3MsIDI4IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCA1ZGFiZThhMDIwNTEg
KHlpZWxkX3VudGlsX2ZkX3JlYWRhYmxlOiBtYWtlIGl0IHdvcmsgd2l0aCBhbnkgQWlvQ29udGVj
dCkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVy
cm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBz
ZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNv
bW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQK
aHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTEwMjAxNDQ3NTAuMTE3Ni0xLWRpZXRtYXJAcHJv
eG1veC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t



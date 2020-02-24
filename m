Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C3DC38BFA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF9E2176D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF9E2176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MH9-0004Oi-PM
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:32:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j6M9T-00084V-An
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j6M9R-0006rd-Pq
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:24:35 -0500
Resent-Date: Mon, 24 Feb 2020 17:24:35 -0500
Resent-Message-Id: <E1j6M9R-0006rd-Pq@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j6M9R-0006rA-H5
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:24:33 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1582583041; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hsFphQXb7NH731LDW7ujqIVwgWHi5miUG6lUvh8eL/X9G8Bukd94cKurGHVcGZueD62SPXgQv4reTH7wDuwabDJyG5R8NFFNuoXCKceNz5Cn5SjRxClqDnWBirGMXo8R4cjz46aS4ZFYfMCaHSqRjEGC1xzsP2Z3FG1bZ/R7eQ8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1582583041;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=VBKsFD0Apr5oa5Hkh90ApPqAcwCadgXyRXCodB4lou0=; 
 b=hg18dExzNEqo6JKguDcAWt0MFZi0imbHRMuWSzig4n01uWNtgBWhf/T7Zw3xF96pLn7KDBe+bpCBdj2W9zj3aPLhdYgE6L079bz6Lfo44kTLRDp6Xs+ycEG1bd91bx/IKo3zn5bbLzZeZewBVKsiIwqnCMupbJGm0+5hlAnMhuc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1582583038206170.36458632506879;
 Mon, 24 Feb 2020 14:23:58 -0800 (PST)
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
Subject: Re: [PATCH v5 00/50] Initial support for multi-process qemu
Message-ID: <158258303525.10132.16101667667220110836@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jag.raman@oracle.com
Date: Mon, 24 Feb 2020 14:23:58 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTgyNTc2MzcyLmdp
dC5qYWcucmFtYW5Ab3JhY2xlLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5F
VFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9
MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpxZW11LXN5c3RlbS1hYXJjaDY0
OiBmYWxsaW5nIGJhY2sgdG8gdGNnCiAgVEVTVCAgICBjaGVjay11bml0OiB0ZXN0cy90ZXN0LWNo
YXIKKioKRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3Rlc3QtY2hhci5jOjIzMDpjaGFy
X211eF90ZXN0OiBhc3NlcnRpb24gZmFpbGVkIChoMS5sYXN0X2V2ZW50ID09IDQyKTogKDMgPT0g
NDIpCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDAwNApxZW11LXN5c3RlbS1hYXJjaDY0OiAtYWNj
ZWwga3ZtOiBpbnZhbGlkIGFjY2VsZXJhdG9yIGt2bQpxZW11LXN5c3RlbS1hYXJjaDY0OiBmYWxs
aW5nIGJhY2sgdG8gdGNnCkVSUk9SIC0gQmFpbCBvdXQhIEVSUk9SOi90bXAvcWVtdS10ZXN0L3Ny
Yy90ZXN0cy90ZXN0LWNoYXIuYzoyMzA6Y2hhcl9tdXhfdGVzdDogYXNzZXJ0aW9uIGZhaWxlZCAo
aDEubGFzdF9ldmVudCA9PSA0Mik6ICgzID09IDQyKQptYWtlOiAqKiogW2NoZWNrLXVuaXRdIEVy
cm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBURVNUICAg
IGNoZWNrLXF0ZXN0LXg4Nl82NDogdGVzdHMvcXRlc3QvZmRjLXRlc3QKICBURVNUICAgIGlvdGVz
dC1xY293MjogMDA1Ci0tLQpOb3QgcnVuOiAyNTkKRmFpbHVyZXM6IDAzMCAwNDAgMDQxIDA3MSAw
OTkgMTIwIDE4NCAxODYgMjY3CkZhaWxlZCA5IG9mIDExNiBpb3Rlc3RzCm1ha2U6ICoqKiBbY2hl
Y2stdGVzdHMvY2hlY2stYmxvY2suc2hdIEVycm9yIDEKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBj
YWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjY0LCBp
biA8bW9kdWxlPgogICAgc3lzLmV4aXQobWFpbigpKQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nl
c3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21t
YW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11
Lmluc3RhbmNlLnV1aWQ9MDg0ZjQ0OGJmYjQxNGQ2NmEyMmEyY2NmMTMzZjcxNjMnLCAnLXUnLCAn
MTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICct
ZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywg
J1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAn
LWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8u
Y2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIv
dG1wL3BhdGNoZXctdGVzdGVyLXRtcC0wdmh6NDdfYy9zcmMvZG9ja2VyLXNyYy4yMDIwLTAyLTI0
LTE3LjA5LjE2LjExNzQ6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFy
L3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3Rh
dHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTA4NGY0
NDhiZmI0MTRkNjZhMjJhMmNjZjEzM2Y3MTYzCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJy
b3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXIt
dG1wLTB2aHo0N19jL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9z
N10gRXJyb3IgMgoKcmVhbCAgICAxNG0zOS45MDZzCnVzZXIgICAgMG04LjM0MHMKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzL2NvdmVyLjE1ODI1
NzYzNzIuZ2l0LmphZy5yYW1hbkBvcmFjbGUuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRv
czcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


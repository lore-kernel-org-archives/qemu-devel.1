Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67333CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A31421D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A31421D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO4vE-00078q-Un
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 15:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iO4rn-0001Ee-15
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iO4rl-0004XH-6s
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:03:18 -0400
Resent-Date: Fri, 25 Oct 2019 15:03:18 -0400
Resent-Message-Id: <E1iO4rl-0004XH-6s@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21445)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iO4rk-0004WL-Se
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:03:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572030174; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kA9aPOrZ3g+S6tgp5ozhV+v3zM47Z8WZpc9IEV51ZywAhH3UN5aYJb4ionG+hH6I60MfyuiHd53awL+r+r1McnNnaooACDjzZR8J2ztapbs5XRgbtsm8EW+kF75cnvBfqxEcQxi9lPwi3DqRRlhrjy8kWpYprVeAiePFIcgMdVU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572030174;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=nEqxn9SibQJyl+HZHFCCOxOuqM8vWuonUVFa9axPI2E=; 
 b=NkmNbJl/58juMgNadKkEQZr26tt+SyoJ2goPoGl1tJxW47Hvo12vKj5qNT2T4EKmVyAIF26WQ2tZSFK89kl9eTEjgbBqDqlDnb44bRDsV9LeAwy+kZM1PhQYuMP+o15haEv1eZx9Db3mkvJEpjDfbyGXWyD6S9RgnVo6GXvcOt4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1572030173844991.2777826940095;
 Fri, 25 Oct 2019 12:02:53 -0700 (PDT)
In-Reply-To: <20191025022553.25298-1-ehabkost@redhat.com>
Subject: Re: [PATCH 0/7] i386: Add `machine` parameter to query-cpu-definitions
Message-ID: <157203017258.8606.11902247566926802617@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ehabkost@redhat.com
Date: Fri, 25 Oct 2019 12:02:53 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com,
 imammedo@redhat.com, jdenemar@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAyNTAyMjU1My4yNTI5
OC0xLWVoYWJrb3N0QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCAwLzddIGkzODY6IEFkZCBgbWFjaGluZWAgcGFy
YW1ldGVyIHRvIHF1ZXJ5LWNwdS1kZWZpbml0aW9ucwpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDog
MjAxOTEwMjUwMjI1NTMuMjUyOTgtMS1laGFia29zdEByZWRoYXQuY29tCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8
fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3Jp
dGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9
PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRl
ZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjgwNzc0ZjMg
Y3B1OiBBZGQgYG1hY2hpbmVgIHBhcmFtZXRlciB0byBxdWVyeS1jcHUtZGVmaW5pdGlvbnMKYTk0
NDY5ZSBpMzg2OiBEb24ndCB1c2UgZGVmYXVsdF9jcHVfdmVyc2lvbigpIGluc2lkZSBxdWVyeS1j
cHUtZGVmaW5pdGlvbnMKOWM4MjAwNCBpMzg2OiBSZW1vdmUgeDg2X2NwdV9zZXRfZGVmYXVsdF92
ZXJzaW9uKCkgZnVuY3Rpb24KYzUyOTYyNCBtYWNoaW5lOiBtYWNoaW5lX2ZpbmRfY2xhc3MoKSBm
dW5jdGlvbgpmNzllZGZjIGkzODY6IERvbid0IHVzZSBkZWZhdWx0X2NwdV92ZXJzaW9uIGF0ICIt
Y3B1IGhlbHAiCjAxMDY5ODMgaTM4NjogQWRkIGRlZmF1bHRfdmVyc2lvbiBwYXJhbWV0ZXIgdG8g
Q1BVIHZlcnNpb24gZnVuY3Rpb25zCmQ2YTE3MmIgaTM4NjogVXNlIGdfYXV0b2ZyZWUgYXQgeDg2
X2NwdV9saXN0X2VudHJ5KCkKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvNyBDaGVja2luZyBjb21t
aXQgZDZhMTcyYjA1NjE5IChpMzg2OiBVc2UgZ19hdXRvZnJlZSBhdCB4ODZfY3B1X2xpc3RfZW50
cnkoKSkKMi83IENoZWNraW5nIGNvbW1pdCAwMTA2OTgzYzdiM2MgKGkzODY6IEFkZCBkZWZhdWx0
X3ZlcnNpb24gcGFyYW1ldGVyIHRvIENQVSB2ZXJzaW9uIGZ1bmN0aW9ucykKV0FSTklORzogbGlu
ZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzI4OiBGSUxFOiB0YXJnZXQvaTM4Ni9jcHUuYzozMTkxOgor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgWDg2Q1BV
VmVyc2lvbiBkZWZhdWx0X3ZlcnNpb24pCgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVy
cwojNjA6IEZJTEU6IHRhcmdldC9pMzg2L2NwdS5jOjM5ODM6CisgICAgZ19hdXRvZnJlZSBjaGFy
ICphbGlhc19vZiA9IHg4Nl9jcHVfY2xhc3NfZ2V0X2FsaWFzX29mKGNjLCBkZWZhdWx0X2NwdV92
ZXJzaW9uKTsKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiM3ODogRklMRTogdGFy
Z2V0L2kzODYvY3B1LmM6NDEyMToKKyAgICBYODZDUFVWZXJzaW9uIHZlcnNpb24gPSB4ODZfY3B1
X21vZGVsX3Jlc29sdmVfdmVyc2lvbihtb2RlbCwgZGVmYXVsdF9jcHVfdmVyc2lvbik7Cgp0b3Rh
bDogMCBlcnJvcnMsIDMgd2FybmluZ3MsIDU1IGxpbmVzIGNoZWNrZWQKClBhdGNoIDIvNyBoYXMg
c3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFy
ZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVD
S1BBVENIIGluIE1BSU5UQUlORVJTLgozLzcgQ2hlY2tpbmcgY29tbWl0IGY3OWVkZmNkNjE5NSAo
aTM4NjogRG9uJ3QgdXNlIGRlZmF1bHRfY3B1X3ZlcnNpb24gYXQgIi1jcHUgaGVscCIpCjQvNyBD
aGVja2luZyBjb21taXQgYzUyOTYyNGQyODdiIChtYWNoaW5lOiBtYWNoaW5lX2ZpbmRfY2xhc3Mo
KSBmdW5jdGlvbikKNS83IENoZWNraW5nIGNvbW1pdCA5YzgyMDA0NWM3MzMgKGkzODY6IFJlbW92
ZSB4ODZfY3B1X3NldF9kZWZhdWx0X3ZlcnNpb24oKSBmdW5jdGlvbikKV0FSTklORzogbGluZSBv
dmVyIDgwIGNoYXJhY3RlcnMKIzgxOiBGSUxFOiB0YXJnZXQvaTM4Ni9jcHUuYzozMTc4OgorICAg
ICAgICAoUENNYWNoaW5lQ2xhc3MgKilvYmplY3RfY2xhc3NfZHluYW1pY19jYXN0KE9CSkVDVF9D
TEFTUyhtYyksIFRZUEVfUENfTUFDSElORSk7CgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFj
dGVycwojODc6IEZJTEU6IHRhcmdldC9pMzg2L2NwdS5jOjMxODQ6CisgICAgcmV0dXJuIGRlZmF1
bHRfY3B1X3ZlcnNpb25fZm9yX21hY2hpbmUoTUFDSElORV9HRVRfQ0xBU1MocWRldl9nZXRfbWFj
aGluZSgpKSk7CgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMTEwOiBGSUxFOiB0
YXJnZXQvaTM4Ni9jcHUuYzo0MTM0OgorICAgIFg4NkNQVVZlcnNpb24gdmVyc2lvbiA9IHg4Nl9j
cHVfbW9kZWxfcmVzb2x2ZV92ZXJzaW9uKG1vZGVsLCBkZWZhdWx0X2NwdV92ZXJzaW9uKCkpOwoK
dG90YWw6IDAgZXJyb3JzLCAzIHdhcm5pbmdzLCA4OCBsaW5lcyBjaGVja2VkCgpQYXRjaCA1Lzcg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KNi83IENoZWNraW5nIGNvbW1pdCBhOTQ0NjllYTli
ODMgKGkzODY6IERvbid0IHVzZSBkZWZhdWx0X2NwdV92ZXJzaW9uKCkgaW5zaWRlIHF1ZXJ5LWNw
dS1kZWZpbml0aW9ucykKNy83IENoZWNraW5nIGNvbW1pdCA4MDc3NGYzODY2YmUgKGNwdTogQWRk
IGBtYWNoaW5lYCBwYXJhbWV0ZXIgdG8gcXVlcnktY3B1LWRlZmluaXRpb25zKQpXQVJOSU5HOiBs
aW5lIG92ZXIgODAgY2hhcmFjdGVycwojMTQ3OiBGSUxFOiB0ZXN0cy9hY2NlcHRhbmNlL3g4Nl9j
cHVfbW9kZWxfdmVyc2lvbnMucHk6MjM4OgorICAgICAgICAiIiJDaGVjayBpZiB1bnZlcnNpb25l
ZCBDUFUgbW9kZWwgaXMgYW4gYWxpYXMgcG9pbnRpbmcgdG8gcmlnaHQgdmVyc2lvbiIiIgoKRVJS
T1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiMxNTI6IEZJTEU6IHRlc3RzL2FjY2VwdGFuY2Uv
eDg2X2NwdV9tb2RlbF92ZXJzaW9ucy5weToyNDM6CisgICAgICAgIGNwdXMxID0gZGljdCgobVsn
bmFtZSddLCBtLmdldCgnYWxpYXMtb2YnKSkgZm9yIG0gaW4gdm0xLmNvbW1hbmQoJ3F1ZXJ5LWNw
dS1kZWZpbml0aW9ucycsIG1hY2hpbmU9J25vbmUnKSkKCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hh
cmFjdGVycwojMTU5OiBGSUxFOiB0ZXN0cy9hY2NlcHRhbmNlL3g4Nl9jcHVfbW9kZWxfdmVyc2lv
bnMucHk6MjUwOgorICAgICAgICBjcHVzMiA9IGRpY3QoKG1bJ25hbWUnXSwgbS5nZXQoJ2FsaWFz
LW9mJykpIGZvciBtIGluIHZtMi5jb21tYW5kKCdxdWVyeS1jcHUtZGVmaW5pdGlvbnMnKSkKCldB
Uk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMxNjU6IEZJTEU6IHRlc3RzL2FjY2VwdGFu
Y2UveDg2X2NwdV9tb2RlbF92ZXJzaW9ucy5weToyNTY6CisgICAgICAgICIiIkNoZWNrIGlmIHVu
dmVyc2lvbmVkIENQVSBtb2RlbCBpcyBhbiBhbGlhcyBwb2ludGluZyB0byByaWdodCB2ZXJzaW9u
IiIiCgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzE3MDogRklMRTogdGVzdHMvYWNj
ZXB0YW5jZS94ODZfY3B1X21vZGVsX3ZlcnNpb25zLnB5OjI2MToKKyAgICAgICAgY3B1czEgPSBk
aWN0KChtWyduYW1lJ10sIG0uZ2V0KCdhbGlhcy1vZicpKSBmb3IgbSBpbiB2bTEuY29tbWFuZCgn
cXVlcnktY3B1LWRlZmluaXRpb25zJywgbWFjaGluZT0ncGMtaTQ0MGZ4LTQuMScpKQoKRVJST1I6
IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiMxNzc6IEZJTEU6IHRlc3RzL2FjY2VwdGFuY2UveDg2
X2NwdV9tb2RlbF92ZXJzaW9ucy5weToyNjg6CisgICAgICAgIGNwdXMyID0gZGljdCgobVsnbmFt
ZSddLCBtLmdldCgnYWxpYXMtb2YnKSkgZm9yIG0gaW4gdm0yLmNvbW1hbmQoJ3F1ZXJ5LWNwdS1k
ZWZpbml0aW9ucycpKQoKdG90YWw6IDQgZXJyb3JzLCAyIHdhcm5pbmdzLCAxNDEgbGluZXMgY2hl
Y2tlZAoKUGF0Y2ggNy83IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFu
eSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUg
bWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVO
RCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlz
IGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTAyNTAyMjU1My4yNTI5
OC0xLWVoYWJrb3N0QHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t



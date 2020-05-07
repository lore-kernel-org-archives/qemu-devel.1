Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A76C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 06:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB8812075E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 06:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8812075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWZbU-00039Z-N6
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 02:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jWZao-0002gG-98; Thu, 07 May 2020 02:01:10 -0400
Resent-Date: Thu, 07 May 2020 02:01:10 -0400
Resent-Message-Id: <E1jWZao-0002gG-98@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jWZam-0001sE-KK; Thu, 07 May 2020 02:01:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588831242; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=A+4+3lWLlL22OdM+HS0O/AuBmMK6dfYRcEtBJELJmyYGnR7uQuAFd5RCdXHEGssgmN3sJWECGaJWEb0hLckOrWvbl4l7S+LLn0KujgLeR7Jd/6ggucdlNPNT1R0Nga3iozLexTwzjUxxh8+qDJd8tQLXTsf7A/eMBbnkrqBcs9E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588831242;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=HC0j2HBRfU/a0p0pjA6TwtivHoK8X3Wuvc7Xb73Ae94=; 
 b=jrUzz0RqxhIxqiZb44lC4vNGAq6CKW+1AMKuX7fx+I09j/Bj/z1g1sZmXHWOLcOoh9o9pCMOSN1IRTMGlrRPsfgntJTNY6qzDNCN4RWkfekJgLq57ULPtF4OpgrpTvDEZmIG/D94HF8+kmdrdFhfvHd8JShf5H4c2nLawBd26tE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158883124049050.79332613357519;
 Wed, 6 May 2020 23:00:40 -0700 (PDT)
Message-ID: <158883123897.4109.4633937308510882032@45ef0f9c86ae>
In-Reply-To: <20200507050228.802395-1-david@gibson.dropbear.id.au>
Subject: Re: [PULL 00/18] ppc-for-5.1 queue 20200507
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: david@gibson.dropbear.id.au
Date: Wed, 6 May 2020 23:00:40 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:01:05
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
Cc: peter.maydell@linaro.org, aik@ozlabs.ru, qemu-devel@nongnu.org,
 npiggin@gmail.com, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUwNzA1MDIyOC44MDIz
OTUtMS1kYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMjAwNTA3MDUwMjI4LjgwMjM5NS0x
LWRhdmlkQGdpYnNvbi5kcm9wYmVhci5pZC5hdQpTdWJqZWN0OiBbUFVMTCAwMC8xOF0gcHBjLWZv
ci01LjEgcXVldWUgMjAyMDA1MDcKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3Rv
Z3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4
ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjJkN2NmMmYgdGFyZ2V0LXBw
YzogZml4IHJsd2ltaSwgcmx3aW5tLCBybHdubSBmb3IgQ2xhbmctOQo4YTQwYzk5IHNwYXByX252
ZGltbTogVHdlYWsgZXJyb3IgbWVzc2FnZXMKYzcxMTg4NCBzcGFwcl9udmRpbW0uYzogbWFrZSAn
bGFiZWwtc2l6ZScgbWFuZGF0b3J5CjNiOTY2ZWQgdGFyZ2V0L3BwYzogQWRkIHN1cHBvcnQgZm9y
IFJhZGl4IHBhcnRpdGlvbi1zY29wZWQgdHJhbnNsYXRpb24KODQxYzY4ZCB0YXJnZXQvcHBjOiBS
ZXdvcmsgcHBjX3JhZGl4NjRfd2Fsa190cmVlKCkgZm9yIHBhcnRpdGlvbi1zY29wZWQgdHJhbnNs
YXRpb24KYTY2NDhkYSB0YXJnZXQvcHBjOiBFeHRlbmQgcHBjX3JhZGl4NjRfY2hlY2tfcHJvdCgp
IHdpdGggYSAncGFydGl0aW9uX3Njb3BlZCcgYm9vbApiYTY0Mjg1IHRhcmdldC9wcGM6IEludHJv
ZHVjZSBwcGNfcmFkaXg2NF94bGF0ZSgpIGZvciBSYWRpeCB0cmVlIHRyYW5zbGF0aW9uCjEyZmZj
NzIgc3BhcHI6IERvbid0IGFsbG93IHVucGx1ZyBvZiBOVkxpbmsyIGRldmljZXMKYjgwN2RlMiB0
YXJnZXQvcHBjOiBBc3NlcnQgaWYgSFYgbW9kZSBpcyBzZXQgd2hlbiBydW5uaW5nIHVuZGVyIGEg
cHNlcmllcyBtYWNoaW5lCmI5MjExNzIgdGFyZ2V0L3BwYzogSW50cm9kdWNlIGEgcmVsb2NhdGlv
biBib29sIGluIHBwY19yYWRpeDY0X2hhbmRsZV9tbXVfZmF1bHQoKQowZjFlYTM3IHRhcmdldC9w
cGM6IEVuZm9yY2UgdGhhdCB0aGUgcm9vdCBwYWdlIGRpcmVjdG9yeSBzaXplIG11c3QgYmUgYXQg
bGVhc3QgNQowMjY1ZmViIHNwYXByOiBEcm9wIENBUyByZWJvb3QgZmxhZwo2NjBiYjI5IHNwYXBy
L2NhczogU2VwYXJhdGUgQ0FTIGhhbmRsaW5nIGZyb20gcmVidWlsZGluZyB0aGUgRkRUCmFlNjVk
YTYgc3BhcHI6IFNpbXBsaWZ5IHNlbGVjdGlvbiBvZiByYWRpeC9oYXNoIGR1cmluZyBDQVMKZDk4
NjllZCBwcGMvcG52OiBBZGQgc3VwcG9ydCBmb3IgTk1JIGludGVyZmFjZQpmMGVkNjVhIHBwYy9z
cGFwcjogdHdlYWsgY2hhbmdlIHN5c3RlbSByZXNldCBoZWxwZXIKZDhhMjljMSBzcGFwcjogRG9u
J3QgY2hlY2sgY2FwYWJpbGl0aWVzIHJlbW92ZWQgYmV0d2VlbiBDQVMgY2FsbHMKYTFhMjU5NyB0
YXJnZXQvcHBjOiBJbXByb3ZlIHN5c2NhbGwgZXhjZXB0aW9uIGxvZ2dpbmcKCj09PSBPVVRQVVQg
QkVHSU4gPT09CjEvMTggQ2hlY2tpbmcgY29tbWl0IGExYTI1OTc5NzljZiAodGFyZ2V0L3BwYzog
SW1wcm92ZSBzeXNjYWxsIGV4Y2VwdGlvbiBsb2dnaW5nKQpFUlJPUjogY29kZSBpbmRlbnQgc2hv
dWxkIG5ldmVyIHVzZSB0YWJzCiM0MjogRklMRTogdGFyZ2V0L3BwYy9leGNwX2hlbHBlci5jOjcz
OgorXkleSSAgIiByND0lMDE2IiBQUkl4NjQgIiByNT0lMDE2IiBQUkl4NjQgIiByNj0lMDE2IiBQ
Ukl4NjQkCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiM0MzogRklM
RTogdGFyZ2V0L3BwYy9leGNwX2hlbHBlci5jOjc0OgorXkleSSAgIiByNz0lMDE2IiBQUkl4NjQg
IiByOD0lMDE2IiBQUkl4NjQgIiByOT0lMDE2IiBQUkl4NjQkCgpFUlJPUjogY29kZSBpbmRlbnQg
c2hvdWxkIG5ldmVyIHVzZSB0YWJzCiM0NDogRklMRTogdGFyZ2V0L3BwYy9leGNwX2hlbHBlci5j
Ojc1OgorXkleSSAgIiByMTA9JTAxNiIgUFJJeDY0ICIgcjExPSUwMTYiIFBSSXg2NCAiIHIxMj0l
MDE2IiBQUkl4NjQkCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiM0
NzogRklMRTogdGFyZ2V0L3BwYy9leGNwX2hlbHBlci5jOjc4OgorXkleSSAgcHBjX2R1bXBfZ3By
KGVudiwgNSksIHBwY19kdW1wX2dwcihlbnYsIDYpLCQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91
bGQgbmV2ZXIgdXNlIHRhYnMKIzQ4OiBGSUxFOiB0YXJnZXQvcHBjL2V4Y3BfaGVscGVyLmM6Nzk6
CiteSV5JICBwcGNfZHVtcF9ncHIoZW52LCA3KSwgcHBjX2R1bXBfZ3ByKGVudiwgOCksJAoKRVJS
T1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojNDk6IEZJTEU6IHRhcmdldC9w
cGMvZXhjcF9oZWxwZXIuYzo4MDoKK15JXkkgIHBwY19kdW1wX2dwcihlbnYsIDkpLCBwcGNfZHVt
cF9ncHIoZW52LCAxMCksJAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFi
cwojNTA6IEZJTEU6IHRhcmdldC9wcGMvZXhjcF9oZWxwZXIuYzo4MToKK15JXkkgIHBwY19kdW1w
X2dwcihlbnYsIDExKSwgcHBjX2R1bXBfZ3ByKGVudiwgMTIpLCQKCkVSUk9SOiBjb2RlIGluZGVu
dCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzUxOiBGSUxFOiB0YXJnZXQvcHBjL2V4Y3BfaGVscGVy
LmM6ODI6CiteSV5JICBlbnYtPm5pcCk7JAoKdG90YWw6IDggZXJyb3JzLCAwIHdhcm5pbmdzLCA0
NyBsaW5lcyBjaGVja2VkCgpQYXRjaCAxLzE4IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJl
dmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQg
dGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoy
LzE4IENoZWNraW5nIGNvbW1pdCBkOGEyOWMxNjg0MGEgKHNwYXByOiBEb24ndCBjaGVjayBjYXBh
YmlsaXRpZXMgcmVtb3ZlZCBiZXR3ZWVuIENBUyBjYWxscykKMy8xOCBDaGVja2luZyBjb21taXQg
ZjBlZDY1YWRjMDM0IChwcGMvc3BhcHI6IHR3ZWFrIGNoYW5nZSBzeXN0ZW0gcmVzZXQgaGVscGVy
KQo0LzE4IENoZWNraW5nIGNvbW1pdCBkOTg2OWVkNzZlYjkgKHBwYy9wbnY6IEFkZCBzdXBwb3J0
IGZvciBOTUkgaW50ZXJmYWNlKQo1LzE4IENoZWNraW5nIGNvbW1pdCBhZTY1ZGE2MWViNmIgKHNw
YXByOiBTaW1wbGlmeSBzZWxlY3Rpb24gb2YgcmFkaXgvaGFzaCBkdXJpbmcgQ0FTKQo2LzE4IENo
ZWNraW5nIGNvbW1pdCA2NjBiYjI5NzE1MWIgKHNwYXByL2NhczogU2VwYXJhdGUgQ0FTIGhhbmRs
aW5nIGZyb20gcmVidWlsZGluZyB0aGUgRkRUKQo3LzE4IENoZWNraW5nIGNvbW1pdCAwMjY1ZmVi
ZWQ5ZGQgKHNwYXByOiBEcm9wIENBUyByZWJvb3QgZmxhZykKOC8xOCBDaGVja2luZyBjb21taXQg
MGYxZWEzN2JmOGUwICh0YXJnZXQvcHBjOiBFbmZvcmNlIHRoYXQgdGhlIHJvb3QgcGFnZSBkaXJl
Y3Rvcnkgc2l6ZSBtdXN0IGJlIGF0IGxlYXN0IDUpCjkvMTggQ2hlY2tpbmcgY29tbWl0IGI5MjEx
NzI5OTE4MCAodGFyZ2V0L3BwYzogSW50cm9kdWNlIGEgcmVsb2NhdGlvbiBib29sIGluIHBwY19y
YWRpeDY0X2hhbmRsZV9tbXVfZmF1bHQoKSkKMTAvMTggQ2hlY2tpbmcgY29tbWl0IGI4MDdkZTI3
YWFiNiAodGFyZ2V0L3BwYzogQXNzZXJ0IGlmIEhWIG1vZGUgaXMgc2V0IHdoZW4gcnVubmluZyB1
bmRlciBhIHBzZXJpZXMgbWFjaGluZSkKMTEvMTggQ2hlY2tpbmcgY29tbWl0IDEyZmZjNzIxNmZk
YiAoc3BhcHI6IERvbid0IGFsbG93IHVucGx1ZyBvZiBOVkxpbmsyIGRldmljZXMpCjEyLzE4IENo
ZWNraW5nIGNvbW1pdCBiYTY0Mjg1NzcxYjEgKHRhcmdldC9wcGM6IEludHJvZHVjZSBwcGNfcmFk
aXg2NF94bGF0ZSgpIGZvciBSYWRpeCB0cmVlIHRyYW5zbGF0aW9uKQoxMy8xOCBDaGVja2luZyBj
b21taXQgYTY2NDhkYTQ4MWEyICh0YXJnZXQvcHBjOiBFeHRlbmQgcHBjX3JhZGl4NjRfY2hlY2tf
cHJvdCgpIHdpdGggYSAncGFydGl0aW9uX3Njb3BlZCcgYm9vbCkKMTQvMTggQ2hlY2tpbmcgY29t
bWl0IDg0MWM2OGRlMzkyMyAodGFyZ2V0L3BwYzogUmV3b3JrIHBwY19yYWRpeDY0X3dhbGtfdHJl
ZSgpIGZvciBwYXJ0aXRpb24tc2NvcGVkIHRyYW5zbGF0aW9uKQoxNS8xOCBDaGVja2luZyBjb21t
aXQgM2I5NjZlZDgzODFkICh0YXJnZXQvcHBjOiBBZGQgc3VwcG9ydCBmb3IgUmFkaXggcGFydGl0
aW9uLXNjb3BlZCB0cmFuc2xhdGlvbikKMTYvMTggQ2hlY2tpbmcgY29tbWl0IGM3MTE4ODQyNDE1
ZCAoc3BhcHJfbnZkaW1tLmM6IG1ha2UgJ2xhYmVsLXNpemUnIG1hbmRhdG9yeSkKMTcvMTggQ2hl
Y2tpbmcgY29tbWl0IDhhNDBjOTk0M2Y2ZSAoc3BhcHJfbnZkaW1tOiBUd2VhayBlcnJvciBtZXNz
YWdlcykKMTgvMTggQ2hlY2tpbmcgY29tbWl0IDJkN2NmMmYzYWI2NCAodGFyZ2V0LXBwYzogZml4
IHJsd2ltaSwgcmx3aW5tLCBybHdubSBmb3IgQ2xhbmctOSkKPT09IE9VVFBVVCBFTkQgPT09CgpU
ZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFi
bGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1MDcwNTAyMjguODAyMzk1LTEtZGF2
aWRAZ2lic29uLmRyb3BiZWFyLmlkLmF1L3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdl
LgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==


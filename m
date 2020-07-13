Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B140CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:43:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EFD32072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EFD32072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juvvI-0000SJ-M9
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 06:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1juvuk-0008Tq-NW
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:42:26 -0400
Resent-Date: Mon, 13 Jul 2020 06:42:26 -0400
Resent-Message-Id: <E1juvuk-0008Tq-NW@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1juvui-0001lL-9j
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:42:26 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594636934; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FZQq3uxpLI+TLChGMm9UUedTQd0x1CdxGkNAQDlcTRA5GCTZG7qdjdeEKzJDsbzW06uP9lGuyORKI0JPPISD4I9q2nTpX2GvExl1ph1U1gFmAOK+a7BCVCULQbgzSH/o/RtaInd9jmVSsp644GdVmmh7JGEfxh5LiBR9ELDagWk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594636934;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=k+WnN0UvQ2bGFqxcDvQH/ErJyM8FX/JuZ3A/NRT+CQE=; 
 b=UO5xoCALo+Z9WZUU6hpvHzQKqwNIYKNOx0gMSx/kZh5ysEYf4fEfvrbssdyOO+p5e30rzr2mdV3XluehfR2ulGDIV0mFmMNn1x1b0jqioKSfflKUok4IJBKCthueArE91jqbEq/QEvo/ZM7AzanovWnCVrdBF9zUc5n8s8fyxgk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594636931867694.6192379360133;
 Mon, 13 Jul 2020 03:42:11 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] Add strace support for printing arguments for a
 group of selected syscalls
Message-ID: <159463693048.2008.14386814094345160622@07a7f0d89f7d>
In-Reply-To: <20200713095058.106624-1-Filip.Bozuta@syrmia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: Filip.Bozuta@syrmia.com
Date: Mon, 13 Jul 2020 03:42:11 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 06:42:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Filip.Bozuta@syrmia.com, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcxMzA5NTA1OC4xMDY2
MjQtMS1GaWxpcC5Cb3p1dGFAc3lybWlhLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAwNzEzMDk1MDU4
LjEwNjYyNC0xLUZpbGlwLkJvenV0YUBzeXJtaWEuY29tClN1YmplY3Q6IFtQQVRDSCB2MiAwLzRd
IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnRzIGZvciBhIGdyb3VwIG9m
IHNlbGVjdGVkIHN5c2NhbGxzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNo
CmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRy
dWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMv
Y2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
U3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo3NzNkMzAwIGxpbnV4LXVzZXI6IEFkZCBz
dHJhY2Ugc3VwcG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnRzIG9mIHNvbWUgY2xvY2sgYW5kIHRp
bWUgZnVuY3Rpb25zCmMwZjRmZDMgbGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBw
cmludGluZyBhcmd1bWVudHMgb2Ygc3lzY2FsbHMgdXNlZCB0byBsb2NrIGFuZCB1bmxvY2sgbWVt
b3J5CmJlZjkzYWMgbGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBwcmludGluZyBh
cmd1bWVudHMgb2YgdHJ1bmNhdGUoKS9mdHJ1bmNhdGUoKSBhbmQgZ2V0c2lkKCkKNjYwMWNmYiBs
aW51eC11c2VyOiBNYWtlIGNwdV9lbnYgYWNjZXNzaWJsZSBpbiBzdHJhY2UuYwoKPT09IE9VVFBV
VCBCRUdJTiA9PT0KMS80IENoZWNraW5nIGNvbW1pdCA2NjAxY2ZiMWIwODEgKGxpbnV4LXVzZXI6
IE1ha2UgY3B1X2VudiBhY2Nlc3NpYmxlIGluIHN0cmFjZS5jKQoyLzQgQ2hlY2tpbmcgY29tbWl0
IGJlZjkzYWMwMjE0MyAobGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBwcmludGlu
ZyBhcmd1bWVudHMgb2YgdHJ1bmNhdGUoKS9mdHJ1bmNhdGUoKSBhbmQgZ2V0c2lkKCkpCjMvNCBD
aGVja2luZyBjb21taXQgYzBmNGZkM2RmOGNlIChsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBv
cnQgZm9yIHByaW50aW5nIGFyZ3VtZW50cyBvZiBzeXNjYWxscyB1c2VkIHRvIGxvY2sgYW5kIHVu
bG9jayBtZW1vcnkpCkVSUk9SOiBzdG9yYWdlIGNsYXNzIHNob3VsZCBiZSBhdCB0aGUgYmVnaW5u
aW5nIG9mIHRoZSBkZWNsYXJhdGlvbgojMzM2OiBGSUxFOiBsaW51eC11c2VyL3N0cmFjZS5jOjEy
MDE6CitVTlVTRUQgc3RhdGljIHN0cnVjdCBmbGFncyBtbG9ja2FsbF9mbGFnc1tdID0gewoKdG90
YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAzMDcgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMy80IGhh
cyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMK
YXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNI
RUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo0LzQgQ2hlY2tpbmcgY29tbWl0IDc3M2QzMDBmOWEw
ZiAobGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBwcmludGluZyBhcmd1bWVudHMg
b2Ygc29tZSBjbG9jayBhbmQgdGltZSBmdW5jdGlvbnMpCkVSUk9SOiBzdG9yYWdlIGNsYXNzIHNo
b3VsZCBiZSBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZSBkZWNsYXJhdGlvbgojNTg6IEZJTEU6IGxp
bnV4LXVzZXIvc3RyYWNlLmM6Njc6CitVTlVTRUQgc3RhdGljIHZvaWQgcHJpbnRfdGltZXNwZWMo
YWJpX3Vsb25nLCBpbnQpOwoKRVJST1I6IHN0b3JhZ2UgY2xhc3Mgc2hvdWxkIGJlIGF0IHRoZSBi
ZWdpbm5pbmcgb2YgdGhlIGRlY2xhcmF0aW9uCiM2MDogRklMRTogbGludXgtdXNlci9zdHJhY2Uu
Yzo2OToKK1VOVVNFRCBzdGF0aWMgdm9pZCBwcmludF9pdGltZXJfdHlwZShhYmlfdWxvbmcsIGlu
dCk7CgpFUlJPUjogc3RvcmFnZSBjbGFzcyBzaG91bGQgYmUgYXQgdGhlIGJlZ2lubmluZyBvZiB0
aGUgZGVjbGFyYXRpb24KIzYxOiBGSUxFOiBsaW51eC11c2VyL3N0cmFjZS5jOjcwOgorVU5VU0VE
IHN0YXRpYyB2b2lkIHByaW50X2l0aW1lcnZhbChhYmlfdWxvbmcsIGludCk7Cgp0b3RhbDogMyBl
cnJvcnMsIDAgd2FybmluZ3MsIDI5OSBsaW5lcyBjaGVja2VkCgpQYXRjaCA0LzQgaGFzIHN0eWxl
IHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFs
c2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRD
SCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRl
ZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRj
aGV3Lm9yZy9sb2dzLzIwMjAwNzEzMDk1MDU4LjEwNjYyNC0xLUZpbGlwLkJvenV0YUBzeXJtaWEu
Y29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


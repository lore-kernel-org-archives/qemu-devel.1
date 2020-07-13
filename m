Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC57C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 572C320663
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572C320663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv2t1-0002bq-MZ
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 14:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jv2sU-0002CL-CT
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 14:08:34 -0400
Resent-Date: Mon, 13 Jul 2020 14:08:34 -0400
Resent-Message-Id: <E1jv2sU-0002CL-CT@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jv2sR-0001Cz-1K
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 14:08:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594663698; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cVHHwVlgBrl6Deig3U90Mu2+xeMmSueUV56rGY8NunKr/OOJUvb+PS2vTOo3CVMQQ+O2UDj1DvCk4kHibXKnyRXp2rFNc5+jODg50CJmT3VqVIEOJ0C6IscrcMAqiRJb1Tk4iM1jGgyFNpp4vG9zyxqWBDoTeJE1wvMCDlI2O1s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594663698;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=UiryxuvV9uzHFOojk73JdixtKayadSgYpQPwxxhOBIM=; 
 b=fv+ptOl/uGMf1s6NTHpuw6v83tcizJ9/C9DkdzQnHzfBzPGF26/eNnTNpczfPCzAN1m1eOn75qD1ZPRhJcSUXlyRMYfandGgO2o/6DjrgrrzfQT+qZRJXpgrXQlAYGw9HAPznslicEWSNkxDvA7L9uWjuTAOPxodBzH6eIXHVxY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594663696571681.4052958362051;
 Mon, 13 Jul 2020 11:08:16 -0700 (PDT)
Subject: Re: [PATCH 0/2] Fixes for env->user_features
Message-ID: <159466369526.2008.5436732946619374670@07a7f0d89f7d>
In-Reply-To: <20200713174436.41070-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: xiaoyao.li@intel.com
Date: Mon, 13 Jul 2020 11:08:16 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 14:08:28
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xiaoyao.li@intel.com,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcxMzE3NDQzNi40MTA3
MC0xLXhpYW95YW8ubGlAaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEg
TkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEg
Sj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgVEVTVCAgICBpb3Rlc3Qt
cWNvdzI6IDAyMgogIFRFU1QgICAgY2hlY2stdW5pdDogdGVzdHMvdGVzdC1jaGFyCioqCkVSUk9S
Oi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy90ZXN0LWNoYXIuYzoxMjA0OmNoYXJfc2VyaWFsX3Rl
c3Q6ICdjaHInIHNob3VsZCBub3QgYmUgTlVMTApFUlJPUiB0ZXN0LWNoYXIgLSBCYWlsIG91dCEg
RVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3Rlc3QtY2hhci5jOjEyMDQ6Y2hhcl9zZXJp
YWxfdGVzdDogJ2Nocicgc2hvdWxkIG5vdCBiZSBOVUxMCm1ha2U6ICoqKiBbY2hlY2stdW5pdF0g
RXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIFRFU1Qg
ICAgaW90ZXN0LXFjb3cyOiAwMjQKICBURVNUICAgIGlvdGVzdC1xY293MjogMDI1Ci0tLQogICAg
cmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQ
cm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0t
bGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD00OTM5ZGVhZDRkMGY0MDNlYTQxYWRiNGM1
MTRhZjgyZScsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25m
aW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdV
UkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUn
LCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdics
ICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hl
OnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXpxamk1bGF3L3NyYy9kb2Nr
ZXItc3JjLjIwMjAtMDctMTMtMTMuNTMuMTYuMjQ1MTI6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3Fl
bXUvY2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVk
IG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5p
bnN0YW5jZS51dWlkPTQ5MzlkZWFkNGQwZjQwM2VhNDFhZGI0YzUxNGFmODJlCm1ha2VbMV06ICoq
KiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90
bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXpxamk1bGF3L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVu
LXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAxNG01OS44NTFzCnVzZXIgICAg
MG05LjA0NHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9y
Zy9sb2dzLzIwMjAwNzEzMTc0NDM2LjQxMDcwLTEteGlhb3lhby5saUBpbnRlbC5jb20vdGVzdGlu
Zy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


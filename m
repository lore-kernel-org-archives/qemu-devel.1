Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D6AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:54:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CF7207CD
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CF7207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr4Le-0003vj-SL
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 14:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jr4Ki-0002vy-PG; Thu, 02 Jul 2020 14:53:16 -0400
Resent-Date: Thu, 02 Jul 2020 14:53:16 -0400
Resent-Message-Id: <E1jr4Ki-0002vy-PG@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21771)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jr4Kg-0007oL-7U; Thu, 02 Jul 2020 14:53:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593715982; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Vexi5ianXVFIM9rbmaqbsqmq25ehIkATqzdhbvLQIg7AaR+B3oteKeZXpPb6gt/M4i41vgtIfTjMj3ELYO4CZPT8Sw3+U0gYI0PKyI9/VOciNrGlJz8xtVyerxuM4x/XPbAEH5BHZHBs6El3sDLQPVMWVwso6LHFneuaQGbdq0g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593715982;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=rVUeq1gr3zVV1+MMtr0ACORI/HqwQmM+yCgoXp8KUIM=; 
 b=VE0cWWfB759FfkR6cq/17sBqLQ0UhByj87h3zRTCwJtWLuyNeCjFUlQoOl4CBYCfUuTU2eU+DWqQzRUF7fO0c+Vh0hNQKC0ndOqziZTHSIOZKjkfuY4wV0GMeDrE/EcrHvr0U301rEivPjxl5/e9nFJ6NnIAu77HSmefN8+lXYI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593715980206433.8451601788065;
 Thu, 2 Jul 2020 11:53:00 -0700 (PDT)
Message-ID: <159371597819.6600.13421276437306558588@d1fd068a5071>
Subject: Re: [PATCH 0/6] migration: bring savevm/loadvm/delvm over to QMP
In-Reply-To: <20200702175754.2211821-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berrange@redhat.com
Date: Thu, 2 Jul 2020 11:53:00 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 11:03:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, berrange@redhat.com,
 qemu-block@nongnu.org, quintela@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, pavel.dovgaluk@ispras.ru,
 pbonzini@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwMjE3NTc1NC4yMjEx
ODIxLTEtYmVycmFuZ2VAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0x
IE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0x
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogKHFlbXUpIGluZm8gc25h
cHNob3RzCiBObyBhdmFpbGFibGUgYmxvY2sgZGV2aWNlIHN1cHBvcnRzIHNuYXBzaG90cwogKHFl
bXUpIGxvYWR2bSBzbmFwMAotRXJyb3I6IE5vIGJsb2NrIGRldmljZSBzdXBwb3J0cyBzbmFwc2hv
dHMKK0Vycm9yOiBObyBibG9jayBkZXZpY2UgY2FuIGFjY2VwdCBzbmFwc2hvdHMKIChxZW11KSBx
dWl0CiAKIAotLS0KIFRlc3Rpbmc6IC1ibG9ja2RldiBkcml2ZXI9ZmlsZSxmaWxlbmFtZT1URVNU
X0RJUi90LklNR0ZNVCxub2RlLW5hbWU9ZmlsZQogUUVNVSBYLlkuWiBtb25pdG9yIC0gdHlwZSAn
aGVscCcgZm9yIG1vcmUgaW5mb3JtYXRpb24KIChxZW11KSBzYXZldm0gc25hcDAKLUVycm9yOiBE
ZXZpY2UgJycgaXMgd3JpdGFibGUgYnV0IGRvZXMgbm90IHN1cHBvcnQgc25hcHNob3RzCitFcnJv
cjogRGV2aWNlICdmaWxlJyBpcyB3cml0YWJsZSBidXQgZG9lcyBub3Qgc3VwcG9ydCBzbmFwc2hv
dHMKIChxZW11KSBpbmZvIHNuYXBzaG90cwogTm8gYXZhaWxhYmxlIGJsb2NrIGRldmljZSBzdXBw
b3J0cyBzbmFwc2hvdHMKIChxZW11KSBsb2Fkdm0gc25hcDAKLUVycm9yOiBEZXZpY2UgJycgaXMg
d3JpdGFibGUgYnV0IGRvZXMgbm90IHN1cHBvcnQgc25hcHNob3RzCitFcnJvcjogRGV2aWNlICdm
aWxlJyBpcyB3cml0YWJsZSBidXQgZG9lcyBub3Qgc3VwcG9ydCBzbmFwc2hvdHMKIChxZW11KSBx
dWl0CiAKIEZvcm1hdHRpbmcgJ1RFU1RfRElSL3QuSU1HRk1UJywgZm10PUlNR0ZNVCBzaXplPTEz
NDIxNzcyOAotLS0KTm90IHJ1bjogMjU5CkZhaWx1cmVzOiAyNjcKRmFpbGVkIDEgb2YgMTE5IGlv
dGVzdHMKbWFrZTogKioqIFtjaGVjay10ZXN0cy9jaGVjay1ibG9jay5zaF0gRXJyb3IgMQptYWtl
OiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIFRFU1QgICAgY2hlY2stcXRl
c3QtYWFyY2g2NDogdGVzdHMvcXRlc3QvcW9zLXRlc3QKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBj
YWxsIGxhc3QpOgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQp
CnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAn
ZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ZDQxNWEx
MTUwNzgyNDZlNGFiOTljOGE0ZDI3Nzg3ZTcnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9w
dCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAn
LWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAn
LWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFy
L3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2Nh
Y2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRt
cC12aTRib3NpMy9zcmMvZG9ja2VyLXNyYy4yMDIwLTA3LTAyLTE0LjM2LjI5LjY1Mjg6L3Zhci90
bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0
LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRl
cj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWQ0MTVhMTE1MDc4MjQ2ZTRhYjk5YzhhNGQy
Nzc4N2U3Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5n
IGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXZpNGJvc2kzL3NyYycKbWFr
ZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAx
Nm0yOS4yNzlzCnVzZXIgICAgMG04Ljk5OHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNzAyMTc1NzU0LjIyMTE4MjEtMS1iZXJyYW5n
ZUByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4K
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJl
ZGhhdC5jb20=


Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7668AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44669221EE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44669221EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr4Zk-0001fg-E8
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 15:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jr4Z0-0000rQ-4r; Thu, 02 Jul 2020 15:08:02 -0400
Resent-Date: Thu, 02 Jul 2020 15:08:02 -0400
Resent-Message-Id: <E1jr4Z0-0000rQ-4r@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jr4Yx-0001sU-Gl; Thu, 02 Jul 2020 15:08:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593716868; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hqHpicSK2w5N5qyKaWpcDzwC2BHED+61sjatPQcxrX4IjSi7SVIqBe+eF/dp4l/4F3hpBOfXak89A92+Xdt6NJAmlR84oGCJx26K/XEPlemYIQLSlznAwUG334kyTrP/yOZlOlVaeWWjW7px5XNT5jaaEodx/DYFGqOHfqF9BBk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593716868;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=fezJ/bBZTRCVObwExQK6/76td24xT+fP8LhRigTFe0g=; 
 b=kShkLlFNlKbgFBVGLEykPezYPr0N/1S4Nxwo0rIyHmVk0OgES4b5Zuh2aMeSOXTFOjWRNHxhi/SbBwfuVgxFGxEw90TG3utTtmxTYtKPeZWdZhMbkW07JCrqkYJzRc7DLjjG/hBNMbzXRL2Gjk5m8RPmebCjcoZ973zfecmjGtU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593716867077747.620860493987;
 Thu, 2 Jul 2020 12:07:47 -0700 (PDT)
Message-ID: <159371686538.6600.1753620947486453851@d1fd068a5071>
Subject: Re: [PATCH 0/6] migration: bring savevm/loadvm/delvm over to QMP
In-Reply-To: <20200702175754.2211821-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berrange@redhat.com
Date: Thu, 2 Jul 2020 12:07:47 -0700 (PDT)
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
c3QtYWFyY2g2NDogdGVzdHMvcXRlc3QvdGVzdC1obXAKICBURVNUICAgIGNoZWNrLXF0ZXN0LWFh
cmNoNjQ6IHRlc3RzL3F0ZXN0L3Fvcy10ZXN0Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vy
cm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQg
J1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5z
dGFuY2UudXVpZD04MGVjYWJmZGMzYjQ0Y2RhYmQ5MTViNDI3ZDc5MWFmZScsICctdScsICcxMDAz
JywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywg
J1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0n
LCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScs
ICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2Fj
aGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1w
L3BhdGNoZXctdGVzdGVyLXRtcC12bHVib2piNy9zcmMvZG9ja2VyLXNyYy4yMDIwLTA3LTAyLTE0
LjUyLjU2LjMxMTA2Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zhci90
bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1
cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD04MGVjYWJm
ZGMzYjQ0Y2RhYmQ5MTViNDI3ZDc5MWFmZQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9y
IDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRt
cC12bHVib2piNy9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczdd
IEVycm9yIDIKCnJlYWwgICAgMTRtNDkuNjY4cwp1c2VyICAgIDBtOC45MzFzCgoKVGhlIGZ1bGwg
bG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDcwMjE3NTc1
NC4yMjExODIxLTEtYmVycmFuZ2VAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50
b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQ
YXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


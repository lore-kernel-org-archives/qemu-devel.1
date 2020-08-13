Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81FEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 14:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D5D20716
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 14:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D5D20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6E3f-0005lz-Mw
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 10:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6E2j-00057b-GJ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 10:17:21 -0400
Resent-Date: Thu, 13 Aug 2020 10:17:21 -0400
Resent-Message-Id: <E1k6E2j-00057b-GJ@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21786)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6E2f-00019n-WD
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 10:17:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597328195; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=b0Ye60fHPOuubPBoYBuzzAIDHo5kboFVsDVtpDFZeKHEMVv2Dw1cFZCuAQTQJotgbkOpuutTWyWkVKehTtkgVr8I2X+y/TN2dzIw86CRpufsTR/D7TX3SzY8MyaHcEXWjby3Dhni5DbTEJp2y2aSk9arT1DQMG0R52the9OyoG0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597328195;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=9RRbhZkWphw9c2qjwpluvpuZNPN06Ml5y9jEFBHZ1fw=; 
 b=Y+lN6aZdesYFRlIPkw27KZ9uqEx/nF75zBDqzSFhSwjED0YF9uNFmvhgMWMzS5uLTGqi5Yhdg6rHs/+ndvhp49mG4jIDDFQeaAl9vdPjrH30KgGKpPLAw3QEzQ6odOB964ts/7VWqswFaRUFF7Z3yyLNf4zam1NWOzYpvhXTSNU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597328190397955.8350031428361;
 Thu, 13 Aug 2020 07:16:30 -0700 (PDT)
Subject: Re: [PATCH v5 00/14] QEMU cpus.c refactoring part2
Message-ID: <159732818874.15736.6159613223332985218@66eaa9a8a123>
In-Reply-To: <20200812183250.9221-1-cfontana@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: cfontana@suse.de
Date: Thu, 13 Aug 2020 07:16:30 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 10:17:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 ehabkost@redhat.com, alex.bennee@linaro.org, haxm-team@intel.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 r.bolshakov@yadro.com, dovgaluk@ispras.ru, wenchao.wang@intel.com,
 pbonzini@redhat.com, sunilmut@microsoft.com, rth@twiddle.net,
 philmd@redhat.com, cfontana@suse.de, colin.xu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxMjE4MzI1MC45MjIx
LTEtY2ZvbnRhbmFAc3VzZS5kZS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5FVFdP
Uks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9MTQg
TkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFRFU1QgICAgY2hlY2stdW5pdDog
dGVzdHMvdGVzdC1jaGFyClVuZXhwZWN0ZWQgZXJyb3IgaW4gb2JqZWN0X3Byb3BlcnR5X3RyeV9h
ZGQoKSBhdCAvdG1wL3FlbXUtdGVzdC9zcmMvcW9tL29iamVjdC5jOjExODE6CmF0dGVtcHQgdG8g
YWRkIGR1cGxpY2F0ZSBwcm9wZXJ0eSAnc2VyaWFsLWlkJyB0byBvYmplY3QgKHR5cGUgJ2NvbnRh
aW5lcicpCkVSUk9SIHRlc3QtY2hhciAtIHRvbyBmZXcgdGVzdHMgcnVuIChleHBlY3RlZCAzOCwg
Z290IDkpCm1ha2U6ICoqKiBbY2hlY2stdW5pdF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBm
b3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIFRFU1QgICAgY2hlY2stcXRlc3QteDg2XzY0OiB0ZXN0
cy9xdGVzdC9oZC1nZW8tdGVzdApxZW11LXN5c3RlbS1hYXJjaDY0OiAtYWNjZWwga3ZtOiBpbnZh
bGlkIGFjY2VsZXJhdG9yIGt2bQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRj
b2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8n
LCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1
aWQ9ZTJjZDJkNWYxZjFkNGViNmJjNmJjZDc5ZTNkMTY0MDQnLCAnLXUnLCAnMTAwMScsICctLXNl
Y3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRf
TElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywg
J0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hF
X0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1k
b2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXct
dGVzdGVyLXRtcC0ybnA0eDF3cS9zcmMvZG9ja2VyLXNyYy4yMDIwLTA4LTEzLTEwLjAwLjQwLjEx
OTA4Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11L2NlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9y
dW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0
ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1lMmNkMmQ1ZjFmMWQ0ZWI2
YmM2YmNkNzllM2QxNjQwNAptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsx
XTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC0ybnA0eDF3
cS9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIK
CnJlYWwgICAgMTVtNDkuMjc2cwp1c2VyICAgIDBtOC42MDhzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2
YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDgxMjE4MzI1MC45MjIxLTEt
Y2ZvbnRhbmFAc3VzZS5kZS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3Nh
Z2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t


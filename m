Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32F6C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 04:15:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA5C2078B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 04:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA5C2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHgOn-0005q5-M5
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 00:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jHgOF-0005Og-CH
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 00:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jHgOC-0000EE-U2
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 00:14:39 -0400
Resent-Date: Fri, 27 Mar 2020 00:14:39 -0400
Resent-Message-Id: <E1jHgOC-0000EE-U2@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21186)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jHgOC-0000DG-MH
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 00:14:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585282464; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OYSyCzYK2gy0tJnOYeVO463B66pQViFcJq5FhIrEt8g6VMO9KCEpnl9n1z7a7kw1v/oVl5iKZg/ROY/8psrcQVp/Xp0n7zj+TP3y1ufeAmfBcp6Hs1fCEfMlqnxg0EKOndWSRvo0WGEvvwzKMGG2gRAEOt+XRv1pSmAxSQuEimo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585282464;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=j+dNKprNVS/f952Fx4ezmWpKa9tSdyJw/fjwYZ6dl+8=; 
 b=APPMz+BqApDbINvIA9/qn2tAL/Ms4hXR73oaz7mc1IwI97kkHNqXPM4qhs+NVqmyQp74CJqydsbjha7Go/ZYQk3QgPRNSi0pI9sPKZmP3RExe+G2Rt9cpzx7pOsUYyNnIeN/IcqMxG4Cf4Pw+B+cOR8SZwMRsA/A3F4WYAgCnsk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585282461136227.77465510738068;
 Thu, 26 Mar 2020 21:14:21 -0700 (PDT)
In-Reply-To: <20200327035650.2085-1-pannengyuan@huawei.com>
Subject: Re: [PATCH 0/2] fix two virtio queues memleak
Message-ID: <158528245983.25711.16031942510344939635@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pannengyuan@huawei.com
Date: Thu, 26 Mar 2020 21:14:21 -0700 (PDT)
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
Cc: zhang.zhanghailiang@huawei.com, mst@redhat.com, pannengyuan@huawei.com,
 qemu-devel@nongnu.org, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMyNzAzNTY1MC4yMDg1
LTEtcGFubmVuZ3l1YW5AaHVhd2VpLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0x
IE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0x
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFRFU1QgICAgY2hlY2st
cXRlc3QteDg2XzY0OiB0ZXN0cy9xdGVzdC9oZC1nZW8tdGVzdApCcm9rZW4gcGlwZQovdG1wL3Fl
bXUtdGVzdC9zcmMvdGVzdHMvcXRlc3QvbGlicXRlc3QuYzoxNzU6IGtpbGxfcWVtdSgpIGRldGVj
dGVkIFFFTVUgZGVhdGggZnJvbSBzaWduYWwgMTEgKFNlZ21lbnRhdGlvbiBmYXVsdCkgKGNvcmUg
ZHVtcGVkKQpFUlJPUiAtIHRvbyBmZXcgdGVzdHMgcnVuIChleHBlY3RlZCAxNywgZ290IDE2KQpt
YWtlOiAqKiogW2NoZWNrLXF0ZXN0LXg4Nl82NF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBm
b3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIFRFU1QgICAgY2hlY2stdW5pdDogdGVzdHMvdGVzdC1i
dWZmZXJpc3plcm8KICBURVNUICAgIGNoZWNrLXVuaXQ6IHRlc3RzL3Rlc3QtdXVpZAotLS0KTm90
IHJ1bjogMjU5ClBhc3NlZCBhbGwgMTE2IGlvdGVzdHMKKioKRVJST1I6L3RtcC9xZW11LXRlc3Qv
c3JjL3Rlc3RzL3F0ZXN0L2FjcGktdXRpbHMuYzoxNDU6YWNwaV9maW5kX3JzZHBfYWRkcmVzc191
ZWZpOiBjb2RlIHNob3VsZCBub3QgYmUgcmVhY2hlZApFUlJPUiAtIEJhaWwgb3V0ISBFUlJPUjov
dG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvcXRlc3QvYWNwaS11dGlscy5jOjE0NTphY3BpX2ZpbmRf
cnNkcF9hZGRyZXNzX3VlZmk6IGNvZGUgc2hvdWxkIG5vdCBiZSByZWFjaGVkCm1ha2U6ICoqKiBb
Y2hlY2stcXRlc3QtYWFyY2g2NF0gRXJyb3IgMQpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwg
bGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxt
b2R1bGU+CiAgICBzeXMuZXhpdChtYWluKCkpCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vy
cm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQg
J1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5z
dGFuY2UudXVpZD1mMjVhYTkyNTIxYjU0OWJjYWVkYzczOWVjM2FiOTM5OCcsICctdScsICcxMDAx
JywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywg
J1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0n
LCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScs
ICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNo
ZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAv
cGF0Y2hldy10ZXN0ZXItdG1wLWh3b2c1MmZ1L3NyYy9kb2NrZXItc3JjLjIwMjAtMDMtMjYtMjMu
NTUuNDEuNzc0Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zhci90bXAv
cWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAy
LgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1mMjVhYTkyNTIx
YjU0OWJjYWVkYzczOWVjM2FiOTM5OAptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEK
bWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1o
d29nNTJmdS9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVy
cm9yIDIKCnJlYWwgICAgMThtMzkuNjc0cwp1c2VyICAgIDBtOS40NDJzCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDMyNzAzNTY1MC4y
MDg1LTEtcGFubmVuZ3l1YW5AaHVhd2VpLmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3
Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


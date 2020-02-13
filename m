Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8C4C3B189
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 16:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F78206ED
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 16:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F78206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2H1T-0005fG-Ll
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 11:07:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j2H0w-0005GB-LD
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:06:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j2H0u-0000mW-45
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:06:54 -0500
Resent-Date: Thu, 13 Feb 2020 11:06:54 -0500
Resent-Message-Id: <E1j2H0u-0000mW-45@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21114)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j2H0t-0000jX-SA
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:06:52 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1581609989; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=C9aJzadwi4HeJlHA6L2XzMKPlIpMssJLDEOhA0HMtlqJSFo3zOX2ONuk1rod1NCD++EMsbVPpdBD4ahOwL0poxJrLCCaO6ACeiApuWuI7H17NcJPKiyLUWrhgcMVdi5tK9v6FeOHRKsSj00ZsgeS46dExGAb8WHbeFqL03KFVo0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1581609989;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=m2F3hpz7fVyr4dyd9XUxd2xuqll5WU6aKlU8F/dZNDs=; 
 b=QjWTAfKzpJ9meskppufxKx70NKVbuPRDndEvbBhXwAS/JedNKsGedu+z2wfTP/0WfOtHdq3vYgRdI6t3GttWLTh6aSL/5f8yitZnMdxb+jZbsge8VLP2nwxs063SMXa5PMFQvNpfdDTxrx2W4N3xJfMcusFPGSlsu+qPfC1eQCQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158160998214718.840036943250652;
 Thu, 13 Feb 2020 08:06:22 -0800 (PST)
In-Reply-To: <20200213074952.544-1-miaoyubo@huawei.com>
Subject: Re: [RFC 0/2] pci_expander_brdige:acpi:Support pxb-pcie for ARM
Message-ID: <158160998074.29586.3051605719787707513@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: miaoyubo@huawei.com
Date: Thu, 13 Feb 2020 08:06:22 -0800 (PST)
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
Cc: peter.maydell@linaro.org, mst@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, shannon.zhaosl@gmail.com, miaoyubo@huawei.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIxMzA3NDk1Mi41NDQt
MS1taWFveXVib0BodWF3ZWkuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVzaW5nIGV4cGVjdGVkIGZpbGUg
J3Rlc3RzL2RhdGEvYWNwaS92aXJ0L1NQQ1InCkxvb2tpbmcgZm9yIGV4cGVjdGVkIGZpbGUgJ3Rl
c3RzL2RhdGEvYWNwaS92aXJ0L0RTRFQnClVzaW5nIGV4cGVjdGVkIGZpbGUgJ3Rlc3RzL2RhdGEv
YWNwaS92aXJ0L0RTRFQnCkVSUk9SIC0gQmFpbCBvdXQhIEVSUk9SOi90bXAvcWVtdS10ZXN0L3Ny
Yy90ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LmM6NDkwOnRlc3RfYWNwaV9hc2w6IGFzc2Vy
dGlvbiBmYWlsZWQ6IChhbGxfdGFibGVzX21hdGNoKQphY3BpLXRlc3Q6IFdhcm5pbmchIERTRFQg
YmluYXJ5IGZpbGUgbWlzbWF0Y2guIEFjdHVhbCBbYW1sOi90bXAvYW1sLUZPNVhGMF0sIEV4cGVj
dGVkIFthbWw6dGVzdHMvZGF0YS9hY3BpL3ZpcnQvRFNEVF0uCnRvIHNlZSBBU0wgZGlmZiBiZXR3
ZWVuIG1pc21hdGNoZWQgZmlsZXMgaW5zdGFsbCBJQVNMLCByZWJ1aWxkIFFFTVUgZnJvbSBzY3Jh
dGNoIGFuZCByZS1ydW4gdGVzdHMgd2l0aCBWPTEgZW52aXJvbm1lbnQgdmFyaWFibGUgc2V0KioK
RVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYzo0
OTA6dGVzdF9hY3BpX2FzbDogYXNzZXJ0aW9uIGZhaWxlZDogKGFsbF90YWJsZXNfbWF0Y2gpCm1h
a2U6ICoqKiBbY2hlY2stcXRlc3QtYWFyY2g2NF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBm
b3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIFRFU1QgICAgY2hlY2stcXRlc3QteDg2XzY0OiB0ZXN0
cy9xdGVzdC9kZXZpY2UtcGx1Zy10ZXN0CiAgVEVTVCAgICBjaGVjay1xdGVzdC14ODZfNjQ6IHRl
c3RzL3F0ZXN0L2RyaXZlX2RlbC10ZXN0Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9y
KHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1sn
c3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFu
Y2UudXVpZD0zYzFlNTRmYzI0ZDM0ODg3ODNjYThlNjc3NzU1MjRhMCcsICctdScsICcxMDAzJywg
Jy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RB
UkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAn
LWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdD
Q0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUv
cWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3Bh
dGNoZXctdGVzdGVyLXRtcC01aDVpZXB6by9zcmMvZG9ja2VyLXNyYy4yMDIwLTAyLTEzLTEwLjUz
LjI2LjMyNTEyOi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zhci90bXAv
cWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAy
LgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD0zYzFlNTRmYzI0
ZDM0ODg3ODNjYThlNjc3NzU1MjRhMAptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEK
bWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC01
aDVpZXB6by9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVy
cm9yIDIKCnJlYWwgICAgMTJtNTUuMDMycwp1c2VyICAgIDBtOC40NzdzCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDIxMzA3NDk1Mi41
NDQtMS1taWFveXVib0BodWF3ZWkuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5
cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcg
W2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRj
aGV3LWRldmVsQHJlZGhhdC5jb20=


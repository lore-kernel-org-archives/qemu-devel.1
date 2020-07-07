Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D53DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 13:36:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E98820658
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 13:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E98820658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsnlV-0003hK-Aw
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 09:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jsnkp-0002pp-9Y; Tue, 07 Jul 2020 09:35:23 -0400
Resent-Date: Tue, 07 Jul 2020 09:35:23 -0400
Resent-Message-Id: <E1jsnkp-0002pp-9Y@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jsnkn-0003Nt-DK; Tue, 07 Jul 2020 09:35:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594128906; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mv7lKHRa3bwQWJCJbEOTLK+9JmtXJXveLuJJ1/oz1seXzKdfG9NJD5mzpGBtt5A/uoBtqcrDhwI88PYoerfmetfPgCFG5k906HUun8v//FEh/bFJpgapQffGW6WITmXKYlMyrn5/h2aSDHsqCS3WLbHCTQcPgyqFEs+aVHbBe6k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594128906;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=FR2+n9EHAapbhSXBsmA2bR4X0zhP6VOxActEmUlnz+w=; 
 b=mSuz/xeP2kc5IzColFCSx3ic0TESMm52NKTgd/+79MbhBamBcKgqFq/mGLDcGFLIaKRE173zcqZSwENIwMP96uYJJCGtBb2JS25wL0gFg7K5ZHMciYtJ59gqfDPch1NkzjexUt6cBX7D8y+J45zENyQCgIplTNLohf4034yvdHc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594128903178233.064757862742;
 Tue, 7 Jul 2020 06:35:03 -0700 (PDT)
Subject: Re: [PATCH v5 00/20] microvm: add acpi support
Message-ID: <159412890128.1183.957367283880211839@07a7f0d89f7d>
In-Reply-To: <20200707125356.32450-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Tue, 7 Jul 2020 06:35:03 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 09:34:31
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 ehabkost@redhat.com, slp@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 shannon.zhaosl@gmail.com, qemu-arm@nongnu.org, kraxel@redhat.com,
 pbonzini@redhat.com, imammedo@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwNzEyNTM1Ni4zMjQ1
MC0xLWtyYXhlbEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCmFjcGktdGVzdDogV2FybmluZyEg
RFNEVCBiaW5hcnkgZmlsZSBtaXNtYXRjaC4gQWN0dWFsIFthbWw6L3RtcC9hbWwtWUIzU04wXSwg
RXhwZWN0ZWQgW2FtbDp0ZXN0cy9kYXRhL2FjcGkvbWljcm92bS9EU0RUXS4KU2VlIHNvdXJjZSBm
aWxlIHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYyBmb3IgaW5zdHJ1Y3Rpb25zIG9uIGhv
dyB0byB1cGRhdGUgZXhwZWN0ZWQgZmlsZXMuCnRvIHNlZSBBU0wgZGlmZiBiZXR3ZWVuIG1pc21h
dGNoZWQgZmlsZXMgaW5zdGFsbCBJQVNMLCByZWJ1aWxkIFFFTVUgZnJvbSBzY3JhdGNoIGFuZCBy
ZS1ydW4gdGVzdHMgd2l0aCBWPTEgZW52aXJvbm1lbnQgdmFyaWFibGUgc2V0KioKRVJST1I6L3Rt
cC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYzo0OTU6dGVzdF9h
Y3BpX2FzbDogYXNzZXJ0aW9uIGZhaWxlZDogKGFsbF90YWJsZXNfbWF0Y2gpCkVSUk9SIC0gQmFp
bCBvdXQhIEVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10
ZXN0LmM6NDk1OnRlc3RfYWNwaV9hc2w6IGFzc2VydGlvbiBmYWlsZWQ6IChhbGxfdGFibGVzX21h
dGNoKQptYWtlOiAqKiogW2NoZWNrLXF0ZXN0LXg4Nl82NF0gRXJyb3IgMQptYWtlOiAqKiogV2Fp
dGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAwMzAK
ICBURVNUICAgIGlvdGVzdC1xY293MjogMDMxCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vy
cm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQg
J1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5z
dGFuY2UudXVpZD04ZjVmNDFlMzg2Yjg0NWE5YTBmNWVkYzJhZGUyMzFjNycsICctdScsICcxMDAz
JywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywg
J1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0n
LCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScs
ICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2Fj
aGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1w
L3BhdGNoZXctdGVzdGVyLXRtcC1kZDdfdW5zZy9zcmMvZG9ja2VyLXNyYy4yMDIwLTA3LTA3LTA5
LjE5LjIxLjEwNDU1Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zhci90
bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1
cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD04ZjVmNDFl
Mzg2Yjg0NWE5YTBmNWVkYzJhZGUyMzFjNwptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9y
IDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRt
cC1kZDdfdW5zZy9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczdd
IEVycm9yIDIKCnJlYWwgICAgMTVtNDIuMzM1cwp1c2VyICAgIDBtOC45ODFzCgoKVGhlIGZ1bGwg
bG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDcwNzEyNTM1
Ni4zMjQ1MC0xLWtyYXhlbEByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcv
P3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDDDC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 18:02:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1683422597
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 18:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1683422597
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvPFr-0003qA-E9
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 14:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jvPEu-00031M-Fl
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 14:01:13 -0400
Resent-Date: Tue, 14 Jul 2020 14:01:12 -0400
Resent-Message-Id: <E1jvPEu-00031M-Fl@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jvPEr-0002SC-Ll
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 14:01:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594749655; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TUnPqZh6DR9TkWooqHPIzrHYlhjCSE1im72Z2rkPWgkJPDF2S3+DW5AOhyEPgOPOm3fKqe9xqgx9GqNb9ZIwDnk/3QHa5DJl5iyd2CHkYqbc39xKBzPfKVRBwP1J2rutuTG4ItJJ9xUMKqZ5TFC0XEoNETWg9wXspipKnqqv3s0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594749655;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=lq0g6uzhE3RxMe1mmg+vlxxOngYPCwzCOy0LGj7KiC8=; 
 b=S6Cx70z+3AqpyxI/RH+OhRt1I5OWtLpdZfV4ENYC3zIEsiRjMo1wGYgKq1BzX3NAtlw+qwZxtnsPMyWmwqUxyy2g0t6k0pmWDzmjXqj/dq0A3Y6PojOUhf92WRazE4SnUM9mnQguFBoxxDH/Jfa9WJNUQFswMVPGOLT8zkI8fPE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594749654133347.37269741916805;
 Tue, 14 Jul 2020 11:00:54 -0700 (PDT)
Subject: Re: [PATCH] tests: qmp-cmd-test: fix memory leak
Message-ID: <159474965262.11884.17817462514402321073@07a7f0d89f7d>
In-Reply-To: <20200714171531.83723-1-liq3ea@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: liq3ea@163.com
Date: Tue, 14 Jul 2020 11:00:54 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 12:50:01
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
Cc: lvivier@redhat.com, thuth@redhat.com, liq3ea@gmail.com, liq3ea@163.com,
 armbru@redhat.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcxNDE3MTUzMS44Mzcy
My0xLWxpcTNlYUAxNjMuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVUV09S
Sz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0xNCBO
RVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgVEVTVCAgICBjaGVjay11bml0OiB0
ZXN0cy90ZXN0LWNyeXB0by1zZWNyZXQKICBURVNUICAgIGNoZWNrLXVuaXQ6IHRlc3RzL3Rlc3Qt
Y2hhcgoqKgpFUlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvdGVzdC1jaGFyLmM6MTIwNDpj
aGFyX3NlcmlhbF90ZXN0OiAnY2hyJyBzaG91bGQgbm90IGJlIE5VTEwKRVJST1IgdGVzdC1jaGFy
IC0gQmFpbCBvdXQhIEVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy90ZXN0LWNoYXIuYzox
MjA0OmNoYXJfc2VyaWFsX3Rlc3Q6ICdjaHInIHNob3VsZCBub3QgYmUgTlVMTAptYWtlOiAqKiog
W2NoZWNrLXVuaXRdIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9i
cy4uLi4KICBURVNUICAgIGlvdGVzdC1xY293MjogMDI5CnFlbXUtc3lzdGVtLWFhcmNoNjQ6IC1h
Y2NlbCBrdm06IGludmFsaWQgYWNjZWxlcmF0b3Iga3ZtCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJv
Y2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENv
bW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFl
bXUuaW5zdGFuY2UudXVpZD00MDEwOTg5MmNiNDk0N2I1OTIxMTBmNTRkYzM4N2QzZCcsICctdScs
ICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywg
Jy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUn
LCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScs
ICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3
Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1majNkOTVsZi9zcmMvZG9ja2VyLXNyYy4yMDIwLTA3
LTE0LTEzLjQ1LjQ2LjEwNDMzOi92YXIvdG1wL3FlbXU6eixybycsICdxZW11L2NlbnRvczcnLCAn
L3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0
IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD00
MDEwOTg5MmNiNDk0N2I1OTIxMTBmNTRkYzM4N2QzZAptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5d
IEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC1majNkOTVsZi9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNl
bnRvczddIEVycm9yIDIKCnJlYWwgICAgMTVtNi4yMDRzCnVzZXIgICAgMG01LjgxMnMKCgpUaGUg
ZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNzE0
MTcxNTMxLjgzNzIzLTEtbGlxM2VhQDE2My5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9z
Ny8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


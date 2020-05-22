Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5912C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 13:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE64206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 13:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE64206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc7Jc-00053R-Se
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 09:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jc7IM-0003hL-5r
 for qemu-devel@nongnu.org; Fri, 22 May 2020 09:01:02 -0400
Resent-Date: Fri, 22 May 2020 09:01:02 -0400
Resent-Message-Id: <E1jc7IM-0003hL-5r@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21335)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jc7IK-0001UK-J5
 for qemu-devel@nongnu.org; Fri, 22 May 2020 09:01:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590152439; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BtNv1EuofG07fMFhTDGBqm94cKeQCyou7xz/OOkcl7eXnRStsjimHYqsV33RoLiFTSJokRcYI/AdHVsTN9FzzC1+DMR7eZi193x3pyMP7QShxEZYB+YwEKV6AOf7fWcNrYhuwCfWIecuTmMbKHyNVDXVdoIwbDtbaanS8UYB4RM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590152439;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=zep62gD6tELKaTPwOpb+1YiwG/YV9PyfnuVype0leS8=; 
 b=QcbYRiGwKL9SUA+ECvEYBLR2S/7+600OkK0u3C7i2mpgQu657Wlylf1is1QJP/WfTQhckaft9pdy/hd4r3Ze0nVi0gNav0Q4MpZDIvVuw7yv2CvwAjL73WwfC6kdek2HRoAscKXeTUTvcPEMqat7vrBNNkgAgyBR5i6xHGSMqHg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590152425357641.440624361952;
 Fri, 22 May 2020 06:00:25 -0700 (PDT)
Message-ID: <159015242407.1576.15549574381053917559@45ef0f9c86ae>
In-Reply-To: <159013007895.28110.2020104406699709721.stgit@pasha-ThinkPad-X280>
Subject: Re: [PATCH] replay: notify the main loop when there are no
 instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: Pavel.Dovgaluk@gmail.com
Date: Fri, 22 May 2020 06:00:25 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 07:27:45
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, qemu-devel@nongnu.org,
 pavel.dovgaluk@ispras.ru, dovgaluk@ispras.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTkwMTMwMDc4OTUuMjgxMTAu
MjAyMDEwNDQwNjY5OTcwOTcyMS5zdGdpdEBwYXNoYS1UaGlua1BhZC1YMjgwLwoKCgpIaSwKClRo
aXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxl
YXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYg
eW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQK
bG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2Nr
ZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlj
a0BjZW50b3M3IFNIT1dfRU5WPTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9
PT0KCnFlbXUtc3lzdGVtLWFhcmNoNjQ6IGNhbm5vdCBzZXQgdXAgZ3Vlc3QgbWVtb3J5ICdjdWJp
ZWJvYXJkLnJhbSc6IENhbm5vdCBhbGxvY2F0ZSBtZW1vcnkKQnJva2VuIHBpcGUKL3RtcC9xZW11
LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0LmM6MTY2OiBraWxsX3FlbXUoKSB0cmllZCB0
byB0ZXJtaW5hdGUgUUVNVSBwcm9jZXNzIGJ1dCBlbmNvdW50ZXJlZCBleGl0IHN0YXR1cyAxIChl
eHBlY3RlZCAwKQpFUlJPUiAtIHRvbyBmZXcgdGVzdHMgcnVuIChleHBlY3RlZCA2NywgZ290IDE5
KQptYWtlOiAqKiogW2NoZWNrLXF0ZXN0LWFhcmNoNjRdIEVycm9yIDEKVHJhY2ViYWNrIChtb3N0
IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxp
bmUgNjY0LCBpbiA8bW9kdWxlPgogICAgc3lzLmV4aXQobWFpbigpKQotLS0KICAgIHJhaXNlIENh
bGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vy
cm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywg
J2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9N2VkMjFiZDA5Y2ZlNGFiYjkxYWE2OWJjZjgyOTU3MTkn
LCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAn
LS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9
JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1df
RU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUv
cGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12
JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC04dW91anhzMi9zcmMvZG9ja2VyLXNyYy4y
MDIwLTA1LTIyLTA4LjQyLjIwLjIzNzk0Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRv
czcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVy
byBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2Uu
dXVpZD03ZWQyMWJkMDljZmU0YWJiOTFhYTY5YmNmODI5NTcxOQptYWtlWzFdOiAqKiogW2RvY2tl
ci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNo
ZXctdGVzdGVyLXRtcC04dW91anhzMi9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1
aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMThtMy45MDlzCnVzZXIgICAgMG04LjQ2MXMK
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1
OTAxMzAwNzg5NS4yODExMC4yMDIwMTA0NDA2Njk5NzA5NzIxLnN0Z2l0QHBhc2hhLVRoaW5rUGFk
LVgyODAvdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9y
Zy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNv
bQ==


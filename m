Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252EDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 19:21:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE657206F7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 19:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE657206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm06g-00026J-9d
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 15:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jm066-0001hJ-VK
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 15:21:14 -0400
Resent-Date: Thu, 18 Jun 2020 15:21:14 -0400
Resent-Message-Id: <E1jm066-0001hJ-VK@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jm064-00018r-DK
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 15:21:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592508051; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EveMtZb5jPbrRKMRbYmIMIE+ieLhs68W4kSu3UarzM7hYXElqMog+Q43fdAy5GgJLn30H8Vv5KThNFrqMPSQrvhYzU+/dxSo1Tskxdz6KJ2dvbKPLDpqeVwZMwRGNe3tPeieomuKgcDe4q3SzS3uXR1NkfI4Cp8DU5JLLq+tnms=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592508051;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=fKQH66L68JiLi38xDNFXqsRRw/eKwcdx+ICtfKdko7k=; 
 b=llEYYMEwSL9jxrQLm5pT0z6cab3dd59OzQeV4OSN67x4VDIoSybHcS78RRpt8KK1Xxl0dy3ARoeayquNr2gbjyJR0cKwcbADxmDuoGtlsvDP7cHwxAhKGa4ah9IYC3Jp4icY7UEibnpHYR9pNcVz4NSIKtpP4wOj/g3nzXZBhjc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1592508049689891.302746343209;
 Thu, 18 Jun 2020 12:20:49 -0700 (PDT)
Message-ID: <159250804756.26237.17299109725503483740@d1fd068a5071>
Subject: Re: [RFC v6 0/4] QEMU cpus.c refactoring
In-Reply-To: <20200618190401.4895-1-cfontana@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: cfontana@suse.de
Date: Thu, 18 Jun 2020 12:20:49 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 12:45:19
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
 ehabkost@redhat.com, alex.bennee@linaro.org, mtosatti@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, r.bolshakov@yadro.com,
 haxm-team@intel.com, colin.xu@intel.com, pbonzini@redhat.com,
 sunilmut@microsoft.com, rth@twiddle.net, philmd@redhat.com, cfontana@suse.de,
 wenchao.wang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxODE5MDQwMS40ODk1
LTEtY2ZvbnRhbmFAc3VzZS5kZS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGFzYW4g
YnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91
dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJs
eSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmlu
L2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9eDg2
XzY0LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0Mg
ICAgICBiYWNrZW5kcy9ybmctYnVpbHRpbi5vCiAgQ0MgICAgICBiYWNrZW5kcy9ybmctcmFuZG9t
Lm8KICBDQyAgICAgIGJhY2tlbmRzL3RwbS5vCi90bXAvcWVtdS10ZXN0L3NyYy9kbWEtaGVscGVy
cy5jOjE1NDoyMDogZXJyb3I6IHVzZSBvZiB1bmRlY2xhcmVkIGlkZW50aWZpZXIgJ3VzZV9pY291
bnQnCiAgICAgICAgaWYgKG1lbSAmJiB1c2VfaWNvdW50ICYmIGRicy0+ZGlyID09IERNQV9ESVJF
Q1RJT05fRlJPTV9ERVZJQ0UpIHsKICAgICAgICAgICAgICAgICAgIF4KMSBlcnJvciBnZW5lcmF0
ZWQuCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogZG1hLWhlbHBl
cnMub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpU
cmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIv
ZG9ja2VyLnB5IiwgbGluZSA2NjksIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJv
Y2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENv
bW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFl
bXUuaW5zdGFuY2UudXVpZD1lZTIwMGRlMmIxYzA0MmM2YTYxZDU2NTk5N2Q4M2Y3ZCcsICctdScs
ICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywg
Jy1lJywgJ1RBUkdFVF9MSVNUPXg4Nl82NC1zb2Z0bW11JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VS
RV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScs
ICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAn
L2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6
eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAteWk2cnRzNzkvc3JjL2RvY2tl
ci1zcmMuMjAyMC0wNi0xOC0xNS4xNi41OC4zMTMwNDovdmFyL3RtcC9xZW11Onoscm8nLCAncWVt
dTpmZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1kZWJ1ZyddJyByZXR1cm5lZCBu
b24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5z
dGFuY2UudXVpZD1lZTIwMGRlMmIxYzA0MmM2YTYxZDU2NTk5N2Q4M2Y3ZAptYWtlWzFdOiAqKiog
W2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1w
L3BhdGNoZXctdGVzdGVyLXRtcC15aTZydHM3OS9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10
ZXN0LWRlYnVnQGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAzbTQ5LjE3MXMKdXNlciAgICAwbTgu
NTQ0cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xv
Z3MvMjAyMDA2MTgxOTA0MDEuNDg5NS0xLWNmb250YW5hQHN1c2UuZGUvdGVzdGluZy5hc2FuLz90
eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t


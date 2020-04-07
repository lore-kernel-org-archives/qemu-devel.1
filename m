Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031C4C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE1B20719
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE1B20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLnPh-0004DN-1D
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 08:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jLnPA-0003lI-3I
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jLnP8-0002qc-F7
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:32:35 -0400
Resent-Date: Tue, 07 Apr 2020 08:32:35 -0400
Resent-Message-Id: <E1jLnP8-0002qc-F7@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21148)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jLnP8-0002nV-7V
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:32:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586262734; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BAt+pP+UdiFJdcpTSVyCACIPNNaPq9fFndMWtSds2KFHoH4ouqVDbexFYd4geJ9wNQgLE2fIFvFQxWkeyxtnXsiJNNVIIzNW3mmnrtj9nL5sZRvFCK7FyOcxG8NXdW8SyONv/GxcP2XFtp9fvo8Y2h4LsN3LGlMSkFuCgEvV/m4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586262734;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=igNTzyMXXGC7kVNV1qbY5V+G8tX4zpi5rcXwo9qB38A=; 
 b=XtgobPyCqzJiK6PFi4rJeWGnKC2WWYsmqZ0SjIpp7son8Qz3AhdUFGfR/BWGk02+7gw1PXqOALLB2gpFHTkqWkbvm7OCgkQmOAuy+Tfm17U0DFaDX2z3UN2xSVkkbQU6oeS+0v8+R7sxvE4FOZlCi+CFcJ4b+n51cG9Tiguz+CM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15862627307521005.7188438061144;
 Tue, 7 Apr 2020 05:32:10 -0700 (PDT)
In-Reply-To: <20200407105706.1920-1-miaoyubo@huawei.com>
Subject: Re: [PATCH v5 0/8] pci_expander_brdige:acpi:Support pxb-pcie for ARM
Message-ID: <158626272955.11348.18290271649738716554@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: miaoyubo@huawei.com
Date: Tue, 7 Apr 2020 05:32:10 -0700 (PDT)
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, shannon.zhaosl@gmail.com,
 miaoyubo@huawei.com, imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwNzEwNTcwNi4xOTIw
LTEtbWlhb3l1Ym9AaHVhd2VpLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGFz
YW4gYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWly
IG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9i
YWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEv
YmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEg
TkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9
eDg2XzY0LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAg
Q0MgICAgICB4ODZfNjQtc29mdG1tdS9zb2Z0bW11L21haW4ubwogIENDICAgICAgeDg2XzY0LXNv
ZnRtbXUvZ2Ric3R1Yi14bWwubwogIENDICAgICAgeDg2XzY0LXNvZnRtbXUvdHJhY2UvZ2VuZXJh
dGVkLWhlbHBlcnMubwovdG1wL3FlbXUtdGVzdC9zcmMvaHcvaTM4Ni9hY3BpLWJ1aWxkLmM6MTY4
NTo5OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ2Nyc19yYW5nZV9p
bnNlcnQnIGlzIGludmFsaWQgaW4gQzk5IFstV2Vycm9yLC1XaW1wbGljaXQtZnVuY3Rpb24tZGVj
bGFyYXRpb25dCiAgICAgICAgY3JzX3JhbmdlX2luc2VydChjcnNfcmFuZ2Vfc2V0Lm1lbV9yYW5n
ZXMsCiAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvaTM4Ni9hY3BpLWJ1aWxkLmM6MTY4
NTo5OiBub3RlOiBkaWQgeW91IG1lYW4gJ2dfc3RyaW5nX2luc2VydCc/Ci91c3IvaW5jbHVkZS9n
bGliLTIuMC9nbGliL2dzdHJpbmcuaDoxMDY6MTQ6IG5vdGU6ICdnX3N0cmluZ19pbnNlcnQnIGRl
Y2xhcmVkIGhlcmUKR1N0cmluZyogICAgIGdfc3RyaW5nX2luc2VydCAgICAgICAgICAgIChHU3Ry
aW5nICAgICAgICAgKnN0cmluZywKICAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2h3
L2kzODYvYWNwaS1idWlsZC5jOjE2ODU6OTogZXJyb3I6IHRoaXMgZnVuY3Rpb24gZGVjbGFyYXRp
b24gaXMgbm90IGEgcHJvdG90eXBlIFstV2Vycm9yLC1Xc3RyaWN0LXByb3RvdHlwZXNdCiAgICAg
ICAgY3JzX3JhbmdlX2luc2VydChjcnNfcmFuZ2Vfc2V0Lm1lbV9yYW5nZXMsCiAgICAgICAgXgoy
IGVycm9ycyBnZW5lcmF0ZWQuCm1ha2VbMV06ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVz
Lm1hazo2OTogaHcvaTM4Ni9hY3BpLWJ1aWxkLm9dIEVycm9yIDEKbWFrZVsxXTogKioqIFdhaXRp
bmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KbWFrZTogKioqIFtNYWtlZmlsZTo1Mjc6IHg4Nl82
NC1zb2Z0bW11L2FsbF0gRXJyb3IgMgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6
CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+
CiAgICBzeXMuZXhpdChtYWluKCkpCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJl
dGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3Vk
bycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2Uu
dXVpZD1jNTY1ZmQ0OWZiZjg0Nzk2YTU1ZmJhN2MwZWQ5ZDBmNScsICctdScsICcxMDAzJywgJy0t
c2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdF
VF9MSVNUPXg4Nl82NC1zb2Z0bW11JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICct
ZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0n
LCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hl
dzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcv
dmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtdHlkM3F4MmUvc3JjL2RvY2tlci1zcmMuMjAyMC0w
NC0wNy0wOC4yOC4yNC4yMDAwNjovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAn
L3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1kZWJ1ZyddJyByZXR1cm5lZCBub24temVybyBleGl0
IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1j
NTY1ZmQ0OWZiZjg0Nzk2YTU1ZmJhN2MwZWQ5ZDBmNQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5d
IEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC10eWQzcXgyZS9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LWRlYnVnQGZl
ZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAzbTQ1LjgxM3MKdXNlciAgICAwbTguMTUzcwoKClRoZSBm
dWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA0MDcx
MDU3MDYuMTkyMC0xLW1pYW95dWJvQGh1YXdlaS5jb20vdGVzdGluZy5hc2FuLz90eXBlPW1lc3Nh
Z2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t


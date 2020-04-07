Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26540C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:57:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC26E206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC26E206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLnnN-0005jJ-6i
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 08:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jLnej-00014J-T7
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:48:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jLnei-0006b7-N6
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:48:41 -0400
Resent-Date: Tue, 07 Apr 2020 08:48:41 -0400
Resent-Message-Id: <E1jLnei-0006b7-N6@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21118)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jLnei-0006aa-FE
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:48:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586263705; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=L9mExk6R1sMhLJS7/VEJUaQ3v9jpbgmRnkBi2/ZJcV7yaPuQti1QOyRTUXH5RJhSUL0ae8iPQVLczkYrFik6BniOu6B5XBnwv+ruhqGNOuQEE0wUVmRtUqZrBQ8n8Mn1pYo4PmfSqGGMy9IPUJIBu0FEdl5USoUhLUcFQ6Bg4Gk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586263705;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=gq+MoXgYtwVA88pi6R7QKtJThGTv5afEXhosgWYASCY=; 
 b=jYJLOA1YZ0a63Wg4SgflB1HnzS7j2A9locOuCTLgr0Jz4KXgRjFK6vLtHpJCclj3M4WdrVL/ecaOFWUbHf6M1h0DjfWBITd+3Myokx5UffL4k8ADEb58QANqdblJg7fcNI4jd/ydtSG6/cPWTS2olZY1UpovEBZIJJFv1fzhdPs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586263580131603.0773209827108;
 Tue, 7 Apr 2020 05:46:20 -0700 (PDT)
In-Reply-To: <20200407105706.1920-1-miaoyubo@huawei.com>
Subject: Re: [PATCH v5 0/8] pci_expander_brdige:acpi:Support pxb-pcie for ARM
Message-ID: <158626357843.11348.9140575297323852387@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: miaoyubo@huawei.com
Date: Tue, 7 Apr 2020 05:46:20 -0700 (PDT)
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
LTEtbWlhb3l1Ym9AaHVhd2VpLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1p
bWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVk
b3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgYWFy
Y2g2NC1zb2Z0bW11L3FhcGkvcWFwaS12aXNpdC1tYWNoaW5lLXRhcmdldC5vCiAgQ0MgICAgICBh
YXJjaDY0LXNvZnRtbXUvcWFwaS9xYXBpLXZpc2l0LW1pc2MtdGFyZ2V0Lm8KL3RtcC9xZW11LXRl
c3Qvc3JjL2h3L2kzODYvYWNwaS1idWlsZC5jOiBJbiBmdW5jdGlvbiAnYnVpbGRfZHNkdCc6Ci90
bXAvcWVtdS10ZXN0L3NyYy9ody9pMzg2L2FjcGktYnVpbGQuYzoxNjg1Ojk6IGVycm9yOiBpbXBs
aWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAnY3JzX3JhbmdlX2luc2VydCc7IGRpZCB5b3Ug
bWVhbiAnZ19zdHJpbmdfaW5zZXJ0Jz8gWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFy
YXRpb25dCiAgICAgICAgIGNyc19yYW5nZV9pbnNlcnQoY3JzX3JhbmdlX3NldC5tZW1fcmFuZ2Vz
LAogICAgICAgICBefn5+fn5+fn5+fn5+fn5+CiAgICAgICAgIGdfc3RyaW5nX2luc2VydAovdG1w
L3FlbXUtdGVzdC9zcmMvaHcvaTM4Ni9hY3BpLWJ1aWxkLmM6MTY4NTo5OiBlcnJvcjogbmVzdGVk
IGV4dGVybiBkZWNsYXJhdGlvbiBvZiAnY3JzX3JhbmdlX2luc2VydCcgWy1XZXJyb3I9bmVzdGVk
LWV4dGVybnNdCmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2Vb
MV06ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogaHcvaTM4Ni9hY3BpLWJ1
aWxkLm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo1Mjc6IHg4Nl82NC1zb2Z0bW11L2Fs
bF0gRXJyb3IgMgptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIEND
ICAgICAgYWFyY2g2NC1zb2Z0bW11L3FhcGkvcWFwaS12aXNpdC5vCiAgQ0MgICAgICBhYXJjaDY0
LXNvZnRtbXUvcWFwaS9xYXBpLWV2ZW50cy1tYWNoaW5lLXRhcmdldC5vCi0tLQogICAgcmFpc2Ug
Q2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNz
RXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwn
LCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD0wZTI5OWMxYTBlODM0YzRkYjA0OGJhZTkxMWY5MzFk
ZCcsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcs
ICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BU
Uz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hP
V19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21l
L3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAn
LXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWxyczYycjN5L3NyYy9kb2NrZXItc3Jj
LjIwMjAtMDQtMDctMDguNDMuMjcuMzg4NDovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRv
cmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1taW5ndyddJyByZXR1cm5lZCBub24temVy
byBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2Uu
dXVpZD0wZTI5OWMxYTBlODM0YzRkYjA0OGJhZTkxMWY5MzFkZAptYWtlWzFdOiAqKiogW2RvY2tl
ci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNo
ZXctdGVzdGVyLXRtcC1scnM2MnIzeS9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LW1p
bmd3QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAybTUxLjc2NHMKdXNlciAgICAwbTguMjEycwoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAy
MDA0MDcxMDU3MDYuMTkyMC0xLW1pYW95dWJvQGh1YXdlaS5jb20vdGVzdGluZy5kb2NrZXItbWlu
Z3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


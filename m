Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7B2C2BB54
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:43:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E9620719
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E9620719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLna7-0007tM-1z
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 08:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jLnZX-0007Sj-EQ
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jLnZW-0002wA-1m
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:43:19 -0400
Resent-Date: Tue, 07 Apr 2020 08:43:19 -0400
Resent-Message-Id: <E1jLnZW-0002wA-1m@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jLnZV-0002sq-QB
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:43:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586263379; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OTfkJ4rvDhSTL6mNTHbjqtVw+k/0aPePGn0kP9vu6cD/f4eLcvgYVpEr/nOXs83yBNX84T5Su6gknPzaMwgoQJqEOD+509RYM3tGaKRutuHv+/ck1BdQq+t85ZHkmdWRwJePTTii2wiGsrhwNurW7A29fV2KGiyZWrFvqecL2M8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586263379;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=+EzOFwdnSMWX9x3i05dfai6PaKuBpbQpwfF5ZxrA2x8=; 
 b=ZbjwsHepQobQGyho39B6svTu6+GDWJeF404Ok1xkm1EM8kNPkYhZxOAQxY1QxedL94cab4RtbPn6Nf62UFwPzkmmVrA4OKZhvkU/S5TxE1kYQCpHuc2Vb5YpbCahuTdd/ciIITp3P9qiPXvWqCulJowsQvsnjQDIJZ6myXhu4cg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586263376525643.5977971908829;
 Tue, 7 Apr 2020 05:42:56 -0700 (PDT)
In-Reply-To: <20200407105706.1920-1-miaoyubo@huawei.com>
Subject: Re: [PATCH v5 0/8] pci_expander_brdige:acpi:Support pxb-pcie for ARM
Message-ID: <158626337574.11348.11530363060254619962@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: miaoyubo@huawei.com
Date: Tue, 7 Apr 2020 05:42:56 -0700 (PDT)
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
Y2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5F
VFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9
MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgeDg2XzY0LXNv
ZnRtbXUvdGFyZ2V0L2kzODYva3ZtLm8KICBDQyAgICAgIGFhcmNoNjQtc29mdG1tdS9xYXBpL3Fh
cGktdmlzaXQtbWlzYy10YXJnZXQubwovdG1wL3FlbXUtdGVzdC9zcmMvaHcvaTM4Ni9hY3BpLWJ1
aWxkLmM6IEluIGZ1bmN0aW9uICdidWlsZF9kc2R0JzoKL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2kz
ODYvYWNwaS1idWlsZC5jOjE2ODU6OTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1
bmN0aW9uICdjcnNfcmFuZ2VfaW5zZXJ0JyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNs
YXJhdGlvbl0KICAgICAgICAgY3JzX3JhbmdlX2luc2VydChjcnNfcmFuZ2Vfc2V0Lm1lbV9yYW5n
ZXMsCiAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2kzODYvYWNwaS1idWlsZC5jOjE2
ODU6OTogZXJyb3I6IG5lc3RlZCBleHRlcm4gZGVjbGFyYXRpb24gb2YgJ2Nyc19yYW5nZV9pbnNl
cnQnIFstV2Vycm9yPW5lc3RlZC1leHRlcm5zXQpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVh
dGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW2h3L2kzODYvYWNwaS1idWlsZC5vXSBFcnJvciAx
Cm1ha2VbMV06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgQ0MgICAgICBh
YXJjaDY0LXNvZnRtbXUvcWFwaS9xYXBpLXZpc2l0Lm8KICBDQyAgICAgIGFhcmNoNjQtc29mdG1t
dS9xYXBpL3FhcGktZXZlbnRzLW1hY2hpbmUtdGFyZ2V0Lm8KLS0tCiAgQ0MgICAgICBhYXJjaDY0
LXNvZnRtbXUvdGFyZ2V0L2FybS9tb25pdG9yLm8KICBDQyAgICAgIGFhcmNoNjQtc29mdG1tdS90
YXJnZXQvYXJtL2FybS1wb3dlcmN0bC5vCiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvdGFyZ2V0
L2FybS9rdm0tc3R1Yi5vCm1ha2U6ICoqKiBbeDg2XzY0LXNvZnRtbXUvYWxsXSBFcnJvciAyCm1h
a2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgQ0MgICAgICBhYXJjaDY0
LXNvZnRtbXUvdGFyZ2V0L2FybS90bGJfaGVscGVyLm8KICBDQyAgICAgIGFhcmNoNjQtc29mdG1t
dS90YXJnZXQvYXJtL2RlYnVnX2hlbHBlci5vCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vy
cm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQg
J1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5z
dGFuY2UudXVpZD1kNGRkNGM4Mzg4YzY0ZDdkOWE2OGYxMDcyNmJiYzZmZicsICctdScsICcxMDAz
JywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywg
J1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0n
LCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScs
ICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2Fj
aGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1w
L3BhdGNoZXctdGVzdGVyLXRtcC1sa2lndHNwYi9zcmMvZG9ja2VyLXNyYy4yMDIwLTA0LTA3LTA4
LjQwLjA1LjI2NzcyOi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zhci90
bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1
cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1kNGRkNGM4
Mzg4YzY0ZDdkOWE2OGYxMDcyNmJiYzZmZgptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9y
IDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRt
cC1sa2lndHNwYi9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczdd
IEVycm9yIDIKCnJlYWwgICAgMm01MS4wNjZzCnVzZXIgICAgMG04LjQ4OHMKCgpUaGUgZnVsbCBs
b2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDA3MTA1NzA2
LjE5MjAtMS1taWFveXVib0BodWF3ZWkuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcv
P3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


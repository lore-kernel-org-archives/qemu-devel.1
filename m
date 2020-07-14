Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7653C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:05:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A748720658
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A748720658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvOMp-0005a5-Vm
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 13:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jvOME-00059h-2m
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 13:04:42 -0400
Resent-Date: Tue, 14 Jul 2020 13:04:42 -0400
Resent-Message-Id: <E1jvOME-00059h-2m@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jvOMB-00028a-GJ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 13:04:41 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594746272; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PAGQJH5eA8JHqAsYc77f2JGLuCPMP4YdryHOZydxsb7eC+aXG5m/lV4BwJJTXniFWCYeLa7pbmfh/qKMxXVAcWf2/Kr4azmedGRMNnJxLzsIXmzwg2q2gosATrTxocvnTpsZag6H+gIJnfxYJLu66XmRfZ8n03/PfacRxXOtipQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594746272;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=smkUCF6rRsOrGx89ae8Y5ZWAzuj/2OXOHepe1rOZqmo=; 
 b=N5k2+ilM9fRqApwOsHF+82Qv+4R+47D7tP0/CgAwGNJ8P6Cvxew/UWhStJ6shxmr6Un7QJpMQobnxrJu25TbYD4m7ZkycLKnL8dRnNOxZ768tX22MF4AMUzovBM2NUcEDuYL4X4p6/JVub1Dq5cI9LxbnEMMWxkOxJX54M3n3DI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594746270068159.904038620988;
 Tue, 14 Jul 2020 10:04:30 -0700 (PDT)
Subject: Re: [PATCH for 5.1] docs: fix trace docs build with sphinx 3.1.1
Message-ID: <159474626888.11884.11479350725210959094@07a7f0d89f7d>
In-Reply-To: <20200714162659.1017432-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berrange@redhat.com
Date: Tue, 14 Jul 2020 10:04:30 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 12:56:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcxNDE2MjY1OS4xMDE3
NDMyLTEtYmVycmFuZ2VAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0x
IE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0x
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFRFU1QgICAgaW90ZXN0
LXFjb3cyOiAwMjQKICBURVNUICAgIGNoZWNrLXVuaXQ6IHRlc3RzL3Rlc3QtY2hhcgoqKgpFUlJP
UjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvdGVzdC1jaGFyLmM6MTIwNDpjaGFyX3NlcmlhbF90
ZXN0OiAnY2hyJyBzaG91bGQgbm90IGJlIE5VTEwKRVJST1IgdGVzdC1jaGFyIC0gQmFpbCBvdXQh
IEVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy90ZXN0LWNoYXIuYzoxMjA0OmNoYXJfc2Vy
aWFsX3Rlc3Q6ICdjaHInIHNob3VsZCBub3QgYmUgTlVMTAptYWtlOiAqKiogW2NoZWNrLXVuaXRd
IEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KcWVtdS1z
eXN0ZW0tYWFyY2g2NDogLWFjY2VsIGt2bTogaW52YWxpZCBhY2NlbGVyYXRvciBrdm0KcWVtdS1z
eXN0ZW0tYWFyY2g2NDogZmFsbGluZyBiYWNrIHRvIHRjZwotLS0KICAgIHJhaXNlIENhbGxlZFBy
b2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBD
b21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5x
ZW11Lmluc3RhbmNlLnV1aWQ9ZWU5MGQyN2IzNTM2NDM0MmFhYzg4ODE4NDc3YjhlNWMnLCAnLXUn
LCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScs
ICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1l
JywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEn
LCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hl
dy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC05ZjhpZ256Ny9zcmMvZG9ja2VyLXNyYy4yMDIwLTA3
LTE0LTEyLjQ4LjUxLjE2NTk2Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11L2NlbnRvczcnLCAn
L3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0
IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1l
ZTkwZDI3YjM1MzY0MzQyYWFjODg4MTg0NzdiOGU1YwptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5d
IEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC05ZjhpZ256Ny9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNl
bnRvczddIEVycm9yIDIKCnJlYWwgICAgMTVtMzguODY1cwp1c2VyICAgIDBtOC43NzRzCgoKVGhl
IGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDcx
NDE2MjY1OS4xMDE3NDMyLTEtYmVycmFuZ2VAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlj
a0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


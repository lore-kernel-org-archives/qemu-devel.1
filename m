Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48089C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 19:00:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C42F2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 19:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C42F2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC6aZ-000671-7e
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 15:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53241)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jC6Zw-0005iF-QC
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 14:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jC6Zv-00007o-9t
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 14:59:40 -0400
Resent-Date: Wed, 11 Mar 2020 14:59:40 -0400
Resent-Message-Id: <E1jC6Zv-00007o-9t@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21167)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jC6Zv-0008Qp-1W
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 14:59:39 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1583953163; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dnxFLSiTixo76qoEIthm+tI73XnoGD4zvsZCM8gbd+fgrKgWLrZgFzD9g+lpk50/MGMjLEY5gQuo3Z9ceMVsvIKwSeBluqytGhzX/Aam5tdHBlEJPmJ51vM27d+w2jFk1NCzLIJ16+lUKVlI52CM2YceKI4oIBuPLS+N9wtkQz8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1583953163;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=SgBCbXEpBOtU+5rTPbAo7cd3gDzG0z5C5NEFfo/mrSQ=; 
 b=ib8bAAkFz5u+641+oooLII+hzgSplqeeJkTcLbCMdNDKxZqK4+KSswv2UbxWQbrwKP1omMtsxGGemTf9gmMtWhBDl46TXO1leroYVwynhGlJx7slm1AycKnD0ZQU5WiLUSj51da+jDZXYyh2xNx7c/7e4Xpowo9zDhL6r56UrzA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1583953160591111.03217273272708;
 Wed, 11 Mar 2020 11:59:20 -0700 (PDT)
In-Reply-To: <20200311170826.79419-1-liran.alon@oracle.com>
Subject: Re: [PATCH] acpi: Add Windows ACPI Emulated Device Table (WAET)
Message-ID: <158395315920.8804.12475968769225149761@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: liran.alon@oracle.com
Date: Wed, 11 Mar 2020 11:59:20 -0700 (PDT)
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 liran.alon@oracle.com, pbonzini@redhat.com, elad.gabay@oracle.com,
 imammedo@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxMTE3MDgyNi43OTQx
OS0xLWxpcmFuLmFsb25Ab3JhY2xlLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0x
IE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0x
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVc2luZyBleHBlY3RlZCBm
aWxlICd0ZXN0cy9kYXRhL2FjcGkvcGMvSFBFVCcKTG9va2luZyBmb3IgZXhwZWN0ZWQgZmlsZSAn
dGVzdHMvZGF0YS9hY3BpL3BjL1dBRVQnCioqCkVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0
cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LmM6MzY3OmxvYWRfZXhwZWN0ZWRfYW1sOiBhc3NlcnRp
b24gZmFpbGVkOiAoZXhwX3NkdC5hbWxfZmlsZSkKRVJST1IgLSBCYWlsIG91dCEgRVJST1I6L3Rt
cC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYzozNjc6bG9hZF9l
eHBlY3RlZF9hbWw6IGFzc2VydGlvbiBmYWlsZWQ6IChleHBfc2R0LmFtbF9maWxlKQptYWtlOiAq
KiogW2NoZWNrLXF0ZXN0LXg4Nl82NF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5m
aW5pc2hlZCBqb2JzLi4uLgogIFRFU1QgICAgY2hlY2stdW5pdDogdGVzdHMvdGVzdC1idWZmZXJp
c3plcm8KcWVtdS1zeXN0ZW0tYWFyY2g2NDogLWFjY2VsIGt2bTogaW52YWxpZCBhY2NlbGVyYXRv
ciBrdm0KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJw
cm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tl
cicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTU1OThhNDQ5ODc0
MjQ5MWM5YmU3NmUxMjI1ZjYwZmU1JywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAn
c2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywg
J0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywg
J0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAv
Y2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTov
dmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtZjVn
OXNkNjUvc3JjL2RvY2tlci1zcmMuMjAyMC0wMy0xMS0xNC40Ny4zNC42MDU1Oi92YXIvdG1wL3Fl
bXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWlj
ayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFi
ZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD01NTk4YTQ0OTg3NDI0OTFjOWJlNzZlMTIyNWY2MGZl
NQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJl
Y3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1mNWc5c2Q2NS9zcmMnCm1ha2U6ICoq
KiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMTFtNDUu
MjAzcwp1c2VyICAgIDBtOC43MDZzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDMxMTE3MDgyNi43OTQxOS0xLWxpcmFuLmFsb25Ab3Jh
Y2xlLmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t


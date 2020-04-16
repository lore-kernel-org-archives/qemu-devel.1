Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4B9C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 21:50:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C43206D6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 21:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C43206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPCOs-0007i6-FF
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 17:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jPCMe-0006JM-VG
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 17:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jPCMd-0003da-CU
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 17:48:04 -0400
Resent-Date: Thu, 16 Apr 2020 17:48:04 -0400
Resent-Message-Id: <E1jPCMd-0003da-CU@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jPCMd-0003cv-4H
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 17:48:03 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587073673; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WX6Cq9ciaKfiHVslsDLt+cWKwX5Xhgslew4f6YqVua3T3UAyLYfFwAwDlQYUY/XmwfggtlEE0F9xBpK9mlOm6o2fZiEpqiaI+WUc1BlhNe+uc9yrzM41BuUZVAi2Rv/HZ0UMa4Bu4NdIyn9fd4KrMN7c60iG4MCHp+9lBXrk6Hk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587073673;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=IkrjAoKMumI563bagfAh4tm3DC3fIYnnrTuya4eykSg=; 
 b=OTJOGFNIu/dr1cAYNRgsQzkHYTz5d+x3keGqyuqCn9s8ZprnyGDohsqE/i6sT2HsJeTKtyN9ORqkuIrnGLJNI1YjUxz6GZnZDknlQlGUlS43fOHmYBZCZX7vGpw9TrWSq0OoOQRe2fiJlyn4rNcd63sQuGsv4vm5BCltvdfTliA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158707367159370.62563091486675;
 Thu, 16 Apr 2020 14:47:51 -0700 (PDT)
In-Reply-To: <20200416203624.32366-1-mlevitsk@redhat.com>
Subject: Re: [PATCH 0/4] RFC/WIP: Fix scsi devices plug/unplug races w.r.t
 virtio-scsi iothread
Message-ID: <158707367004.15335.13791358735439652114@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mlevitsk@redhat.com
Date: Thu, 16 Apr 2020 14:47:51 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: fam@euphon.net, berrange@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, mlevitsk@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQxNjIwMzYyNC4zMjM2
Ni0xLW1sZXZpdHNrQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBO
RVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBK
PTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBURVNUICAgIGNoZWNrLXF0
ZXN0LXg4Nl82NDogdGVzdHMvcXRlc3QvZGV2aWNlLXBsdWctdGVzdAogIFRFU1QgICAgY2hlY2st
cXRlc3QteDg2XzY0OiB0ZXN0cy9xdGVzdC9kcml2ZV9kZWwtdGVzdAoqKgpFUlJPUjovdG1wL3Fl
bXUtdGVzdC9zcmMvdGVzdHMvcXRlc3QvZHJpdmVfZGVsLXRlc3QuYzoyNTpkcml2ZV9hZGQ6IGFz
c2VydGlvbiBmYWlsZWQgKHJlc3AgPT0gIk9LXHJcbiIpOiAoIkR1cGxpY2F0ZSBJRCAnZHJpdmUw
JyBmb3IgZHJpdmVcclxuIiA9PSAiT0tcclxuIikKRVJST1IgLSBCYWlsIG91dCEgRVJST1I6L3Rt
cC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0L2RyaXZlX2RlbC10ZXN0LmM6MjU6ZHJpdmVfYWRk
OiBhc3NlcnRpb24gZmFpbGVkIChyZXNwID09ICJPS1xyXG4iKTogKCJEdXBsaWNhdGUgSUQgJ2Ry
aXZlMCcgZm9yIGRyaXZlXHJcbiIgPT0gIk9LXHJcbiIpCm1ha2U6ICoqKiBbY2hlY2stcXRlc3Qt
eDg2XzY0XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4u
CiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDA0MApxZW11LXN5c3RlbS1hYXJjaDY0OiAtYWNjZWwg
a3ZtOiBpbnZhbGlkIGFjY2VsZXJhdG9yIGt2bQotLS0KICBURVNUICAgIGNoZWNrLXF0ZXN0LWFh
cmNoNjQ6IHRlc3RzL3F0ZXN0L2Nkcm9tLXRlc3QKICBURVNUICAgIGNoZWNrLXF0ZXN0LWFhcmNo
NjQ6IHRlc3RzL3F0ZXN0L2RldmljZS1pbnRyb3NwZWN0LXRlc3QKKioKRVJST1I6L3RtcC9xZW11
LXRlc3Qvc3JjL3FvbS9vYmplY3QuYzoxMTI0Om9iamVjdF91bnJlZjogYXNzZXJ0aW9uIGZhaWxl
ZDogKG9iai0+cmVmID4gMCkKQnJva2VuIHBpcGUKL3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3F0
ZXN0L2xpYnF0ZXN0LmM6MTc1OiBraWxsX3FlbXUoKSBkZXRlY3RlZCBRRU1VIGRlYXRoIGZyb20g
c2lnbmFsIDYgKEFib3J0ZWQpIChjb3JlIGR1bXBlZCkKRVJST1IgLSB0b28gZmV3IHRlc3RzIHJ1
biAoZXhwZWN0ZWQgNiwgZ290IDUpCm1ha2U6ICoqKiBbY2hlY2stcXRlc3QtYWFyY2g2NF0gRXJy
b3IgMQogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAxNTQKICBURVNUICAgIGlvdGVzdC1xY293Mjog
MTU2CiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDE1OAotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nl
c3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21t
YW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11
Lmluc3RhbmNlLnV1aWQ9ZjAxYzUzZDNkYmZjNDMzOGE3MTc5MDdiYmY3MjRmZTMnLCAnLXUnLCAn
MTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICct
ZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywg
J1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAn
LWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8u
Y2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIv
dG1wL3BhdGNoZXctdGVzdGVyLXRtcC0xcDJ2bHZpNC9zcmMvZG9ja2VyLXNyYy4yMDIwLTA0LTE2
LTE3LjMzLjQzLjI1NDg1Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zh
ci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0
YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1mMDFj
NTNkM2RiZmM0MzM4YTcxNzkwN2JiZjcyNGZlMwptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVy
cm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVy
LXRtcC0xcDJ2bHZpNC9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRv
czddIEVycm9yIDIKCnJlYWwgICAgMTRtNy41NTRzCnVzZXIgICAgMG05LjI5MXMKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDE2MjAz
NjI0LjMyMzY2LTEtbWxldml0c2tAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50
b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQ
YXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


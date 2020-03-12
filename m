Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C53C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 21:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE5DD20674
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 21:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5DD20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCVd1-00062S-3O
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 17:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jCVcJ-0005Xv-MA
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 17:43:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jCVcG-000693-On
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 17:43:46 -0400
Resent-Date: Thu, 12 Mar 2020 17:43:45 -0400
Resent-Message-Id: <E1jCVcG-000693-On@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jCVcG-00065G-6r; Thu, 12 Mar 2020 17:43:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584049418; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hyYFioagSpK6HZHDQKNMSg4EosVj49vCWuLhzkiR86CY4b38WXiW2W1tigXJz8DfzD6Kmb1ck7SjCQL3gOB76zb+PB9uCWyAmLaOjawmg4pxY4iIezkDq9FKNw7Ji7lVm2p3dbfNE8MKLPWfEwYHmvY5SZCaEF1HHoXnoZKpxxI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584049418;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=dIychNlo8R6fkLXtbjWy2Dx8AGnJrugV3FNs5h3DBJk=; 
 b=De/IOZy4ev1+ZRH145Xd+xv3zGNerho1w+ShqNebKAkjMuOzA1Tvry2dch4NcRayIaroLkk+7O6xQ0Ik7fzVEespVqQq7fI/Oa5z+BKtQSP/yP+wsiexhVjQqYXYvxa4tG2PoLkEfOfNq9G+vSmd0g/vgRxmRYGu0DPHzP+un+k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1584049417292697.4921804103464;
 Thu, 12 Mar 2020 14:43:37 -0700 (PDT)
In-Reply-To: <20200312192822.3739399-1-eblake@redhat.com>
Subject: Re: [PATCH v4 0/7] Tighten qemu-img rules on missing backing format
Message-ID: <158404941600.16773.7980152689600838017@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eblake@redhat.com
Date: Thu, 12 Mar 2020 14:43:37 -0700 (PDT)
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxMjE5MjgyMi4zNzM5
Mzk5LTEtZWJsYWtlQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBO
RVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBK
PTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKSW4gZmlsZSBpbmNsdWRlZCBm
cm9tIC90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL3FhcGkvcW1wL3FkaWN0Lmg6MTY6MCwKICAg
ICAgICAgICAgICAgICBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9zaGVlcGRvZy5jOjIw
OgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svc2hlZXBkb2cuYzogSW4gZnVuY3Rpb24gJ3NkX2Nv
X2NyZWF0ZV9vcHRzJzoKL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvcWFwaS9xbXAvcW9iamVj
dC5oOjk4OjI5OiBlcnJvcjogJ3FkaWN0JyBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGluIHRo
aXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXplZF0KICAgICBhc3NlcnQoIW9i
aiB8fCBvYmotPmJhc2UucmVmY250KTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCi90
bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9zaGVlcGRvZy5jOjIxNjQ6MTI6IG5vdGU6ICdxZGljdCcg
d2FzIGRlY2xhcmVkIGhlcmUKLS0tCiAgICAgICAgICAgIF4KY2MxOiBhbGwgd2FybmluZ3MgYmVp
bmcgdHJlYXRlZCBhcyBlcnJvcnMKICBDQyAgICAgIHNjc2kvcHItbWFuYWdlci5vCm1ha2U6ICoq
KiBbYmxvY2svc2hlZXBkb2cub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5p
c2hlZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAi
Li90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+Ci0tLQogICAg
cmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQ
cm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0t
bGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD00MjM5MGZjNmNhZTE0ZGZjOGRiODQ3Nzk5
NDhlNjIzNicsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25m
aW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdV
UkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUn
LCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdics
ICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNo
ZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1ibW1tamdieC9zcmMvZG9j
a2VyLXNyYy4yMDIwLTAzLTEyLTE3LjQxLjQ5LjIxMzY1Oi92YXIvdG1wL3FlbXU6eixybycsICdx
ZW11OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5l
ZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUu
aW5zdGFuY2UudXVpZD00MjM5MGZjNmNhZTE0ZGZjOGRiODQ3Nzk5NDhlNjIzNgptYWtlWzFdOiAq
KiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIv
dG1wL3BhdGNoZXctdGVzdGVyLXRtcC1ibW1tamdieC9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1
bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMW00Ny40MzBzCnVzZXIgICAg
MG03Ljk1MXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9y
Zy9sb2dzLzIwMjAwMzEyMTkyODIyLjM3MzkzOTktMS1lYmxha2VAcmVkaGF0LmNvbS90ZXN0aW5n
LmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQg
YXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBz
ZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


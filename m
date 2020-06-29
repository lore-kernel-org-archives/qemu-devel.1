Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58358C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 21:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 303AD20775
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 21:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303AD20775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq11d-0004OH-FJ
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 17:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jq10h-0003Tp-17; Mon, 29 Jun 2020 17:08:15 -0400
Resent-Date: Mon, 29 Jun 2020 17:08:15 -0400
Resent-Message-Id: <E1jq10h-0003Tp-17@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jq10e-0001b1-6P; Mon, 29 Jun 2020 17:08:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593464868; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ks6Wb9dEZk3UdH7R7/ZTEv6VTxDJBRNRD1OYaZT4LZEX2xfNx09CPws/dI9WmAczC2AYxVAx87TrUxvAEft51YngjsPP3kZRNbIKPDo29//YoLWT1xRD8dBrwPVn+MkjjwR7YC0Njq4b3oHbna7I5urj+9Z3av0MOzndkksytec=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593464868;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=g39ADZMg4ekgRTxMudU+HvzPsWPxhrh8RK82x1/YQ9g=; 
 b=DsfdK8DBNPl8lQ4BaxzLD9U96PnufvPXedEzloy+Iyp9/wVxQ1QLvErhmuPlRGsQj81RuvScmQy6YhmCFkxD4xfaDEiOLsNjG/ZqQxrpuTp4Gc5ktt/dv6+EsK8p3jmo3sWG8oAVqnDwfftnJLHpK8mLqBC0U/ZFXQKvo6nR5ik=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593464865372403.2697800705854;
 Mon, 29 Jun 2020 14:07:45 -0700 (PDT)
Message-ID: <159346486377.15477.6186679362319226240@d1fd068a5071>
Subject: Re: [PATCH 0/2] hw/block/nvme: handle transient dma errors
In-Reply-To: <20200629202053.1223342-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: its@irrelevant.dk
Date: Mon, 29 Jun 2020 14:07:45 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 17:08:09
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, k.jensen@samsung.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, kbusch@kernel.org, its@irrelevant.dk,
 mlevitsk@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYyOTIwMjA1My4xMjIz
MzQyLTEtaXRzQGlycmVsZXZhbnQuZGsvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBO
RVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBK
PTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKLS0tIC90bXAvcWVtdS10ZXN0
L3NyYy90ZXN0cy9xZW11LWlvdGVzdHMvMDQwLm91dCAgICAgICAyMDIwLTA2LTI5IDIwOjEyOjEw
LjAwMDAwMDAwMCArMDAwMAorKysgL3RtcC9xZW11LXRlc3QvYnVpbGQvdGVzdHMvcWVtdS1pb3Rl
c3RzLzA0MC5vdXQuYmFkIDIwMjAtMDYtMjkgMjA6NTg6NDguMjg4NzkwODE4ICswMDAwCkBAIC0x
LDMgKzEsNSBAQAorV0FSTklORzpxZW11Lm1hY2hpbmU6cWVtdSByZWNlaXZlZCBzaWduYWwgOTog
L3RtcC9xZW11LXRlc3QvYnVpbGQvdGVzdHMvcWVtdS1pb3Rlc3RzLy4uLy4uL3g4Nl82NC1zb2Z0
bW11L3FlbXUtc3lzdGVtLXg4Nl82NCAtZGlzcGxheSBub25lIC12Z2Egbm9uZSAtY2hhcmRldiBz
b2NrZXQsaWQ9bW9uLHBhdGg9L3RtcC90bXAuSmRvbDBmUFNjUS9xZW11LTIxNzQ5LW1vbml0b3Iu
c29jayAtbW9uIGNoYXJkZXY9bW9uLG1vZGU9Y29udHJvbCAtcXRlc3QgdW5peDpwYXRoPS90bXAv
dG1wLkpkb2wwZlBTY1EvcWVtdS0yMTc0OS1xdGVzdC5zb2NrIC1hY2NlbCBxdGVzdCAtbm9kZWZh
dWx0cyAtZGlzcGxheSBub25lIC1hY2NlbCBxdGVzdAorV0FSTklORzpxZW11Lm1hY2hpbmU6cWVt
dSByZWNlaXZlZCBzaWduYWwgOTogL3RtcC9xZW11LXRlc3QvYnVpbGQvdGVzdHMvcWVtdS1pb3Rl
c3RzLy4uLy4uL3g4Nl82NC1zb2Z0bW11L3FlbXUtc3lzdGVtLXg4Nl82NCAtZGlzcGxheSBub25l
IC12Z2Egbm9uZSAtY2hhcmRldiBzb2NrZXQsaWQ9bW9uLHBhdGg9L3RtcC90bXAuSmRvbDBmUFNj
US9xZW11LTIxNzQ5LW1vbml0b3Iuc29jayAtbW9uIGNoYXJkZXY9bW9uLG1vZGU9Y29udHJvbCAt
cXRlc3QgdW5peDpwYXRoPS90bXAvdG1wLkpkb2wwZlBTY1EvcWVtdS0yMTc0OS1xdGVzdC5zb2Nr
IC1hY2NlbCBxdGVzdCAtbm9kZWZhdWx0cyAtZGlzcGxheSBub25lIC1hY2NlbCBxdGVzdAogLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4K
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KIFJhbiA1OSB0ZXN0cwotLS0KTm90IHJ1bjogMjU5CkZhaWx1cmVzOiAw
NDAKRmFpbGVkIDEgb2YgMTE5IGlvdGVzdHMKbWFrZTogKioqIFtjaGVjay10ZXN0cy9jaGVjay1i
bG9jay5zaF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4u
LgogIFRFU1QgICAgY2hlY2stcXRlc3QtYWFyY2g2NDogdGVzdHMvcXRlc3QvcW9zLXRlc3QKVHJh
Y2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nl
c3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21t
YW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11
Lmluc3RhbmNlLnV1aWQ9ZGEyNWVhYThiZGQwNGNiNzgzZTJjNDI3YzZhNWFhOTQnLCAnLXUnLCAn
MTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICct
ZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywg
J1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAn
LWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8u
Y2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIv
dG1wL3BhdGNoZXctdGVzdGVyLXRtcC05OGw3a295Mi9zcmMvZG9ja2VyLXNyYy4yMDIwLTA2LTI5
LTE2LjUxLjQ2LjIwNzQyOi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zh
ci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0
YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1kYTI1
ZWFhOGJkZDA0Y2I3ODNlMmM0MjdjNmE1YWE5NAptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVy
cm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVy
LXRtcC05OGw3a295Mi9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRv
czddIEVycm9yIDIKCnJlYWwgICAgMTVtNTcuNTkwcwp1c2VyICAgIDBtOS4yNDBzCgoKVGhlIGZ1
bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDYyOTIw
MjA1My4xMjIzMzQyLTEtaXRzQGlycmVsZXZhbnQuZGsvdGVzdGluZy5kb2NrZXItcXVpY2tAY2Vu
dG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNr
IHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


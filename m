Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEE8C3B1BF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 01:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48EA92072C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 01:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EA92072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Vh8-00076T-Ei
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 20:59:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j3VgR-0006Ez-6J
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 20:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j3VgP-0001TX-NG
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 20:58:50 -0500
Resent-Date: Sun, 16 Feb 2020 20:58:50 -0500
Resent-Message-Id: <E1j3VgP-0001TX-NG@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j3VgO-0001Ot-IE; Sun, 16 Feb 2020 20:58:49 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1581904694; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZfITRVlqrmwrIaK5LnQSBPhd2mt2upIfOLMmc6dtqTuBymdBNMr5dWrmYd/ETMx7Ti9TfuzzjPQxvFqhpboMfFVg3LwcXQW7Zmy4yGQtNpoYX+z9niPVVifD6xZ7TM0UgZn+QE8g5x1O1my+Hof/lhmC23cZ2/Z3mpgJXYqwNV0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1581904694;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=+Q92JkpEHaMBZidjUitV7WlmVdqbO8FBHBidjLdReew=; 
 b=lvPZ7g3JtokLOQy5rcChtbLQYKFP0UeSH42BUC60WSSF4Gn6Yu41NyvciVLLSYsNPjPAOrf8bUEiE73vLftyuCWFNNXCXLgs3bR4p/rWm8GQKVAQ2PO2GhCxFReqbTbEB1Ho24+4tUh2iwOWGTQg85/JIKXSCBulE+5SIQJi7uQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158190469314487.81033754147495;
 Sun, 16 Feb 2020 17:58:13 -0800 (PST)
In-Reply-To: <20200217012737.30231-1-gengdongjiu@huawei.com>
Subject: Re: [PATCH RESEND v23 00/10] Add ARMv8 RAS virtualization support in
 QEMU
Message-ID: <158190469039.22563.11180150744026622799@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: gengdongjiu@huawei.com
Date: Sun, 16 Feb 2020 17:58:13 -0800 (PST)
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
Cc: fam@euphon.net, peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com,
 kvm@vger.kernel.org, mst@redhat.com, mtosatti@redhat.com,
 qemu-devel@nongnu.org, ehabkost@redhat.com, gengdongjiu@huawei.com,
 shannon.zhaosl@gmail.com, zhengxiang9@huawei.com, qemu-arm@nongnu.org,
 james.morse@arm.com, shameerali.kolothum.thodi@huawei.com,
 jonathan.cameron@huawei.com, pbonzini@redhat.com, imammedo@redhat.com,
 lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIxNzAxMjczNy4zMDIz
MS0xLWdlbmdkb25naml1QGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2Nr
ZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3
QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAg
IGh3L2F1ZGlvL3NiMTYubwpJbiBmaWxlIGluY2x1ZGVkIGZyb20gL3RtcC9xZW11LXRlc3Qvc3Jj
L2h3L2FjcGkvZ2hlcy5jOjI5OgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYWNwaS9naGVzLmM6IElu
IGZ1bmN0aW9uICdhY3BpX2doZXNfcmVjb3JkX21lbV9lcnJvcic6Ci90bXAvcWVtdS10ZXN0L3Ny
Yy9pbmNsdWRlL3FlbXUvdXVpZC5oOjM4OjM6IGVycm9yOiBtaXNzaW5nIGJyYWNlcyBhcm91bmQg
aW5pdGlhbGl6ZXIgWy1XZXJyb3I9bWlzc2luZy1icmFjZXNdCiAgIHsgKGEpICYgMHhmZiwgKChh
KSA+PiA4KSAmIDB4ZmYsICgoYSkgPj4gMTYpICYgMHhmZiwgKChhKSA+PiAyNCkgJiAweGZmLCBc
CiAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2FjcGkvZ2hlcy5jOjYwOjU6IG5vdGU6IGluIGV4
cGFuc2lvbiBvZiBtYWNybyAnVVVJRF9MRScKLS0tCiAgICAgUWVtdVVVSUQgbWVtX3NlY3Rpb25f
aWRfbGUgPSBVRUZJX0NQRVJfU0VDX1BMQVRGT1JNX01FTTsKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CmNjMTogYWxsIHdhcm5pbmdz
IGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1
bGVzLm1hazo2OTogaHcvYWNwaS9naGVzLm9dIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9y
IHVuZmluaXNoZWQgam9icy4uLi4KICBDQyAgICAgIGh3L2F1ZGlvL2VzMTM3MC5vClRyYWNlYmFj
ayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJy
b3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAn
WydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0
YW5jZS51dWlkPTlhNzY0MDI0NjNjMzQ1MzI4YmU1NmFlNDA5N2NlZTNiJywgJy11JywgJzEwMDMn
LCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAn
VEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScs
ICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUnLCAn
Q0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hl
L3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9w
YXRjaGV3LXRlc3Rlci10bXAtbGZocV9qNWEvc3JjL2RvY2tlci1zcmMuMjAyMC0wMi0xNi0yMC41
NS4zNi4xMzM5NzovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zhci90bXAv
cWVtdS9ydW4nLCAndGVzdC1taW5ndyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAy
LgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD05YTc2NDAyNDYz
YzM0NTMyOGJlNTZhZTQwOTdjZWUzYgptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEK
bWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1s
ZmhxX2o1YS9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LW1pbmd3QGZlZG9yYV0gRXJy
b3IgMgoKcmVhbCAgICAybTM1LjQ2NnMKdXNlciAgICAwbTguMjMxcwoKClRoZSBmdWxsIGxvZyBp
cyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAyMTcwMTI3MzcuMzAy
MzEtMS1nZW5nZG9uZ2ppdUBodWF3ZWkuY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


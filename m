Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BE8FA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 19:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50EF82053B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 19:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50EF82053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKorb-0008Ua-Ge
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 15:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iKoqC-0007NA-Rs
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 15:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iKoqB-0008Oh-Lf
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 15:20:12 -0400
Resent-Date: Wed, 16 Oct 2019 15:20:12 -0400
Resent-Message-Id: <E1iKoqB-0008Oh-Lf@eggs.gnu.org>
Received: from sender4-of-o56.zoho.com ([136.143.188.56]:21671)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iKoqB-0008Mr-E4; Wed, 16 Oct 2019 15:20:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571253592; cv=none; d=zoho.com; s=zohoarc; 
 b=N5ze4nUWu/7ckLn0RLvcCdMhe/vM9XvDhVtY2SeQyDdbwp1DWWcaQvZ6jTsp7ocl2HvgDH6sKaVLIVEkTrzBtX2gFbspOCNzxrBVkGjASXtpT8vM8IEGyFCfK8AStNAtUpQd/KbIxM8LJHEPnZpSrc6lFlxy5ZQFRC9+udRuZsw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1571253592;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=P1WiDURyYbhiTaORz8ApToj458GlmpDmh169vCS49XA=; 
 b=JKz9bE3xYmz9gfAY172pvKB08LI2g1iCsqdO/ESmhDA9Ab5BCA3a3Nz8ed3aQgjDI7Oy+nYevtyf+3Ge1pxa/72EMI5O8AfirozZjDhf1EVonyoxAVwrM+uibwt+yb5FDDw16rXRW+aK8+w/58g2Nz+usuhhxBxQBXfRYoA41iQ=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571253591705649.7713017373951;
 Wed, 16 Oct 2019 12:19:51 -0700 (PDT)
In-Reply-To: <1571243333-882302-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: Re: [PATCH v4 0/4] qcow2: advanced compression options
Message-ID: <157125358988.16217.2913726879958644095@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: andrey.shinkevich@virtuozzo.com
Date: Wed, 16 Oct 2019 12:19:51 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.56
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org, andrey.shinkevich@virtuozzo.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTcxMjQzMzMzLTg4MjMwMi0x
LWdpdC1zZW5kLWVtYWlsLWFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20vCgoKCkhpLAoK
VGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBs
ZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElm
IHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0
CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQg
QVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBt
YWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKICBDQyAgICAgIGJsb2NrL2Jsa3ZlcmlmeS5vCiAgQ0MgICAgICBibG9jay9i
bGtyZXBsYXkubwovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzIuYzogSW4gZnVuY3Rpb24g
J3Fjb3cyX2NvX3B3cml0ZXZfY29tcHJlc3NlZF9wYXJ0JzoKL3RtcC9xZW11LXRlc3Qvc3JjL2Js
b2NrL3Fjb3cyLmM6NDI0NDo5OiBlcnJvcjogJ3JldCcgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXpl
ZCBpbiB0aGlzIGZ1bmN0aW9uIFstV2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRdCiAgICAgaW50
IHJldDsKICAgICAgICAgXn5+CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJy
b3JzCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogYmxvY2svcWNv
dzIub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgog
IENDICAgICAgYmxvY2svcGFyYWxsZWxzLm8KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxh
c3QpOgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnBy
b2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2Vy
JywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MmUzNTljNGI3YjBm
NDAzY2ExNDgyNWE5YzRiMDY3YTgnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdz
ZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAn
RVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAn
REVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2Nj
YWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92
YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1oano4
ZWxtby9zcmMvZG9ja2VyLXNyYy4yMDE5LTEwLTE2LTE1LjE3LjM3LjE2MzA3Oi92YXIvdG1wL3Fl
bXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LW1pbmd3
J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJl
bD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTJlMzU5YzRiN2IwZjQwM2NhMTQ4MjVhOWM0YjA2N2E4
Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVj
dG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWhqejhlbG1vL3NyYycKbWFrZTogKioq
IFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDJtMTIuOTAx
cwp1c2VyICAgIDBtNy43MDhzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8v
cGF0Y2hldy5vcmcvbG9ncy8xNTcxMjQzMzMzLTg4MjMwMi0xLWdpdC1zZW5kLWVtYWlsLWFuZHJl
eS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90
eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t



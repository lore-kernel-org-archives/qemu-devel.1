Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2458C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 01:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ACBC2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 01:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACBC2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbwqh-0004nq-QS
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 21:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbwq2-0003KI-Bg
 for qemu-devel@nongnu.org; Thu, 21 May 2020 21:51:06 -0400
Resent-Date: Thu, 21 May 2020 21:51:06 -0400
Resent-Message-Id: <E1jbwq2-0003KI-Bg@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbwq0-0005hi-MS
 for qemu-devel@nongnu.org; Thu, 21 May 2020 21:51:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590112227; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZmsM3LlZGI/HiPGa+dXA0YqKgC9fzgfVkMyaST7zdQk8vq9KHbjVREDeeoB/e3lwVUs3VG+3equsRG6vFQ/X8PXM4MwzU40JLcQJksXDVfPwqUAqZhrcBMTyHo4xocxNWLJipEYTwMokTMHMFK5slWjo0DRR4B49gkhLViYxan4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590112227;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=WUrAZp56bxgcrJe1rzeF6CWyeoavfGAZwLbab3rP7AY=; 
 b=OVP4uhaekuiFM7x29WCz1qFYMq8Yq3EeTXmXyZ2Xazf+adI9lhat6UqbPEytV365T5jepvEnnXgwzFSox/t5Q1iTCuxKjsIpAjz2du1T4b6WHclxcsNKgBt1D2njI0ZBzA9SqgmcOYDYxu+ELchZRLItrlf8fN4XGAZfF8E9V/Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590112225535512.814736600939;
 Thu, 21 May 2020 18:50:25 -0700 (PDT)
Message-ID: <159011222425.1576.2239862082893996188@45ef0f9c86ae>
In-Reply-To: <cover.1590089984.git.balaton@eik.bme.hu>
Subject: Re: [PATCH v2 0/7] Misc display/sm501 clean ups and fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: balaton@eik.bme.hu
Date: Thu, 21 May 2020 18:50:25 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 21:51:00
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, mail@sebastianbauer.info, magnus.damm@gmail.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTkwMDg5OTg0Lmdp
dC5iYWxhdG9uQGVpay5ibWUuaHUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0
IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBURVNUICAgIGlvdGVzdC1xY293
MjogMDM5CnNvY2tldF9hY2NlcHQgZmFpbGVkOiBSZXNvdXJjZSB0ZW1wb3JhcmlseSB1bmF2YWls
YWJsZQoqKgpFUlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvcXRlc3QvbGlicXRlc3QuYzoz
MDE6cXRlc3RfaW5pdF93aXRob3V0X3FtcF9oYW5kc2hha2U6IGFzc2VydGlvbiBmYWlsZWQ6IChz
LT5mZCA+PSAwICYmIHMtPnFtcF9mZCA+PSAwKQovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvcXRl
c3QvbGlicXRlc3QuYzoxNjY6IGtpbGxfcWVtdSgpIHRyaWVkIHRvIHRlcm1pbmF0ZSBRRU1VIHBy
b2Nlc3MgYnV0IGVuY291bnRlcmVkIGV4aXQgc3RhdHVzIDEgKGV4cGVjdGVkIDApCkVSUk9SIC0g
QmFpbCBvdXQhIEVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9saWJxdGVzdC5j
OjMwMTpxdGVzdF9pbml0X3dpdGhvdXRfcW1wX2hhbmRzaGFrZTogYXNzZXJ0aW9uIGZhaWxlZDog
KHMtPmZkID49IDAgJiYgcy0+cW1wX2ZkID49IDApCm1ha2U6ICoqKiBbY2hlY2stcXRlc3QteDg2
XzY0XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAg
VEVTVCAgICBpb3Rlc3QtcWNvdzI6IDA0MApxZW11LXN5c3RlbS1hYXJjaDY0OiAtYWNjZWwga3Zt
OiBpbnZhbGlkIGFjY2VsZXJhdG9yIGt2bQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJv
cihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdb
J3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3Rh
bmNlLnV1aWQ9NDE2MDJkZjZjZmZjNDgxNmIzZWJhMGUzNzZjMTAwOTknLCAnLXUnLCAnMTAwMScs
ICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdU
QVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9Jywg
Jy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAn
Q0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUv
cWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3Bh
dGNoZXctdGVzdGVyLXRtcC1vYXJ1ZzZmby9zcmMvZG9ja2VyLXNyYy4yMDIwLTA1LTIxLTIxLjM0
LjIzLjg1NDk6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9x
ZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIu
CmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTQxNjAyZGY2Y2Zm
YzQ4MTZiM2ViYTBlMzc2YzEwMDk5Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQpt
YWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLW9h
cnVnNmZvL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJy
b3IgMgoKcmVhbCAgICAxNm0wLjg3NnMKdXNlciAgICAwbTEwLjc4M3MKCgpUaGUgZnVsbCBsb2cg
aXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzL2NvdmVyLjE1OTAwODk5ODQu
Z2l0LmJhbGF0b25AZWlrLmJtZS5odS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t


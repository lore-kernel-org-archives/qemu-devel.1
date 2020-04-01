Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D2DC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 18:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB9A206F5
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 18:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB9A206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJiZb-00067O-Rz
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 14:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jJiYh-0005Rx-Tm
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jJiYf-0008Q5-Q0
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:57:51 -0400
Resent-Date: Wed, 01 Apr 2020 14:57:51 -0400
Resent-Message-Id: <E1jJiYf-0008Q5-Q0@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jJiYf-0008ML-Dp
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:57:49 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585767459; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bww6XKZSHxiYOCpMGG9/SfITPNoXVh+4aoz/f7LAi/5xHMzrROz4wsTAHO7bsrCyi0vmiAth05wtcgQr5GSG2NtMfObQCIP5sjEbemIjMlD6Zer0jC1NkwLdExUsccssRb/xw4f406dz3sQrEa3x4nJYOMbNrKC30O+vN/99mSw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585767459;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=8IWn1p2z4FGjx/V8STmdpEQqouaTxkuRYM+Qve43m28=; 
 b=BwrBMQaeU2i0bMk4bSF+XNUPahQosECTLOrZyczm7TbQ86dFWdjTeiU/JEi7ZoKVCYz+FG1YaDILvldkYcwwV0XC2P/ZJrm0Un8MmXRzondqw0SSeOTodTaHZHJrhPwX+i11WWm6UZvC9yHpatEw449ZEM2s5cfwh+dMVP5xDMY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585767454838797.4085111117812;
 Wed, 1 Apr 2020 11:57:34 -0700 (PDT)
In-Reply-To: <20200401162023.GA15912@simran-Inspiron-5558>
Subject: Re: [PATCH] lockable: Replace locks with lock guard macros
Message-ID: <158576745359.20436.14792001046810935798@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: singhalsimran0@gmail.com
Date: Wed, 1 Apr 2020 11:57:34 -0700 (PDT)
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
Cc: stefanha@gmail.com, jusual@mail.ru, qemu-devel@nongnu.org,
 yuval.shaia.ml@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwMTE2MjAyMy5HQTE1
OTEyQHNpbXJhbi1JbnNwaXJvbi01NTU4LwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
YXNhbiBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhl
aXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHBy
b2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9
MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElT
VD14ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
ICBDQyAgICAgIHg4Nl82NC1zb2Z0bW11L2h3L2kzODYveDg2Lm8KICBDQyAgICAgIHg4Nl82NC1z
b2Z0bW11L2h3L2kzODYvcGMubwogIENDICAgICAgeDg2XzY0LXNvZnRtbXUvaHcvaTM4Ni9wY19z
eXNmdy5vCi90bXAvcWVtdS10ZXN0L3NyYy9ody9yZG1hL3JkbWFfdXRpbHMuYzo3NDo1OiBlcnJv
cjogdW51c2VkIHZhcmlhYmxlICdxZW11X2xvY2thYmxlX2F1dG9fX0NPVU5URVJfXycgWy1XZXJy
b3IsLVd1bnVzZWQtdmFyaWFibGVdCiAgICBRRU1VX0xPQ0tfR1VBUkQoJmxpc3QtPmxvY2spOwog
ICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9xZW11L2xvY2thYmxlLmg6MTczOjI5OiBu
b3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvICdRRU1VX0xPQ0tfR1VBUkQnCi0tLQo8c2NyYXRjaCBz
cGFjZT46MTk0OjE6IG5vdGU6IGV4cGFuZGVkIGZyb20gaGVyZQpxZW11X2xvY2thYmxlX2F1dG9f
X0NPVU5URVJfXwpeCi90bXAvcWVtdS10ZXN0L3NyYy9ody9yZG1hL3JkbWFfdXRpbHMuYzoxMDk6
NTogZXJyb3I6IHVudXNlZCB2YXJpYWJsZSAncWVtdV9sb2NrYWJsZV9hdXRvX19DT1VOVEVSX18n
IFstV2Vycm9yLC1XdW51c2VkLXZhcmlhYmxlXQogICAgUUVNVV9MT0NLX0dVQVJEKCZsaXN0LT5s
b2NrKTsKICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvcWVtdS9sb2NrYWJsZS5oOjE3
MzoyOTogbm90ZTogZXhwYW5kZWQgZnJvbSBtYWNybyAnUUVNVV9MT0NLX0dVQVJEJwotLS0KPHNj
cmF0Y2ggc3BhY2U+OjIwNzoxOiBub3RlOiBleHBhbmRlZCBmcm9tIGhlcmUKcWVtdV9sb2NrYWJs
ZV9hdXRvX19DT1VOVEVSX18KXgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvcmRtYS9yZG1hX3V0aWxz
LmM6MTE2OjU6IGVycm9yOiB1bnVzZWQgdmFyaWFibGUgJ3FlbXVfbG9ja2FibGVfYXV0b19fQ09V
TlRFUl9fJyBbLVdlcnJvciwtV3VudXNlZC12YXJpYWJsZV0KICAgIFFFTVVfTE9DS19HVUFSRCgm
bGlzdC0+bG9jayk7CiAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL3FlbXUvbG9ja2Fi
bGUuaDoxNzM6Mjk6IG5vdGU6IGV4cGFuZGVkIGZyb20gbWFjcm8gJ1FFTVVfTE9DS19HVUFSRCcK
LS0tCnFlbXVfbG9ja2FibGVfYXV0b19fQ09VTlRFUl9fCl4KMyBlcnJvcnMgZ2VuZXJhdGVkLgpt
YWtlWzFdOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IGh3L3JkbWEvcmRt
YV91dGlscy5vXSBFcnJvciAxCm1ha2VbMV06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpv
YnMuLi4uCiAgQ0MgICAgICB4ODZfNjQtc29mdG1tdS9ody9pMzg2L3BjX3BpaXgubwovdG1wL3Fl
bXUtdGVzdC9zcmMvaHcvaHlwZXJ2L2h5cGVydi5jOjQ5NTo1OiBlcnJvcjogdW51c2VkIHZhcmlh
YmxlICdxZW11X2xvY2thYmxlX2F1dG9fX0NPVU5URVJfXycgWy1XZXJyb3IsLVd1bnVzZWQtdmFy
aWFibGVdCiAgICBRRU1VX0xPQ0tfR1VBUkQoJmhhbmRsZXJzX211dGV4KTsKICAgIF4KL3RtcC9x
ZW11LXRlc3Qvc3JjL2luY2x1ZGUvcWVtdS9sb2NrYWJsZS5oOjE3MzoyOTogbm90ZTogZXhwYW5k
ZWQgZnJvbSBtYWNybyAnUUVNVV9MT0NLX0dVQVJEJwotLS0KPHNjcmF0Y2ggc3BhY2U+OjI0OjE6
IG5vdGU6IGV4cGFuZGVkIGZyb20gaGVyZQpxZW11X2xvY2thYmxlX2F1dG9fX0NPVU5URVJfXwpe
Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9oeXBlcnYvaHlwZXJ2LmM6NTY4OjU6IGVycm9yOiB1bnVz
ZWQgdmFyaWFibGUgJ3FlbXVfbG9ja2FibGVfYXV0b19fQ09VTlRFUl9fJyBbLVdlcnJvciwtV3Vu
dXNlZC12YXJpYWJsZV0KICAgIFFFTVVfTE9DS19HVUFSRCgmaGFuZGxlcnNfbXV0ZXgpOwogICAg
XgovdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9xZW11L2xvY2thYmxlLmg6MTczOjI5OiBub3Rl
OiBleHBhbmRlZCBmcm9tIG1hY3JvICdRRU1VX0xPQ0tfR1VBUkQnCi0tLQpxZW11X2xvY2thYmxl
X2F1dG9fX0NPVU5URVJfXwpeCjIgZXJyb3JzIGdlbmVyYXRlZC4KbWFrZVsxXTogKioqIFsvdG1w
L3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBody9oeXBlcnYvaHlwZXJ2Lm9dIEVycm9yIDEK
L3RtcC9xZW11LXRlc3Qvc3JjL2h3L3JkbWEvcmRtYV9ybS5jOjE1MDo1OiBlcnJvcjogdW51c2Vk
IHZhcmlhYmxlICdxZW11X2xvY2thYmxlX2F1dG9fX0NPVU5URVJfXycgWy1XZXJyb3IsLVd1bnVz
ZWQtdmFyaWFibGVdCiAgICBRRU1VX0xPQ0tfR1VBUkQoJnRibC0+bG9jayk7CiAgICBeCi90bXAv
cWVtdS10ZXN0L3NyYy9pbmNsdWRlL3FlbXUvbG9ja2FibGUuaDoxNzM6Mjk6IG5vdGU6IGV4cGFu
ZGVkIGZyb20gbWFjcm8gJ1FFTVVfTE9DS19HVUFSRCcKLS0tCnFlbXVfbG9ja2FibGVfYXV0b19f
Q09VTlRFUl9fCl4KMSBlcnJvciBnZW5lcmF0ZWQuCm1ha2VbMV06ICoqKiBbL3RtcC9xZW11LXRl
c3Qvc3JjL3J1bGVzLm1hazo2OTogaHcvcmRtYS9yZG1hX3JtLm9dIEVycm9yIDEKbWFrZTogKioq
IFtNYWtlZmlsZTo1Mjc6IHg4Nl82NC1zb2Z0bW11L2FsbF0gRXJyb3IgMgpUcmFjZWJhY2sgKG1v
c3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5Iiwg
bGluZSA2NjQsIGluIDxtb2R1bGU+CiAgICBzeXMuZXhpdChtYWluKCkpCi0tLQogICAgcmFpc2Ug
Q2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNz
RXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwn
LCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1kOTMwNjc2MDMwOTM0YzFmYmI1ZTQ1ZmNmZDM0Nzk0
OScsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcs
ICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPXg4Nl82NC1zb2Z0bW11JywgJy1lJywgJ0VYVFJB
X0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVH
PScsICctZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUn
LCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1w
L2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1pZTlfZ24xZy9z
cmMvZG9ja2VyLXNyYy4yMDIwLTA0LTAxLTE0LjUzLjI3LjIzODc2Oi92YXIvdG1wL3FlbXU6eixy
bycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LWRlYnVnJ10nIHJl
dHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20u
cWVtdS5pbnN0YW5jZS51dWlkPWQ5MzA2NzYwMzA5MzRjMWZiYjVlNDVmY2ZkMzQ3OTQ5Cm1ha2Vb
MV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBg
L3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWllOV9nbjFnL3NyYycKbWFrZTogKioqIFtkb2Nr
ZXItcnVuLXRlc3QtZGVidWdAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDRtNy40MTVzCnVzZXIg
ICAgMG04LjQzN3MKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3
Lm9yZy9sb2dzLzIwMjAwNDAxMTYyMDIzLkdBMTU5MTJAc2ltcmFuLUluc3Bpcm9uLTU1NTgvdGVz
dGluZy5hc2FuLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


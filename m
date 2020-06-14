Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB6EC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 04:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 499C42065D
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 04:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499C42065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkK2A-0006qg-JH
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 00:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jkK1e-0006Qw-Iu
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 00:13:42 -0400
Resent-Date: Sun, 14 Jun 2020 00:13:42 -0400
Resent-Message-Id: <E1jkK1e-0006Qw-Iu@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jkK1b-0000aa-Eh
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 00:13:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592107987; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cHnkWbgO5s7DqorXQEwVqe16AgaHcGtQ0OtUZVA8xJCdaHKhgANxKfuzqpITVc6tFVeRUAXytoK/hI8b6/O+Cc8Sj1WCfWCVuaFkCGxkdQQzFpDTvSqtxZa0l86ah4Q/MCEexY1UXH4sMwOdDi+qzulfF7T6BLRyKi8LNWZf7QM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592107987;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=H8zQORow9sHbvASIxiOt5zievZ71Uv+NZ6a+dWcwH5I=; 
 b=L7PXy3P7FkXDcf7f+doRcETIOqw8x9NY4xrzzTKgaBkgex4DEDEFpK30HQ4IqD4JJrJJNuuoQzDs0QeVIQ6ZFtFKSbwbgUJGn/JVJ3DSguINA+zWPFEoEE3ZQMHWQa6lZne4Cf5rJPhb62Wj4uXa2RzvIxDgF/CLg+iagfQ/smY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1592107985511860.0064435429799;
 Sat, 13 Jun 2020 21:13:05 -0700 (PDT)
Message-ID: <159210798411.19484.323273319749283590@45ef0f9c86ae>
In-Reply-To: <20200614034729.3004-1-jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] target/mips: Fix PageMask with variable page size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jiaxun.yang@flygoat.com
Date: Sat, 13 Jun 2020 21:13:05 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 23:24:32
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: aurelien@aurel32.net, aleksandar.qemu.devel@gmail.com,
 aleksandar.rikalo@syrmia.com, jiaxun.yang@flygoat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxNDAzNDcyOS4zMDA0
LTEtamlheHVuLnlhbmdAZmx5Z29hdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGlu
ZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5z
dGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9
MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9
MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKKysrIC90bXAvcWVtdS10
ZXN0L2J1aWxkL3Rlc3RzL3FlbXUtaW90ZXN0cy8wNDEub3V0LmJhZCAyMDIwLTA2LTE0IDA0OjA2
OjI4LjkyNTI1NzA3OCArMDAwMApAQCAtMSw1ICsxLDMwIEBACi0uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLgorV0FSTklORzpxZW11Lm1hY2hpbmU6cWVtdSBy
ZWNlaXZlZCBzaWduYWwgOTogL3RtcC9xZW11LXRlc3QvYnVpbGQvdGVzdHMvcWVtdS1pb3Rlc3Rz
Ly4uLy4uL3g4Nl82NC1zb2Z0bW11L3FlbXUtc3lzdGVtLXg4Nl82NCAtZGlzcGxheSBub25lIC12
Z2Egbm9uZSAtY2hhcmRldiBzb2NrZXQsaWQ9bW9uLHBhdGg9L3RtcC90bXAuVHBZd3RwOThobi9x
ZW11LTIxODEwLW1vbml0b3Iuc29jayAtbW9uIGNoYXJkZXY9bW9uLG1vZGU9Y29udHJvbCAtcXRl
c3QgdW5peDpwYXRoPS90bXAvdG1wLlRwWXd0cDk4aG4vcWVtdS0yMTgxMC1xdGVzdC5zb2NrIC1h
Y2NlbCBxdGVzdCAtbm9kZWZhdWx0cyAtZGlzcGxheSBub25lIC1hY2NlbCBxdGVzdCAtZHJpdmUg
aWY9dmlydGlvLGlkPWRyaXZlMCxmaWxlPS90bXAvcWVtdS10ZXN0L3Rlc3QuaW1nLGZvcm1hdD1x
Y293MixjYWNoZT13cml0ZWJhY2ssYWlvPXRocmVhZHMsbm9kZS1uYW1lPXRvcCxiYWNraW5nLm5v
ZGUtbmFtZT1iYXNlIC1kcml2ZSBpZj1pZGUsaWQ9ZHJpdmUxLG1lZGlhPWNkcm9tCisuLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi5FLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLgorPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQor
RVJST1I6IHRlc3RfcGF1c2UgKF9fbWFpbl9fLlRlc3RTaW5nbGVEcml2ZSkKKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KK1RyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKKyAgRmlsZSAiMDQxIiwgbGlu
ZSAxMDgsIGluIHRlc3RfcGF1c2UKLS0tCiBSYW4gMTA0IHRlc3RzCiAKLU9LCitGQUlMRUQgKGVy
cm9ycz0xKQogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAwNDIKICBURVNUICAgIGlvdGVzdC1xY293
MjogMDQzCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDA0NgotLS0KTm90IHJ1bjogMjU5CkZhaWx1
cmVzOiAwNDEKRmFpbGVkIDEgb2YgMTE5IGlvdGVzdHMKbWFrZTogKioqIFtjaGVjay10ZXN0cy9j
aGVjay1ibG9jay5zaF0gRXJyb3IgMQpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6
CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjksIGluIDxtb2R1bGU+
CiAgICBzeXMuZXhpdChtYWluKCkpCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJl
dGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3Vk
bycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2Uu
dXVpZD02ZjIyYjNkM2YxNDQ0YzEwOThhNjI4NjUyMzljM2I5OCcsICctdScsICcxMDAzJywgJy0t
c2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdF
VF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUn
LCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FD
SEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVt
dS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNo
ZXctdGVzdGVyLXRtcC01ZGkwMngyXy9zcmMvZG9ja2VyLXNyYy4yMDIwLTA2LTEzLTIzLjU1LjQ5
LjUyNDY6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11
L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZp
bHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTZmMjJiM2QzZjE0NDRj
MTA5OGE2Mjg2NTIzOWMzYjk4Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtl
WzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTVkaTAy
eDJfL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3Ig
MgoKcmVhbCAgICAxN20xNC41OTdzCnVzZXIgICAgMG04LjE5MnMKCgpUaGUgZnVsbCBsb2cgaXMg
YXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNjE0MDM0NzI5LjMwMDQt
MS1qaWF4dW4ueWFuZ0BmbHlnb2F0LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90
eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t


Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2701DC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 08:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9A32083D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 08:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9A32083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48688 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfKAa-0004AH-6G
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 04:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36878)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hfK9L-0003ie-CQ
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 04:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hfK9J-0003Q4-TE
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 04:16:27 -0400
Resent-Date: Mon, 24 Jun 2019 04:16:27 -0400
Resent-Message-Id: <E1hfK9J-0003Q4-TE@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21403)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hfK9J-0003Ll-KV
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 04:16:25 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561364166; cv=none; d=zoho.com; s=zohoarc; 
 b=OpVxb4k9LvQPOlK78xXRsjdRTWjZbaio9Gmaxmxme6TjUrfL9CUOtrKxdFC+C4kPKgbTHAqoZbeAkr0JYXCEHMdI8ALk+AyrTrrF7aSHaun3bVXh++33dSrS6mgzwilE3+IiPB7pMbCOZ1mz/xm5BliqGjnzNoR0XiS0h1whv9E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561364166;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=LQZJ9Ic0Aq2pSskShpP4ez9E82EEwQt97aX+Ipp3vpU=; 
 b=YD6Qxe/V4B1OjAZAtFqxr0xWUPvWC5wzxf2xfqOswfnB9jcX+0OAGKpeOZ0sYP+JDn5Tz1sbTe+SN4toqdu1PR7v6pStzj4dItCetVPbZaGm0yHvcFjHj+QyBN6as11FWaTGQFtQG/dstJ4AZeiFXqeNBegci5FWCd+04XTp9E4=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561364164528922.7889256217694;
 Mon, 24 Jun 2019 01:16:04 -0700 (PDT)
In-Reply-To: <20190624070339.4408-1-david.brenken@efs-auto.org>
Message-ID: <156136416355.4070.2439554148159918154@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: david.brenken@efs-auto.org
Date: Mon, 24 Jun 2019 01:16:04 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v3 0/5] tricore: adding new instructions
 and fixing
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
Cc: kbastian@mail.uni-paderborn.de, david.brenken@efs-auto.de,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYyNDA3MDMzOS40NDA4
LTEtZGF2aWQuYnJlbmtlbkBlZnMtYXV0by5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVk
IGJ1aWxkIHRlc3Qgb24gczM5MHggaG9zdC4gUGxlYXNlIGZpbmQgdGhlIGRldGFpbHMgYmVsb3cu
Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCiMgVGVzdGluZyBzY3JpcHQg
d2lsbCBiZSBpbnZva2VkIHVuZGVyIHRoZSBnaXQgY2hlY2tvdXQgd2l0aAojIEhFQUQgcG9pbnRp
bmcgdG8gYSBjb21taXQgdGhhdCBoYXMgdGhlIHBhdGNoZXMgYXBwbGllZCBvbiB0b3Agb2YgImJh
c2UiCiMgYnJhbmNoCnNldCAtZQpDQz0kSE9NRS9iaW4vY2MKSU5TVEFMTD0kUFdEL2luc3RhbGwK
QlVJTEQ9JFBXRC9idWlsZApta2RpciAtcCAkQlVJTEQgJElOU1RBTEwKU1JDPSRQV0QKY2QgJEJV
SUxECiRTUkMvY29uZmlndXJlIC0tY2M9JENDIC0tcHJlZml4PSRJTlNUQUxMCm1ha2UgLWo0CiMg
WFhYOiB3ZSBuZWVkIHJlbGlhYmxlIGNsZWFuIHVwCiMgbWFrZSBjaGVjayAtajQgVj0xCm1ha2Ug
aW5zdGFsbAoKZWNobwplY2hvICI9PT0gRU5WID09PSIKZW52CgplY2hvCmVjaG8gIj09PSBQQUNL
QUdFUyA9PT0iCnJwbSAtcWEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICB1bmlj
b3JlMzItc29mdG1tdS9xYXBpL3FhcGktY29tbWFuZHMubwogIENDICAgICAgc3BhcmMtc29mdG1t
dS9taWdyYXRpb24vcmFtLm8KL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWhnZWZ2a2VsL3Ny
Yy90YXJnZXQvdHJpY29yZS9mcHVfaGVscGVyLmM6IEluIGZ1bmN0aW9uIOKAmGhlbHBlcl9xc2Vl
ZOKAmToKL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWhnZWZ2a2VsL3NyYy90YXJnZXQvdHJp
Y29yZS9mcHVfaGVscGVyLmM6MjQzOjk6IGVycm9yOiB0b28gZmV3IGFyZ3VtZW50cyB0byBmdW5j
dGlvbiDigJhmbG9hdDMyX2lzX3NpZ25hbGluZ19uYW7igJkKICAyNDMgfCAgICAgaWYgKGZsb2F0
MzJfaXNfc2lnbmFsaW5nX25hbihhcmcxKSB8fCByZXN1bHQgPT0gZmxvYXQzMl9zcXJ0X25hbikg
ewogICAgICB8ICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CkluIGZpbGUgaW5jbHVk
ZWQgZnJvbSAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtaGdlZnZrZWwvc3JjL3RhcmdldC90
cmljb3JlL2ZwdV9oZWxwZXIuYzoyMzoKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNjI0MDcwMzM5LjQ0MDgtMS1kYXZpZC5icmVua2Vu
QGVmcy1hdXRvLm9yZy90ZXN0aW5nLnMzOTB4Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t



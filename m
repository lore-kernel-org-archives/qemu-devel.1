Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B36C48BE4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 19:30:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 029A7208E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 19:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029A7208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hga6C-0003To-Ou
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 15:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32936)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hga5T-0002S1-LL
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 15:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hga5R-0005qT-Uq
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 15:29:39 -0400
Resent-Date: Thu, 27 Jun 2019 15:29:39 -0400
Resent-Message-Id: <E1hga5R-0005qT-Uq@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21497)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hga5R-0005n7-FQ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 15:29:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561663737; cv=none; d=zoho.com; s=zohoarc; 
 b=cBoCUobWcoyXB4hWOCMFlnOOWd5loMtLBltZjwp4RYutb2+dZm0ksdc4zHqWCKyC7hLk8P8VGEh39PHW+dV46Whm+b50QryCMhBYJ1bPFLG3kmeeDHEqcGuoRopB3MuROr+YzzR9tBKEst30E8zL2JJP6ELm3eKy4H1kAQmwChw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561663737;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=j7F61vetC5dZ6zEvD0QKldB0LEMLiKeoDQhkK21EXZU=; 
 b=SJQo1ab+kvHQvOVwkd78BUZ//ndA0QbjpwpCPEy6r1rzADj8xsBqJKAT1lVsWOxwSZudXyqz8PphftXhtogP9FETLvDErhnmNdCR5z901E+WWyGZb9duerkxwyj2yK1XWU1w6vix1gp/4ug71Bewu/ZU8oXClvBD5wMdOLe4654=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561663654833234.58813337985248;
 Thu, 27 Jun 2019 12:27:34 -0700 (PDT)
Message-ID: <156166365360.6332.12789669195894130027@c4a48874b076>
In-Reply-To: <1561648298-18100-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Thu, 27 Jun 2019 12:27:34 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v13 0/5] linux-user: A set of miscellaneous
 patches
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
Cc: qemu-devel@nongnu.org, amarkovic@wavecomp.com, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYxNjQ4Mjk4LTE4MTAwLTEt
Z2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20vCgoKCkhpLAoKVGhp
cyBzZXJpZXMgZmFpbGVkIGJ1aWxkIHRlc3Qgb24gczM5MHggaG9zdC4gUGxlYXNlIGZpbmQgdGhl
IGRldGFpbHMgYmVsb3cuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCiMg
VGVzdGluZyBzY3JpcHQgd2lsbCBiZSBpbnZva2VkIHVuZGVyIHRoZSBnaXQgY2hlY2tvdXQgd2l0
aAojIEhFQUQgcG9pbnRpbmcgdG8gYSBjb21taXQgdGhhdCBoYXMgdGhlIHBhdGNoZXMgYXBwbGll
ZCBvbiB0b3Agb2YgImJhc2UiCiMgYnJhbmNoCnNldCAtZQpDQz0kSE9NRS9iaW4vY2MKSU5TVEFM
TD0kUFdEL2luc3RhbGwKQlVJTEQ9JFBXRC9idWlsZApta2RpciAtcCAkQlVJTEQgJElOU1RBTEwK
U1JDPSRQV0QKY2QgJEJVSUxECiRTUkMvY29uZmlndXJlIC0tY2M9JENDIC0tcHJlZml4PSRJTlNU
QUxMCm1ha2UgLWo0CiMgWFhYOiB3ZSBuZWVkIHJlbGlhYmxlIGNsZWFuIHVwCiMgbWFrZSBjaGVj
ayAtajQgVj0xCm1ha2UgaW5zdGFsbAoKZWNobwplY2hvICI9PT0gRU5WID09PSIKZW52CgplY2hv
CmVjaG8gIj09PSBQQUNLQUdFUyA9PT0iCnJwbSAtcWEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0K
CiAgQ0MgICAgICBpMzg2LWxpbnV4LXVzZXIvbGludXgtdXNlci91bmFtZS5vCiAgQ0NBUyAgICBp
Mzg2LWxpbnV4LXVzZXIvbGludXgtdXNlci9zYWZlLXN5c2NhbGwubwogIENDICAgICAgaTM4Ni1s
aW51eC11c2VyL2xpbnV4LXVzZXIvaTM4Ni9zaWduYWwubwovdmFyL3RtcC9wYXRjaGV3LXRlc3Rl
ci10bXAtenFocWE5NXkvc3JjL2xpbnV4LXVzZXIvc3lzY2FsbC5jOjMyMzoxNjogZXJyb3I6IGNv
bmZsaWN0aW5nIHR5cGVzIGZvciDigJhzdGF0eOKAmQogIDMyMyB8IF9zeXNjYWxsNShpbnQsIHN0
YXR4LCBpbnQsIGRpcmZkLCBjb25zdCBjaGFyICosIHBhdGhuYW1lLCBpbnQsIGZsYWdzLAogICAg
ICB8ICAgICAgICAgICAgICAgIF5+fn5+Ci92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC16cWhx
YTk1eS9zcmMvbGludXgtdXNlci9zeXNjYWxsLmM6MjE0OjEzOiBub3RlOiBpbiBkZWZpbml0aW9u
IG9mIG1hY3JvIOKAmF9zeXNjYWxsNeKAmQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQK
aHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU2MTY0ODI5OC0xODEwMC0xLWdpdC1zZW5kLWVtYWls
LWFsZWtzYW5kYXIubWFya292aWNAcnQtcmsuY29tL3Rlc3RpbmcuczM5MHgvP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20=



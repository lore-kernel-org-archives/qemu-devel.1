Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE381C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:35:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94695229F3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94695229F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfmU-0008Uj-SA
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49441)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hqfjb-0006cm-Df
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:32:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hqfjX-0002Ze-H8
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:32:47 -0400
Resent-Date: Thu, 25 Jul 2019 11:32:45 -0400
Resent-Message-Id: <E1hqfjX-0002Ze-H8@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21441)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hqfjW-0002Z6-VX
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:32:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1564068759; cv=none; d=zoho.com; s=zohoarc; 
 b=NfvXR4bEtuAzQZh0o6ndecTFT/99GCwpZ2aQmKm0qFjLiRXIbIQq0JbbfwPWpEgL00u9G9Jnp4qM5c1Ox7j/cQxdF3IDmra2t2YIEABM0ADv47AoE0ZLL7lFSc2RA9WaEc2WDNkbCo0S+c29fZXUQngNAq8Qc+lmE0ALrH+8i7s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1564068759;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=QyrQudK3/09trn47SKOicSkzgLnsmoRmBf9GhFRUiC4=; 
 b=jkfaKnNEdKjMiL+wuTrDkcCT70xA/fikf95v7MlI7G3xekKknUH2SMxaAkiAp7PUnnXadKd4wEVAyozMgo1JCjhlMzi0DAb9csf44y3w6KLB1jIctecy0NjwPZ75ArGW+sICBc0uc1BhSztPuJy0jbRJaawimuAhrAbsCxN623U=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 156406875727917.065832133988124;
 Thu, 25 Jul 2019 08:32:37 -0700 (PDT)
Message-ID: <156406875620.22819.17066044136128599992@c4a48874b076>
In-Reply-To: <20190725150832.1180275-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: stefanb@linux.vnet.ibm.com
Date: Thu, 25 Jul 2019 08:32:37 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v2 0/2] tpm: Improve on error handling
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 stefanb@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcyNTE1MDgzMi4xMTgw
Mjc1LTEtc3RlZmFuYkBsaW51eC52bmV0LmlibS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpTdWJqZWN0OiBbUWVtdS1kZXZlbF0g
W1BBVENIIHYyIDAvMl0gdHBtOiBJbXByb3ZlIG9uIGVycm9yIGhhbmRsaW5nCk1lc3NhZ2UtaWQ6
IDIwMTkwNzI1MTUwODMyLjExODAyNzUtMS1zdGVmYW5iQGxpbnV4LnZuZXQuaWJtLmNvbQoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAv
ZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFj
ayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4
NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKZmF0YWw6IGdpdCBmZXRjaF9wYWNrOiBleHBlY3Rl
ZCBBQ0svTkFLLCBnb3QgJ0VSUiB1cGxvYWQtcGFjazogbm90IG91ciByZWYgOWMzZTRlMmM2ZDgz
ZTI0NGUyMTM2YTZjZGQ1YTI4MzBiYWQ4MmNhMycKZmF0YWw6IFRoZSByZW1vdGUgZW5kIGh1bmcg
dXAgdW5leHBlY3RlZGx5CmVycm9yOiBDb3VsZCBub3QgZmV0Y2ggM2M4Y2Y1YTljMjFmZjg3ODIx
NjRkMWRlZjdmNDRiZDg4ODcxMzM4NApUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6
CiAgRmlsZSAiLi9wYXRjaGV3LWNsaSIsIGxpbmUgNTA0LCBpbiB0ZXN0X29uZQogICAgZ2l0X2Ns
b25lX3JlcG8oY2xvbmUsIHJbInJlcG8iXSwgclsiaGVhZCJdLCBsb2dmKQogIEZpbGUgIi4vcGF0
Y2hldy1jbGkiLCBsaW5lIDQ4LCBpbiBnaXRfY2xvbmVfcmVwbwogICAgc3Rkb3V0PWxvZ2YsIHN0
ZGVycj1sb2dmKQogIEZpbGUgIi91c3IvbGliNjQvcHl0aG9uMy40L3N1YnByb2Nlc3MucHkiLCBs
aW5lIDU1OCwgaW4gY2hlY2tfY2FsbAogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNv
ZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snZ2l0Jywg
J3JlbW90ZScsICdhZGQnLCAnLWYnLCAnLS1taXJyb3I9ZmV0Y2gnLCAnM2M4Y2Y1YTljMjFmZjg3
ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NCcsICdodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1w
cm9qZWN0L3FlbXUnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMQoKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNzI1MTUw
ODMyLjExODAyNzUtMS1zdGVmYW5iQGxpbnV4LnZuZXQuaWJtLmNvbS90ZXN0aW5nLmNoZWNrcGF0
Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=



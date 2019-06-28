Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D36DC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:40:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 252FD2086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252FD2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgs3Q-0004IF-3J
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 10:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43781)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hgs1Z-0002sB-51
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hgs1W-0005Yv-Qy
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:38:49 -0400
Resent-Date: Fri, 28 Jun 2019 10:38:48 -0400
Resent-Message-Id: <E1hgs1W-0005Yv-Qy@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21440)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hgs1V-0005XG-6r
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 10:38:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561690279; cv=none; d=zoho.com; s=zohoarc; 
 b=R1pDy+AermS7qgs+NWlvfNQ02Jnz+GhvL/ysKWpvnFiVinlLrnH5y0iGhg/tXBFKcRj48x7M0Pf9HcXIga5mOyfGXDvYFheD1bfOH0wKvWj1rc8RPoBYVQxMqnTOORzFrhGBlW98C0XTTQ7LxqFI6Wgm4AEW+BZ+Bkg1ew2182Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561690279;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=6UaHKpQ7r9uAgTZDcy2vO7YJN25gFqtkfnhj2H2bWv4=; 
 b=nPAa8Lhz/VUyluLzc9WFoaqCcXjbN3y+f0DYQmPpklOnMYA02sg//rV3amxvFC4r7zwBC1MK1KZxopI4tfLJ5SD6SH+wZXIk0ENfg/MTU+37JsF6HAxOeMkrVx+8wM1HilhvQ34vD69IeY18MUmhamDQ2l/wWRNqzclUEzSi9sM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561690187125936.8270204339346;
 Thu, 27 Jun 2019 19:49:47 -0700 (PDT)
Message-ID: <156169018571.6332.9317225427076483475@c4a48874b076>
In-Reply-To: <20190628015606.32107-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ehabkost@redhat.com
Date: Thu, 27 Jun 2019 19:49:47 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PULL 00/29] Machine next patches
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
Cc: peter.maydell@linaro.org, rth@twiddle.net, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYyODAxNTYwNi4zMjEw
Ny0xLWVoYWJrb3N0QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIGJ1aWxk
IHRlc3Qgb24gczM5MHggaG9zdC4gUGxlYXNlIGZpbmQgdGhlIGRldGFpbHMgYmVsb3cuCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCiMgVGVzdGluZyBzY3JpcHQgd2lsbCBi
ZSBpbnZva2VkIHVuZGVyIHRoZSBnaXQgY2hlY2tvdXQgd2l0aAojIEhFQUQgcG9pbnRpbmcgdG8g
YSBjb21taXQgdGhhdCBoYXMgdGhlIHBhdGNoZXMgYXBwbGllZCBvbiB0b3Agb2YgImJhc2UiCiMg
YnJhbmNoCnNldCAtZQpDQz0kSE9NRS9iaW4vY2MKSU5TVEFMTD0kUFdEL2luc3RhbGwKQlVJTEQ9
JFBXRC9idWlsZApta2RpciAtcCAkQlVJTEQgJElOU1RBTEwKU1JDPSRQV0QKY2QgJEJVSUxECiRT
UkMvY29uZmlndXJlIC0tY2M9JENDIC0tcHJlZml4PSRJTlNUQUxMCm1ha2UgLWo0CiMgWFhYOiB3
ZSBuZWVkIHJlbGlhYmxlIGNsZWFuIHVwCiMgbWFrZSBjaGVjayAtajQgVj0xCm1ha2UgaW5zdGFs
bAoKZWNobwplY2hvICI9PT0gRU5WID09PSIKZW52CgplY2hvCmVjaG8gIj09PSBQQUNLQUdFUyA9
PT0iCnJwbSAtcWEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCi92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC12Znc0c2E3OC9zcmMvdGFyZ2V0L3MzOTB4L2t2bS5jOjM2NzogdW5kZWZpbmVkIHJl
ZmVyZW5jZSB0byBgbWF4X2NwdXMnCi91c3IvYmluL2xkOiB0YXJnZXQvczM5MHgva3ZtLm86IGlu
IGZ1bmN0aW9uIGBrdm1fczM5MF92Y3B1X2ludGVycnVwdF9wcmVfc2F2ZSc6Ci92YXIvdG1wL3Bh
dGNoZXctdGVzdGVyLXRtcC12Znc0c2E3OC9zcmMvdGFyZ2V0L3MzOTB4L2t2bS5jOjE5NTM6IHVu
ZGVmaW5lZCByZWZlcmVuY2UgdG8gYG1heF9jcHVzJwpjb2xsZWN0MjogZXJyb3I6IGxkIHJldHVy
bmVkIDEgZXhpdCBzdGF0dXMKbWFrZVsxXTogKioqIFtNYWtlZmlsZToyMDU6IHFlbXUtc3lzdGVt
LXMzOTB4XSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6NDcyOiBzdWJkaXItczM5MHgtc29m
dG1tdV0gRXJyb3IgMgptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAx
OTA2MjgwMTU2MDYuMzIxMDctMS1laGFia29zdEByZWRoYXQuY29tL3Rlc3RpbmcuczM5MHgvP3R5
cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcg
W2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRj
aGV3LWRldmVsQHJlZGhhdC5jb20=



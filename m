Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54379C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 23:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 138D320774
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 23:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138D320774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6MKR-0002l5-6L
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 19:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6MJs-0002MU-I7
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 19:07:36 -0400
Resent-Date: Thu, 13 Aug 2020 19:07:36 -0400
Resent-Message-Id: <E1k6MJs-0002MU-I7@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6MJq-0007JK-8n
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 19:07:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597360048; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WhysP3NzKQDcYLQLYnOUnr+1cne5PT9TXtO8VnTk4IrsX862NutJeZVqrHDetWvYMwdYz5CNgWkBR/jZg2LVrEkGUxXT6ni1cOipwnfKsPFWRJIgmRqQ55rBMO1hI1ydt1EqbSoMAuv44Kokk0bAwdpjcPjvqSjHwAB8g1u47MY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597360048;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=MPsFB0Ho9XSa5ofGzJ7L04OfOfBE2bBqAjx0ldO3vLA=; 
 b=UzwY8Uhr0DmGvvWn1ZOmO6auh29zhctGPyhtcwYbYVk9pEZqRnaQ+R7plnHkRsb8xCEMV+u6ZfXsIgZngt1lsRZwfBsHuHrkbp/RYJKq4IaqlZa5IGU+lN9NiUGnOWrkr7LWoajh4edf7q0GqxFXBpXF9lX4ii/QSq3lPIW8J/U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597360045905794.3370801479635;
 Thu, 13 Aug 2020 16:07:25 -0700 (PDT)
Subject: Re: [PATCH 00/41] qom: Automated conversion of type checking
 boilerplate
Message-ID: <159736004490.30474.18322987546659397934@66eaa9a8a123>
In-Reply-To: <20200813222625.243136-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ehabkost@redhat.com
Date: Thu, 13 Aug 2020 16:07:25 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 19:01:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxMzIyMjYyNS4yNDMx
MzYtMS1laGFia29zdEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEg
TkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEg
Sj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBody9jaGFy
L2Ntc2RrLWFwYi11YXJ0Lm8KICBDQyAgICAgIGh3L2NoYXIvZGVidWdjb24ubwpJbiBmaWxlIGlu
Y2x1ZGVkIGZyb20gL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2NoYXIveGVuX2NvbnNvbGUuYzoyOTow
OgovdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9ody94ZW4veGVuLWxlZ2FjeS1iYWNrZW5kLmg6
MTM6MTogZXJyb3I6IHVua25vd24gdHlwZSBuYW1lICdYZW5MZWdhY3lEZXZpY2UnCiBERUNMQVJF
X0lOU1RBTkNFX0NIRUNLRVIoWGVuTGVnYWN5RGV2aWNlLCBYRU5CQUNLRU5EX0RFVklDRSwKIF4K
SW4gZmlsZSBpbmNsdWRlZCBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL2NoYXJkZXYv
Y2hhci5oOjc6MCwKICAgICAgICAgICAgICAgICBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9pbmNs
dWRlL2NoYXJkZXYvY2hhci1mZS5oOjQsCiAgICAgICAgICAgICAgICAgZnJvbSAvdG1wL3FlbXUt
dGVzdC9zcmMvaHcvY2hhci94ZW5fY29uc29sZS5jOjI4OgovdG1wL3FlbXUtdGVzdC9zcmMvaW5j
bHVkZS9ody94ZW4veGVuLWxlZ2FjeS1iYWNrZW5kLmg6IEluIGZ1bmN0aW9uICdYRU5CQUNLRU5E
X0RFVklDRSc6Ci90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL2h3L3hlbi94ZW4tbGVnYWN5LWJh
Y2tlbmQuaDoxMzoyNjogZXJyb3I6ICdYZW5MZWdhY3lEZXZpY2UnIHVuZGVjbGFyZWQgKGZpcnN0
IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQogREVDTEFSRV9JTlNUQU5DRV9DSEVDS0VSKFhlbkxlZ2Fj
eURldmljZSwgWEVOQkFDS0VORF9ERVZJQ0UsCiAgICAgICAgICAgICAgICAgICAgICAgICAgXgov
dG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9xb20vb2JqZWN0Lmg6ODYzOjc6IG5vdGU6IGluIGRl
ZmluaXRpb24gb2YgbWFjcm8gJ09CSkVDVF9DSEVDSycKLS0tCi90bXAvcWVtdS10ZXN0L3NyYy9p
bmNsdWRlL2h3L3hlbi94ZW4tbGVnYWN5LWJhY2tlbmQuaDoxMzoxOiBub3RlOiBpbiBleHBhbnNp
b24gb2YgbWFjcm8gJ0RFQ0xBUkVfSU5TVEFOQ0VfQ0hFQ0tFUicKIERFQ0xBUkVfSU5TVEFOQ0Vf
Q0hFQ0tFUihYZW5MZWdhY3lEZXZpY2UsIFhFTkJBQ0tFTkRfREVWSUNFLAogXgovdG1wL3FlbXUt
dGVzdC9zcmMvaW5jbHVkZS9xb20vb2JqZWN0Lmg6ODYzOjEzOiBlcnJvcjogZXhwZWN0ZWQgZXhw
cmVzc2lvbiBiZWZvcmUgJyknIHRva2VuCiAgICAgKCh0eXBlICopb2JqZWN0X2R5bmFtaWNfY2Fz
dF9hc3NlcnQoT0JKRUNUKG9iaiksIChuYW1lKSwgXAogICAgICAgICAgICAgXgovdG1wL3FlbXUt
dGVzdC9zcmMvaW5jbHVkZS9xb20vb2JqZWN0Lmg6NTcyOjE0OiBub3RlOiBpbiBleHBhbnNpb24g
b2YgbWFjcm8gJ09CSkVDVF9DSEVDSycKLS0tCiAgQ0MgICAgICBody9jb3JlL25taS5vCiAgQ0Mg
ICAgICBody9jb3JlL3ZtLWNoYW5nZS1zdGF0ZS1oYW5kbGVyLm8KICBDQyAgICAgIGh3L2NvcmUv
cWRldi1wcm9wZXJ0aWVzLXN5c3RlbS5vCm1ha2U6ICoqKiBbaHcvY2hhci94ZW5fY29uc29sZS5v
XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNl
YmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2Nr
ZXIucHkiLCBsaW5lIDcwOSwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNz
RXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFu
ZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5p
bnN0YW5jZS51dWlkPWY3Y2E5NTYzZGY5MTQ2OTQ5MzYxNzA0MjY2YjdiNjk2JywgJy11JywgJzEw
MDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUn
LCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdW
PScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1l
JywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5j
YWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90
bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWU4anYxMXRhL3NyYy9kb2NrZXItc3JjLjIwMjAtMDgtMTMt
MTkuMDQuNDcuOTUxMjovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdS9jZW50b3M3JywgJy92YXIv
dG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0
dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ZjdjYTk1
NjNkZjkxNDY5NDkzNjE3MDQyNjZiN2I2OTYKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJv
ciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10
bXAtZThqdjExdGEvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3
XSBFcnJvciAyCgpyZWFsICAgIDJtMzguNDEzcwp1c2VyICAgIDBtOC40OTJzCgoKVGhlIGZ1bGwg
bG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDgxMzIyMjYy
NS4yNDMxMzYtMS1laGFia29zdEByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRv
czcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


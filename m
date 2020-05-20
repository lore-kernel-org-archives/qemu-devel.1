Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B045DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 23:16:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7675620884
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 23:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7675620884
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbXx9-0006KG-IE
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 19:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbXwP-0005lv-Nu; Wed, 20 May 2020 19:16:01 -0400
Resent-Date: Wed, 20 May 2020 19:16:01 -0400
Resent-Message-Id: <E1jbXwP-0005lv-Nu@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbXwO-0002PL-1w; Wed, 20 May 2020 19:16:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590016546; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Bu7uUF6vCLy4xvwKjMaMiQyN1T8M0DAb6gpdnBAYEqtLpXmLleA65KKCULV86W2tQNnDt+G0lZ9gj/8VyT97kdmnN90DESAFC/VDJXklI9nCJEzv8Dvz3RbAd2JMUGZViHW8LiJ5et1v0p+HKd/ZHBE9FoXz2mxdbd1IML1qd/c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590016546;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=x+NT60bbq+SVyFVsDZuJeZ/C2AwoeS+YRHLhOD7k3F4=; 
 b=TrVFwiy5XS0wHi9YliXsp7nm7YVZsCW7GAARN52FDXyLz/WYswQutWaJsGp+SvWpWe+9fcg7jBzIIm0CiCn8SUHmZuIQnkCn8wVvnwJymsAoDfIaz002s42DD/OA6UXhuKOhPWK2QpgRe8FPnksC/DocsU0g/DLF4eJPlqXJ940=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590016544168257.2365637530379;
 Wed, 20 May 2020 16:15:44 -0700 (PDT)
Message-ID: <159001654260.29084.6700967189919961032@45ef0f9c86ae>
In-Reply-To: <cover.1590008051.git.lukasstraub2@web.de>
Subject: Re: [PATCH v2 0/4] Introduce 'yank' oob qmp command to recover from
 hanging qemu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lukasstraub2@web.de
Date: Wed, 20 May 2020 16:15:44 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 19:15:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: kwolf@redhat.com, berrange@redhat.com, qemu-block@nongnu.org,
 quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTkwMDA4MDUxLmdp
dC5sdWthc3N0cmF1YjJAd2ViLmRlLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCi90bXAvcWVtdS10ZXN0L3NyYy9j
aGFyZGV2L2NoYXItc29ja2V0LmM6MTM4MTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgeWFua19y
ZWdpc3Rlcl9pbnN0YW5jZScKY2hhcmRldi9jaGFyLXNvY2tldC5vOiBJbiBmdW5jdGlvbiBgY2hh
cl9zb2NrZXRfZmluYWxpemUnOgovdG1wL3FlbXUtdGVzdC9zcmMvY2hhcmRldi9jaGFyLXNvY2tl
dC5jOjEwODQ6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHlhbmtfdW5yZWdpc3Rlcl9pbnN0YW5j
ZScKY29sbGVjdDI6IGVycm9yOiBsZCByZXR1cm5lZCAxIGV4aXQgc3RhdHVzCiAgQ0MgICAgICBz
X25vcm1TdWJub3JtYWxGNjRTaWcubwogIENDICAgICAgc19yb3VuZFBhY2tUb0Y2NC5vCiAgQ0Mg
ICAgICBzX25vcm1Sb3VuZFBhY2tUb0Y2NC5vCm1ha2U6ICoqKiBbdGVzdHMvdGVzdC1jaGFyXSBF
cnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgQ0MgICAg
ICBzX2FkZE1hZ3NGNjQubwogIENDICAgICAgc19zdWJNYWdzRjY0Lm8KLS0tCk5vdCBydW46IDI1
OQpGYWlsdXJlczogMTQwIDE0MyAyNjcKRmFpbGVkIDMgb2YgMTE5IGlvdGVzdHMKbWFrZTogKioq
IFtjaGVjay10ZXN0cy9jaGVjay1ibG9jay5zaF0gRXJyb3IgMQptYWtlOiAqKiogd2FpdDogTm8g
Y2hpbGQgcHJvY2Vzc2VzLiAgU3RvcC4KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3Qp
OgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjY0LCBpbiA8bW9kdWxl
PgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nl
c3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywg
J3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MDExMDRhODAxMTc1NDFk
ZmFiZjczZTU5NmE4YzIzMjgnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNj
b21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhU
UkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVC
VUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2Fj
aGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIv
dG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC0xX2lfMTl5
dS9zcmMvZG9ja2VyLXNyYy4yMDIwLTA1LTIwLTE5LjAzLjM0LjE1NTIwOi92YXIvdG1wL3FlbXU6
eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljaydd
JyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9
Y29tLnFlbXUuaW5zdGFuY2UudXVpZD0wMTEwNGE4MDExNzU0MWRmYWJmNzNlNTk2YThjMjMyOApt
YWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3Rv
cnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC0xX2lfMTl5dS9zcmMnCm1ha2U6ICoqKiBb
ZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMTJtOC40MzRz
CnVzZXIgICAgMG04LjUwNHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9w
YXRjaGV3Lm9yZy9sb2dzL2NvdmVyLjE1OTAwMDgwNTEuZ2l0Lmx1a2Fzc3RyYXViMkB3ZWIuZGUv
dGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQ
bGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


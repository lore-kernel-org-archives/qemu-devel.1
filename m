Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AE0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 23:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A77920774
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 23:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A77920774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6MH6-0001jj-N6
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 19:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6MGS-00011h-KL
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 19:04:04 -0400
Resent-Date: Thu, 13 Aug 2020 19:04:04 -0400
Resent-Message-Id: <E1k6MGS-00011h-KL@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6MGQ-0006xP-FJ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 19:04:04 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597359836; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IHLhWMFm6xQmynYuBe1UlPbb+/SL9d9AO4ZFko2NAH8BFZHAVpR8sUy99wflq3ksz6rCcnvHH5q0socsN7kSZ6oGd0jFVTrwhxn258KKN+trKTqrRHDx5HfRIq4oyuUAon47ZtUUtJkvXXTVq0NNA+9W07wZ393HEZhuzaZnQBE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597359836;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=b8cIH4Fss0JW9eOHxIcuukgiZZV7FtGhonljDQ6SfDk=; 
 b=E+3YrGdq9s5Za3LdWjEWhFLnA+GxY0L2k36LkaTryGFaiU+4ZMaxe+57dy1Peycv0aIv1fDAfqdDEmbYLTk3oYUdGvwijwXluW4QmvIUspxLKW/raLiVqAvlAt+0VGl2I1WDrt0TkcOGoi/ZhRcxm/y1+phMRmSzhzyltUkweEE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597359833750253.57637977908792;
 Thu, 13 Aug 2020 16:03:53 -0700 (PDT)
Subject: Re: [PATCH 00/41] qom: Automated conversion of type checking
 boilerplate
Message-ID: <159735983324.30452.11958140001178661097@66eaa9a8a123>
In-Reply-To: <20200813222625.243136-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ehabkost@redhat.com
Date: Thu, 13 Aug 2020 16:03:53 -0700 (PDT)
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
ZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2Vy
LWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0Bm
ZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBz
dHVicy9lcnJvci1wcmludGYubwogIENDICAgICAgc3R1YnMvZmRzZXQubwogIENDICAgICAgc3R1
YnMvZ2Ric3R1Yi5vCi90bXAvcWVtdS10ZXN0L3NyYy9kb2NzLy4uL2luY2x1ZGUvZXhlYy9tZW1v
cnkuaDozNTM6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ3BhcmVudF9j
bGFzcycgbm90IGRlc2NyaWJlZCBpbiAnSU9NTVVNZW1vcnlSZWdpb25DbGFzcycKL3RtcC9xZW11
LXRlc3Qvc3JjL2RvY3MvLi4vaW5jbHVkZS9leGVjL21lbW9yeS5oOjM1Mzogd2FybmluZzogRnVu
Y3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAndHJhbnNsYXRlJyBub3QgZGVzY3JpYmVkIGluICdJ
T01NVU1lbW9yeVJlZ2lvbkNsYXNzJwovdG1wL3FlbXUtdGVzdC9zcmMvZG9jcy8uLi9pbmNsdWRl
L2V4ZWMvbWVtb3J5Lmg6MzUzOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVy
ICdnZXRfbWluX3BhZ2Vfc2l6ZScgbm90IGRlc2NyaWJlZCBpbiAnSU9NTVVNZW1vcnlSZWdpb25D
bGFzcycKL3RtcC9xZW11LXRlc3Qvc3JjL2RvY3MvLi4vaW5jbHVkZS9leGVjL21lbW9yeS5oOjM1
Mzogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnbm90aWZ5X2ZsYWdfY2hh
bmdlZCcgbm90IGRlc2NyaWJlZCBpbiAnSU9NTVVNZW1vcnlSZWdpb25DbGFzcycKL3RtcC9xZW11
LXRlc3Qvc3JjL2RvY3MvLi4vaW5jbHVkZS9leGVjL21lbW9yeS5oOjM1Mzogd2FybmluZzogRnVu
Y3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAncmVwbGF5JyBub3QgZGVzY3JpYmVkIGluICdJT01N
VU1lbW9yeVJlZ2lvbkNsYXNzJwovdG1wL3FlbXUtdGVzdC9zcmMvZG9jcy8uLi9pbmNsdWRlL2V4
ZWMvbWVtb3J5Lmg6MzUzOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdn
ZXRfYXR0cicgbm90IGRlc2NyaWJlZCBpbiAnSU9NTVVNZW1vcnlSZWdpb25DbGFzcycKL3RtcC9x
ZW11LXRlc3Qvc3JjL2RvY3MvLi4vaW5jbHVkZS9leGVjL21lbW9yeS5oOjM1Mzogd2FybmluZzog
RnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnYXR0cnNfdG9faW5kZXgnIG5vdCBkZXNjcmli
ZWQgaW4gJ0lPTU1VTWVtb3J5UmVnaW9uQ2xhc3MnCi90bXAvcWVtdS10ZXN0L3NyYy9kb2NzLy4u
L2luY2x1ZGUvZXhlYy9tZW1vcnkuaDozNTM6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBv
ciBtZW1iZXIgJ251bV9pbmRleGVzJyBub3QgZGVzY3JpYmVkIGluICdJT01NVU1lbW9yeVJlZ2lv
bkNsYXNzJwoKV2FybmluZywgdHJlYXRlZCBhcyBlcnJvcjoKL3RtcC9xZW11LXRlc3Qvc3JjL2Rv
Y3MvLi4vaW5jbHVkZS9leGVjL21lbW9yeS5oOjIzMTpVbmV4cGVjdGVkIGluZGVudGF0aW9uLgog
IENDICAgICAgc3R1YnMvaW90aHJlYWQtbG9jay5vCiAgQ0MgICAgICBzdHVicy9pcy1kYWVtb25p
emVkLm8KLS0tCiAgQ0MgICAgICBzdHVicy9yZXBsYXkubwogIENDICAgICAgc3R1YnMvcnVuc3Rh
dGUtY2hlY2subwogIENDICAgICAgc3R1YnMvc2VtaWhvc3QubwptYWtlOiAqKiogW01ha2VmaWxl
OjEwOTE6IGRvY3MvZGV2ZWwvaW5kZXguaHRtbF0gRXJyb3IgMgptYWtlOiAqKiogV2FpdGluZyBm
b3IgdW5maW5pc2hlZCBqb2JzLi4uLgpJbiBmaWxlIGluY2x1ZGVkIGZyb20gL3RtcC9xZW11LXRl
c3Qvc3JjL2luY2x1ZGUvZXhlYy9tZW1vcnkuaDoyOCwKICAgICAgICAgICAgICAgICBmcm9tIC90
bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL2h3L2JvYXJkcy5oOjYsCiAgICAgICAgICAgICAgICAg
ZnJvbSAvdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9ody9pMzg2L3BjLmg6NiwKICAgICAgICAg
ICAgICAgICBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9zdHVicy9jbW9zLmM6MjoKL3RtcC9xZW11
LXRlc3Qvc3JjL2luY2x1ZGUvc3lzZW11L2FjY2VsLmg6NjU6MjI6IGVycm9yOiAnQUNDRUwnIHJl
ZGVjbGFyZWQgYXMgZGlmZmVyZW50IGtpbmQgb2Ygc3ltYm9sCiAgIDY1IHwgICAgICAgICAgICAg
ICAgICAgICAgQUNDRUwsIFRZUEVfQUNDRUwpCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
Xn5+fn4KL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvcW9tL29iamVjdC5oOjU3MTo1OiBub3Rl
OiBpbiBkZWZpbml0aW9uIG9mIG1hY3JvICdERUNMQVJFX0lOU1RBTkNFX0NIRUNLRVInCi0tLQov
dXNyL3g4Nl82NC13NjQtbWluZ3czMi9zeXMtcm9vdC9taW5ndy9pbmNsdWRlL3dpbnVzZXIuaDox
NzU3OjU6IG5vdGU6IHByZXZpb3VzIGRlY2xhcmF0aW9uIG9mICdBQ0NFTCcgd2FzIGhlcmUKIDE3
NTcgfCAgIH0gQUNDRUwsKkxQQUNDRUw7CiAgICAgIHwgICAgIF5+fn5+Cm1ha2U6ICoqKiBbL3Rt
cC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogc3R1YnMvY21vcy5vXSBFcnJvciAxClRyYWNl
YmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2Nr
ZXIucHkiLCBsaW5lIDcwOSwgaW4gPG1vZHVsZT4KICAgIHN5cy5leGl0KG1haW4oKSkKLS0tCiAg
ICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxl
ZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAn
LS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPWIzY2E1MDAxN2RkNzQ4OTI4MmFjMTc5
NzJkNzQ1ZTIyJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNv
bmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJ
R1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICct
ZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYn
LCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2Fj
aGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtb3QxdTJzaXYvc3JjL2Rv
Y2tlci1zcmMuMjAyMC0wOC0xMy0xOS4wMS41MS40MzE1Oi92YXIvdG1wL3FlbXU6eixybycsICdx
ZW11L2ZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LW1pbmd3J10nIHJldHVybmVk
IG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5p
bnN0YW5jZS51dWlkPWIzY2E1MDAxN2RkNzQ4OTI4MmFjMTc5NzJkNzQ1ZTIyCm1ha2VbMV06ICoq
KiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90
bXAvcGF0Y2hldy10ZXN0ZXItdG1wLW90MXUyc2l2L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVu
LXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDJtMy4zNDNzCnVzZXIgICAgMG04
LjQ1NHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9s
b2dzLzIwMjAwODEzMjIyNjI1LjI0MzEzNi0xLWVoYWJrb3N0QHJlZGhhdC5jb20vdGVzdGluZy5k
b2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0
b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5k
IHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


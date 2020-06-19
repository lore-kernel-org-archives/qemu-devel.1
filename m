Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028C7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C326020771
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="WSHNaMgZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C326020771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qq.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmH9b-0006Qo-Vu
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 09:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <climber.cui@qq.com>)
 id 1jmH0j-0005DU-Dh
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:24:50 -0400
Received: from smtpbgeu1.qq.com ([52.59.177.22]:54717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <climber.cui@qq.com>)
 id 1jmH0X-0004Bj-B2
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1592573061; bh=BCVTZzY+L5Gzh6O+fRzuQmK5nmDjU4TReQ8UN6Noz4M=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=WSHNaMgZmqkSfRVpm3NE+qeEX0sdQmqZXCtQMmECAqGzKD5NUBq2kj1QLXp3uRyAn
 SM/yBWqglDL1Qsqmwizrnef0v0u9e8c/CYQCGE49vDVN0N/IIArJS3oIyKL0+eGiUZ
 2ucgCmtV7+J/fQbl4r5jPQIr75rfFjzOcwXXosdI=
X-QQ-FEAT: YuwbzFVdD1hYztLj6Ldo630nvfKw3cBVnCj0v5Q57DrbV9W4Yx/A3/aEc99Gp
 cABkjJ8MEqzClLoBs18TMCB+o7QOqf6DfjtsWG+314EVQGS/sbWloFQtdixS10c9/lteLQF
 EU0kcUextkmPv7uLoiVzkQE5m7dKPtU/swu56uHrNX8tUNCtS6MG0Hme8txljWjd/kvTS7W
 Jgj3O4X5tCthZS5th+z0n1E1jEICAahXhZrO3orLqTMm6LWUSa0oRkxEfO/2dhss1wxfwBi
 FN1pC2a0JLSp/y
X-QQ-SSF: 00010000000000F000000000000000D
X-QQ-XMAILINFO: MkPe/1JmsBykDUdFNOJvzbxNf65xWWeI/YLkEJJWhLXW91VttOSIDNajACyUvx
 xjgBc5NWyG5WZxdD3QyxK/vxCC/h70b1bpfK9Iw0ba5RgOX4nXTi8CUqGJkRFi1ab+yUdy+6Q6J3/
 MdrNnqBaopl8PJc14YIqv0t1MwAlfO+V5d5uKiWVU11SGT7o8eBUFg78fYXvg7Z/oyL1WQBZjMa1U
 AhRixKbXg+39sZ+eUQNn3YktOfI1LK7RN/XtSAhwqeQIKuvat20hK1qm3GXBvE9Dl988hh+V/3Ppr
 Hf3YjMcD04xChZgMBO/CTE/V7QZ8/cZVTSLrYEZZ8UOfejFsFri0yLAnVZN4p+bPqFSh7C7yKX9rg
 Xfsq5N3AjusjvUzZxPYkXTM7YUOtgxkt+PDKy4JLMGnCRi8YzQzT8Ee/LSTZmRMOnta+dD/JKI3F6
 qI9DD+fHrGUUKrvwFpMukT4Hhc/HLdLyc2XeFS354LzpGcoMMvyhGWntkXOkp3Huyh4VCfuTYWwze
 LESNRowmusrG5AyW+Xmwop/hvQ9wNqUfo9PsIaT2HtTqczr+hHD47iWBCprkMcZj8O+TNhkYyps/M
 tQ/9gwYpMkv3qeww5VaEO1QWkstgeVghISqUKHh+BsQgTbVlc519dA6/5/Y9e8uwJK/wyhDVruF8Z
 OPvbPHpA5uDoNt6M0x26zY6iCayZkXAkEbemeoqcM7fMs60G4=
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 111.199.165.201
X-QQ-STYLE: 
X-QQ-mid: webmail725t1592573059t777270
From: "=?ISO-8859-1?B?Y2FzbWFj?=" <climber.cui@qq.com>
To: "=?ISO-8859-1?B?cWVtdS1kZXZlbA==?=" <qemu-devel@nongnu.org>
Subject: how to build QEMU with the peripheral device modules
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_5EECBC83_127566A8_2153B5F0"
Content-Transfer-Encoding: 8Bit
Date: Fri, 19 Jun 2020 21:24:19 +0800
X-Priority: 3
Message-ID: <tencent_2BB56CF9C4F3AA4DBB9D8A50C3BFBDCA720A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Fri, 19 Jun 2020 21:24:20 +0800 (CST)
Feedback-ID: webmail:qq.com:bgforeign:bgforeign12
X-QQ-Bgrelay: 1
Received-SPF: pass client-ip=52.59.177.22; envelope-from=climber.cui@qq.com;
 helo=smtpbgeu1.qq.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 09:24:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_EXCESS_BASE64=0.001, HTML_MESSAGE=0.001, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 Jun 2020 09:29:13 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.

------=_NextPart_5EECBC83_127566A8_2153B5F0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

SGkgQWxsLA0KJm5ic3A7ICZuYnNwO0kgYW0gdHJ5aW5nIHRvIGFkZCBhIERNQSBwZXJpcGhl
cmFsIG1vZHVsZS4gSW4gaHcvZG1hIGRpcmVjdG9yeSwgYSBmaWxlJm5ic3A7IHRpX2RtYS5j
IGlzIGFkZGVkLg0KJm5ic3A7ICZuYnNwO0Fsc28sIGluIGh3L2RtYS9rY29uZmlnLCBJIGFk
ZGVkIHRoZSBmb2xsb3dpbmcgbGluZXM6DQpjb25maWcgVElfRE1BDQoJYm9vbA0KDQombmJz
cDsgJm5ic3A7SW4gaHcvZG1hL21ha2VmaWxlLm9qYiwgYWRkZWQgb25lIGxpbmU6DQpjb21t
b24tb2JqLSQoQ09ORklHX1RJX0RNQSkgKz0gdGlfZG1hLm8NCiZuYnNwOyAmbmJzcDtIb3dl
dmVyLCB0aV9kbWEuYyBpcyBub3QgY29tcGlsZWQgYXMgdGhlIFFFTVUgcHJvamVjdCBpcyBi
dWlsdC4gU29tZSBkaXJlY3RvcmllcyhlZy4gYmxvY2ssIGNwdS4uLikgdW5kZXIgaHcgd2ls
bCBiZSBjb21waWxlZCB0aG91Z2guJm5ic3A7DQombmJzcDsgJm5ic3A7VGhlIG1ha2VmaWxl
Lm9iaiBzZWVtcyB0byBzaG93IHRoYXQgdGhlIERNQSBtb2R1bGUgd291bGQgYmUgYnVpbHQg
YWxvbmcgd2l0aCZuYnNwOyBvdGhlcnM6DQpkZXZpY2VzLWRpcnMteSA9IGNvcmUvDQppZmVx
ICgkKENPTkZJR19TT0ZUTU1VKSwgeSkNCmRldmljZXMtZGlycy0kKGNhbGwgbG9yLCQoQ09O
RklHX1ZJUlRJT185UCksJChjYWxsIGxhbmQsJChDT05GSUdfVklSVEZTKSwkKENPTkZJR19Y
RU4pKSkgKz0gOXBmcy8NCmRldmljZXMtZGlycy15ICs9IGFjcGkvDQpkZXZpY2VzLWRpcnMt
eSArPSBhZGMvDQpkZXZpY2VzLWRpcnMteSArPSBhdWRpby8NCmRldmljZXMtZGlycy15ICs9
IGJsb2NrLw0KZGV2aWNlcy1kaXJzLXkgKz0gYnQvDQpkZXZpY2VzLWRpcnMteSArPSBjaGFy
Lw0KZGV2aWNlcy1kaXJzLXkgKz0gY3B1Lw0KZGV2aWNlcy1kaXJzLXkgKz0gZGlzcGxheS8N
CmRldmljZXMtZGlycy15ICs9IGRtYS8NCmRldmljZXMtZGlycy15ICs9IGdwaW8vDQouLi4u
Li4NCiZuYnNwOyAmbmJzcDsgSSBhbSBub3Qgc3VyZSB3aGF0IGlzIG1pc3NpbmcgaGVyZS4g
QW55IGFkdmlzZSB3b3VsZCBiZSBhcHByZWNpYXRlZC4gVGhhbmtzLg0KDQoNCnhpYW9sZWk=

------=_NextPart_5EECBC83_127566A8_2153B5F0
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNo
YXJzZXQ9R0IxODAzMCI+PGRpdj5IaSBBbGwsPC9kaXY+PGRpdj4mbmJzcDsgJm5ic3A7SSBh
bSB0cnlpbmcgdG8gYWRkIGEgRE1BIHBlcmlwaGVyYWwgbW9kdWxlLiBJbiBody9kbWEgZGly
ZWN0b3J5LCBhIGZpbGUmbmJzcDsgdGlfZG1hLmMgaXMgYWRkZWQuPC9kaXY+PGRpdj4mbmJz
cDsgJm5ic3A7QWxzbywgaW4gaHcvZG1hL2tjb25maWcsIEkgYWRkZWQgdGhlIGZvbGxvd2lu
ZyBsaW5lczo8L2Rpdj48ZGl2PjxkaXY+Y29uZmlnIFRJX0RNQTwvZGl2PjxkaXY+PHNwYW4g
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5ib29sPC9kaXY+PC9kaXY+PGRpdj4m
bmJzcDsgJm5ic3A7SW4gaHcvZG1hL21ha2VmaWxlLm9qYiwgYWRkZWQgb25lIGxpbmU6PC9k
aXY+PGRpdj5jb21tb24tb2JqLSQoQ09ORklHX1RJX0RNQSkgKz0gdGlfZG1hLm88L2Rpdj48
ZGl2PiZuYnNwOyAmbmJzcDtIb3dldmVyLCB0aV9kbWEuYyBpcyBub3QgY29tcGlsZWQgYXMg
dGhlIFFFTVUgcHJvamVjdCBpcyBidWlsdC4gU29tZSBkaXJlY3RvcmllcyhlZy4gYmxvY2ss
IGNwdS4uLikgdW5kZXIgaHcgd2lsbCBiZSBjb21waWxlZCB0aG91Z2guJm5ic3A7PC9kaXY+
PGRpdj4mbmJzcDsgJm5ic3A7VGhlIG1ha2VmaWxlLm9iaiBzZWVtcyB0byBzaG93IHRoYXQg
dGhlIERNQSBtb2R1bGUgd291bGQgYmUgYnVpbHQgYWxvbmcgd2l0aCZuYnNwOyBvdGhlcnM6
PC9kaXY+PGRpdj5kZXZpY2VzLWRpcnMteSA9IGNvcmUvPC9kaXY+PGRpdj5pZmVxICgkKENP
TkZJR19TT0ZUTU1VKSwgeSk8L2Rpdj48ZGl2PmRldmljZXMtZGlycy0kKGNhbGwgbG9yLCQo
Q09ORklHX1ZJUlRJT185UCksJChjYWxsIGxhbmQsJChDT05GSUdfVklSVEZTKSwkKENPTkZJ
R19YRU4pKSkgKz0gOXBmcy88L2Rpdj48ZGl2PmRldmljZXMtZGlycy15ICs9IGFjcGkvPC9k
aXY+PGRpdj5kZXZpY2VzLWRpcnMteSArPSBhZGMvPC9kaXY+PGRpdj5kZXZpY2VzLWRpcnMt
eSArPSBhdWRpby88L2Rpdj48ZGl2PmRldmljZXMtZGlycy15ICs9IGJsb2NrLzwvZGl2Pjxk
aXY+ZGV2aWNlcy1kaXJzLXkgKz0gYnQvPC9kaXY+PGRpdj5kZXZpY2VzLWRpcnMteSArPSBj
aGFyLzwvZGl2PjxkaXY+ZGV2aWNlcy1kaXJzLXkgKz0gY3B1LzwvZGl2PjxkaXY+ZGV2aWNl
cy1kaXJzLXkgKz0gZGlzcGxheS88L2Rpdj48ZGl2PmRldmljZXMtZGlycy15ICs9IGRtYS88
L2Rpdj48ZGl2PmRldmljZXMtZGlycy15ICs9IGdwaW8vPC9kaXY+PGRpdj4uLi4uLi48L2Rp
dj48ZGl2PiZuYnNwOyAmbmJzcDsgSSBhbSBub3Qgc3VyZSB3aGF0IGlzIG1pc3NpbmcgaGVy
ZS4gQW55IGFkdmlzZSB3b3VsZCBiZSBhcHByZWNpYXRlZC4gVGhhbmtzLjwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+eGlhb2xlaTwvZGl2Pg==

------=_NextPart_5EECBC83_127566A8_2153B5F0--





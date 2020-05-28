Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E88FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EFD1207F5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="geu5FJGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFD1207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qq.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeFCF-0004Uv-CW
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 05:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1482995675@qq.com>) id 1jeFBL-0003Ti-EE
 for qemu-devel@nongnu.org; Thu, 28 May 2020 05:50:35 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128]:57072)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1482995675@qq.com>) id 1jeFBF-0000AE-By
 for qemu-devel@nongnu.org; Thu, 28 May 2020 05:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1590659360; bh=44Z24dqlDFsZqELSQzWek1sgoarAwm/bdlz3ZnDiGAE=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=geu5FJGFw2pW2qfrf8lNo4J6KGPgpI4oFX2mgrjjbKK0SzzZO08hEjuoPpr3JunO1
 ODQSztMxrrC6WH5zC7kQR3YJwc/O1cp2FDM1+Y7yMED+jA35zAaKpRS+xXKIqhEoaS
 J2Oq/0aDgvcOs+wPOFPrQNOwDMoQ5uxsFzaHj8fU=
X-QQ-FEAT: x+dxIIhayxc7bWx795aFCB++y2HmnqaeIPZilhPwexkJA2Zgd/8XHPse6E2Iw
 SNsMkJxdtaxLFJplm9LDr9b7jaVqOrLgGhWmy3phxO97QcuTI1CWvzHpFbBbAUSCTXQH8oE
 orpJ76xHQO1pHEIArTitTqlBV3nxBwdenzTfmjGU7ZOsYCqDDQO+KGoYtS6pK/lrgwOZRvS
 T2gyZFnoOSeH+42YBtIBCb4L2Yvx1bkpvoPu6EUCdeO/yw6eV5ugqB87DUSslXpNSKijGUV
 vrh+KjjUdQU1eN3d4I3iOYjkxGdfVBViQyrQ==
X-QQ-SSF: 00010000000000F000000000000000D
X-QQ-XMAILINFO: MoPlkZp6QhD4jiIcaunVKoWp0mUXcD3x4E12ELeDOGpRx1L/eswa/4CUxaZiJl
 gkVtsahP7LkPRk4yUAIRCBtt2kF3tQmBiUUzq4CvRxRB3gJJDBHR5/2jb+Z90dLmjKoJjFZuNOXrY
 5bK94379mSEs2W2rEi0Y8KNr1U3eBlMKlKHIwnU5tz8Q+O+S6bDOROe9FyXQWEZv/xxYRzU3RFIgi
 4PGWF0kfNeQ4xt7oyQZFEZCS0QEiKZuya5UFb8hWZ+YS63CrnU4SH2AFR34X28m2jRTOCWkmPywX5
 i9vsnyuD/YPx9b+jcieuT8ZvkcKp9u+6yHJmg3bTfzYiMARmCKudU1KCn3vtUwUdBnzb5EVW28rmM
 N3BIiIN0hzosQ0MlOhFol3MSuTyKznhtxfqD5OgbwPFXl/+y9O/gczKe0+dAlcfFJaXWoPccw6/kR
 3Jw7kRIlKzOuvBUntbaOu1IYEldRz74r7rfmfh4oStQe5ZHurXJibBR9AYR5H9GyPO0GahQuFto6z
 TYzSxfhK3+8vqnf9vRHUirWTbVydYUUFmGUxZIjvZfan7VmdOpjJH/yKMoZlCV+F/8Gor2nb+wL/h
 QBIeM3Vm4VoogOt7U19o7Xb+5OeNTvcXCfWQ65jxvvib+7hmMQ8rlxE9qWHuDavcfc+nhYlCRjGSK
 WTP7Ex27eSvGBG3sL7qc+hrMBIloGsz8u2UMZADfuWaapLDt6AsvA5DwWn+w==
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 124.64.70.219
In-Reply-To: <87v9kg4fw4.fsf@linaro.org>
References: <tencent_86D9DB902C46CBAC4F3A6FD5B4CDA93B7506@qq.com>
 <8b83e11b-e593-b7db-48b6-252e23c599da@amsat.org>
 <tencent_B0E453026AE8377459F3162D9F7D5ECE6907@qq.com>
 <87v9kg4fw4.fsf@linaro.org>
X-QQ-STYLE: 
X-QQ-mid: webmail725t1590659359t7467700
From: "=?gb18030?B?eGlhb2xlaQ==?=" <1482995675@qq.com>
To: "=?gb18030?B?QWxleCBCZW5uqKZl?=" <alex.bennee@linaro.org>,
 "=?gb18030?B?cWVtdS1kZXZlbA==?=" <qemu-devel@nongnu.org>
Subject: =?gb18030?B?u9i4tKO6IEdEQiBnZXQgd3JvbmcgZGVidWcgaW5m?=
 =?gb18030?B?b3Mgb24gVEkgRFNQIGFyY2hpdGVjdHVyZSBleHRl?=
 =?gb18030?B?bnNpb24=?=
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb18030"
Content-Transfer-Encoding: base64
Date: Thu, 28 May 2020 17:49:19 +0800
X-Priority: 3
Message-ID: <tencent_1EBC79D30BA701D4EC6F31B2442DFE3E5C08@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 2160357922
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Thu, 28 May 2020 17:49:20 +0800 (CST)
Feedback-ID: webmail:qq.com:bgforeign:bgforeign12
X-QQ-Bgrelay: 1
Received-SPF: pass client-ip=54.254.200.128; envelope-from=1482995675@qq.com;
 helo=smtpbgsg2.qq.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 05:50:24
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: 48
X-Spam_score: 4.8
X-Spam_bar: ++++
X-Spam_report: (4.8 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_EXCESS_BASE64=0.979,
 MIME_CHARSET_FARAWAY=2.45, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgLAogICBUaGFua3MgZm9yIHRoZSBoaW50LgogICBJIGhhdmUgYmVlbiBsb29raW5nIGZv
ciBob3cgUUVNVSBkZXRlcm1pbmUgdGhlIHRhcmdldCBwcm9ncmFtIHRlcm1pbmF0ZXMgYnkg
Y2hlY2tpbmcgdGhlIGhvc3QgaW1wbGVtZW50YXRpb24gKGVnICBpMzg2KS4gSSB0aG91Z2h0
IHRoZSB0YXJnZXQgcHJvZ3JhbSB0ZXJtaW5hdGlvbiBpcyBjb25uZWN0ZWQgdG8gdGhlIGlu
aXRpYWwgRlAgcHVzaGVkIHRvIHN0YWNrLCBJIGFtIG5vdCBzdXJlIHRoaXMgaXMgaG93IFFF
TVUgZG9lcy4gIENvdWxkIHlvdSBiZSBtb3JlIHNwZWNpZmljIG9uIHRoZSB0ZXJtaW5hdGlv
biBjaGVjayA/ICBpcyBpdCB0YXJnZXQgIGFyY2hpdGVjdHVyZSBkZXBlbmRlbnQoIGFuIGFk
ZGVkIERTUCB0YXJnZXQgYXJjaGl0ZWN0dXJlIHNob3VsZCBkZWFsIHdpdGggaXQgZXhwbGlj
aXRseSk/CiAgIFRoYW5rcyBhZ2FpbgoKeGlhb2xlaSAKCi0tLS0tLS0tLS0tLS0tLS0tLSDU
rcq808q8/iAtLS0tLS0tLS0tLS0tLS0tLS0Kt6K8/sjLOiAiQWxleCBCZW5uqKZlIjxhbGV4
LmJlbm5lZUBsaW5hcm8ub3JnPjsKt6LLzcqxvOQ6IDIwMjDE6jXUwjI4yNUo0MfG2svEKSDP
ws7nNDozNArK1bz+yMs6ICJjYXNtYWMiPDE0ODI5OTU2NzVAcXEuY29tPjsKs63LzTogIlBo
aWxpcHBlIE1hdGhpZXUtRGF1ZKimIjxmNGJ1Z0BhbXNhdC5vcmc+OyJxZW11LWRldmVsIjxx
ZW11LWRldmVsQG5vbmdudS5vcmc+OwrW98ziOiBSZTogR0RCIGdldCB3cm9uZyBkZWJ1ZyBp
bmZvcyBvbiBUSSBEU1AgYXJjaGl0ZWN0dXJlIGV4dGVuc2lvbgoKCmNhc21hYyA8MTQ4Mjk5
NTY3NUBxcS5jb20+IHdyaXRlczoKCj4gSGksClRoYW5rIHlvdSBmb3IgZm9yd2FyZGluZyBt
eSBxdWVzdGlvbiB0byBkZXZlbG9wZXJzIGFuZCBzaGFyaW5nIHRoZSBDNnggaW1wbGVtZW50
YXRpb24uCj4gJm5ic3A7Jm5ic3A7IFBlcmhhcHMgSSBzaG91bGQgZm9sbG93IHVwIHdpdGgg
YW5vdGhlciBwcm9ibGVtIEkgZW5jb3VudGVyZWQuIFRoZSBzZW5lcmlvIGlzIHRoZSZuYnNw
OyBlbXVsYXRvciBrZWVwcyBydW5uaW5nIGV2ZW50aG91Z2ggdGhlIHByb2dyYW0gaXQgZW11
bGF0ZXMgaGFzIGFscmVhZHkgZXhpdGVkLiBBbmQgaXQga2VlcHMgcmV0cmlldmluZyBpbnN0
cnVjdGlvbnMgd2hpY2ggYXJlIGFsbCB6ZXJvICJpbnN0cnVjdGlvbiIoMHgwMDAwMDAwMCku
IAo+Cj4gIEl0IGxvb2tzIHRvIG1lIHRoYXQgaW4gZnVuY3Rpb24gY3B1X2V4ZWMoQ1BVU3Rh
dGUgKmNwdSksIHRoZSBmb2xsb3dpbmcgbG9vcCBuZXZlciB0ZXJtaW5hdGU6Cj4gd2hpbGUg
KCFjcHVfaGFuZGxlX2V4Y2VwdGlvbihjcHUsICZhbXA7cmV0KSkgewo+IFRyYW5zbGF0aW9u
QmxvY2sgKmxhc3RfdGIgPSBOVUxMOwogPiBpbnQgdGJfZXhpdCA9IDA7Cj4gd2hpbGUgKCFj
cHVfaGFuZGxlX2ludGVycnVwdChjcHUsICZhbXA7bGFzdF90YikpIHsgLi4uIH0KPiBJcyBp
dCBiZWNhdXNlIGNwdS0mZ3Q7ZXhpdF9yZXF1ZXN0IHJlbWFpbnMgMCA/Cj4KPiBBdCB3aGF0
IHBvaW50IHNob3VsZCB3ZSBtYWtlIGNwdS0mZ3Q7ZXhpdF9yZXF1ZXN0PTEgPwoKY3B1LT5l
eGl0X3JlcXVlc3QgaXMgc2V0IGZvciBhc3luY2hyb251cyBjb25kaXRpb25zIChlLmcuIHRp
bWVyIElSUXMgb3IKSU8gZXZlbnRzKS4gQSBudW1iZXIgb2YgaGVscGVycyB3aWxsICJraWNr
IiB0aGUgY3B1IGJ5IGNhbGxpbmcKY3B1X2V4aXQoKS4KCj4gJm5ic3A7Jm5ic3A7IFRoYW5r
cyBhZ2FpbiEhCj4KPgo+IHJlZ2FyZHMKPiB4aWFvbGVpCj4KPgo+





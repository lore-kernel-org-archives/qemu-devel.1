Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B71C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:35:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08DAA2166E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GP6r+V/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DAA2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFa1t-0000w9-4r
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 05:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFZyW-0003g1-EX
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFZyT-0001xA-3F
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599557495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u7FNgdepMH72P87TrGLbP8aP3D2xBjMQJfOFMDpbZhY=;
 b=GP6r+V/dvFMqJg3THIinNyaqUEdtiTEFSpuys8s1zr4NMQhWhCfPT/600D4sHXof46z6Fh
 kVrLIS8TJETk1LlbmGnIxdTc7CT0IRzI9dpcvOXucPU3fs92HmqqhrzpJiLuMaX2mjsS6U
 bFA79/mFVqAMs3MPw9NV6lxgKonup8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-l_ucIbFFNQ60zuC3XDRiJg-1; Tue, 08 Sep 2020 05:31:34 -0400
X-MC-Unique: l_ucIbFFNQ60zuC3XDRiJg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AF671074642;
 Tue,  8 Sep 2020 09:31:33 +0000 (UTC)
Received: from localhost (ovpn-114-244.ams2.redhat.com [10.36.114.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9842B5C1BB;
 Tue,  8 Sep 2020 09:31:29 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] docs: add qemu-storage-daemon(1) man page
Date: Tue,  8 Sep 2020 10:31:12 +0100
Message-Id: <20200908093113.47564-4-stefanha@redhat.com>
In-Reply-To: <20200908093113.47564-1-stefanha@redhat.com>
References: <20200908093113.47564-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:11:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Kashyap Chamarthy <kchamart@redhat.com>,
 afrosi@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RG9jdW1lbnQgdGhlIHFlbXUtc3RvcmFnZS1kYWVtb24gdG9vbC4gTW9zdCBvZiB0aGUgY29tbWFu
ZC1saW5lIG9wdGlvbnMKYXJlIGlkZW50aWNhbCB0byB0aGVpciBRRU1VIGNvdW50ZXJwYXJ0cy4g
UGVyaGFwcyBTcGhpbnggaHh0b29sCmludGVncmF0aW9uIGNvdWxkIGJlIGV4dGVuZGVkIHRvIGV4
dHJhY3QgZG9jdW1lbnRhdGlvbiBmb3IgaW5kaXZpZHVhbApjb21tYW5kLWxpbmUgb3B0aW9ucyBz
byB0aGV5IGNhbiBiZSBzaGFyZWQuIEZvciBub3cgdGhlCnFlbXUtc3RvcmFnZS1kYWVtb24gc2lt
cGx5IHJlZmVycyB0byB0aGUgcWVtdSgxKSBtYW4gcGFnZSB3aGVyZSB0aGUKY29tbWFuZC1saW5l
IG9wdGlvbnMgYXJlIGlkZW50aWNhbC4KClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8
c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBkb2NzL3Rvb2xzL2NvbmYucHkgICAgICAgICAgICAg
ICAgIHwgICAyICsKIGRvY3MvdG9vbHMvaW5kZXgucnN0ICAgICAgICAgICAgICAgfCAgIDEgKwog
ZG9jcy90b29scy9xZW11LXN0b3JhZ2UtZGFlbW9uLnJzdCB8IDEwNSArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAxMDggaW5zZXJ0aW9ucygrKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGRvY3MvdG9vbHMvcWVtdS1zdG9yYWdlLWRhZW1vbi5yc3QKCmRpZmYgLS1n
aXQgYS9kb2NzL3Rvb2xzL2NvbmYucHkgYi9kb2NzL3Rvb2xzL2NvbmYucHkKaW5kZXggOTA1MmQx
N2Q2ZC4uYzE2MjkwZTcxNiAxMDA2NDQKLS0tIGEvZG9jcy90b29scy9jb25mLnB5CisrKyBiL2Rv
Y3MvdG9vbHMvY29uZi5weQpAQCAtMjAsNiArMjAsOCBAQCBodG1sX3RoZW1lX29wdGlvbnNbJ2Rl
c2NyaXB0aW9uJ10gPSBcCiBtYW5fcGFnZXMgPSBbCiAgICAgKCdxZW11LWltZycsICdxZW11LWlt
ZycsIHUnUUVNVSBkaXNrIGltYWdlIHV0aWxpdHknLAogICAgICBbJ0ZhYnJpY2UgQmVsbGFyZCdd
LCAxKSwKKyAgICAoJ3FlbXUtc3RvcmFnZS1kYWVtb24nLCAncWVtdS1zdG9yYWdlLWRhZW1vbics
IHUnUUVNVSBzdG9yYWdlIGRhZW1vbicsCisgICAgIFtdLCAxKSwKICAgICAoJ3FlbXUtbmJkJywg
J3FlbXUtbmJkJywgdSdRRU1VIERpc2sgTmV0d29yayBCbG9jayBEZXZpY2UgU2VydmVyJywKICAg
ICAgWydBbnRob255IExpZ3VvcmkgPGFudGhvbnlAY29kZW1vbmtleS53cz4nXSwgOCksCiAgICAg
KCdxZW11LXRyYWNlLXN0YXAnLCAncWVtdS10cmFjZS1zdGFwJywgdSdRRU1VIFN5c3RlbVRhcCB0
cmFjZSB0b29sJywKZGlmZiAtLWdpdCBhL2RvY3MvdG9vbHMvaW5kZXgucnN0IGIvZG9jcy90b29s
cy9pbmRleC5yc3QKaW5kZXggMjMyY2U5ZjNlNC4uOWIwNzZhZGI2MiAxMDA2NDQKLS0tIGEvZG9j
cy90b29scy9pbmRleC5yc3QKKysrIGIvZG9jcy90b29scy9pbmRleC5yc3QKQEAgLTExLDYgKzEx
LDcgQEAgQ29udGVudHM6CiAgICA6bWF4ZGVwdGg6IDIKIAogICAgcWVtdS1pbWcKKyAgIHFlbXUt
c3RvcmFnZS1kYWVtb24KICAgIHFlbXUtbmJkCiAgICBxZW11LXRyYWNlLXN0YXAKICAgIHZpcnRm
cy1wcm94eS1oZWxwZXIKZGlmZiAtLWdpdCBhL2RvY3MvdG9vbHMvcWVtdS1zdG9yYWdlLWRhZW1v
bi5yc3QgYi9kb2NzL3Rvb2xzL3FlbXUtc3RvcmFnZS1kYWVtb24ucnN0Cm5ldyBmaWxlIG1vZGUg
MTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAuLjcyOWE1ZTcyNDgKLS0tIC9kZXYvbnVsbAorKysgYi9k
b2NzL3Rvb2xzL3FlbXUtc3RvcmFnZS1kYWVtb24ucnN0CkBAIC0wLDAgKzEsMTA1IEBACitRRU1V
IFN0b3JhZ2UgRGFlbW9uCis9PT09PT09PT09PT09PT09PT09CisKK1N5bm9wc2lzCistLS0tLS0t
LQorCisqKnFlbXUtc3RvcmFnZS1kYWVtb24qKiBbb3B0aW9uc10KKworRGVzY3JpcHRpb24KKy0t
LS0tLS0tLS0tCisKK3FlbXUtc3RvcmFnZS1kYWVtb24gcHJvdmlkZXMgZGlzayBpbWFnZSBmdW5j
dGlvbmFsaXR5IGZyb20gUUVNVSwgcWVtdS1pbWcsIGFuZAorcWVtdS1uYmQgaW4gYSBsb25nLXJ1
bm5pbmcgcHJvY2VzcyBjb250cm9sbGVkIHZpYSBRTVAgY29tbWFuZHMgd2l0aG91dCBydW5uaW5n
CithIHZpcnR1YWwgbWFjaGluZS4gSXQgY2FuIGV4cG9ydCBkaXNrIGltYWdlcyBvdmVyIE5CRCwg
cnVuIGJsb2NrIGpvYgorb3BlcmF0aW9ucywgYW5kIHBlcmZvcm0gb3RoZXIgZGlzay1yZWxhdGVk
IG9wZXJhdGlvbnMuIFRoZSBkYWVtb24gaXMgY29udHJvbGxlZAordmlhIGEgUU1QIG1vbml0b3Ig
c29ja2V0IGFuZCBpbml0aWFsIGNvbmZpZ3VyYXRpb24gZnJvbSB0aGUgY29tbWFuZC1saW5lLgor
CitUaGUgZGFlbW9uIG9mZmVycyB0aGUgZm9sbG93aW5nIHN1YnNldCBvZiBRRU1VIGZlYXR1cmVz
OgorCisqIEJsb2NrZGV2IG5vZGVzCisqIEJsb2NrIGpvYnMKKyogTkJEIHNlcnZlcgorKiBDaGFy
YWN0ZXIgZGV2aWNlcworKiBDcnlwdG8gYW5kIHNlY3JldHMKKyogUU1QCisKK0NvbW1hbmRzIGNh
biBiZSBzZW50IG92ZXIgYSBRRU1VIE1vbml0b3IgUHJvdG9jb2wgKFFNUCkgY29ubmVjdGlvbi4g
U2VlIHRoZQorOm1hbnBhZ2U6YHFlbXUtc3RvcmFnZS1kYWVtb24tcW1wLXJlZig3KWAgbWFudWFs
IHBhZ2UgZm9yIGEgZGVzY3JpcHRpb24gb2YgdGhlCitjb21tYW5kcy4KKworVGhlIGRhZW1vbiBy
dW5zIHVudGlsIGl0IGlzIHN0b3BwZWQgdXNpbmcgdGhlIGBgcXVpdGBgIFFNUCBjb21tYW5kIG9y
CitTSUdJTlQvU0lHSFVQL1NJR1RFUk0uCisKKyoqV2FybmluZzoqKiBOZXZlciBtb2RpZnkgaW1h
Z2VzIGluIHVzZSBieSBhIHJ1bm5pbmcgdmlydHVhbCBtYWNoaW5lIG9yIGFueQorb3RoZXIgcHJv
Y2VzczsgdGhpcyBtYXkgZGVzdHJveSB0aGUgaW1hZ2UuIEFsc28sIGJlIGF3YXJlIHRoYXQgcXVl
cnlpbmcgYW4KK2ltYWdlIHRoYXQgaXMgYmVpbmcgbW9kaWZpZWQgYnkgYW5vdGhlciBwcm9jZXNz
IG1heSBlbmNvdW50ZXIgaW5jb25zaXN0ZW50CitzdGF0ZS4KKworT3B0aW9ucworLS0tLS0tLQor
CisuLiBwcm9ncmFtOjogcWVtdS1zdG9yYWdlLWRhZW1vbgorCitTdGFuZGFyZCBvcHRpb25zOgor
CisuLiBvcHRpb246OiAtaCwgLS1oZWxwCisKKyAgRGlzcGxheSB0aGlzIGhlbHAgYW5kIGV4aXQK
KworLi4gb3B0aW9uOjogLVYsIC0tdmVyc2lvbgorCisgIERpc3BsYXkgdmVyc2lvbiBpbmZvcm1h
dGlvbiBhbmQgZXhpdAorCisuLiBvcHRpb246OiAtVCwgLS10cmFjZSBbW2VuYWJsZT1dUEFUVEVS
Tl1bLGV2ZW50cz1GSUxFXVssZmlsZT1GSUxFXQorCisgIC4uIGluY2x1ZGU6OiAuLi9xZW11LW9w
dGlvbi10cmFjZS5yc3QuaW5jCisKKy4uIG9wdGlvbjo6IC0tYmxvY2tkZXYgQkxPQ0tERVZERUYK
KworICBpcyBhIGJsb2NrZGV2IG5vZGUgZGVmaW5pdGlvbi4gU2VlIHRoZSA6bWFucGFnZTpgcWVt
dSgxKWAgbWFudWFsIHBhZ2UgZm9yIGEKKyAgZGVzY3JpcHRpb24gb2YgYmxvY2tkZXYgbm9kZSBw
cm9wZXJ0aWVzIGFuZCB0aGUKKyAgOm1hbnBhZ2U6YHFlbXUtYmxvY2stZHJpdmVycyg3KWAgbWFu
dWFsIHBhZ2UgZm9yIGEgZGVzY3JpcHRpb24gb2YKKyAgZHJpdmVyLXNwZWNpZmljIHBhcmFtZXRl
cnMuCisKKy4uIG9wdGlvbjo6IC0tY2hhcmRldiBDSEFSREVWREVGCisKKyAgaXMgYSBjaGFyYWN0
ZXIgZGV2aWNlIGRlZmluaXRpb24uIFNlZSB0aGUgOm1hbnBhZ2U6YHFlbXUoMSlgIG1hbnVhbCBw
YWdlIGZvcgorICBhIGRlc2NyaXB0aW9uIG9mIGNoYXJhY3RlciBkZXZpY2UgcHJvcGVydGllcy4g
QSBjb21tb24gY2hhcmFjdGVyIGRldmljZQorICBkZWZpbml0aW9uIGNvbmZpZ3VyZXMgYSBVTklY
IGRvbWFpbiBzb2NrZXQ6OgorCisgIC0tY2hhcmRldiBzb2NrZXQsaWQ9Y2hhcjEscGF0aD0vdG1w
L3FtcC5zb2NrLHNlcnZlcixub3dhaXQKKworLi4gb3B0aW9uOjogLS1tb25pdG9yIE1PTklUT1JE
RUYKKworICBpcyBhIFFNUCBtb25pdG9yIGRlZmluaXRpb24uIFNlZSB0aGUgOm1hbnBhZ2U6YHFl
bXUoMSlgIG1hbnVhbCBwYWdlIGZvcgorICBhIGRlc2NyaXB0aW9uIG9mIFFNUCBtb25pdG9yIHBy
b3BlcnRpZXMuIEEgY29tbW9uIFFNUCBtb25pdG9yIGRlZmluaXRpb24KKyAgY29uZmlndXJlcyBh
IG1vbml0b3Igb24gY2hhcmFjdGVyIGRldmljZSBgYGNoYXIxYGA6OgorCisgIC0tbW9uaXRvciBj
aGFyZGV2PWNoYXIxCisKKy4uIG9wdGlvbjo6IC0tbmJkLXNlcnZlciBhZGRyLnR5cGU9aW5ldCxh
ZGRyLmhvc3Q9PGhvc3Q+LGFkZHIucG9ydD08cG9ydD5bLHRscy1jcmVkcz08aWQ+XVssdGxzLWF1
dGh6PTxpZD5dCisgIC0tbmJkLXNlcnZlciBhZGRyLnR5cGU9dW5peCxhZGRyLnBhdGg9PHBhdGg+
Wyx0bHMtY3JlZHM9PGlkPl1bLHRscy1hdXRoej08aWQ+XQorCisgIGlzIGEgTkJEIHNlcnZlciBk
ZWZpbml0aW9uLiBCb3RoIFRDUCBhbmQgVU5JWCBkb21haW4gc29ja2V0cyBhcmUgc3VwcG9ydGVk
LgorICBUTFMgZW5jcnlwdGlvbiBjYW4gYmUgY29uZmlndXJlZCB1c2luZyBgYC0tb2JqZWN0YGAg
dGxzLWNyZWRzLSogYW5kIGF1dGh6LSoKKyAgc2VjcmV0cyAoc2VlIGJlbG93KS4KKworICBUbyBj
b25maWd1cmUgYW4gTkJEIHNlcnZlciBvbiBVTklYIGRvbWFpbiBzb2NrZXQgcGF0aCBgYC90bXAv
bmJkLnNvY2tgYDo6CisKKyAgLS1uYmQtc2VydmVyIGFkZHIudHlwZT11bml4LGFkZHIucGF0aD0v
dG1wL25iZC5zb2NrCisKKy4uIG9wdGlvbjo6IC0tb2JqZWN0IGhlbHAKKyAgLS1vYmplY3QgPHR5
cGU+LGhlbHAKKyAgLS1vYmplY3QgPHR5cGU+Wyw8cHJvcGVydHk+PTx2YWx1ZT4uLi5dCisKKyAg
aXMgYSBRRU1VIHVzZXIgY3JlYXRhYmxlIG9iamVjdCBkZWZpbml0aW9uLiBMaXN0IG9iamVjdCB0
eXBlcyB3aXRoIGBgaGVscGBgLgorICBMaXN0IG9iamVjdCBwcm9wZXJ0aWVzIHdpdGggYGA8dHlw
ZT4saGVscGBgLiBTZWUgdGhlIDptYW5wYWdlOmBxZW11KDEpYAorICBtYW51YWwgcGFnZSBmb3Ig
YSBkZXNjcmlwdGlvbiBvZiB0aGUgb2JqZWN0IHByb3BlcnRpZXMuIFRoZSBtb3N0IGNvbW1vbgor
ICBvYmplY3QgdHlwZSBpcyBhIGBgc2VjcmV0YGAsIHdoaWNoIGlzIHVzZWQgdG8gc3VwcGx5IHBh
c3N3b3JkcyBhbmQvb3IKKyAgZW5jcnlwdGlvbiBrZXlzLgorCitTZWUgYWxzbworLS0tLS0tLS0K
KworOm1hbnBhZ2U6YHFlbXUoMSlgLCA6bWFucGFnZTpgcWVtdS1ibG9jay1kcml2ZXJzKDcpYCwg
Om1hbnBhZ2U6YHFlbXUtc3RvcmFnZS1kYWVtb24tcW1wLXJlZig3KWAKLS0gCjIuMjYuMgoK



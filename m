Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61923C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:12:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D8220720
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 21:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoIHQBDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D8220720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjUV0-0003Eb-B8
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 17:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jjUTZ-00018P-IG; Thu, 11 Jun 2020 17:11:05 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:33944)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jjUTY-0003GN-5f; Thu, 11 Jun 2020 17:11:05 -0400
Received: by mail-ej1-x62d.google.com with SMTP id l27so7963185ejc.1;
 Thu, 11 Jun 2020 14:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=uqRkS+04znKDsw7rOy4FGLZ4dtAJHAdv4x6eVo3FtZQ=;
 b=FoIHQBDYczrL+czYzIaom7LOKvtqYd/K5ixr6/h7Yz1gCvt51KwjK7l7Uags38oA4B
 lTlH5k7n/hZ5+NXliI5V0ivLTtXVU0saEsXXIFrPGlaE2+VlA9/nylvnRp3G2D7h2WDJ
 0vvTJlQz4cVYWVnbI85OYHct0jvCYHV1mEEkyjS7+wbcsMw5Xyk6TTKFTVvTB/ToKqzr
 +be5w8TM6xXF82CsbIoJKVJyEDL23Tv8vexA4LBkQXe5PDNEFMnovoNIv70Te4ds9bqs
 3V17JRzLgnjH7/tGSCQtsaDQ/fUS5qkXvunkkZ9HhcDETisVryew3loMFv9TWOARq9aX
 VZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=uqRkS+04znKDsw7rOy4FGLZ4dtAJHAdv4x6eVo3FtZQ=;
 b=Kz+NYtsbjEVbqD157dOGBj62jmEn4GShzwUz0eMUW5l67dmhx/JCcQf0cAegaX3lh4
 eRLclYfipZC+pZrziIOOCZyVUGewPcqp+rsKuO36ddR+K5IwLKSNJPlCZC3e4YA+SH4U
 BpiWqbRureIOErJh3b8J2EcpiwL60fbXpgMGIYqq4WOLWJecoXITJ0X9lYx5nH5xbRX7
 DpPrPSifi+4H7m8jp2iC136WtwfQsvqTc8yzg/lcDVu2ZcnT5ppRleYCVUmjbODkm9Bf
 opsx4z8LLf7BTxk3LGSSzZ4InH7s7sSKAXbf4coMUN9jQpBADUk6FiAt9k5wtDdShLKd
 esxw==
X-Gm-Message-State: AOAM530Nb8e8DgTBVDAWolenmCd5F0h3wufOuIfkbH2YqnV3yGC0iEEi
 sXyCOeGC3+QORJgN99EXFntjXRTMK+qy8Z/UvEInA2vnf70=
X-Google-Smtp-Source: ABdhPJzw8cnlZYYizgg3OBrN9zi4QYxb/3gYxagiS4jl+WXuiHUTenDw2xAZxE/oOLShUlw6py4VrNor2jBmF+tyLsI=
X-Received: by 2002:a17:906:68ca:: with SMTP id
 y10mr9967077ejr.322.1591909850248; 
 Thu, 11 Jun 2020 14:10:50 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Thu, 11 Jun 2020 22:10:39 +0100
Message-ID: <CA+XhMqwHSBd_TSFqipO6bn=hVSV8+Mdm3y=_i6gQoGBxRsjS0g@mail.gmail.com>
Subject: [PATCH 1/1] util/getauxval: Porting to FreeBSD getauxval feature
To: qemu-trivial@nongnu.org, qemu-devel <qemu-devel@nongnu.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/mixed; boundary="00000000000023a19605a7d56545"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x62d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 PYZOR_CHECK=1.392, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

--00000000000023a19605a7d56545
Content-Type: text/plain; charset="UTF-8"



--00000000000023a19605a7d56545
Content-Type: application/octet-stream; 
	name="0001-util-getauxval-Porting-to-FreeBSD-the-getauxval-feat.patch"
Content-Disposition: attachment; 
	filename="0001-util-getauxval-Porting-to-FreeBSD-the-getauxval-feat.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kbb9ztph0>
X-Attachment-Id: f_kbb9ztph0

RnJvbSAzMTZjYmRlYTA0MzRhNTIzYzc4ZDNmMThmZTdlNjY5NzU3N2U0YWFlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBDYXJsaWVyIDxkZXZuZXhlbkBnbWFpbC5jb20+CkRh
dGU6IFR1ZSwgMjYgTWF5IDIwMjAgMDg6MzM6MTIgKzAxMDAKU3ViamVjdDogW1BBVENIXSB1dGls
L2dldGF1eHZhbDogUG9ydGluZyB0byBGcmVlQlNEIHRoZSBnZXRhdXh2YWwgZmVhdHVyZQoKRnJl
ZUJTRCBoYXMgYSBzaW1pbGFyIEFQSSBmb3IgYXV4aWxpYXJ5IHZlY3Rvci4KClNpZ25lZC1vZmYt
Ynk6IERhdmlkIENhcmxpZXIgPGRldm5leGVuQGdtYWlsLmNvbT4KLS0tCiBjb25maWd1cmUgICAg
ICAgIHwgNSArKysrKwogdXRpbC9nZXRhdXh2YWwuYyB8IDYgKysrKysrCiAyIGZpbGVzIGNoYW5n
ZWQsIDExIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9jb25maWd1cmUgYi9jb25maWd1cmUK
aW5kZXggMmZjMDVjNDQ2NS4uMmM5Mzg2NzA4MCAxMDA3NTUKLS0tIGEvY29uZmlndXJlCisrKyBi
L2NvbmZpZ3VyZQpAQCAtNTgyNCw3ICs1ODI0LDEyIEBAIGdldGF1eHZhbD1ubwogY2F0ID4gJFRN
UEMgPDwgRU9GCiAjaW5jbHVkZSA8c3lzL2F1eHYuaD4KIGludCBtYWluKHZvaWQpIHsKKyNpZiBk
ZWZpbmVkKF9fRnJlZUJTRF9fKQorICB1bnNpZ25lZCBsb25nIGEgPSAwOworICByZXR1cm4gZWxm
X2F1eF9pbmZvKEFUX0hXQ0FQLCAmYSwgc2l6ZW9mKGEpKSA9PSAwOworI2Vsc2UKICAgcmV0dXJu
IGdldGF1eHZhbChBVF9IV0NBUCkgPT0gMDsKKyNlbmRpZgogfQogRU9GCiBpZiBjb21waWxlX3By
b2cgIiIgIiIgOyB0aGVuCmRpZmYgLS1naXQgYS91dGlsL2dldGF1eHZhbC5jIGIvdXRpbC9nZXRh
dXh2YWwuYwppbmRleCAzNmFmZGZiOWU2Li4zNzNlZDM4OTlmIDEwMDY0NAotLS0gYS91dGlsL2dl
dGF1eHZhbC5jCisrKyBiL3V0aWwvZ2V0YXV4dmFsLmMKQEAgLTMzLDcgKzMzLDEzIEBACiAKIHVu
c2lnbmVkIGxvbmcgcWVtdV9nZXRhdXh2YWwodW5zaWduZWQgbG9uZyBrZXkpCiB7CisjaWYgZGVm
aW5lZChfX2xpbnV4X18pCiAgICAgcmV0dXJuIGdldGF1eHZhbChrZXkpOworI2VsaWYgZGVmaW5l
ZChfX0ZyZWVCU0RfXykKKyAgICB1bnNpZ25lZCBsb25nIGF1eCA9IDA7CisgICAgZWxmX2F1eF9p
bmZvKGtleSwgJmF1eCwgc2l6ZW9mKGF1eCkpOworICAgIHJldHVybiBhdXg7CisjZW5kaWYKIH0K
ICNlbGlmIGRlZmluZWQoX19saW51eF9fKQogI2luY2x1ZGUgImVsZi5oIgotLSAKMi4yNy4wLnJj
MAoK
--00000000000023a19605a7d56545--


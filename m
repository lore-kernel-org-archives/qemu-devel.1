Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D08C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:49:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED6D2073A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR5UVTXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED6D2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NIR-0003oV-8X
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 17:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j2NHW-00034j-9F
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j2NHV-0006UI-4K
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:48:26 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36541)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j2NHU-000697-Ll
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:48:24 -0500
Received: by mail-ot1-x343.google.com with SMTP id j20so7312929otq.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 14:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5gVLkcooyTNnleYQe61DpXF/xKxVEtPc9IP+fcRQ+9k=;
 b=mR5UVTXwvhULltw2f/twvvByaNkQtUtXU1KBOCkLg3sVEPIWoS99K66RNnKDCUGWau
 19PvNHqhU+J9Wp3gggTWAqxQFQnX8iJjmXijaPiNZO/uDAAVTX8M7jK37L+w0qGraOU/
 V6OiBLflpJLRUEZQJSyGckw6q9Ri3cNZCjUQju4xiQ7iIXnaRBB34YH/eAb2VSPAkXt/
 9/9s19znvztz+4SFJtVvDhMKqH96YUyeTOIckxDBkpC7ATIRbjzCwh9iOlSDor/L+I3W
 6So2G6gVYzrLAvppgUgnOw6uC/vrmFxNf6wGzQ0pF3wXcLbaXO4Nw1iWq65lOiKMOJ9M
 wt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5gVLkcooyTNnleYQe61DpXF/xKxVEtPc9IP+fcRQ+9k=;
 b=uBg2U/BbDaPislhrGZWc3Dm2tvpnuJbUub9zhfZqn6LqGuD0cdQbHM4ehff6NtGb8/
 kL+u5v05hckKyOWfTlHYe6VT0ktaBZp7skhfLLZYL9Pb+iojzdTDrRHNY1iwkQI51/WE
 BnXNcTLLCXG7I6mXmSxnKDkLf/zl3Eb3+GpSKU8uks7A9gAG8P7T8reXifNdDKaysCGz
 Z5wgjBYa9aH8hNTo/1ipgdgad18u2qsu9O0ynSnT4z4uAa8+Io59DeBRaScsyk6CmgeD
 jQCE/L9LSq8kJiovdp8eT7sKES1j9yh9ad3pQvCRfcFKzLpdKbL+8jFqA3O/kVw8HOeg
 viAA==
X-Gm-Message-State: APjAAAVz+gvKtmafHq0bRDeRYLUwEaX6HYDGMvZBxSnTVcvi2lxiuG0Q
 7mvMqmZk1kwQ8vRIWPywjHd0dwTNWQSjkhHFyME=
X-Google-Smtp-Source: APXvYqwFK41k9e08V9jpGrHhlSCLBfB9nz5ePcvyILwPsDsCpQvunCWm6YdO01DLNEN2aHiea23WfGJ6KOs1k9oX+dg=
X-Received: by 2002:a9d:7305:: with SMTP id e5mr14505475otk.64.1581634088546; 
 Thu, 13 Feb 2020 14:48:08 -0800 (PST)
MIME-Version: 1.0
References: <1581603905-21565-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1581603905-21565-3-git-send-email-Filip.Bozuta@rt-rk.com>
In-Reply-To: <1581603905-21565-3-git-send-email-Filip.Bozuta@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 13 Feb 2020 23:47:48 +0100
Message-ID: <CAL1e-=gbxdb7MC5zXOcv-XAdKA92N9eLLkmxEL2Nz9KE0O-+Ag@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tests/tcg/multiarch: Add tests for implemented
 alsa sound timer ioctls
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Content-Type: multipart/alternative; boundary="000000000000033671059e7ce206"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000033671059e7ce206
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

3:26 PM =C4=8Cet, 13.02.2020. Filip Bozuta <Filip.Bozuta@rt-rk.com> =D1=98=
=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> +int main(int argc, char **argv)
> +{
> +    char ioctls[15][35] =3D {"SNDRV_TIMER_IOCTL_PVERSION",
> +                           "SNDRV_TIMER_IOCTL_INFO",
> +                           "SNDRV_TIMER_IOCTL_NEXT_DEVICE",
> +                           "SNDRV_TIMER_IOCTL_PARAMS",
> +                           "SNDRV_TIMER_IOCTL_TREAD",
> +                           "SNDRV_TIMER_IOCTL_STATUS",
> +                           "SNDRV_TIMER_IOCTL_GINFO",
> +                           "SNDRV_TIMER_IOCTL_START",
> +                           "SNDRV_TIMER_IOCTL_GPARAMS",
> +                           "SNDRV_TIMER_IOCTL_STOP",
> +                           "SNDRV_TIMER_IOCTL_GSTATUS",
> +                           "SNDRV_TIMER_IOCTL_CONTINUE",
> +                           "SNDRV_TIMER_IOCTL_SELECT",
> +                           "SNDRV_TIMER_IOCTL_PAUSE"};
> +
> +    bool (*const funcs[]) (int, bool) =3D {
> +          test_pversion,
> +          test_next_device,
> +          test_tread,
> +          test_ginfo,
> +          test_gparams,
> +          test_gstatus,
> +          test_select,
> +          test_info,
> +          test_params,
> +          test_status,
> +          test_start,
> +          test_pause,
> +          test_continue,
> +          test_stop,
> +          NULL
> +    };
> +

Order of these two arrays don't match, and that leads to the wrong choice
of test function later on in the code. For example, if one chooses
"SNDRV_TIMER_IOCTL_STATUS" in the command line, one will end up testing
"SNDRV_TIMER_IOCTL_GSTATUS", if one chooses "SNDRV_TIMER_IOCTL_INFO", one
will end up testing "SNDRV_TIMER_IOCTL_NEXT_DEVICE", etc. Nice feature
(ability to test just a single ioctl), but it needs to be fixed.

Thanks,
Aleksandar

--000000000000033671059e7ce206
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PHAgZGlyPSJsdHIiPjwvcD4NCjxwIGRpcj0ibHRyIj4zOjI2IFBNIMSMZXQsIDEzLjAyLjIwMjAu
IEZpbGlwIEJvenV0YSAmbHQ7PGEgaHJlZj0ibWFpbHRvOkZpbGlwLkJvenV0YUBydC1yay5jb20i
PkZpbGlwLkJvenV0YUBydC1yay5jb208L2E+Jmd0OyDRmNC1INC90LDQv9C40YHQsNC+L9C70LA6
PGJyPg0KJmd0Ozxicj4NCiZndDsgK2ludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndik8YnI+
DQomZ3Q7ICt7PGJyPg0KJmd0OyArwqAgwqAgY2hhciBpb2N0bHNbMTVdWzM1XSA9IHsmcXVvdDtT
TkRSVl9USU1FUl9JT0NUTF9QVkVSU0lPTiZxdW90Oyw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O1NORFJWX1RJTUVSX0lPQ1RMX0lORk8m
cXVvdDssPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAmcXVvdDtTTkRSVl9USU1FUl9JT0NUTF9ORVhUX0RFVklDRSZxdW90Oyw8YnI+DQomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O1NORFJWX1RJTUVS
X0lPQ1RMX1BBUkFNUyZxdW90Oyw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCZxdW90O1NORFJWX1RJTUVSX0lPQ1RMX1RSRUFEJnF1b3Q7LDxicj4N
CiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7U05E
UlZfVElNRVJfSU9DVExfU1RBVFVTJnF1b3Q7LDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7U05EUlZfVElNRVJfSU9DVExfR0lORk8mcXVv
dDssPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAm
cXVvdDtTTkRSVl9USU1FUl9JT0NUTF9TVEFSVCZxdW90Oyw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O1NORFJWX1RJTUVSX0lPQ1RMX0dQ
QVJBTVMmcXVvdDssPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAmcXVvdDtTTkRSVl9USU1FUl9JT0NUTF9TVE9QJnF1b3Q7LDxicj4NCiZndDsgK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7U05EUlZfVElNRVJf
SU9DVExfR1NUQVRVUyZxdW90Oyw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCZxdW90O1NORFJWX1RJTUVSX0lPQ1RMX0NPTlRJTlVFJnF1b3Q7LDxi
cj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7
U05EUlZfVElNRVJfSU9DVExfU0VMRUNUJnF1b3Q7LDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7U05EUlZfVElNRVJfSU9DVExfUEFVU0Um
cXVvdDt9Ozxicj4NCiZndDsgKzxicj4NCiZndDsgK8KgIMKgIGJvb2wgKCpjb25zdCBmdW5jc1td
KSAoaW50LCBib29sKSA9IHs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCB0ZXN0X3B2ZXJzaW9u
LDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIHRlc3RfbmV4dF9kZXZpY2UsPGJyPg0KJmd0OyAr
wqAgwqAgwqAgwqAgwqAgdGVzdF90cmVhZCw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCB0ZXN0
X2dpbmZvLDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIHRlc3RfZ3BhcmFtcyw8YnI+DQomZ3Q7
ICvCoCDCoCDCoCDCoCDCoCB0ZXN0X2dzdGF0dXMsPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAg
dGVzdF9zZWxlY3QsPGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgdGVzdF9pbmZvLDxicj4NCiZn
dDsgK8KgIMKgIMKgIMKgIMKgIHRlc3RfcGFyYW1zLDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKg
IHRlc3Rfc3RhdHVzLDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIHRlc3Rfc3RhcnQsPGJyPg0K
Jmd0OyArwqAgwqAgwqAgwqAgwqAgdGVzdF9wYXVzZSw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDC
oCB0ZXN0X2NvbnRpbnVlLDxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIHRlc3Rfc3RvcCw8YnI+
DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCBOVUxMPGJyPg0KJmd0OyArwqAgwqAgfTs8YnI+DQomZ3Q7
ICs8L3A+DQo8cCBkaXI9Imx0ciI+T3JkZXIgb2YgdGhlc2UgdHdvIGFycmF5cyBkb24mIzM5O3Qg
bWF0Y2gsIGFuZCB0aGF0IGxlYWRzIHRvIHRoZSB3cm9uZyBjaG9pY2Ugb2YgdGVzdCBmdW5jdGlv
biBsYXRlciBvbiBpbiB0aGUgY29kZS4gRm9yIGV4YW1wbGUsIGlmIG9uZSBjaG9vc2VzICZxdW90
O1NORFJWX1RJTUVSX0lPQ1RMX1NUQVRVUyZxdW90OyBpbiB0aGUgY29tbWFuZCBsaW5lLCBvbmUg
d2lsbCBlbmQgdXAgdGVzdGluZyAmcXVvdDtTTkRSVl9USU1FUl9JT0NUTF9HU1RBVFVTJnF1b3Q7
LCBpZiBvbmUgY2hvb3NlcyAmcXVvdDtTTkRSVl9USU1FUl9JT0NUTF9JTkZPJnF1b3Q7LCBvbmUg
d2lsbCBlbmQgdXAgdGVzdGluZyAmcXVvdDtTTkRSVl9USU1FUl9JT0NUTF9ORVhUX0RFVklDRSZx
dW90OywgZXRjLiBOaWNlIGZlYXR1cmUgKGFiaWxpdHkgdG8gdGVzdCBqdXN0IGEgc2luZ2xlIGlv
Y3RsKSwgYnV0IGl0IG5lZWRzIHRvIGJlIGZpeGVkLjwvcD4NCjxwIGRpcj0ibHRyIj5UaGFua3Ms
PGJyPg0KQWxla3NhbmRhcjwvcD4NCg==
--000000000000033671059e7ce206--


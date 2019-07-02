Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E59C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:21:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 411DD21479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411DD21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiGr8-0003w3-JW
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 07:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56340)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hiGlm-0008MS-EY
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hiGlj-0006vQ-Ct
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:16:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51848)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hiGlj-0006nQ-35
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 07:16:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so461990wma.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 04:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=VSiOwhKmunyZTXresUcTs7kbbf4PY+elQ9HSwQcUwfo=;
 b=WKy3EV7RyM1qrvQRm4xxPk0pBAqCfJH7KGyPfYKk3xeR+z47aXjCUVYLW0tcV9uvvL
 fj8A/M2P5pTKlnfHXK8+mNwCdmxFeB+Ii/1yjbWHwsuu6n52u5yxLtOIu94b8TutaixC
 /9kUwVvvyTKxXepn5H1dB6gG+q0LlfGgcrWmQOWDgWd4ajbCKNgFiCiDQhWdrXCc4lZ2
 AkrjF9JWbQEy1ES3iqXxtaSy9nGxGYPaWbJPofGCxIgG4VtbuIHtiw1cL8YITrtxxk1h
 IMwcjTzqkFpc5lT4UpPPe4qJZZMt3Y1G8VTK8WkXI15Z6rsNDk1NEBc14iR9U9dd7kyi
 da3g==
X-Gm-Message-State: APjAAAU4SLBZ8uR1PPmNs2QcqL0402qiFmMaBohDnSBkwFydV0mgAHi7
 df6zl1EHSdXOVT0JTLYaWjlVOQ==
X-Google-Smtp-Source: APXvYqwQbkkyKFhb2zalJqJ2ZhV0CuDIgkhs2cvKcZ0O5DekISps0BbxtgFmAKa4fqnAbarbKUgJ1g==
X-Received: by 2002:a7b:cae2:: with SMTP id t2mr3091277wml.157.1562066171546; 
 Tue, 02 Jul 2019 04:16:11 -0700 (PDT)
Received: from dritchie.redhat.com (18.red-83-35-20.dynamicip.rima-tde.net.
 [83.35.20.18])
 by smtp.gmail.com with ESMTPSA id x16sm1901979wmj.4.2019.07.02.04.16.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 02 Jul 2019 04:16:11 -0700 (PDT)
References: <20190701144705.102615-1-slp@redhat.com>
 <20190701144705.102615-5-slp@redhat.com>
 <20190702081914.ulccsaokivd6epgv@steredhat> <877e90ygab.fsf@redhat.com>
 <e980826e-4e8d-7bdd-827a-63d8ce9a08ba@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
In-reply-to: <e980826e-4e8d-7bdd-827a-63d8ce9a08ba@redhat.com>
Date: Tue, 02 Jul 2019 13:16:08 +0200
Message-ID: <874l44y9dz.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/i386: Introduce the microvm
 machine type
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
Cc: ehabkost@redhat.com, maran.wilson@oracle.com, mst@redhat.com,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 02/07/19 10:47, Sergio Lopez wrote:
>>> Could it be useful to support initrd as well?
>>>
>>> I'm thinking a possibility to a microvm to use only the initrd without a
>>> block device.
>> I agree, thanks for the suggestion. I'll add support for it.
>
> I'd like to take a look at adding firmware support too, so that we get
> linuxboot and multiboot for free.  This would also allow boot time
> comparisons.

I agree, but I'd prefer doing that on another iteration. This way we can
already introduce the machine type, with its basic set of features and
characteristics (which work in the sense it was initially intended), so
other projects can start experimenting with it.

Then we can add other options like ACPI and firmware support as knobs.

Sergio.



--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl0bPPgACgkQ9GknjS8M
AjVNoRAAmqI3J37xIWIRjP38Co+GepSU4VCKopyvTjEY6ew6Ykr+HdIFnCpjF4bS
VNVLdmn+rly4MHiXNlPifIds6pcSCACuIrNMtTHNACpM/VDRasp9wAEx3FSdGdbm
2Ake2mjHh1oEDY3zN0kVwOOo/azhSXbUmyosA3zKEH+AM4b+5ba+oSSL9WAYqW+M
pRsgNqyEC6iT9aMtSKx1ExJZvThcHrO/ooEiQ+EbIKy6ajNpa/DrkAAoXbKvfXc/
5YqnPybHgdTmcJK2YD5QtUXtRc780/mc7WUPmXGLqkKa+ZtwXfSm9ZDY2KlGF+zb
becPGTtx8le4Xhx1WgnLg/2ltgtvmgmAkyqXH0liE4/KCz40JxRKMT0ZhuABiQmi
SFAMeNrkWAelXPrvuBwV457NkeiTB05NnvXPw+3LDGmZfisiHSi5oGzghsxZcCQs
uNgn+91Grl0teDgzDLlHkw9AgKTlfwvvVfOGfJkwGdcMbvTjJ4/bBtB7Ly9rzJCg
18NyfNwNw2xaNKIjaqDm8z/faVqBeQqpSZCFudcMWw+0N50Rx1YWkRdOzCNV48jS
K3zbHtNt5jfbOfrpewBdVsuZqgmphPtjb9SFJ48MPHkKehS22UlTyM2ZtzmHnMEC
witMaSI8TP6zX1QfriMqU8OTbRdeWwj+/7YV5oftYP8IoysGBr8=
=rErC
-----END PGP SIGNATURE-----
--=-=-=--


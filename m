Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698B5C32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F174218DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 10:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F174218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFyF7-0008Kz-CS
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 06:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iFyD9-0006h4-Mb
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iFyD8-0007ao-Py
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:19:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55996)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iFyD8-0007aa-HQ
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 06:19:50 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 88AE12DD3B
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 10:19:49 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id m16so497866wmg.8
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 03:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to;
 bh=GDRq+Y9wrO/qw4EoU2FcteS8Wu/uIkZRuZRNRF5nhhs=;
 b=biuNOuG90VmEpeWGnUiosloiOayhl7zvOc6UmQyd4yZ2Fb9wkfDEeU82Bgf2GUHYbL
 KGUiY1ON7DOE10TJRwt+BIlMIWOsAHUfG5qbdEK3tAn3Bm6UEQ6OGx1JlYm8B37+5QG8
 LQBycM9t8ZNYF0Bk07gXiMaKfU8lhcugKVqjdiKx0eN+cQfhv3b1bznwx1dWDWhZhYC3
 i9SCjtXOY75pvILBWPVQIUTLcTpQZAYR57OC0CADDyc6iSYZpD8HhMQ68CixS7tzxh+3
 q1Al8vFBIO3CwSKMhDIwqyUbPetTCsfGe0Qpe0G/4LP8W1HMbnJ04zhIWkgOfGZ7gCvM
 EwBQ==
X-Gm-Message-State: APjAAAVej1ZT4ZUHE01sZzIxyNBO0/pcuHWr36WEa0Ifz30/MDPktfsd
 H7HKLk6RU/CPeaFO14LMcRVqaAw5rUqZYO8THGPhp4pZr9oR6pGa34nmnIsdVXuDJzOEzIHvQM4
 899IBBbTIUxH1Pp4=
X-Received: by 2002:a1c:e0d6:: with SMTP id x205mr1569241wmg.1.1570097988069; 
 Thu, 03 Oct 2019 03:19:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy7/HNdWcqfii2tZKF8qEoxVFdHpp5WO3PePQ/mJWeQ8CWGx8FtrZwYEjn0Mun2VKqq+xQWeQ==
X-Received: by 2002:a1c:e0d6:: with SMTP id x205mr1569232wmg.1.1570097987689; 
 Thu, 03 Oct 2019 03:19:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b903:6d6f:a447:e464?
 ([2001:b07:6468:f312:b903:6d6f:a447:e464])
 by smtp.gmail.com with ESMTPSA id u7sm2262829wrp.19.2019.10.03.03.19.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2019 03:19:46 -0700 (PDT)
Subject: Re: [PATCH v5 08/10] roms: add microvm-bios (qboot) as binary and git
 submodule
To: Sergio Lopez <slp@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20191002113103.45023-1-slp@redhat.com>
 <20191002113103.45023-9-slp@redhat.com> <87lfu2i1mh.fsf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <59b1b371-f0f3-de63-6cac-dbb86e17c1d1@redhat.com>
Date: Thu, 3 Oct 2019 12:19:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87lfu2i1mh.fsf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="F78VcbdjmBdVdGjEtKV0SlgStRy5HYv38"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, mst@redhat.com, lersek@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, imammedo@redhat.com,
 sgarzare@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F78VcbdjmBdVdGjEtKV0SlgStRy5HYv38
Content-Type: multipart/mixed; boundary="STtjLXKDeA8DKQRlIXDsuCUVoEvGDLJrQ";
 protected-headers="v1"
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sergio Lopez <slp@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com,
 marcel.apfelbaum@gmail.com, rth@twiddle.net, ehabkost@redhat.com,
 philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com, sgarzare@redhat.com
Message-ID: <59b1b371-f0f3-de63-6cac-dbb86e17c1d1@redhat.com>
Subject: Re: [PATCH v5 08/10] roms: add microvm-bios (qboot) as binary and git
 submodule
References: <20191002113103.45023-1-slp@redhat.com>
 <20191002113103.45023-9-slp@redhat.com> <87lfu2i1mh.fsf@redhat.com>
In-Reply-To: <87lfu2i1mh.fsf@redhat.com>

--STtjLXKDeA8DKQRlIXDsuCUVoEvGDLJrQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03/10/19 12:07, Sergio Lopez wrote:
>=20
>> qboot is a minimalist x86 firmware for booting Linux kernels. It does
>> the mininum amount of work required for the task, and it's able to
>> boot both PVH images and bzImages without relying on option roms.
> I've just noticed all other submodules refer to mirrors hosted in
> git.qemu.org. What's our policy regarding this submodules? Can we add a=

> reference to an external repo or should I somehow request a mirror in
> the aforementioned repo?

We usually start with an external repo and then sooner or later change
it to a mirror on qemu.org.

Paolo


--STtjLXKDeA8DKQRlIXDsuCUVoEvGDLJrQ--

--F78VcbdjmBdVdGjEtKV0SlgStRy5HYv38
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl2Vyz4ACgkQv/vSX3jH
roMJ2Af+K7Z5HNPVoen28tcg0DbhGx3n+IQElA6ZAAA9z0nIAR8XEoMiCE01goC+
8bCr3/Fwk6X0X8zpD3FtSKFYFpAcxY/efCv3OeEplX4oziNf0JKxEOBjFwRrrJpM
CdDqE0xS+deFowzw2FSBH3z7dLU+AgYtcmLkAH4SZxgJWzx2bqFd0GrrDGXt+3B/
1SWynvBSqh9gpH0BTE+6h+aAF4MK3tH1rSm2iRJSbgsD/BZqEW+sU7J4y/CAKrd2
3ycYfORGhSohMltSvt8ZcJ3Ch/rsLw4XXJVGjUE17sSQ0hKMhEBTwn8j1EhvO0Cb
Dv+zHSFtPhvfosywzZWKrF0myYdB6A==
=gePN
-----END PGP SIGNATURE-----

--F78VcbdjmBdVdGjEtKV0SlgStRy5HYv38--


Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90315C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 09:59:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591BA2074D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 09:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VY8enEoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591BA2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJwde-0008D6-IK
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 05:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jJwd1-0007Z1-JT
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:59:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jJwd0-00063v-EE
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:59:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51359
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jJwd0-00063S-At
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585821553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bYJz8UBRrNj3MPpag7qiVmHNTPTcSrtNZp7+exnqYA8=;
 b=VY8enEoCxxANlFBDaWveceq7O9Noe2WvfKEHbe0OsZyyd1nd1TflDn7k+GA8WLjuTF8IEu
 KwefT9fWzXlXMHBsoGhwRsx92Bd9Ddpx/3nKLnY8Qm8DzDKJwwnBfgHqu/alE/wiQgkOMB
 mbMuNGUW3MnCt3kmv9Jumpkz6ic+wyc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-F_FuS2RJO_Oy_Tl6EpMUKw-1; Thu, 02 Apr 2020 05:59:10 -0400
X-MC-Unique: F_FuS2RJO_Oy_Tl6EpMUKw-1
Received: by mail-wm1-f70.google.com with SMTP id c21so845913wmb.3
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 02:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=kcM+lIQaFPCujnSX/yJSGlUbqRxnq+GCz6SpXdNKbLU=;
 b=o+GXPqQQ9NiP3NHKe7ykIxQXEA+6WmXZ3IAtSrFj66E+WwPgTDnzkHutXe8hr3rNlL
 +AmCM6NjOkMxPPpo+k1r/4hJD9gtY/Bga3eUSlCAPsN1NMEdXmd7TruuC85kzF+3gFdW
 TvyMGBoillwVRHV9Tupcv7VrrtVzXMrdBPQ8Dl+4iIDNSL0WIC6PgAvPMu8vkKjbNq4P
 Q6LQJYFuIskrB6+EdoUD7El9PusJD2sOl1dcuRQVNctfKRwvgGv849vQTKT9TeMvlywQ
 4mHZ5S61fm0SoMWoelWlNoM5i24diNAaAQzntt2bcPNuTvHR2X/DUDUVACUeWah+/OPp
 tl2A==
X-Gm-Message-State: AGi0PubFBA32wUTiAV4vUEw/ZlyuN/HSE8ejA9fdwXvJMFcKCq2LTrFN
 oDn6EF+Zrg8YDd0lkGTvv5x754KAVDxvKU2n2jXtDG8X//ShpS5u69/8CPEct+X+J4DTA2FKK3f
 HrNpAOvnQ+9RoOMQ=
X-Received: by 2002:a1c:f315:: with SMTP id q21mr2640261wmq.169.1585821548720; 
 Thu, 02 Apr 2020 02:59:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypJKvesvk4MEiJaQwj1KlrmIwFAj6ww+JwcmKoiGzWFwdKrZtauDfOOupZAwB8lon75RXuLs5g==
X-Received: by 2002:a1c:f315:: with SMTP id q21mr2640243wmq.169.1585821548459; 
 Thu, 02 Apr 2020 02:59:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1868:42dd:216c:2c09?
 ([2001:b07:6468:f312:1868:42dd:216c:2c09])
 by smtp.gmail.com with ESMTPSA id t6sm6250937wma.30.2020.04.02.02.59.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2020 02:59:07 -0700 (PDT)
Subject: Re: [PATCH v2] util/async: Add memory barrier to aio_ctx_prepare
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200402024431.1629-1-fangying1@huawei.com>
 <20200402093221.GD28280@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7de4d886-d861-5c80-f669-098b730906c8@redhat.com>
Date: Thu, 2 Apr 2020 11:59:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200402093221.GD28280@stefanha-x1.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7fYZeEc37bDDNzeSKpHMy6djmskiuXbhL"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: fam@euphon.net, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, qemu-arm@nongnu.org, Ying Fang <fangying1@huawei.com>,
 wu.wubin@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7fYZeEc37bDDNzeSKpHMy6djmskiuXbhL
Content-Type: multipart/mixed; boundary="ARsgMU4D6t2OXgPmm6TrvkE6RHKAjBl9w"

--ARsgMU4D6t2OXgPmm6TrvkE6RHKAjBl9w
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02/04/20 11:32, Stefan Hajnoczi wrote:
> Paolo, I'm not sure how to interpret this case according to
> docs/devel/atomics.txt.  Maybe you can clarify.
>=20
> atomic_or() is sequentially consistent and I therefore expected it to
> act as a barrier.  Or does sequential consistency only cover the memory
> accessed via the sequentially consistent atomics APIs and everything
> else (like aio_compute_timeout()) can be reordered?

Yes, that's what I expected too when I wrote that code. :(  But Torvald
Riegel explained a while ago that seq-cst accesses are actually weaker
than e.g. the Linux kernel atomics[1].

The difference basically only matters if you are writing the relatively
common synchronization pattern

=09write A=09=09=09=09write B
=09smp_mb()=09=09=09smp_mb()
=09read B=09=09=09=09read A
=09if not B then sleep=09=09if A then wake up the other side
=09do something

because you must either use memory barriers as above, or use seq-cst
writes *and* reads.  You cannot rely on having a memory barrier implicit
in the writes.

Paolo

[1] https://lists.gnu.org/archive/html/qemu-arm/2019-10/msg00051.html


--ARsgMU4D6t2OXgPmm6TrvkE6RHKAjBl9w--

--7fYZeEc37bDDNzeSKpHMy6djmskiuXbhL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl6Ft2oACgkQv/vSX3jH
roMn6gf9G8iYNeFAnctSRlfxhtoLOahjINkoihuLe14ZwXCPJXugXey7TUiY7y6t
H30E1NGCfcgqxtMZhFVDl18AyptkE3kMXAJiI083YUcm6gZVYji8YWKq16EROk58
N1Y2YbSj9PXchZboZLXMfhho0fRCOA5kP+bXpEOOHOlcxMmgLXg9SYNVXIGy/hsK
+oUIF3WHn+AJyu1B7l3DLl+7HRGcR9VL5qp+Ka418KbtFs3m3TWpfNVVFOkWe9Kx
oVJmmR8GM1Ow1sWaYAtaNSKVUVgr5sjzroLleC2Y+52gUehV9jEKkMxKjCerNwiD
BvTYzBOxxuE374YmXGXlHxHtL1rhww==
=+IeU
-----END PGP SIGNATURE-----

--7fYZeEc37bDDNzeSKpHMy6djmskiuXbhL--



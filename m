Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EFDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D752082F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wv85fD/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D752082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqFfo-0006wB-PM
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 08:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldoktor@redhat.com>)
 id 1jqFex-0006LR-6R
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:46:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46864
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ldoktor@redhat.com>)
 id 1jqFev-0006Bn-I5
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593521204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/nwEW3zaW0aZneDcbDb8T/CLVNd4l8W1NfhfGLPSvNs=;
 b=Wv85fD/L3+fjxVCQ6eUVpnKmq+N9Wx92RrZC3MbAJCL9n6js5X30ns2SKVIx5FdoulWxt1
 912uIyk31/C1TFYsrwd1vndYZu2fLslsZufU7JXKTuSqIf8O/J/p34IkB1mDyVpGKJqyCJ
 pfM2tQrsb2vDSmiKIlUrEnNVU0Os+WI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-r-P56aeYPPG6vZ81LWsJOg-1; Tue, 30 Jun 2020 08:46:40 -0400
X-MC-Unique: r-P56aeYPPG6vZ81LWsJOg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69AFA80400E;
 Tue, 30 Jun 2020 12:46:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D83E48504;
 Tue, 30 Jun 2020 12:46:37 +0000 (UTC)
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
 <5ff8e75e-787e-a34d-2b3c-da63e2e46e1f@redhat.com>
 <CALTWKrUOjwi9xG7vXCQ9sXStFaPh782ytwwPbztAp_PNuHFHYA@mail.gmail.com>
 <CAHiYmc7tYYWb6AMQeFtCOQFXWbzB4+jGx1Zia+uvDd8ej+rieg@mail.gmail.com>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Autocrypt: addr=ldoktor@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFcV6vsBCADa8NUYov+a+AmCEEUB3stiiMM0NQc1WwlcxGoMxKHcqqIj/kdPhUDvFS32
 V94V7en1Lx+cpXKRMZP3n+3WG+VZWLwaktJgqrECZ161zE7xF5d1H3CLmwStbe6Cw1oR4LYQ
 HBpuqFEA5znoLuTTsP1uXs9h1cYNzX7hmOTvPCLJfDJ1iv954FsgCGtoVvl4CoxaR3u2VNOs
 hXsTTVyJM6gDTsyqn0uvLOHGWGIGVhDkLV4hv6pSdiKrtQKWIUji3Z8x41MbZybmJxHkpOVz
 Jl3jnNE3CbiEq77Is9LMI4yTF2CESs3V4XMBLfZPLrQBC0gzjeRxwCnbdOZRwY5KI457ABEB
 AAG0K0x1a2FzIERva3RvciAoUmVkIEhhdCkgPGxkb2t0b3JAcmVkaGF0LmNvbT6JAVQEEwEI
 AD8CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEF
 Al4caiwFCQsFbrUACgkQJrNi5H/PIsErWAf2OeTv2KSo5ukikdSA/iNItDXqqMhgrN0JbMad
 b82VYKKCFP+NXQy26NQqcKjaJlmv1Q4rYDfLvz+1gvnir6l9gg47g/EPC5s2UxGOlGz8fzgH
 cHne02PFEUKCNSlSZTJW8DCwFKN4VkPGqungJvDd9i8gC9B/TB3HH4IHr82mA3BnQ3wml9KH
 KXRoEJVR15cd6kKU55MRG0mq6VzYnW5Wwyxf0ZC6+R2tQgzxsvxRVPvQXSbcGv3kWoPgRo5a
 8IWzMB194tWVYNaqhMUPKZsgBUGF3JdzrwgDBAuC16mKgyMDrzH3X0ZZ3TXH+mQBXu/px5L8
 BMz/WAibkjPVTeqeuQENBFcV6vsBCADDwkgr2llR9lY1mKsEjA56+R1m7VouGAfzgR9fDjTK
 cwQVrW39zRto6K4s1xVt2ccsa9QBAnag3/6t0akRYhNVKMPEVh/ck6fJJkmEudCAYwbiPeZ0
 Vky5s8bUYkS65s8AAHSG5F+NBO86+kgrTcnYflwyi6DzrY4c6dP6Z+icau5ORI7Q8GrfC18/
 5neAsK4QOSYRlKHggrGzQKgtTgrFZFAemhM7FwCIfOPxybmpu7cJvUqtfPx0SZiEKrZ+kV/+
 H4Z8Q7yBT8gIkPxZBQdhxUrRtuJmyQJxI4a1K2PCrRCqK1kxtyw8Sx63/YvfPjgws+5UCm9z
 3A5Gz/eJP0GHABEBAAGJATwEGAEIACYCGwwWIQSkCkxFxANN4Cpa1IMms2Lkf88iwQUCXhxq
 TwUJCwVutQAKCRAms2Lkf88iwdfeCACyrlND9Kk27optBo2LMBJmoJAOJTl4o8YvWkrGFzK5
 NxWCpaRJCOCfQanACRDW3oEyd4CdLF4GXWsGhIgGymP2+/McpZXJdFwgHNQWtyZ8GHJW/TXr
 GphJ9FLskb2xh83RrLYy29eF+GeZcVLsGP1ZCLz3I6byhbEfklqKymB1q4bQl2cEijm/VK25
 cYpTtNa0SZiNCmfGqfQ60BtDHCjZm1x9GO+67pJmL2FuO0Tq2TtT+SgU1ZKbSYdPWPk2ZetD
 8RRkaPlrVRVGgW1w1/pCS29BHWaazjkmAVHE2Idh6O+7usA/G1Q3OEjWmJpmfwyKHI/rMv/f
 zMoMrrqg5DNH
Message-ID: <54168dd1-2907-37ef-20d4-9feddf7c7561@redhat.com>
Date: Tue, 30 Jun 2020 14:46:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc7tYYWb6AMQeFtCOQFXWbzB4+jGx1Zia+uvDd8ej+rieg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ldoktor@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SAMe1Kb90r8VXwSYEXEMtJsIHnCLcTvOM"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ldoktor@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:55:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SAMe1Kb90r8VXwSYEXEMtJsIHnCLcTvOM
Content-Type: multipart/mixed; boundary="8tXK0MNitJ17Y0Ru8tOEMePs0GNOtWP5k"

--8tXK0MNitJ17Y0Ru8tOEMePs0GNOtWP5k
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

> However, we know that the results for hosts of different architectures
> will be different - we expect that.
>=20
> 32-bit Intel host will also most likely produce significantly
> different results than 64-bit Intel hosts. By the way, 64-bit targets
> in QEMU linux-user mode are not supported on 32-bit hosts (although
> nothing stops the user to start corresponding instances of QEMU on a
> 32-bit host, but the results are unpredictable.
>=20
> Let's focus now on Intel 64-bit hosts only. Richard, can you perhaps
> enlighten us on whether QEMU (from the point of view of TCG target)
> behaves differently on different Intel 64-bit hosts, and to what
> degree?
>=20
> I currently work remotely, but once I am be physically at my office I
> will have a variety of hosts at the company, and would be happy to do
> the comparison between them, wrt what you presented in Report 2.
>=20
> In conclusion, I think a basic description of your test bed is missing
> in your reports. And, for final reports (which we call "nightly
> reports") a detailed system description, as Mr Lukas outlined, is,
> also in my opinion, necessary.
>=20
> Thanks, Mr. Lukas, for bringing this to our attention!
>=20

You're welcome. I'm more on the python side, but as far as I know different=
 cpu models (provided their features are enabled) and especially architectu=
res result in way different code-paths. Imagine an old processor without ve=
ctor instructions compare to newer ones that can process multiple instructi=
ons at once.

As for the reports, I don't think that at this point it would be necessary =
to focus on anything besides a single cpu model (x86_64 Intel) as there are=
 already many variables. Later someone can follow-up with a cross-arch comp=
arison, if necessary.

Regards,
Luk=C3=A1=C5=A1

> Yours,
> Aleksandar
>=20
>=20
>=20
>=20
>> Best regards,
>> Ahmed Karaman
>=20



--8tXK0MNitJ17Y0Ru8tOEMePs0GNOtWP5k--

--SAMe1Kb90r8VXwSYEXEMtJsIHnCLcTvOM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAl77NCwACgkQJrNi5H/P
IsGRFwgAhzIlIJt6bR5YXtR3/LSKLYpBFdYjhRENfiIAH2zeWeBZLDO0KruHFz/M
ggJLMWe6VzUmoCnDZCIRVWk3WMzaeJIxyEpgQp/Rqo5jNqIrEyfu+AZRHH3gj+hR
iKdL4efbdooB4Rea6MbvCISUCiPSAt2AOUj2SFvCpxSPyq/S/HCRGMyK5aIpX4Au
LBGwKuyXQKrGchf4CEcUIDN5tBCoen1llI1mywnygypdPyGR9F3rJY5x6wsRhghl
1ol78rW/or7r5s9iuXExHVVpAV54CxIJ4sV1gYsHdgfuvZbYln70cwex8WexvbyT
Ml9M+Pe/Nt9SIaqsKCdlHuPRuD8Pnw==
=wTGD
-----END PGP SIGNATURE-----

--SAMe1Kb90r8VXwSYEXEMtJsIHnCLcTvOM--



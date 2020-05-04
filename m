Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991D4C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:03:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A9220705
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OajrX9Wi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A9220705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbh8-0000Hm-HF
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jVbgB-0007BT-R8
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:02:43 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52673 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jVbgA-0006FU-5L
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:02:43 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49G4LP2B3Qz9sT1; Tue,  5 May 2020 00:02:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588600957;
 bh=VP5Ww3jNU/2Eh3MWgokM8Symu+c5/rWbfvmlaCqJujE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OajrX9WiJNt5iq8O3WL+J9pjgi3JMYKGX++dy00V8lsfDLUJQMRpk0vDt3SQKGCZw
 oQdI25n6Zao/jpjn1vG9qzYounkv1bgdiXE5CU6I6VpvY7EjZGyCCJN1SKwoRVN85f
 HfgHOq1nz7TZRNb2d7ygt5q1OYiDpMVWd1/YTew8=
Date: Mon, 4 May 2020 18:24:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH RESEND v3 1/2] Makefile: libfdt: build only the strict
 necessary
Message-ID: <20200504082440.GC13695@umbus.fritz.box>
References: <20200411093150.4741-1-cfontana@suse.de>
 <20200411093150.4741-2-cfontana@suse.de>
 <06e9c2cc-9fc9-693b-a342-22622cb1ff2e@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
In-Reply-To: <06e9c2cc-9fc9-693b-a342-22622cb1ff2e@suse.de>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 10:02:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe Mathieu-Daude <philmd@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Alex Bennee <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2020 at 01:47:47PM +0200, Claudio Fontana wrote:
> just a gentle ping on this one, now that 5.0 is out, is proceeding
> with this ok?

Yes, go for it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6v0UYACgkQbDjKyiDZ
s5LCpxAAwCREVGZAiBOFIigZoTJugB1z/LVcus5q6V+5gn0i52R18ytgKhGrNtcv
8Ta5eP57/VZT3XuKGEpvzGYT5SXOHH7Rgf5IjYdwzc8HAVwZfoMIfctHlpYVLYdN
LpxOcTTbreGv3Rs+qofByo9ov37ZTIhY2FPVbbGCPfCY5wuTlJtZX8MfJILon4tG
qzhzQAam7sAbfqJdeo4Dm19ngTzCgTTlZWiH/UPw4HbRS8+z+bt2vMzezQlHEs/k
gIVoIcw1Ue3bwIh36dlEg2vdjWG9Ox3qLXUWUrkwD+tQWi2Rrheu0PXSL0WFsk0w
JbsTN2BjDbmhRVL/pfWD1VHrldFBYJvoTTdpEYZPwBeGrINLHCZ3lDFL6Lx3YC6q
ZpwK+TEho5Ul6wMcd6P8HL3W2u+bN3qy7Y0UQH4KZYRMkfYkdF7996BjVOlj27zH
l+sGHh9x1BGwy5lhO0XNj0ZLa7rFrXRaVvdRfagYR0gS4R+Y1dWpb9Hoo4gsOtoD
lQB6tT0nm7Q0J01Bv/NcdxCGhCYNLMQMRhf2PkJ1JARQJRnqkKImakk+OCqtiOTb
UmtG1VuP+WvtZhUIEIBczRXjA9HTxzf0KY+twtMoWnivafOjBYaEENwQ4c/LdPOT
BzTDKR7nTLlUmTLuHkhQJIrZ8VKmy3YN3oB2nGuQGHcAwtOnDU0=
=lrdB
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--


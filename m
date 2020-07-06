Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D433C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 07:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4906F20724
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 07:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbtbYnSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4906F20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsLgt-0003p8-It
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 03:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jsLgH-0003OX-OD
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 03:36:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32366
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jsLgE-0006Az-OA
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 03:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594021005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=N0niEkmlHZxu3AUFQIuBOHU5EczKvQ63r4BHscBfqK0=;
 b=SbtbYnSYScHXedQ3CvmBtuR5kNGtOkK2uZZ07VmgnefWJaWfWQKdi3s9ZvpqYtcLOHk7KL
 l6mkUuqU9ii7LEDfT5zOUoBa50avEg8+er7sD32s/ATbjpTECiPYMOsGqNutG1mVhpEUJ8
 uxhLOODOsLfyDYgPzsqNtgJVW9SF8EU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-hZQwsm-9PK-vO7MlSjKeuA-1; Mon, 06 Jul 2020 03:36:43 -0400
X-MC-Unique: hZQwsm-9PK-vO7MlSjKeuA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B48E800406;
 Mon,  6 Jul 2020 07:36:42 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-144.ams2.redhat.com [10.36.112.144])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C459275E34;
 Mon,  6 Jul 2020 07:36:41 +0000 (UTC)
Subject: Re: [PULL 5/6] hw/m68k/mcf5206: Replace remaining hw_error()s by
 qemu_log_mask()
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200706072835.23582-1-thuth@redhat.com>
 <20200706072835.23582-6-thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9b84407f-cf8d-b733-6db1-0c50c9a0f33f@redhat.com>
Date: Mon, 6 Jul 2020 09:36:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200706072835.23582-6-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xeNciyHMzf6BcDqjJhLV21D9RRlRg1qqr"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:52:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xeNciyHMzf6BcDqjJhLV21D9RRlRg1qqr
Content-Type: multipart/mixed; boundary="CEXXI7mmX1TAfLdm0muBnqZCSTPX4OzrZ";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
Message-ID: <9b84407f-cf8d-b733-6db1-0c50c9a0f33f@redhat.com>
Subject: Re: [PULL 5/6] hw/m68k/mcf5206: Replace remaining hw_error()s by
 qemu_log_mask()
References: <20200706072835.23582-1-thuth@redhat.com>
 <20200706072835.23582-6-thuth@redhat.com>
In-Reply-To: <20200706072835.23582-6-thuth@redhat.com>

--CEXXI7mmX1TAfLdm0muBnqZCSTPX4OzrZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06/07/2020 09.28, Thomas Huth wrote:
> From: Thomas Huth <huth@tuxfamily.org>
>=20
> hw_error() dumps the CPU state and exits QEMU. This is ok during initial
> code development (to see where the guest code is currently executing),
> but it is certainly not the desired behavior that we want to present to
> normal users, and it can also cause trouble when e.g. fuzzing devices.
> Thus let's replace these hw_error()s by qemu_log_mask()s instead.
>=20
> Message-Id: <20200611055807.15921-1-huth@tuxfamily.org>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Thomas Huth <thuth@tuxfamily.org>

I just noticed that I had a typo in my e-mail address here :-(

Peter, FYI, I fixed it and pushed the same tag (pull-request-2020-07-06)
again, latest commit ID is now 8c4329214f1d4484205e6f7c48e98ff26969eb56.

Sorry for the inconvenience.

 Thomas


--CEXXI7mmX1TAfLdm0muBnqZCSTPX4OzrZ--

--xeNciyHMzf6BcDqjJhLV21D9RRlRg1qqr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl8C1IcACgkQLtnXdP5w
LbUo3BAAlE46Gv4SO4L6YymKvQLRlSiJL4cUIRHN9FXGMOxJJEjetNTkm5BSVPU+
V2wvYGViuP3tXP1i5tuJB2z4UlmWe0xgeUvG00Oxad/UQEKEVKurpMVD1F9HKj/a
LbxbI0a8s+eTdoXQdz3Dfa6m0r6sbJXy0G5qbK/JO7QlEsIBPOR37sEB1J+c/GLQ
cjJMXuhkL6rtF0XS8G4sn5thU6tjwTklD5zEBQlP9PCXprZCO4RzyfGom7HeybLG
Su7jwT4sMzqFcIFWHZ+D2Y6jZF7O1rHpG9TuHrFBBPPFZZ1SXM4rcO+KSoM2bVrA
eMsHuK6BwK8yggE6F5o6Ia0VLYn4KrwsgBRM73Ck0+nsZLygxi3xTh0hz5MB8jRF
878L9X2VYfLg9v7Atn3YJf6T6Lc3ZQtJfK+ccTavc4c9duBNO4vqAbXTEGMLSs6r
9UmdAa9w67DtNB13rDHyrbUszPAjiQdTT8TvqHGW64/F+ZBa0PGwJJjxJg2VlGIz
vZXogRTIkPNJxmtYviFirhVf4U3XPuNviLfm3XjWtVAYtn9uR30pgAcsy1BcD1hM
Yg+8ENmQwSNdDQWK6/FfF7oDDk7BoMRZPQZBqZ6srKhqLWexpN87CEzWbC6zUFMU
fGaZ+t42UHp+dx0nmsaPV1cIsb9xxw0YYLHDlcCFBtaEAQR9TZI=
=moEc
-----END PGP SIGNATURE-----

--xeNciyHMzf6BcDqjJhLV21D9RRlRg1qqr--



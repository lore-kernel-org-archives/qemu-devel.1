Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F564C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 15:00:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2F720709
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 15:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2F720709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dlrobertson.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZyIw-00040O-Qz
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 11:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan@dlrobertson.com>)
 id 1jZyI2-0003S4-PL
 for qemu-devel@nongnu.org; Sat, 16 May 2020 10:59:50 -0400
Received: from sender4-op-o13.zoho.com ([136.143.188.13]:17385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dan@dlrobertson.com>)
 id 1jZyI1-0003jd-UU
 for qemu-devel@nongnu.org; Sat, 16 May 2020 10:59:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589641170; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lJbCIdFOIi4QqTdyVGvQpR+KMh6tI0Bcli0ivqhIGaWHi7yYsxw7Dtn0H4qvVIJnJ8WRh7VA4wigWz74cXnGZQRE2zPnWUsPSOBwmJ3UmaFIIzNLoqwEMoH8/VjhwQnyRLOoOnd1/Nu7LBrMKqbR448nHkiEzauP/K0PyvLrK8c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589641170;
 h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=ZEOVGOEfzABW61IDz46pXaFGLg4q3vjqXMIPU9Dnv20=; 
 b=oA6WIvm9TBuuqLYBrq04sWtb9k4FWm6jzu8khZlLGdji7c3d4Gp1Ffm5y8MoIUV1DpcagLoQ2nsqr657mEZD91MPXJ2KmTc0Ysn8VCK88iO1V7pfKt1RR/6BLIAdacsJYhc/JROHI2rqOKqO3wYxeAFFttjfGjnw4aQm0PCsWyI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=dan@dlrobertson.com;
 dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie (pool-96-255-47-18.washdc.fios.verizon.net
 [96.255.47.18]) by mx.zohomail.com
 with SMTPS id 1589641169080428.11878363805874;
 Sat, 16 May 2020 07:59:29 -0700 (PDT)
Date: Sat, 16 May 2020 14:41:14 +0000
From: Dan Robertson <dan@dlrobertson.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 1/1] 9pfs: include linux/limits.h for XATTR_SIZE_MAX
Message-ID: <20200516144114.GA23744@nessie>
References: <20200515203015.7090-1-dan@dlrobertson.com>
 <20200515203015.7090-2-dan@dlrobertson.com>
 <20200516133023.55492cfe@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <20200516133023.55492cfe@bahia.lan>
X-Zoho-Virus-Status: 2
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.13; envelope-from=dan@dlrobertson.com;
 helo=sender4-op-o13.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 10:59:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 16, 2020 at 01:30:23PM +0200, Greg Kurz wrote:
> Applied to 9p-next with R-b and Fixes tags, thanks.

Great! Thanks for the feedback everyone.

Cheers,

 - Dan

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEF5dO2RaKc5C+SCJ9RcSmUsR+QqUFAl6/+4kACgkQRcSmUsR+
QqVS5Q//UYcmAQCdteuITp1BI+KzLOJoVWXlK81Kii/nW/Ql9+JPqdj6fWncAjcc
9UaJnM8EIIkpJU2ZCPM2lI3g4fgvKxdRVBk7jyG94GixrUd6j4E45yab7N9SvZUE
RXm8/grk3+2Q8nUoIR4PWcvifJnCHHAmpzIvVVb/LeLZTsbPzC1Zrd50tyHGZn85
Xal0qYUWCMz25imJN13tGulaGKX8cBCzD0PKh9KpNewnDqUM1m0JPLFr5GzPwoRj
egvjWI9lG++AFwIxjz4UzOzOdeshiO4Yw6yt3hR8zSVWEBixVxr+qQt2UkD+YKzL
RrvlzDFHB+dZO4AvZqFFlrjU3SIB1KyYxV2ltmUvMCGMRjc7FmUcqj0OEMp+1sms
1DjSDCEH7VOqYI3MS8qP+IbzrjIbt6L9riLcmAg1l2gMWrZW4QclSkakE5ndnjj3
WuVjEY8IomRpOh6UvSodOFWq5aKdI3pYL1K0bV1hj0ulYp5AkRWaocsX2HqQgcGP
Zj5a04qQ68MVKjvz5tdoTCAxI+sFIo/iCltPm9gaROfDiWYmk+8LeiZPwjcxlimE
GtlDpnCKaEVtPuQRIHroSvJjggXKk1qcqoCJjb7fwvXd/tMg9zXjWrk7dZA6lD77
/91KJzgMl8zbWqg3TO3pBYK2BhdfrBWyEEu+641TGGS6trQ4hD4=
=nUXy
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--


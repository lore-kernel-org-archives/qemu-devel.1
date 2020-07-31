Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B08C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 10:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6B920829
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 10:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eok6fdwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6B920829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1SD6-0002Vf-E5
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 06:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k1SCI-0001Qu-GB; Fri, 31 Jul 2020 06:23:30 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55878)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k1SCG-0001iH-Ta; Fri, 31 Jul 2020 06:23:30 -0400
Received: by mail-wm1-x342.google.com with SMTP id 9so8100373wmj.5;
 Fri, 31 Jul 2020 03:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=b3f1ucrTl3HjESEtozvx+z5P+hHzlCJ924m+lTxekg4=;
 b=eok6fdwZfSMvsjXwQ9fPGlkYRlG4u2l5VH0bqvqb2rAaok1rv+waCnbAVoZqhB80H0
 qzoEhEfre9KmqeLOy/6YLDCKyAX1xt+1HxsvMKhTZoM3ee16e1p0IOcwbhUGgZypbAtB
 pvMEQa+UrmwSGsSQ36c/pYHAGV+dH3SchhWRA956w+nzKH6jIT6kDT4ipblwseXDqYeE
 +FYEytL8KGj1sTCzjSjaaaQx1aSh0aeNTNaf2mhST0rdQo3ARDHvFQbRfd33CjqPGlfM
 sfUktZcEJtkjyMBtMWzVrNxurO4cd00yrK5I59/R3MIznt8/ePXSUP7Od/jmlxSBh5MF
 8x6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=b3f1ucrTl3HjESEtozvx+z5P+hHzlCJ924m+lTxekg4=;
 b=nuZu+aLQ+LLNPolKXg+L9ExPpRhQkNUHjPDTI+YhGgIlK4TJ4RGYi+I9+ySvGf43PT
 ofoFMV0NOOpTBxxkVE0yV7jxTqhYZ9Ki1gOlw9Db9XE1zDTDKhizynZig/u6fz0YgHNb
 PwjHQR3P9eGBPYUGpUN1Eg7yeeZSApVSk+5jgbudRX1Q+H9wKmmiTLvJOz75ajfOqRfW
 BctzCDmkBqtsxxFGlyCRl/BTmGql72zG7CiwjiEqoVWx3S+L5WAtLB/ndMon5Og8C4H3
 Jbq+MFZ6qLuBIp9Y9pdtzPLVXs2TDARaiu5LoTh3oaLFU+BOlnyzzeWwatjPFAG8cz1N
 qqZQ==
X-Gm-Message-State: AOAM5328ycOz8N6IlA9XCWGMMdfQEX5RgTG6ybPpw2qqY7KIkc/6ccCO
 /GDNwsZ3cXcCkg5iZcl3UQ8=
X-Google-Smtp-Source: ABdhPJw1hHJEK1ncElLSaLuDgJ4yV0n/yvAZjjWyfHVVp1fyiehxcovplkdlHQajQ6UMnq8lSF5cUw==
X-Received: by 2002:a7b:c150:: with SMTP id z16mr3114550wmi.136.1596191006395; 
 Fri, 31 Jul 2020 03:23:26 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b2sm11114620wmj.47.2020.07.31.03.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2020 03:23:25 -0700 (PDT)
Date: Fri, 31 Jul 2020 11:23:23 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Denis V. Lunev" <den@openvz.org>
Subject: Re: [PATCH 2/2] block: add logging facility for long standing IO
 requests
Message-ID: <20200731102323.GB177875@stefanha-x1.localdomain>
References: <20200710172711.8059-1-den@openvz.org>
 <20200710172711.8059-3-den@openvz.org>
 <20200729103029.GB37763@stefanha-x1.localdomain>
 <914c161e-31b6-b7b2-2cc7-788c1e6f8f98@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <914c161e-31b6-b7b2-2cc7-788c1e6f8f98@openvz.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2020 at 02:06:43PM +0300, Denis V. Lunev wrote:
> On 7/29/20 1:30 PM, Stefan Hajnoczi wrote:
> > On Fri, Jul 10, 2020 at 08:27:11PM +0300, Denis V. Lunev wrote:
> >> @@ -3740,6 +3741,10 @@ QemuOptsList qemu_common_drive_opts =3D {
> >>              .type =3D QEMU_OPT_BOOL,
> >>              .help =3D "whether to account for failed I/O operations "
> >>                      "in the statistics",
> >> +        },{
> >> +            .name =3D "latency-log-threshold",
> >> +            .type =3D QEMU_OPT_STRING,
> > QEMU_OPT_NUMBER?
> good catch! we have this parameter on by default (10 seconds) and never
> passed it from the command line :)
>=20
> Thus should we keep this off be default or on? :)

On by default sounds good. It adds useful information.

Stefan

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8j8RsACgkQnKSrs4Gr
c8gWAQf+LOP+R1r1PGrMXXhEiTNRaL2SODCON48kzDY1gQpOvlSMTz3TT/V/sXkm
rBHHKDPIh4KPcrw3Kx8GyKwb/CXckzV6BqXtwimiLmACWTOxS2iEeeJwozONJB8j
tJYfD7oK4rpWMfP1j8LTx86NmPh1hMgG9ZVinfjqiaSCDK7qdCNxF7CSjp05amqS
0k5rjp0kxJQ2WmahN4qg0kUPi8Xb0JAngAmUrMZsueR70K5omxX3DiSnzvxDySTa
K06/nUFbXJ27/oMF/I4VJKFk5tRcEikPcdvdC9Y3ZnsheNxlzQdpyoB4i3jDGcc+
dvno+kIR0nqkdDT3n+CPD/buGtg23w==
=n4zx
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--


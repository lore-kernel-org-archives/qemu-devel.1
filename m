Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F82FA3735
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 09:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B91CC222C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 09:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91CC222C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL2HM-0001Uc-V2
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 05:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iL2Gh-00013K-13
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iL2GZ-0003TK-OL
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:40:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56472)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iL2GZ-0003SM-IA
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 05:40:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4E98F7652E;
 Thu, 17 Oct 2019 09:40:18 +0000 (UTC)
Received: from localhost (ovpn-117-215.ams2.redhat.com [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDBDB5D71C;
 Thu, 17 Oct 2019 09:40:14 +0000 (UTC)
Date: Thu, 17 Oct 2019 10:40:13 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [Patch v2] checkpatch: sugguest to use qemu_real_host_page_size
 instead of getpagesize() or sysconf(_SC_PAGESIZE)
Message-ID: <20191017094013.GE23557@stefanha-x1.localdomain>
References: <20191017004633.13229-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ryJZkp9/svQ58syV"
Content-Disposition: inline
In-Reply-To: <20191017004633.13229-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 17 Oct 2019 09:40:18 +0000 (UTC)
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
Cc: thuth@redhat.com, berrange@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ryJZkp9/svQ58syV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2019 at 08:46:33AM +0800, Wei Yang wrote:
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> CC: Richard Henderson <richard.henderson@linaro.org>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> ---
> v2: add "\b" for better match, suggested by Richard Henderson <richard.he=
nderson@linaro.org>
> ---
>  scripts/checkpatch.pl | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ryJZkp9/svQ58syV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2oNv0ACgkQnKSrs4Gr
c8jdCQf/TMqTuiNZ8n3MikUR74g6eBG93MlsiWUHmKO1et+23FuVo6m91k7znxZ/
b8q2qgs7CzgD8dOUBC3EVwc4j/kmCzeoWSm1xJqMd7dm1sdZtuCugfHpDZ48X9n8
3hQvW8s0ZbEEopeAu332opJZlflK2YHfwhLgveaN8bnJR9SBUt/jLWa7ZPCebGGb
jlWQDJxjjb8jvI/xSJFqSzlpNMP10p/9Ht9kfNaUyddga16P7EoO2JxE/0qBKqsd
BPrEFV/X9gv7qPUfsVJdC5Fvk7oUn9iv4goWcq2JHvEweC4wEs1rIyGVDoJfjXJb
38Z4zmQrkklFnt/XcmC0yOxdY0h6bw==
=LKFl
-----END PGP SIGNATURE-----

--ryJZkp9/svQ58syV--


Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D6BC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:17:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E50C20637
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 22:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAuv+2J9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E50C20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCW8r-0006Df-Nf
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 18:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1jCW81-0004B0-SR
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1jCW80-00083e-4D
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:16:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51718
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1jCW7z-00083F-Ur
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 18:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584051391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8+SHYF9pMPN6HbZBfkYDPwlAkAXdnH8LXRU2tRX/Erg=;
 b=LAuv+2J9rjtXp7meHZHHiZnxEx8mkRc2onNhqkXwHyWvDkthqVJ0A/bxe9EQiUOMIHSQLp
 CeMpLsXhIvIj0WwkVHSjpgN1aAub/+cbJP+zYXAwhVkJXGUzffdt2mCCZz4dOGjb5jcPtb
 dlvMayO2vZSFWaoZq+v8x8EXkUgYdZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-9PgNu8HuNrGcu6q8XprJvw-1; Thu, 12 Mar 2020 18:16:29 -0400
X-MC-Unique: 9PgNu8HuNrGcu6q8XprJvw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D75DB800D48;
 Thu, 12 Mar 2020 22:16:27 +0000 (UTC)
Received: from dhcp-17-173.bos.redhat.com (dhcp-17-173.bos.redhat.com
 [10.18.17.173])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B894F8F37F;
 Thu, 12 Mar 2020 22:16:21 +0000 (UTC)
Date: Thu, 12 Mar 2020 18:16:19 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/5] QEMU Gating CI
Message-ID: <20200312221619.GA483011@dhcp-17-173.bos.redhat.com>
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA_PiX7LffcT9+1Bdn764fsqsSzUZib-yp=Og0Vpa3oOrw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_PiX7LffcT9+1Bdn764fsqsSzUZib-yp=Og0Vpa3oOrw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Wainer Moschetta <wmoschet@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2020 at 10:00:42PM +0000, Peter Maydell wrote:
> On Thu, 12 Mar 2020 at 19:36, Cleber Rosa <crosa@redhat.com> wrote:
> >
> > The idea about a public facing Gating CI for QEMU was lastly
> > summarized in an RFC[1].  Since then, it was decided that a
> > simpler version should be attempted first.
>=20
> OK, so my question here is:
>  * what are the instructions that I have to follow to be
> able to say "ok, here's my branch, run it through these tests,
> please" ?

The quick answer is:

 $ git push git@gitlab.com:qemu-project/qemu.git my-branch:staging

The longer explanation is that these jobs are limited to a "staging"
branch, so all you'd have to do is to push something to a branch
called "staging".  If that branch happens to be from the
"gitlab.com/qemu-project/qemu" repo, than the runners setup there
would be used.  The documentation an ansible playbooks are supposed
to help with this setup.

Once that push happens, you could use:

 $ contrib/ci/scripts/gitlab-pipeline-status --verbose --wait

Before doing something like:

 $ git push git@gitlab.com:qemu-project/qemu.git my-branch:master

>=20
> thanks
> -- PMM
>=20

Let me know if that makes sense.

Cheers,
- Cleber.

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl5qtLAACgkQZX6NM6Xy
CfNNehAAoM686m6juS8H7ccdmRS61pcLyAJ0vhQHeE3aHcTaK34+98ghRfO/9oyd
IaqZIxsNFgCj6rFyeUgxjEf0wuBf+LxxkZsGpQvmY44Eb+FEeBCUHa6o3kBml1Ny
ZNd0I24qTWaTfsVuEF447XIOgEtucS1pedsNyLVMfJk+zbXbrNAOpVAKO07i1TVg
r2apwnadeBykuRiX003cW9mQr3wvOo4mCRVGnaUfKOxLMgcS1blerQWdvJD5DJOi
GLKm2ArcwOxvnFcQK8Vil0jFFJL9Rvvent/mmndWQ7Ge44AqvtmzqEjCD8gnKmhA
fLJr7mPXO5I5HdyXOGDF6Zo8xvPOasecK2oEEC8t04Sg+oAFPn5QnNVSIm1M3wPk
N+nSfVxcfOymXxfF7TN0HOiqkm9kcKjxxAQ1H4UAKY/XXn0vdriWRx2oh2UYk6Bv
lKkywFi5oe7Bczhqg1oJQo9Az3QypEb8DY+a8m+5UtSwsGnjRR1o3jhrOcWOUdEf
eHPvWgtdwvgC4Lu1zgKbOS4kRIMl+UQ9xLRlUJQZ7g8rOH81PANNm+hP346Sdn+M
oGrQPm4SJKmCjRe/P0jEHtUe5miMpRWyIpqG5c2/isfJaM8a7IjT6v4YCn2Y71fO
kWnEeIyaX/4IUqg7T3I/qErk5Fx31/V4M3ZfTg82SD7GxaIjaqU=
=Qj6Y
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--



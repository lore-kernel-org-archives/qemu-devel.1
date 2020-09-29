Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FA2C2D0A8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 03:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A49208FE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 03:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2Ft38Kk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A49208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN67K-0006O2-HK
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 23:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN66F-0005pw-OG
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 23:14:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59094)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN669-0004P4-UT
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 23:14:43 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601349269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Qp/a+fRgWfCpYSkC63hzGEOQ3zchzXGV20ol8QzhfA=;
 b=c2Ft38KkzSX3bolAG4594YuUQZEAT+Fs7zNCS548Xdl+wKsXf4QiEMMSR1NnQUH3iolFEi
 rUjENRlrF/eXzvv4iUC8LIV7iMklh1zi16PMS6NXc8MJ4yXzcmRWemmI7NbtRbENiBpYPj
 q99kv2tfQO5pNFDfYj6S9YqKEz4eyhc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-Na0z8Lx9M1SuvzqxvttY1g-1; Mon, 28 Sep 2020 23:14:25 -0400
X-MC-Unique: Na0z8Lx9M1SuvzqxvttY1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CB8E8030D3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 03:14:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D40FC5C1BD;
 Tue, 29 Sep 2020 03:14:23 +0000 (UTC)
Date: Mon, 28 Sep 2020 23:14:22 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 02/47] [DO-NOT-MERGE] docs: repair broken references
Message-ID: <20200929031422.GC700868@localhost.localdomain>
References: <20200925002900.465855-1-jsnow@redhat.com>
 <20200925002900.465855-3-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200925002900.465855-3-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 08:28:15PM -0400, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/devel/multi-thread-tcg.rst | 2 +-
>  docs/devel/testing.rst          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/docs/devel/multi-thread-tcg.rst b/docs/devel/multi-thread-tc=
g.rst
> index 21483870db..92a9eba13c 100644
> --- a/docs/devel/multi-thread-tcg.rst
> +++ b/docs/devel/multi-thread-tcg.rst
> @@ -267,7 +267,7 @@ of view of external observers (e.g. another processor=
 core). They can
>  apply to any memory operations as well as just loads or stores.
> =20
>  The Linux kernel has an excellent `write-up
> -<https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/plain/D=
ocumentation/memory-barriers.txt>`
> +<https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/plain/D=
ocumentation/memory-barriers.txt>`_
>  on the various forms of memory barrier and the guarantees they can
>  provide.
> =20
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index 666c4d7240..f21f3f58eb 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -953,7 +953,7 @@ compiler flags are needed to build for a given target=
.
>  If you have the ability to run containers as the user you can also
>  take advantage of the build systems "Docker" support. It will then use
>  containers to build any test case for an enabled guest where there is
> -no system compiler available. See :ref: `_docker-ref` for details.
> +no system compiler available. See `docker-ref` for details.
>

Actually, I take the "r-b" back because I missed this line... it
should be:

   no system compiler available. See `docker-ref`_ for details.

- Cleber.

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9yposACgkQZX6NM6Xy
CfPXChAAoQpEuBOqB1vx5gkm/5O2qciDEfrsBU1skeyNdlmZFiToJITeTuCUufH0
6NcWsy1x3sCplSsdXHvX4ofVOOth/RB47L+jJKhINp7cGSBaT1D/TqECwTzTfDok
J4Roo4Sxp+P2kEaOnAxGRJFAzIxFWCFTGnYWNAkL4/kpdHRIDeq2QGS80uqC4Faw
QEMBBS5qITdzEWOcbHHQAqzGp2QWt6VD9zRfi2qAiiHoyB4L9hpmVyr3qxB0wgSK
5gE12K5efy9wqWdNtSPQflZZYaoMFxP33jm0rzvgTQ6Szdv16lgAHOIrYwWwlv//
EFNWNUguC5re2fsxQQjivAcigWbS4TcmYfDcUX+teOX8kplFYePnVVFfiz+BkUvz
grs08sZyIDKYllBD410bO3d81kE0wSsGdiJhZcym2Ks7bqCwvwp8KD5w28DhRBtO
Xj6hKfgHRLxQH3cY8SqsCCb5SQmcIrT/YnC3eNHVHN/l82xAuQQ2wOp3SUb2vZRk
Ej3nBA5A/1BJXAcmv0cS484IPAkS++0CzfmeGMtBH+uO8jLTvRHaUNif9u+Ua0w8
wqSIwOHH2eR7IJwIoPqApvuwZMt+ouE7p4S7+2f3PZf/RD8YN8mv8Dj0dqYFU/Kf
7FqoIy+n0wC9+Oa8xnjc65L3xC2hSLObN82z7pYd38Z9+6oF5tA=
=1kH8
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--



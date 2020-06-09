Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B64C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D367207F9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 10:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POeucemb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D367207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jibUF-00054k-PK
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 06:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jibTd-0004bU-EK
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:27:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45160
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jibTa-0002oh-2u
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 06:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591698444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4YJQYefwOc1J5JzaKwpgCXA3KWlCr7bbf14WZd5wEAo=;
 b=POeucemb2I4QUc36e8tZMJ0QHCnA1TZpwu+9vJS40PsRWw2Kqn4+Xg2b7GaSHFt7ck0REC
 Cmg+TsBt5kEnMD6ELh0m1LSL2iJvs0aQo/Ul/qWQUrOjlgE9XYzbMxi2wDg7acFF3M0Rx/
 yKb/wEwVDTpwpWmGz34jxybMeoe9vi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-vkqhnXJNOQWGystSpaam2w-1; Tue, 09 Jun 2020 06:27:14 -0400
X-MC-Unique: vkqhnXJNOQWGystSpaam2w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A30D464;
 Tue,  9 Jun 2020 10:27:13 +0000 (UTC)
Received: from localhost (ovpn-115-52.ams2.redhat.com [10.36.115.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBA1B385;
 Tue,  9 Jun 2020 10:27:09 +0000 (UTC)
Date: Tue, 9 Jun 2020 11:27:08 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH v2] fuzz: add oss-fuzz build.sh script
Message-ID: <20200609102708.GC92564@stefanha-x1.localdomain>
References: <20200605175028.5626-1-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20200605175028.5626-1-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:42:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: darren.kenny@oracle.com, bsd@redhat.com, qemu-devel@nongnu.org,
 f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2020 at 01:50:28PM -0400, Alexander Bulekov wrote:
> It is neater to keep this in the QEMU repo, since any change that
> requires an update to the oss-fuzz build configuration, can make the
> necessary changes in the same series.
>=20
> Suggested-by: Philippe Mathieu-Daude <f4bug@amsat.org>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>=20
> v2 updates the script header comment.
>=20
>  scripts/oss-fuzz/build.sh | 50 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100755 scripts/oss-fuzz/build.sh

Please add a MAINTAINERS file entry.

> diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
> new file mode 100755
> index 0000000000..e93d6f2e03
> --- /dev/null
> +++ b/scripts/oss-fuzz/build.sh
> @@ -0,0 +1,50 @@
> +#!/bin/sh
> +#
> +# OSS-Fuzz build script. See:
> +# https://google.github.io/oss-fuzz/getting-started/new-project-guide/#b=
uildsh
> +#
> +# This code is licensed under the GPL version 2 or later.  See
> +# the COPYING file in the top-level directory.
> +#
> +
> +# build project
> +# e.g.
> +# ./autogen.sh
> +# ./configure
> +# make -j$(nproc) all
> +
> +# build fuzzers
> +# e.g.
> +# $CXX $CXXFLAGS -std=3Dc++11 -Iinclude \
> +#     /path/to/name_of_fuzzer.cc -o $OUT/name_of_fuzzer \
> +#     $LIB_FUZZING_ENGINE /path/to/library.a
> +
> +mkdir -p $OUT/lib/              # Shared libraries
> +
> +# Build once to get the list of dynamic lib paths, and copy them over
> +./configure --datadir=3D"./data/" --disable-werror --cc=3D"$CC" --cxx=3D=
"$CXX" \
> +    --extra-cflags=3D"$CFLAGS -U __OPTIMIZE__ "

If you respin, please extract -U __OPTIMIZE__ into a separate variable
with a doc comment.

# Explanation for why __OPTIMIZE__ needs to be undefined goes here...
EXTRA_CFLAGS=3D"$CFLAGS -U __OPTIMIZE__"

This will help others understand why this build flag is needed.

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7fY/wACgkQnKSrs4Gr
c8jepQf/f7N9DDkjKqqNK+LDRGarTytiLkzt7t/Czm3/3YZhyNHBZCxdZICYkwJn
ojUV5IT1wxRrVop5UfETnLHvRpG39g2o0pjI3ezUc42dm2auEKpFM8WTI/ZSZKhT
7W/attAdW7pgOHwRmqJIC9tdV9XqHUe2LlJaCe6dijFgBEhwMBnH/3i/iL+ZMjwe
XRzVWcVMMqeI0X9dvH5B6Om3ZC0E52kZmQjtcK+mdf3ml1hlPuSEXRjPoqcXsScb
D1ISe+CV7NrPRJM1M5347U0x89GZ9SMOLz7/mt9pNhcSto1fbwii9IMARUxHuIY3
bG64oYEzE4og78DtCpXLm0RYNwq0Dw==
=Zo7l
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--



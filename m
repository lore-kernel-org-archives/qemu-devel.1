Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568C5C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 20:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE1820659
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 20:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Np99CaGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE1820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icxwX-0001Xx-8O
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 15:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1icxuP-00009K-4Z
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 15:39:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1icxuE-00044t-MN
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 15:39:25 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39009
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1icxuE-00042E-Ax
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 15:39:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575578361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lgNEwiswR6v+HEnmXUcovTS5zeio6VWzpZJAxLbD74c=;
 b=Np99CaGE0J/hs+iqmauo2kugBnrgX2mJ1RdYVK8KRUVl8pTuiHEDMAjkBOv2yoLAj5SlQy
 chDADdybeWAqFiomEGbQoZIhHc0D413Ugjem9OGes51cLInp19YaWrsnlOQM6bGbBYxGmq
 /5AaKE6L4ZReyTJDXdVrwPmsrGWsEZo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-Iv0Q8_2EN4yrkg99aCjRrA-1; Thu, 05 Dec 2019 15:39:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 042771005510;
 Thu,  5 Dec 2019 20:39:19 +0000 (UTC)
Received: from localhost.localdomain (ovpn-125-37.rdu2.redhat.com
 [10.10.125.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83C60694DD;
 Thu,  5 Dec 2019 20:39:10 +0000 (UTC)
Date: Thu, 5 Dec 2019 15:39:08 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 6/7] configure: allow disable of cross compilation
 containers
Message-ID: <20191205203908.GF29262@localhost.localdomain>
References: <20191204154618.23560-1-thuth@redhat.com>
 <20191204154618.23560-7-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191204154618.23560-7-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Iv0Q8_2EN4yrkg99aCjRrA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-block@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Eric Auger <eric.auger@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 04, 2019 at 04:46:17PM +0100, Thomas Huth wrote:
> From: Alex Benn=E9e <alex.bennee@linaro.org>
>=20
> Our docker infrastructure isn't quite as multiarch as we would wish so
> let's allow the user to disable it if they want. This will allow us to
> use still run check-tcg on non-x86 CI setups.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Reviewed-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure              | 8 +++++++-
>  tests/tcg/configure.sh | 6 ++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/configure b/configure
> index 6099be1d84..fe6d0971f1 100755
> --- a/configure
> +++ b/configure
> @@ -302,6 +302,7 @@ audio_win_int=3D""
>  libs_qga=3D""
>  debug_info=3D"yes"
>  stack_protector=3D""
> +use_containers=3D"yes"
> =20
>  if test -e "$source_path/.git"
>  then
> @@ -1539,6 +1540,10 @@ for opt do
>    ;;
>    --disable-plugins) plugins=3D"no"
>    ;;
> +  --enable-containers) use_containers=3D"yes"
> +  ;;
> +  --disable-containers) use_containers=3D"no"
> +  ;;
>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
> @@ -1722,6 +1727,7 @@ Advanced options (experts only):
>                             track the maximum stack usage of stacks creat=
ed by qemu_alloc_stack
>    --enable-plugins
>                             enable plugins via shared library loading
> +  --disable-containers     don't use containers for cross-building
> =20
>  Optional features, enabled with --enable-FEATURE and
>  disabled with --disable-FEATURE, default is enabled if available:
> @@ -8039,7 +8045,7 @@ done
>  (for i in $cross_cc_vars; do
>    export $i
>  done
> -export target_list source_path
> +export target_list source_path use_containers
>  $source_path/tests/tcg/configure.sh)
> =20
>  # temporary config to build submodules
> diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
> index 6c4a471aea..210e68396f 100755
> --- a/tests/tcg/configure.sh
> +++ b/tests/tcg/configure.sh
> @@ -36,8 +36,10 @@ TMPC=3D"${TMPDIR1}/qemu-conf.c"
>  TMPE=3D"${TMPDIR1}/qemu-conf.exe"
> =20
>  container=3D"no"
> -if has "docker" || has "podman"; then
> -  container=3D$($python $source_path/tests/docker/docker.py probe)
> +if test $use_containers =3D "yes"; then
> +    if has "docker" || has "podman"; then
> +        container=3D$($python $source_path/tests/docker/docker.py probe)
> +    fi
>  fi
> =20
>  # cross compilers defaults, can be overridden with --cross-cc-ARCH
> --=20
> 2.18.1
>=20

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>



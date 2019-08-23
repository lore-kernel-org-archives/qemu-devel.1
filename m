Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39833C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C94F2173E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 12:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C94F2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55657 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i191X-000861-OD
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 08:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i18eB-00054d-Lf
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i18e4-0006LL-Lt
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:26:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46354)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i18e3-0006Ip-CR
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 08:26:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2748810F23E9;
 Fri, 23 Aug 2019 12:26:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E038B6313A;
 Fri, 23 Aug 2019 12:26:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 289831162B63; Fri, 23 Aug 2019 14:26:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
References: <20190713143311.17620-1-marcandre.lureau@redhat.com>
 <20190713143311.17620-4-marcandre.lureau@redhat.com>
Date: Fri, 23 Aug 2019 14:26:07 +0200
In-Reply-To: <20190713143311.17620-4-marcandre.lureau@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Sat, 13 Jul 2019 18:33:08 +0400")
Message-ID: <878srknk4g.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Fri, 23 Aug 2019 12:26:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 3/6] tests/docker: add podman support
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
Cc: Fam Zheng <fam@euphon.net>, berrange@redhat.com,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just saw this land in master, awesome.  Suggestion inline.

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Allow to specify the container engine to run with ENGINE variable.
>
> By default, ENGINE=3Dauto and will select either podman or docker.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  Makefile                      | 2 +-
>  tests/docker/Makefile.include | 8 ++++++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 1fcbaed62c..7863bb0cf5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1153,7 +1153,7 @@ endif
>  	@echo  ''
>  	@echo  'Test targets:'
>  	@echo  '  check           - Run all tests (check-help for details)'
> -	@echo  '  docker          - Help about targets running tests inside Doc=
ker containers'
> +	@echo  '  docker          - Help about targets running tests inside con=
tainers'
>  	@echo  '  vm-help         - Help about targets running tests inside VM'

Let's rename target docker to something like container-help, for
symmetry with vm-help, and because calling the target to get help on X X
is in poor taste.

See also
commit 4f2f62762f8119886fbb65920931613cd87840b3
Author: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Date:   Fri May 31 08:43:41 2019 +0200

    Makefile: Rename the 'vm-test' target as 'vm-help'
=20=20=20=20
    We already have 'make check-help', use the 'make vm-help' form
    to display helps about VM testing. Keep the old target to not
    bother old customs.
=20=20=20=20
    Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
    Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
    Message-Id: <20190531064341.29730-1-philmd@redhat.com>
    Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>  	@echo  ''
>  	@echo  'Documentation targets:'
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index f4226b79d0..3c1aec862a 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -17,7 +17,9 @@ DOCKER_TESTS :=3D $(notdir $(shell \
>=20=20
>  DOCKER_TOOLS :=3D travis
>=20=20
> -DOCKER_SCRIPT=3D$(SRC_PATH)/tests/docker/docker.py
> +ENGINE :=3D auto
> +
> +DOCKER_SCRIPT=3D$(SRC_PATH)/tests/docker/docker.py --engine $(ENGINE)
>=20=20
>  TESTS ?=3D %
>  IMAGES ?=3D %
> @@ -146,7 +148,7 @@ $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(D=
OCKER_IMAGES) $(DOCKER_DEPR
>  )
>=20=20
>  docker:
> -	@echo 'Build QEMU and run tests inside Docker containers'
> +	@echo 'Build QEMU and run tests inside Docker or Podman containers'
>  	@echo
>  	@echo 'Available targets:'
>  	@echo
> @@ -193,6 +195,8 @@ endif
>  	@echo '    EXECUTABLE=3D<path>    Include executable in image.'
>  	@echo '    EXTRA_FILES=3D"<path> [... <path>]"'
>  	@echo '                         Include extra files in image.'
> +	@echo '    ENGINE=3Dauto/docker/podman'

Your | are listing.

> +	@echo '                         Specify which container engine to run.'
>=20=20
>  # This rule if for directly running against an arbitrary docker target.
>  # It is called by the expanded docker targets (e.g. make


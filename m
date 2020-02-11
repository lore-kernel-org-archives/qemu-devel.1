Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B38DC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02C2F206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0Ti5Ej9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C2F206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1QI7-0001at-4c
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 02:49:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1j1QHT-00015I-1M
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1j1QHR-0005QS-I1
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:48:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33258
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1j1QHR-0005Nf-EZ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:48:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581407304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+xyu4zvqCz8Eavs5JSNjEXfjb8+1MDL24ApcJ5fqGnc=;
 b=X0Ti5Ej9taPcp/pJPp1nUyMNvK11PULX9W2h2vURMpRXW6iszDPQGI1/rA5QnIS39WSzlZ
 Tr4HgxRDWg+Z+4Ps8zROVi9f+g6EQ3HkgS0z7mcqmh3fQ/PJy0PyUEejjAd3a16JqW7Ygy
 7g5isHrKM4tsNotKC09c/Ut3HTxlTvk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-1RzWOTAbOA-aAyqnH5s6WA-1; Tue, 11 Feb 2020 02:48:22 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1091477
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 07:48:21 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-193.ams2.redhat.com
 [10.36.116.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E921326FCF;
 Tue, 11 Feb 2020 07:48:15 +0000 (UTC)
Subject: Re: [PATCH] gitlab-ci.yml: Add .gitlab-ci.d directory for GitLab
 specific files
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200211065022.11134-1-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <22301476-8d85-e963-1900-73143a3a107a@redhat.com>
Date: Tue, 11 Feb 2020 08:48:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200211065022.11134-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 1RzWOTAbOA-aAyqnH5s6WA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/11/20 07:50, Philippe Mathieu-Daud=C3=A9 wrote:
> As we plan to let maintainers managing their own GitLab CI jobs,
> add a single directory to contain all the new files (to keep the
> root directory cleaner).
>=20
> EDK2 job is the first user, move it there.
>=20
> Suggested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  .gitignore                                   | 1 +
>  .gitlab-ci-edk2.yml =3D> .gitlab-ci.d/edk2.yml | 2 +-
>  .gitlab-ci.yml                               | 2 +-
>  MAINTAINERS                                  | 3 +--
>  4 files changed, 4 insertions(+), 4 deletions(-)
>  rename .gitlab-ci-edk2.yml =3D> .gitlab-ci.d/edk2.yml (98%)
>=20
> diff --git a/.gitignore b/.gitignore
> index bc0a035f9c..18288eacd1 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -95,6 +95,7 @@
>  *.tp
>  *.vr
>  *.d
> +!/.gitlab-ci.d
>  !/scripts/qemu-guest-agent/fsfreeze-hook.d
>  *.o
>  .sdk
> diff --git a/.gitlab-ci-edk2.yml b/.gitlab-ci.d/edk2.yml
> similarity index 98%
> rename from .gitlab-ci-edk2.yml
> rename to .gitlab-ci.d/edk2.yml
> index 088ba4b43a..a9990b7147 100644
> --- a/.gitlab-ci-edk2.yml
> +++ b/.gitlab-ci.d/edk2.yml
> @@ -2,7 +2,7 @@ docker-edk2:
>   stage: build
>   rules: # Only run this job when the Dockerfile is modified
>   - changes:
> -   - .gitlab-ci-edk2.yml
> +   - .gitlab-ci.d/edk2.yml
>     - .gitlab-ci.d/edk2/Dockerfile
>     when: always
>   image: docker:19.03.1
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index c15e394f09..dae6045d78 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -1,5 +1,5 @@
>  include:
> -  - local: '/.gitlab-ci-edk2.yml'
> +  - local: '/.gitlab-ci.d/edk2.yml'
> =20
>  before_script:
>   - apt-get update -qq
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c7717df720..fb00a55f41 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2391,8 +2391,7 @@ F: roms/edk2
>  F: roms/edk2-*
>  F: tests/data/uefi-boot-images/
>  F: tests/uefi-test-tools/
> -F: .gitlab-ci-edk2.yml
> -F: .gitlab-ci.d/edk2/
> +F: .gitlab-ci.d/edk2*
> =20
>  Usermode Emulation
>  ------------------
>=20

Reviewed-by: Laszlo Ersek <lersek@redhat.com>



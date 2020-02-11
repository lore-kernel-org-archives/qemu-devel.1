Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1CDC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 13:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A84C20675
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 13:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DI+ghVrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A84C20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1VeB-00062h-Lj
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 08:32:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1j1VZJ-0003JT-6J
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 08:27:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1j1VZH-0006ZR-Mj
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 08:27:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47390
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1j1VZH-0006YD-Ie
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 08:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581427630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z/qJBYRVnB77xtsfuXVdnqROrpMkltvPU3ucSmYzph4=;
 b=DI+ghVrwzOtNds5g4guKnyswQnSuFATN7nb8N10tuweZoG/HlL/gRCs5bUqqD497/EGk2y
 iTJu2Mrl/OQEDjv1Z4m3cbcpyErAW2yozIyQomTlmDYARXfSfZO/dftdKb6dspdjo60EdB
 /JpXu9s3PPQT6iNf10gbYx+LdZvmr4s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-SqkxKux8OT2Fv9Ym9tkM-A-1; Tue, 11 Feb 2020 08:27:08 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0762107ACC4
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 13:27:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-102.gru2.redhat.com
 [10.97.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F3158AC3E;
 Tue, 11 Feb 2020 13:26:55 +0000 (UTC)
Subject: Re: [PATCH v2] gitlab-ci: Move EDK2 YAML config to .gitlab-ci.d
 directory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200211095004.29647-1-philmd@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <99644327-3404-6e30-682c-7dd53506ab05@redhat.com>
Date: Tue, 11 Feb 2020 11:26:53 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200211095004.29647-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: SqkxKux8OT2Fv9Ym9tkM-A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Thomas Huth <thuth@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2/11/20 7:50 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> We plan to let maintainers managing their own GitLab CI jobs.
> The .gitlab-ci.d directory will contain all the new GitLab files,
> to keep the root directory cleaner.
>
> The EDK2 job was introduced before .gitlab-ci.d was suggested as
> a common directory. Move the YAML file, update its references.
>
> Suggested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Supersedes: <20200211065022.11134-1-philmd@redhat.com>
> v2: Reworded subject/description (Thomas)
> ---
>   .gitignore                                   | 1 +
>   .gitlab-ci-edk2.yml =3D> .gitlab-ci.d/edk2.yml | 2 +-
>   .gitlab-ci.yml                               | 2 +-
>   MAINTAINERS                                  | 3 +--
>   4 files changed, 4 insertions(+), 4 deletions(-)
>   rename .gitlab-ci-edk2.yml =3D> .gitlab-ci.d/edk2.yml (98%)

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

> diff --git a/.gitignore b/.gitignore
> index bc0a035f9c..18288eacd1 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -95,6 +95,7 @@
>   *.tp
>   *.vr
>   *.d
> +!/.gitlab-ci.d
>   !/scripts/qemu-guest-agent/fsfreeze-hook.d
>   *.o
>   .sdk
> diff --git a/.gitlab-ci-edk2.yml b/.gitlab-ci.d/edk2.yml
> similarity index 98%
> rename from .gitlab-ci-edk2.yml
> rename to .gitlab-ci.d/edk2.yml
> index 088ba4b43a..a9990b7147 100644
> --- a/.gitlab-ci-edk2.yml
> +++ b/.gitlab-ci.d/edk2.yml
> @@ -2,7 +2,7 @@ docker-edk2:
>    stage: build
>    rules: # Only run this job when the Dockerfile is modified
>    - changes:
> -   - .gitlab-ci-edk2.yml
> +   - .gitlab-ci.d/edk2.yml
>      - .gitlab-ci.d/edk2/Dockerfile
>      when: always
>    image: docker:19.03.1
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index c15e394f09..dae6045d78 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -1,5 +1,5 @@
>   include:
> -  - local: '/.gitlab-ci-edk2.yml'
> +  - local: '/.gitlab-ci.d/edk2.yml'
>  =20
>   before_script:
>    - apt-get update -qq
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c7717df720..fb00a55f41 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2391,8 +2391,7 @@ F: roms/edk2
>   F: roms/edk2-*
>   F: tests/data/uefi-boot-images/
>   F: tests/uefi-test-tools/
> -F: .gitlab-ci-edk2.yml
> -F: .gitlab-ci.d/edk2/
> +F: .gitlab-ci.d/edk2*
>  =20
>   Usermode Emulation
>   ------------------



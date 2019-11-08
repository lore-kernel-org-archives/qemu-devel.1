Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B00C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:07:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F133421848
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="xBN47fX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F133421848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT4vN-0002MA-VB
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 09:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1iT4sK-0008Hy-RR
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:04:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1iT4sJ-0002Dl-Rz
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:04:32 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:58058)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1iT4sJ-0002DQ-Dv; Fri, 08 Nov 2019 09:04:31 -0500
Received: from [192.168.61.102] (lfbn-1-8165-82.w90-112.abo.wanadoo.fr
 [90.112.74.82])
 by beetle.greensocs.com (Postfix) with ESMTPSA id C188E96EF0;
 Fri,  8 Nov 2019 14:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1573221870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1iXA3v+10Q0q98qhuB75EcaFSp4c6O+HNINtTksGx6o=;
 b=xBN47fX1unoSwq2VKAZgB+7qLPSkBhRBlRjGx2o2/pinjVRzJFD1XrYTg8oPWVaQ4jNKUn
 Ix2gwKaAvyOqH0tnqIcqgD3Uq0Jj+lnt1rwFsOwmhdmbx/DProx864JjywSajWEVIYzL0u
 mZUMswMxFQikA9MeFm/u1g7HH5q1zGk=
Subject: Re: [PATCH v2 2/2] configure: Check bzip2 is available
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>
References: <20191108114531.21518-1-philmd@redhat.com>
 <20191108114531.21518-3-philmd@redhat.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <31d46dcc-e4b9-d4a9-ccd2-e357cd3964f7@greensocs.com>
Date: Fri, 8 Nov 2019 15:04:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191108114531.21518-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1573221870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1iXA3v+10Q0q98qhuB75EcaFSp4c6O+HNINtTksGx6o=;
 b=H2JOp3OTf5T6JQTSQuQMFdOlPnBU4qf3DcwHxPYYxQbGbLJphaHTfHp8afEuKwKizQFx6p
 UlO6lMi5o2sVVsDyynFNsDeRK5CzbnSgMtgXc5VPHXRDHvBNotDhFiY7ZrJ2n3Q6r73jz+
 MfSDi9Igy4ZVGEl0GVOqQ8wDbm80SiI=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1573221870; a=rsa-sha256; cv=none;
 b=E6j+Rgc6Osyqchjj+4ibUVI/Bgd9xh8vzVf/LTrCOFOszHAgHId7YhQqAs5JrgHfhZlvc5
 ihgYnaAyuvlI9M0NmSvj8LkZtuX3o1G81YJ0svzyQTT9545vyQTB8pDMer+oDQu6iVbODI
 Wb4w0tWBa03hHU+pZBNsb/TeGb3fF7w=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 11/8/19 12:45 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> The bzip2 tool is not included in default installations.
> On freshly installed systems, ./configure succeeds but 'make'
> might fail later:
>=20
>     BUNZIP2 pc-bios/edk2-i386-secure-code.fd.bz2
>   /bin/sh: bzip2: command not found
>   make: *** [Makefile:305: pc-bios/edk2-i386-secure-code.fd] Error 127
>   make: *** Deleting file 'pc-bios/edk2-i386-secure-code.fd'
>   make: *** Waiting for unfinished jobs....
>=20
> Add a check in ./configure to warn the user if bzip2 is missing.
>=20
> Fixes: 536d2173b2b
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: use better English (Daniel)
> (Not taking Daniel Reviewed-by because logic changed)
> ---
>  configure | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/configure b/configure
> index 9b322284c3..2b419a8039 100755
> --- a/configure
> +++ b/configure
> @@ -2147,6 +2147,7 @@ case " $target_list " in
>    ;;
>  esac
> =20
> +# Some firmware binaries are compressed with bzip2
With this comment squashed in previous commit:

Reviewed-by: Luc Michel <luc.michel@greensocs.com>


>  for target in $target_list; do
>    case "$target" in
>      arm-softmmu | aarch64-softmmu | i386-softmmu | x86_64-softmmu)
> @@ -2154,6 +2155,9 @@ for target in $target_list; do
>        ;;
>    esac
>  done
> +if test "$edk2_blobs" =3D "yes" && ! has bzip2; then
> +  error_exit "The bzip2 program is required for building QEMU"
> +fi
> =20
>  feature_not_found() {
>    feature=3D$1
>=20


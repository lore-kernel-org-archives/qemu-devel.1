Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99C0C00307
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 09:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E243206A1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 09:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E243206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7GKd-0002QU-NU
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 05:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i7GK0-00021q-D2
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i7GJy-0004A0-6L
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:50:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44866)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i7GJx-00049V-Tq
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 05:50:54 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B8E408E584
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 09:50:52 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id g2so2407880wmk.5
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 02:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=csG05ODezbcMLa5RC8TDs7bTJ/G18te8JO3tDy58PsE=;
 b=mHHxcqU9He0qEazWU7SmLWwqaq4VOXhIW7avPRJiCelZzYofQK7CstY8fyWEhzZkKg
 Ttj9EAq20wYj6Kw7zYSLn5K4kHfUUUAfKvncHl9TWHnAsxLWBcF0tT5GYEQOVOlV/J0M
 s006yVYGv9ufaX/psykOzJLs6DKGZeNbZfGHqjrxm4EkZ4ArQMWxATFkv8PnpfuT8xb0
 WrCh3C2wc1s+Is3hDhXFPlW0gws6czXxs7cGJGmowgOyeowgYzqiyxrtUNqOjloR3+Cc
 eJg3S+nmBeQ+rWX0EBiGEABwVgywPKDreICgdC/zlDe26b2RP4eDC6WBSIwRFcqccLXf
 UWiw==
X-Gm-Message-State: APjAAAVV6SVDiDB3JoAsEo6+2BWuk9avKMnLgeTQ/JFn+cuj0MOmeaDK
 oWDklgc/l3JxqAp5ZJ8HHZPM1idz5bN9eDQp5Nm4VXpECca5ZZSgN8daD/ObkRfR1xySRHMzgzJ
 Va6ks9do5+y1qK5A=
X-Received: by 2002:a1c:a617:: with SMTP id p23mr2636821wme.166.1568022651470; 
 Mon, 09 Sep 2019 02:50:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxbsLIoYXjjA8pEZGk6+2x24RL4TPMBXdlBIx5OKsxhDUnU31w2Lqj0jIhgieYIzGM9YfkorQ==
X-Received: by 2002:a1c:a617:: with SMTP id p23mr2636814wme.166.1568022651291; 
 Mon, 09 Sep 2019 02:50:51 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id r1sm13495620wro.13.2019.09.09.02.50.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2019 02:50:50 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190909094816.1970-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <66b8f407-276a-df89-7448-46f402c5866f@redhat.com>
Date: Mon, 9 Sep 2019 11:50:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190909094816.1970-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] tests/docker: update Debian Sid image
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
Cc: Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/19 11:48 AM, Alex Benn=C3=A9e wrote:
> While we are not currently using it we might as well keep the image
> for later usage. So:
>=20
>   - update to a more recent snapshot
>   - clean up verbiage in commentary
>   - remove duplicate shell from a merge failure

Thank you :)

FYI I'm using this image to do gcc9 test builds.

> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  tests/docker/dockerfiles/debian-sid.docker | 24 ++++++++--------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
>=20
> diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/=
dockerfiles/debian-sid.docker
> index 513459ca7f8..2a1bcc33b24 100644
> --- a/tests/docker/dockerfiles/debian-sid.docker
> +++ b/tests/docker/dockerfiles/debian-sid.docker
> @@ -1,25 +1,19 @@
>  #
>  # Debian Sid Base
>  #
> -# A number of our guests exist as ports only. We can either use the
> -# ports repo or get everything from Sid. However Sid is a rolling
> -# distro which may be broken at any particular time. If you are
> -# unlucky and try and build your images while gcc is in the process of
> -# being uploaded this can fail. Your only recourse is to try again in
> -# a few hours when the repos have re-synced. Once built however you
> -# won't be affected by repo changes unless the docker recipies are
> -# updated and trigger a re-build.
> +# Currently we can build all our guests with cross-compilers in the
> +# latest Debian release (Buster). However new compilers will first
> +# arrive in Sid. However Sid is a rolling distro which may be broken
> +# at any particular time. To try and mitigate this we use Debian's
> +# snapshot archive which provides a "stable" view of what state Sid
> +# was in.
>  #
> =20
>  # This must be earlier than the snapshot date we are aiming for
> -FROM debian:sid-20181011-slim
> +FROM debian:sid-20190812-slim
> =20
> -# Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
> -ENV DEBIAN_SNAPSHOT_DATE "20181030"
> -RUN sed -i "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [=
check-valid-until=3Dno] \1snapshot.debian.org/archive/debian/${DEBIAN_SNA=
PSHOT_DATE} \2%" /etc/apt/sources.list
> -
> -# Use a snapshot known to work (see http://snapshot.debian.org/#Usage)
> -ENV DEBIAN_SNAPSHOT_DATE "20181030"
> + # Use a snapshot known to work (see http://snapshot.debian.org/#Usage=
)
> +ENV DEBIAN_SNAPSHOT_DATE "20190820"
>  RUN sed -i "s%^deb \(https\?://\)deb.debian.org/debian/\? \(.*\)%deb [=
check-valid-until=3Dno] \1snapshot.debian.org/archive/debian/${DEBIAN_SNA=
PSHOT_DATE} \2%" /etc/apt/sources.list
> =20
>  # Duplicate deb line as deb-src
>=20


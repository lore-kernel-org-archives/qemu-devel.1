Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731F5C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48F1722DBF
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F1722DBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5pD7-0008Oe-JX
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 06:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i5pBV-0007SI-Tb
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i5pBU-0002tK-KW
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:40:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i5pBU-0002sj-Al
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:40:12 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 629B4C055673
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 10:40:11 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id j11so326518wmh.2
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 03:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rzNkkpZhVs40qoLTLY2VtbAEoZDa1XPa/NCoUNkxRkQ=;
 b=qA/oXZViLYo8eA5n89Q0F8qAJdToTwxcECDd46MGy8QmPLNNKfOY9Hktjeg3yQSc7l
 6yxyXggBbj209Pk2FdO06/FVrwOUPkEH8Wj7GCYdYvtYGP987u4zCaxfsuEa70ickW/4
 vwBAUzUkickSYse0fbAhSbBuCguCBkmZNfGpOenkGI1tgea/cKda1YWCDcW8tN/uidxI
 eG9mlnGRGN3/xLVapR4/sNGALj56E4YWcwqmcAoH7kqUoMcCMrJzzDxrNnhtryqX8Nau
 GQasSvh1P+bcldYx+MHHj2VU6GBu4aDDEbANPE/CFVwgevthqRZ7Wp27t8viBf4GiVV4
 FifQ==
X-Gm-Message-State: APjAAAX3aDpzcXADDR3b65DWh+gkbZHwBIuzKKQW5ioyek4WFAjs+R2W
 c6nJcUDqWk1mG238LWLlWkTG7VoMCkiGuO1yhMRzK8kEjcB077CzVR/mSD+J6fyTOZrAj/Pctxf
 WIHPueLypHNc+Z50=
X-Received: by 2002:adf:fb4b:: with SMTP id c11mr1910586wrs.176.1567680010107; 
 Thu, 05 Sep 2019 03:40:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzrYH9l/NdM5kjZYnFn1Y7Ty260Mv3AEKMcuf2r5LRSEvPKY22w9GKcPSziTxoRF3TFL3lvRw==
X-Received: by 2002:adf:fb4b:: with SMTP id c11mr1910561wrs.176.1567680009938; 
 Thu, 05 Sep 2019 03:40:09 -0700 (PDT)
Received: from [192.168.1.48] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id a7sm2355344wra.43.2019.09.05.03.40.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2019 03:40:09 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190904203013.9028-1-alex.bennee@linaro.org>
 <20190904203013.9028-26-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c27ec42d-ef09-4db7-4950-9b0af2215bbf@redhat.com>
Date: Thu, 5 Sep 2019 12:40:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190904203013.9028-26-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 25/42] tests/docker: avoid $SHELL invoke
 bash directly
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/19 10:29 PM, Alex Benn=C3=A9e wrote:
> On some images SHELL is pointing at a limited /bin/sh which doesn't
> understand noprofile/norc. Given the run script is running bash just
> invoke it directly.
>=20

This fixes:

  $ make docker-test-build@IMAGE DEBUG=3D1
  [...]
  + echo '  ./test-build'
  ./test-build
  + echo '* Hit Ctrl-D to continue, or type '\''exit 1'\'' to abort'
  * Hit Ctrl-D to continue, or type 'exit 1' to abort
  + echo
  + /bin/sh --noprofile --norc
  /bin/sh: 0: Illegal option --

Fixes: 2b0c4fa13f3

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/docker/run | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/docker/run b/tests/docker/run
> index 1014871fec0..8edc7026ee3 100755
> --- a/tests/docker/run
> +++ b/tests/docker/run
> @@ -62,7 +62,7 @@ echo "* Prepared to run command:"
>  echo "  $CMD"
>  echo "* Hit Ctrl-D to continue, or type 'exit 1' to abort"
>  echo
> -$SHELL --noprofile --norc
> +env bash --noprofile --norc
> =20
>  if "$CMD"; then
>      exit 0
> @@ -72,7 +72,7 @@ elif test -n "$DEBUG"; then
>      echo "* Hit Ctrl-D to exit"
>      echo
>      # Force error after shell exits
> -    $SHELL --noprofile --norc && exit 1
> +    env bash --noprofile --norc && exit 1
>  else
>      exit 1
>  fi
>=20


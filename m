Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7A0C2D0EE
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 11:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09197208E0
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 11:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="al5+8Ol8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09197208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJEpG-0001gY-39
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 07:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJEoH-0001DV-F7
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJEoF-0005Gp-Gy
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:11:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30228
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJEoF-0005GL-9C
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585653114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U/Gzojz/GFJlr+4irscvqrMAwsyOmWw5FxIAff4MNis=;
 b=al5+8Ol8H9Xj/H8NuUHcDMiJZgex3RPyWYRykwW5fVR1/UugC/5MvpbiTuwa73SSp7Vuj2
 QDjyy044KmQEA2EP09//oS33hIXyIQHrE9Qe9mu4xoKMa5kmzHWXBPrxeN4wo89kGoKHbE
 AlGblFiyYPcHArLKS1QAGSKcIL/O87U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-6x3CUehnOfmJSpQdoQc4OQ-1; Tue, 31 Mar 2020 07:11:49 -0400
X-MC-Unique: 6x3CUehnOfmJSpQdoQc4OQ-1
Received: by mail-ed1-f69.google.com with SMTP id a14so18262497edx.22
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 04:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GB8JFlArqWgUYwGYZwUA43LyXgA6f6rv4cUxFw2lWwI=;
 b=PEWyGiINdQAhjzO4HwZBn8V2P64AUkturIzfxFzTGS/6kGzpEhwgWKjHpMbLs5o2LB
 QseOjfr4sF3fNim7czfm0OUCGQkvgXwZc1h6nrejE2mRw9CRNeHin4a6DQnpLZGUb3/c
 bYX2y7e5JS58eK3SfjimmiBpGAcL1Q9Xwa08rGRr7B4Qhy9wg/x/u1AfTT30ae6GJRFB
 MYkppfZWfuPVD6eAPQZTGmniaXngIMbZBkf98b9SWFJt2T9d2gozJTmk7nDi/6TOVnNC
 tmUyWrofuGD9gdIXly79LyDZmFZ0riIAS/L6MfOlBf5CWe8oHdREn9JnjlhZsumWbdya
 zpxg==
X-Gm-Message-State: ANhLgQ1yP78+LYKCHvmwKAshLjuMcvx9dkEA9OCLDpJbfGMq0cQPSuss
 XBT161PA5npQwNSNHDh6xYGYpYng7Nc7Ld/po0ecTqrEzvO8Cxaf+CZZy3UDbw+rWoeCz5QOZ8Z
 E91o8n0X7MSJ2JCs=
X-Received: by 2002:aa7:d65a:: with SMTP id v26mr15395868edr.248.1585653108141; 
 Tue, 31 Mar 2020 04:11:48 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtoD9wP6LAcA27kK8P+eAmGHqbonydrgmCI8A9iRD6+KOxo9Xg1hbqb5mO5NXgL09gN0oBYbw==
X-Received: by 2002:aa7:d65a:: with SMTP id v26mr15395848edr.248.1585653107945; 
 Tue, 31 Mar 2020 04:11:47 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id pj22sm2151663ejb.79.2020.03.31.04.11.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 04:11:46 -0700 (PDT)
Subject: Re: [PATCH] configure: warn if not using a separate build directory
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200331103758.370644-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9b81074d-b9c8-8392-19a2-2f377224b66f@redhat.com>
Date: Tue, 31 Mar 2020 13:11:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200331103758.370644-1-berrange@redhat.com>
Content-Language: en-US
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/31/20 12:37 PM, Daniel P. Berrang=C3=A9 wrote:
> Running configure directly from the source directory is a build
> configuration that will go away in future. It is also not currently
> covered by any automated testing. Display a deprecation warning if
> the user attempts to use an in-srcdir build setup, so that they are
> aware that they're building QEMU in an undesirable manner.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   configure | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
>=20
> diff --git a/configure b/configure
> index e225a1e3ff..1ab7492ab5 100755
> --- a/configure
> +++ b/configure
> @@ -3,6 +3,19 @@
>   # qemu configure script (c) 2003 Fabrice Bellard
>   #
>  =20
> +BUILDDIR=3D$(pwd)
> +SRCDIR=3D$(dirname "$0")

This duplicates $source_path.
Maybe you can rename it $source_path and remove the $source_path=20
assignment later.

> +
> +ABS_BUILDDIR=3D$(realpath $BUILDDIR)
> +ABS_SRCDIR=3D$(realpath $SRCDIR)
> +
> +in_srcdir=3Dno
> +if [ "$ABS_SRCDIR" =3D=3D "$ABS_BUILDDIR" ]
> +then
> +    in_srcdir=3Dyes
> +fi
> +
> +
>   # Unset some variables known to interfere with behavior of common tools=
,
>   # just as autoconf does.
>   CLICOLOR_FORCE=3D GREP_OPTIONS=3D
> @@ -6799,6 +6812,23 @@ if test "$supported_os" =3D "no"; then
>       echo "us upstream at qemu-devel@nongnu.org."
>   fi
>  =20
> +if test "$in_srcdir" =3D "yes"; then
> +    echo
> +    echo "WARNING: SUPPORT FOR IN SOURCE DIR BUILDS IS DEPRECATED"
> +    echo
> +    echo "Support for running the 'configure' script directly from the"
> +    echo "source directory is deprecated and will go away in a future"
> +    echo "release. In source dir builds are not covered by automated"
> +    echo "testing and are liable to break without warning. Users are"
> +    echo "strongly recommended to switch to a separate build directory:"
> +    echo
> +    echo "  $ mkdir build"
> +    echo "  $ cd build"
> +    echo "  $ ../configure"
> +    echo "  $ make"
> +    echo
> +fi

I'd move it at the very end of the file, to be the last thing displayed.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +
>   config_host_mak=3D"config-host.mak"
>  =20
>   echo "# Automatically generated by configure - do not modify" >config-a=
ll-disas.mak
>=20



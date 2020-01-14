Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1986C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD302467A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1D1yWvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD302467A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irMFt-0004w0-F2
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 08:29:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irLoX-0001K8-Kr
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irLoR-0003H0-7G
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:00:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39616
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irLoR-0003Gu-2B
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579006850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IRxlt6zcFfb84BS3BgswWOSXqHCNiDzVeYWSGiwlz6w=;
 b=d1D1yWvuRhpSFjkZ7o86i43gOx1qkDXAjWJ+Uzo44AdqFvRIFlfeykijAXmmqf6Cccp0ys
 iwumpI5eXL3zws7r5NeV8BUDrQk2TB8CTi6sF8K5ltlndHVkdH9zhY/F/tRuZDJIT89oLu
 Bbr+5itlO05nexvPCEQVFMikcgtQLm8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-qz5Vdy8aNNKj3SsIgOLPsw-1; Tue, 14 Jan 2020 08:00:49 -0500
Received: by mail-wr1-f70.google.com with SMTP id f15so6512849wrr.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 05:00:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x0N0FnM+mF4cWc2mLxcC1bCIhPz2lljyI5EFJvi2l7U=;
 b=Xgn10xHXWQ9d5CI39R4tqoRVyyIwZFw0MCA3+Sv8uVaoF2Lb0sBibdJqyEC1dpnFjH
 kvR43UowD2GzGFxqfbRPsD6efjUkQfGFdduYvhtZlF7lGmG6uRpw5zkTKnuGgazDAzKg
 WfmAshUfyS3zqoZ8FsZI2nlixg/XjjmXHtw4lx2PXin5SKSB8XnCU2cmLPt7sHIp/v+U
 M3A5hRLh+SKryMok0MqhiKvvb6lw2S5IfYZH1g3I10IvMc4wiSSAr1UQongoWsI4OBFh
 NL7BvCtzndQBInLwBO/PD+JUWJvZVEQrk/H8jglo5fLD1T96QTIzwAxqZahrvs85BwzL
 VgcQ==
X-Gm-Message-State: APjAAAX9lDhX+lOuxT51IDtbY4acR1M9JGh70D/OkS88p5V0NCFDby9v
 TmmFQTquBKnWGHBOKuVlDnFP/4nwyu0f4yAFaZ7axAzqVklc0enN908mA+tV7OMUaX613ZRHj+t
 EX8I5LfF2jLnWzDA=
X-Received: by 2002:a7b:c847:: with SMTP id c7mr26711748wml.3.1579006847984;
 Tue, 14 Jan 2020 05:00:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqzONXz4/UV3EJj0FGbmiWbldN1MG4+DEW3oQA9lIYvywb+JWm8ojGqSKv2qQ/EDw/HiaPhoYA==
X-Received: by 2002:a7b:c847:: with SMTP id c7mr26711722wml.3.1579006847742;
 Tue, 14 Jan 2020 05:00:47 -0800 (PST)
Received: from [10.0.1.197] (lfbn-mon-1-1103-34.w90-48.abo.wanadoo.fr.
 [90.48.206.34])
 by smtp.gmail.com with ESMTPSA id z4sm18797672wma.2.2020.01.14.05.00.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2020 05:00:47 -0800 (PST)
Subject: Re: [PULL 1/1] trace: update qemu-trace-stap to Python 3
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200114092918.117399-1-stefanha@redhat.com>
 <20200114092918.117399-2-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1f902433-199a-178b-3968-86f23f67b2d9@redhat.com>
Date: Tue, 14 Jan 2020 14:00:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114092918.117399-2-stefanha@redhat.com>
Content-Language: en-US
X-MC-Unique: qz5Vdy8aNNKj3SsIgOLPsw-1
X-Mimecast-Spam-Score: 0
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/14/20 10:29 AM, Stefan Hajnoczi wrote:
> qemu-trace-stap does not support Python 3 yet:
>=20
>    $ scripts/qemu-trace-stap list path/to/qemu-system-x86_64
>    Traceback (most recent call last):
>      File "scripts/qemu-trace-stap", line 175, in <module>
>        main()
>      File "scripts/qemu-trace-stap", line 171, in main
>        args.func(args)
>      File "scripts/qemu-trace-stap", line 118, in cmd_list
>        print_probes(args.verbose, "*")
>      File "scripts/qemu-trace-stap", line 114, in print_probes
>        if line.startswith(prefix):
>    TypeError: startswith first arg must be bytes or a tuple of bytes, not=
 str
>=20
> Now that QEMU requires Python 3.5 or later we can switch to pure Python
> 3.  Use Popen()'s universal_newlines=3DTrue argument to treat stdout as
> text instead of binary.
>=20
> Fixes: 62dd1048c0bd ("trace: add ability to do simple printf logging via =
systemtap")
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1787395
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Message-id: 20200107112438.383958-1-stefanha@redhat.com
> Message-Id: <20200107112438.383958-1-stefanha@redhat.com>

One Message-Id is enough ;)

> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   scripts/qemu-trace-stap | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/scripts/qemu-trace-stap b/scripts/qemu-trace-stap
> index 91d1051cdc..90527eb974 100755
> --- a/scripts/qemu-trace-stap
> +++ b/scripts/qemu-trace-stap
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python
> +#!/usr/bin/env python3
>   # -*- python -*-
>   #
>   # Copyright (C) 2019 Red Hat, Inc
> @@ -18,8 +18,6 @@
>   # You should have received a copy of the GNU General Public License
>   # along with this program; if not, see <http://www.gnu.org/licenses/>.
>  =20
> -from __future__ import print_function
> -
>   import argparse
>   import copy
>   import os.path
> @@ -104,7 +102,9 @@ def cmd_list(args):
>           if verbose:
>               print("Listing probes with name '%s'" % script)
>           proc =3D subprocess.Popen(["stap", "-l", script],
> -                                stdout=3Dsubprocess.PIPE, env=3Dtapset_e=
nv(tapsets))
> +                                stdout=3Dsubprocess.PIPE,
> +                                universal_newlines=3DTrue,
> +                                env=3Dtapset_env(tapsets))
>           out, err =3D proc.communicate()
>           if proc.returncode !=3D 0:
>               print("No probes found, are the tapsets installed in %s" % =
tapset_dir(args.binary))
>=20



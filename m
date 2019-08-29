Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D78C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9B02073F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9B02073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3MMm-0006Bv-1B
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 11:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3MLL-0004ig-4d
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3MLJ-0004od-00
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:28:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36417)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3MLI-0004n1-OT
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:28:08 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DBEE2882EA
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 15:28:06 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id x12so2287182wrw.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 08:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O8vQGGlsIVzPWglK2pvh0sdNwL5Pq856ztvbWAxW9lM=;
 b=LE7BB/8OC7nBbhX9lmqWVom/yW9iqaV/1ihDD9pM4cZRi4IU/FgNeYwVysKyPB2TyZ
 ikOHQ/jc8WDB4LsdgDXF/Q5UUyi5mYUFE/vsnRgo8lgYyOgh9gcVOvCDS26oSM67XBo3
 RPooLj1fIRzfL+3lWpdi1o9Df24Y0lnmstEaY+Qtjo4RJP/4ufiksohucZ5/pOS0JRDv
 598Xyq94GcPCH6BsBDlB2dgyQtrvV58D1HlCVIC0Bx46XNYilcQNc9XsfKO8+fc8Gj4X
 RPnOXRvBAs3NS3Zijhn6BD5UWpa4lUSdH8Wec80jMilG0JTBrlwgO2ORh88F9eMWZjfp
 x3kw==
X-Gm-Message-State: APjAAAV0EsdB3utszQ2HKqgE6mTirKgUZndhYzJyS3Fnt2gxDs4l54n1
 c7N5RM5D7HFejBH3A9EI46QJ2aNk3aZGJLQd0Py5OKB5KCZPGhEsNbbgjTWtStN2w8wtEmij1hH
 LVofEuMDkjfDhp5k=
X-Received: by 2002:a05:6000:110f:: with SMTP id
 z15mr3487693wrw.162.1567092485615; 
 Thu, 29 Aug 2019 08:28:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxRvVVv0OjQsNWYMhO94hkpjKWCCfR6SUe7OcjFtl/Nos3HLJwlyx25WE1zYmJ0Id/cxyrNDQ==
X-Received: by 2002:a05:6000:110f:: with SMTP id
 z15mr3487681wrw.162.1567092485434; 
 Thu, 29 Aug 2019 08:28:05 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id i5sm4060331wrn.48.2019.08.29.08.28.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 08:28:04 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190829144120.12701-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9e98702a-6582-3d38-c9a4-93f0279033bf@redhat.com>
Date: Thu, 29 Aug 2019 17:28:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190829144120.12701-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] tests/docker: upgrade docker.py to python3
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 berrange@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/29/19 4:41 PM, Alex Benn=C3=A9e wrote:
> The recent podman changes (9459f754134bb) imported enum which is part
> of the python3 standard library but only available as an external
> library for python2. This causes problems on the fairly restricted
> environment such as shippable. Lets bite the bullet and make the
> script a fully python3 one. To that end:
>=20
>   - drop the from __future__ import (we are there now ;-)
>   - avoid the StringIO import hack
>   - be consistent with the mode we read/write dockerfiles
>   - s/iteritems/items/
>   - ensure check_output returns strings for processing

Many boring changes at once...

>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/docker/docker.py | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>=20
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index ac5baab4cad..4bba29e104e 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python2
> +#!/usr/bin/env python3
>  #
>  # Docker controlling module
>  #
> @@ -11,7 +11,6 @@
>  # or (at your option) any later version. See the COPYING file in
>  # the top-level directory.
> =20
> -from __future__ import print_function
>  import os
>  import sys
>  import subprocess
> @@ -25,10 +24,7 @@ import tempfile
>  import re
>  import signal
>  from tarfile import TarFile, TarInfo
> -try:
> -    from StringIO import StringIO
> -except ImportError:
> -    from io import StringIO
> +from io import StringIO
>  from shutil import copy, rmtree
>  from pwd import getpwuid
>  from datetime import datetime, timedelta
> @@ -62,11 +58,13 @@ USE_ENGINE =3D EngineEnum.AUTO
> =20
>  def _text_checksum(text):
>      """Calculate a digest string unique to the text content"""
> -    return hashlib.sha1(text).hexdigest()
> +    return hashlib.sha1(text.encode('utf-8')).hexdigest()
> =20
> +def _read_dockerfile(path):
> +    return open(path, 'rt', encoding=3D'utf-8').read()

TIL it's cleaner to explicit the 't' mode.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>  def _file_checksum(filename):
> -    return _text_checksum(open(filename, 'rb').read())
> +    return _text_checksum(_read_dockerfile(filename))
> =20
> =20
>  def _guess_engine_command():
> @@ -192,7 +190,7 @@ def _read_qemu_dockerfile(img_name):
> =20
>      df =3D os.path.join(os.path.dirname(__file__), "dockerfiles",
>                        img_name + ".docker")
> -    return open(df, "r").read()
> +    return _read_dockerfile(df)
> =20
> =20
>  def _dockerfile_preprocess(df):
> @@ -262,6 +260,7 @@ class Docker(object):
>      def _output(self, cmd, **kwargs):
>          return subprocess.check_output(self._command + cmd,
>                                         stderr=3Dsubprocess.STDOUT,
> +                                       encoding=3D'utf-8',
>                                         **kwargs)
> =20
>      def inspect_tag(self, tag):
> @@ -283,7 +282,9 @@ class Docker(object):
>          if argv is None:
>              argv =3D []
> =20
> -        tmp_df =3D tempfile.NamedTemporaryFile(dir=3Ddocker_dir, suffi=
x=3D".docker")
> +        tmp_df =3D tempfile.NamedTemporaryFile(mode=3D"w+t",
> +                                             encoding=3D'utf-8',
> +                                             dir=3Ddocker_dir, suffix=3D=
".docker")
>          tmp_df.write(dockerfile)
> =20
>          if user:
> @@ -396,7 +397,7 @@ class BuildCommand(SubCommand):
>                              help=3D"Dockerfile name")
> =20
>      def run(self, args, argv):
> -        dockerfile =3D open(args.dockerfile, "rb").read()
> +        dockerfile =3D _read_dockerfile(args.dockerfile)
>          tag =3D args.tag
> =20
>          dkr =3D Docker()
> @@ -442,7 +443,7 @@ class BuildCommand(SubCommand):
>                  cksum +=3D [(filename, _file_checksum(filename))]
> =20
>              argv +=3D ["--build-arg=3D" + k.lower() + "=3D" + v
> -                     for k, v in os.environ.iteritems()
> +                     for k, v in os.environ.items()
>                       if k.lower() in FILTERED_ENV_NAMES]
>              dkr.build_image(tag, docker_dir, dockerfile,
>                              quiet=3Dargs.quiet, user=3Dargs.user, argv=
=3Dargv,
> @@ -611,7 +612,7 @@ class CheckCommand(SubCommand):
>                  print("Need a dockerfile for tag:%s" % (tag))
>                  return 1
> =20
> -            dockerfile =3D open(args.dockerfile, "rb").read()
> +            dockerfile =3D _read_dockerfile(args.dockerfile)
> =20
>              if dkr.image_matches_dockerfile(tag, dockerfile):
>                  if not args.quiet:
>=20


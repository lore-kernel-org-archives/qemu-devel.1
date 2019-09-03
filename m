Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7850C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF382087E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF382087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i597J-0004gU-6Q
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 09:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i593Y-0008PI-8b
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i593W-00009p-Pi
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:41:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52084)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i593W-00009e-Hu
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:41:10 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8A7A562E9A
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2019 13:41:09 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id j10so10406741wrb.16
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 06:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nSGimK5jRWnHqZqkA1T5IEdTVDKvOnz7+7AMW0CRkUs=;
 b=dGsALw49FU7V1XUsmNjrNhBTJx/L3w2m+BxnkJB6CSr5GRjq4OmtwGpYTnA1lf5ig8
 hCksTKz5d+d+ulBJGELdH54uYaVf3QGIrKUNzsD/rH3Do8rteNXG+QhYx5+CJcE+hC79
 z9tOgX1lpUUcIaetVSumBdnbcLKDCCdYp8QRRxAtn8Ohlx4jBwunemkHKUd0E3I48mde
 QR89UT0lH5EbZaLlyTIbPUqZUnhzyZrYbnvH/DaKMGfnhmLX4KQasnfvzu2BZLLmZTeH
 0MvSdCW1hT+jgbzjl6aeTp6riAv+pMkfJ/W98UrscGhus1WgYQw90A9ucJM65ZRSlAz/
 dVrQ==
X-Gm-Message-State: APjAAAWZijzUz4N754htgvNThh6L8qwn2FvHC151K4icz4so4STIBwYn
 ZmJ71QZol4drUIo7scuntfRlw5g364OVpfrBLMxHblystLbvqnqrd7rb9QFZuD6kDGLAs7QSvL5
 Cl/Lmw9mXHlfvG/4=
X-Received: by 2002:a1c:770c:: with SMTP id t12mr52016wmi.91.1567518068276;
 Tue, 03 Sep 2019 06:41:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwGSDi0x7rEYurKC+XZ/cs2VVgpRIZlLOMt3bjKipEd2fmJao5vW4GMyVt90HIQnRqE+704Gg==
X-Received: by 2002:a1c:770c:: with SMTP id t12mr51981wmi.91.1567518067989;
 Tue, 03 Sep 2019 06:41:07 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id r65sm31661010wmr.9.2019.09.03.06.41.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2019 06:41:07 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, alex.bennee@linaro.org
References: <20190822134725.32479-1-marcandre.lureau@redhat.com>
 <20190822134725.32479-3-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <06c4e9a3-9c40-89a5-ce64-4f8dc8c3adc0@redhat.com>
Date: Tue, 3 Sep 2019 15:41:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190822134725.32479-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 2/6] docker.py: add podman support
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/22/19 3:47 PM, Marc-Andr=C3=A9 Lureau wrote:
> Add a --engine option to select either docker, podman or auto.
>=20
> Among other advantages, podman allows to run rootless & daemonless
> containers, fortunately sharing compatible CLI with docker.
>=20
> With current podman, we have to use a uidmap trick in order to be able
> to rw-share the ccache directory with the container user.
>=20
> With a user 1000, the default mapping is:                              =
                                                                         =
                                                                  1000 (h=
ost) -> 0 (container).
> So write access to /var/tmp/ccache ends will end with permission
> denied error.
>=20
> With "--uidmap 1000:0:1 --uidmap 0:1:1000", the mapping is:
> 1000 (host) -> 0 (container, 1st namespace) -> 1000 (container, 2nd nam=
espace).
> (the rest is mumbo jumbo to avoid holes in the range of UIDs)
>=20
> A future podman version may have an option such as --userns-keep-uid.
> Thanks to Debarshi Ray <rishi@redhat.com> for the help!
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/docker/docker.py | 48 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 43 insertions(+), 5 deletions(-)
>=20
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index f15545aeea..ac5baab4ca 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -20,6 +20,7 @@ import hashlib
>  import atexit
>  import uuid
>  import argparse
> +import enum

This broke Shippable:
https://app.shippable.com/github/qemu/qemu/runs/1897/summary/console

  Traceback (most recent call last):
    File "./tests/docker/docker.py", line 23, in <module>
      import enum
  ImportError: No module named enum

>  import tempfile
>  import re
>  import signal
> @@ -38,6 +39,26 @@ FILTERED_ENV_NAMES =3D ['ftp_proxy', 'http_proxy', '=
https_proxy']
> =20
>  DEVNULL =3D open(os.devnull, 'wb')
> =20
> +class EngineEnum(enum.IntEnum):
> +    AUTO =3D 1
> +    DOCKER =3D 2
> +    PODMAN =3D 3
> +
> +    def __str__(self):
> +        return self.name.lower()
> +
> +    def __repr__(self):
> +        return str(self)
> +
> +    @staticmethod
> +    def argparse(s):
> +        try:
> +            return EngineEnum[s.upper()]
> +        except KeyError:
> +            return s
> +
> +
> +USE_ENGINE =3D EngineEnum.AUTO
> =20
>  def _text_checksum(text):
>      """Calculate a digest string unique to the text content"""
> @@ -48,9 +69,14 @@ def _file_checksum(filename):
>      return _text_checksum(open(filename, 'rb').read())
> =20
> =20
> -def _guess_docker_command():
> -    """ Guess a working docker command or raise exception if not found=
"""
> -    commands =3D [["docker"], ["sudo", "-n", "docker"]]
> +def _guess_engine_command():
> +    """ Guess a working engine command or raise exception if not found=
"""
> +    commands =3D []
> +
> +    if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.PODMAN]:
> +        commands +=3D [["podman"]]
> +    if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.DOCKER]:
> +        commands +=3D [["docker"], ["sudo", "-n", "docker"]]
>      for cmd in commands:
>          try:
>              # docker version will return the client details in stdout
> @@ -61,7 +87,7 @@ def _guess_docker_command():
>          except OSError:
>              pass
>      commands_txt =3D "\n".join(["  " + " ".join(x) for x in commands])
> -    raise Exception("Cannot find working docker command. Tried:\n%s" %
> +    raise Exception("Cannot find working engine command. Tried:\n%s" %
>                      commands_txt)
> =20
> =20
> @@ -190,7 +216,7 @@ def _dockerfile_preprocess(df):
>  class Docker(object):
>      """ Running Docker commands """
>      def __init__(self):
> -        self._command =3D _guess_docker_command()
> +        self._command =3D _guess_engine_command()
>          self._instances =3D []
>          atexit.register(self._kill_instances)
>          signal.signal(signal.SIGTERM, self._kill_instances)
> @@ -340,6 +366,11 @@ class RunCommand(SubCommand):
>          if args.run_as_current_user:
>              uid =3D os.getuid()
>              argv =3D [ "-u", str(uid) ] + argv
> +            docker =3D Docker()
> +            if docker._command[0] =3D=3D "podman":
> +                argv =3D [ "--uidmap", "%d:0:1" % uid,
> +                         "--uidmap", "0:1:%d" % uid,
> +                         "--uidmap", "%d:%d:64536" % (uid + 1, uid + 1=
)] + argv
>          return Docker().run(argv, args.keep, quiet=3Dargs.quiet)
> =20
> =20
> @@ -507,6 +538,8 @@ class ProbeCommand(SubCommand):
>                  print("yes")
>              elif docker._command[0] =3D=3D "sudo":
>                  print("sudo")
> +            elif docker._command[0] =3D=3D "podman":
> +                print("podman")
>          except Exception:
>              print("no")
> =20
> @@ -602,9 +635,13 @@ class CheckCommand(SubCommand):
> =20
> =20
>  def main():
> +    global USE_ENGINE
> +
>      parser =3D argparse.ArgumentParser(description=3D"A Docker helper"=
,
>                                       usage=3D"%s <subcommand> ..." %
>                                       os.path.basename(sys.argv[0]))
> +    parser.add_argument("--engine", type=3DEngineEnum.argparse, choice=
s=3Dlist(EngineEnum),
> +                        help=3D"specify which container engine to use"=
)
>      subparsers =3D parser.add_subparsers(title=3D"subcommands", help=3D=
None)
>      for cls in SubCommand.__subclasses__():
>          cmd =3D cls()
> @@ -613,6 +650,7 @@ def main():
>          cmd.args(subp)
>          subp.set_defaults(cmdobj=3Dcmd)
>      args, argv =3D parser.parse_known_args()
> +    USE_ENGINE =3D args.engine
>      return args.cmdobj.run(args, argv)
> =20
> =20
>=20


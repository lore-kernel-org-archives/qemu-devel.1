Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4C0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8954205F4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kUx7UKCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8954205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw4tE-0003f4-T8
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 08:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iw4sU-00030l-FD
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:56:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iw4sT-0002zr-0Y
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:56:34 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232]:33847)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iw4sS-0002yn-OW
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:56:32 -0500
Received: by mail-lj1-x232.google.com with SMTP id x7so10727936ljc.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 05:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1uWxbNbiek7eP9l1TB5J6fznoMQZoDDzbH9u8QTUPV8=;
 b=kUx7UKCpfdT0IDuRUPeoRbtUWDU7N3TM4ShDlSNzNxKYabnarayaSw7yQTOigbUxjU
 WDgxcBtCaMvj2ubbp7OPXLoILKu4ApbDJlaiMydKAUtPgE1nezsO6pwH0RETSj++vb+b
 kdtrOq7LpI7CxHXto+Zy9fpxMnsyMO+6TSPS3PVeUDqXmqplYFVWNqv9xqtPXMWC8k7M
 rr0yYCP/DlIOwqFja31vTb0oDGF5EsQ8+6AtWEYtZThxVjdJn93lArQT1ORKq0ptLHPS
 frYsPEXN68A28ylBg/OKyXQAmXknmzMUFmZnGA3Yzcv7TJpF3h6dnorMv6pzMl3XpHX1
 pClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1uWxbNbiek7eP9l1TB5J6fznoMQZoDDzbH9u8QTUPV8=;
 b=mnHcRXeFSXg/pz8H7KcrxORGKx46vBkNO0QLRhItCfyRMgqtSLq8oU2inA89w4a7iE
 tlaeCbAoACIxdVbHxI6ygTT+v1sv3lc4ed5TOMkvoc6XfE6Q5NGhl7avXiS0bzDnc+wO
 PesRXnVt9r/GQf/Qq11wtTcXJEqqh3RP2zXQPX+mOnJ6veA2BQC9ORCoisCBm/KI3I3o
 eqNqajbnhTde5buMB5tcj+cCVv/8Ynvqe/imCcKqMAtjbgf74/B9B6/T+y4X2E2XTUEn
 qCy5aw0j5ASwxM8vqvzEP96XIUFZTOJ1/bmYN6oQyWJo9fYLxDE0fBNZwgwNMTB+EgBe
 Pn5w==
X-Gm-Message-State: APjAAAUi3nG8s/yftQmQvgZimHgq947DgA/EOw0koKUV9DjMdJk9vqG2
 mfuG8i9DHXyaiz2LgooDIxqsBzexiBxhEGVhwTjlXg==
X-Google-Smtp-Source: APXvYqxVrc7cZLe8cNWulVFXZjsVruMCREgolAxhCYB9WRklW1WCoUGOaGiyoJH5kOp8I+rCxJ5jUN5TNOXH7Ac+1Jk=
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr10453207ljg.166.1580133391166; 
 Mon, 27 Jan 2020 05:56:31 -0800 (PST)
MIME-Version: 1.0
References: <20200124165335.422-1-robert.foley@linaro.org>
 <20200124165335.422-5-robert.foley@linaro.org>
 <87sgk1f5ko.fsf@linaro.org>
In-Reply-To: <87sgk1f5ko.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 27 Jan 2020 08:56:20 -0500
Message-ID: <CAEyhzFvf2YcuKfB2+RS+iU0JBSMLn1eGhLq6VVKoks-5WPgGCA@mail.gmail.com>
Subject: Re: [PATCH 4/8] tests/vm: Add configuration to basevm.py
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::232
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
Cc: fam@euphon.net, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jan 2020 at 07:26, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> > -SSH_KEY =3D open(os.path.join(os.path.dirname(__file__),
> > -               "..", "keys", "id_rsa")).read()
> > -SSH_PUB_KEY =3D open(os.path.join(os.path.dirname(__file__),
> > -                   "..", "keys", "id_rsa.pub")).read()
> > -
> > +SSH_KEY_FILE =3D os.path.join(os.path.dirname(__file__),
> > +               "..", "keys", "id_rsa")
> > +SSH_PUB_KEY_FILE =3D os.path.join(os.path.dirname(__file__),
> > +                   "..", "keys", "id_rsa.pub")
> > +SSH_KEY =3D open(SSH_KEY_FILE).read()
> > +SSH_PUB_KEY =3D open(SSH_PUB_KEY_FILE).read()
>
> Why are we tracking more information about the keyfile than we used to
> now? Is this because it's harder to embed keys over paths in the config?
We now allow the user to override the ssh keys.  Because of this we
need to track
the filename separately from the contents of the file, so that we can
put this default
filename into the DEFAULT_CONFIG below.
We also keep the original SSH_PUB_KEY since it is still
used by some pre-existing VM scripts, and we did not want to break backward=
s
compatibility for those scripts.
Actually upon further inspection, it looks like we can delete SSH_KEY,
this is no longer needed. :)
>
> > +
> > +# This is the standard configuration.
> > +# Any or all of these can be overridden by
> > +# passing in a config argument to the VM constructor.
> > +DEFAULT_CONFIG =3D {
> > +    'cpu'             : "max",
> > +    'machine'         : 'pc',
> > +    'guest_user'      : "qemu",
> > +    'guest_pass'      : "qemupass",
> > +    'root_pass'       : "qemupass",
> > +    'ssh_key_file'    : SSH_KEY_FILE,
> > +    'ssh_pub_key_file': SSH_PUB_KEY_FILE,
> > +    'memory'          : "4G",
> > +    'extra_args'      : [],
> > +    'dns'             : "",
> > +    'ssh_port'        : 0,
> > +    'install_cmds'    : "",
> > +    'boot_dev_type'   : "block",
> > +    'ssh_timeout'     : 1,
> > +}
> > +BOOT_DEVICE =3D {
> > +    'block' :  "-drive file=3D{},if=3Dnone,id=3Ddrive0,cache=3Dwriteba=
ck "\
> > +               "-device virtio-blk,drive=3Ddrive0,bootindex=3D0",
> > +    'scsi'  :  "-device virtio-scsi-device,id=3Dscsi "\
> > +               "-drive file=3D{},format=3Draw,if=3Dnone,id=3Dhd0 "\
> > +               "-device scsi-hd,drive=3Dhd0,bootindex=3D0",
> > +}
> >  class BaseVM(object):
> > -    GUEST_USER =3D "qemu"
> > -    GUEST_PASS =3D "qemupass"
> > -    ROOT_PASS =3D "qemupass"
>
> Don't we need these?
We don't need these since we moved them up to the new DEFAULT_CONFIG.
These are essentially the default values now since the user
can now override these.
We also handle the cases where these are accessed by existing scripts,
and ensuring backwards compatibility by referencing these values in the
_config (see the code in __getattr__).

This actually brings up a good point that I wanted to mention.
Our initial plan was to leave the existing VM scripts unchanged.
We were thinking that it would also clarify things for a later patch to
simply change references to ROOT_PASS, GUEST_USER/ PASS,
and SSH_PUB_KEY, within the existing VM scripts (centos, openbsd, etc)
to use _config, and then we could get rid of the __getattr__ change entirel=
y.
Actually, we could even put it at the end of this series too.
I think I will add this change to the next version of this patch unless you
think we should keep it separate?
> >
> >      envvars =3D [
> >          "https_proxy",
> > @@ -59,19 +84,26 @@ class BaseVM(object):
> >      poweroff =3D "poweroff"
> >      # enable IPv6 networking
> >      ipv6 =3D True
> > -    def __init__(self, debug=3DFalse, vcpus=3DNone):
> > +    def __init__(self, debug=3DFalse, vcpus=3DNone, config=3DNone):
> >          self._guest =3D None
> > +        # Allow input config to override defaults.
> > +        self._config =3D DEFAULT_CONFIG.copy()
> > +        if config !=3D None:
> > +            self._config.update(config)
> >          self._tmpdir =3D os.path.realpath(tempfile.mkdtemp(prefix=3D"v=
m-test-",
> >                                                           suffix=3D".tm=
p",
> >                                                           dir=3D"."))
> >          atexit.register(shutil.rmtree, self._tmpdir)
> > -
> > +        self._config['ssh_key'] =3D \
> > +            open(self._config['ssh_key_file']).read().rstrip()
> > +        self._config['ssh_pub_key'] =3D \
> > +            open(self._config['ssh_pub_key_file']).read().rstrip()
> >          self._ssh_key_file =3D os.path.join(self._tmpdir, "id_rsa")
> > -        open(self._ssh_key_file, "w").write(SSH_KEY)
> > +        open(self._ssh_key_file, "w").write(self._config['ssh_key'])
> >          subprocess.check_call(["chmod", "600", self._ssh_key_file])
> >
> >          self._ssh_pub_key_file =3D os.path.join(self._tmpdir, "id_rsa.=
pub")
> > -        open(self._ssh_pub_key_file, "w").write(SSH_PUB_KEY)
> > +        open(self._ssh_pub_key_file,
> >          "w").write(self._config['ssh_pub_key'])
>
> Read as a block I find this confusing:
>
>         self._config['ssh_key'] =3D \
>             open(self._config['ssh_key_file']).read().rstrip()
>         self._config['ssh_pub_key'] =3D \
>             open(self._config['ssh_pub_key_file']).read().rstrip()
>         self._ssh_key_file =3D os.path.join(self._tmpdir, "id_rsa")
>         open(self._ssh_key_file, "w").write(self._config['ssh_key'])
>         subprocess.check_call(["chmod", "600", self._ssh_key_file])
>
>         self._ssh_pub_key_file =3D os.path.join(self._tmpdir, "id_rsa.pub=
")
>         open(self._ssh_pub_key_file, "w").write(self._config['ssh_pub_key=
'])
>
> We read config['ssh_key_file'] but write out _ssh_pub_key_file which
> doesn't seem related.
I agree we can clarify this. :) Most of this logic was here previously,
we're just adding the parameterization of the keys.
This is the current flow:
1) copy the key file (config['ssh_key_file']) to a temporary file
(_ssh_pub_key_file)
2) chmod the key file so that ssh is happy with the permissions.
Without this chmod ssh will refuse to use the key file.
It seems to make sense to add a comment here to clarify all this.
It also seems like we could change the name _ssh_pub_key_file to
_ssh_tmp_pub_key_file
to make it more clear it is a temp file.
What do you think, would that be enough to clarify things?

Thanks & Regards,
-Rob
> <snip>

>
> --
> Alex Benn=C3=A9e


Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B84C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 18:54:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D11E206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 18:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="orZluL0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D11E206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcCo9-0003Qx-OX
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 14:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcCnb-0002yS-Or
 for qemu-devel@nongnu.org; Fri, 22 May 2020 14:53:39 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:40738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcCna-0002gU-GI
 for qemu-devel@nongnu.org; Fri, 22 May 2020 14:53:39 -0400
Received: by mail-lj1-x244.google.com with SMTP id z13so4227732ljn.7
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 11:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=K0x7SDi0gUrUmV5q0M7/Roy4O5nOeJTmwaeiCZ6ueLM=;
 b=orZluL0cxn6nZ+X/b4HjiWs+LA0eNS4LcVsKmbLXKfH8SMGOB7e+gwNc/gYVv+tB6m
 nirJ/zC/iBsclWygsRtka6UnLgYjM1INOf+fieLg/ac9WQp+oWbRbmCo8fCY5fQYq1cj
 NsklwK4GeN0Rn+BRraI+PQLY5We3jy+yFBHbXN8DASdY3Vxwiy1Te4SmPoNwlq5bXW4f
 ROZRu1Vu/L1LKlYibMCSMDwiI13FDhWX9CAxYzXZhnAvzZKv+ndmJEmUHMwApUMlHhZi
 6TIyxd72ZX6ErVsg69QTL3W/1WYHhFdxbD/+PPXrTsv0PxAFjdRFP6UrWkwO8q7WzGRL
 lsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=K0x7SDi0gUrUmV5q0M7/Roy4O5nOeJTmwaeiCZ6ueLM=;
 b=iIan2ltEi0pyCR10x+snx0IokTW1UEvt10p7XkK9NN6/wk3JWGZnm8uF+vShUlceOF
 +UA5F+KAjMeetGrpyDRCeJlUG/+TzdUpws38/MaCrX7HY0FI0/z6gtjcvzvDyMzdM+m2
 lnPP4MVU8zt428fhVc1fgezL5qdERWy1sEHJ2M2Cf7SCZS/nt6MLLiXxqBq1NCEo2cQK
 NpssSYMMT9vkZyPzYWpf9uepRFOFatQ5vHJa9z441lxVgUaq5gOdXMHs840XJwF3XpUf
 0GOxuB9b41jkXAxoU2UiTXV00HHvfLg73AliSwAjf3CDMwFDTOHGcZ1sB1be3ij5eCBb
 fKLQ==
X-Gm-Message-State: AOAM53214OHJ+X/l+uX0Q7qZsc3YPc93Ykqu8wNFxMiWGlM8JxECocMR
 WQ2qd8aDByxgXnMvta96LItoDQ6Uz8fCFNR6igE5lQ==
X-Google-Smtp-Source: ABdhPJyDOpAigp9Sqbj8MBJQUgFSLkfdxgKiW2X1hy92NAE0f3IUssKKjm/+WLQ6NjD/CgkYSGi0cck58jCoXK042pw=
X-Received: by 2002:a2e:3c0b:: with SMTP id j11mr6438581lja.424.1590173616138; 
 Fri, 22 May 2020 11:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200519132259.405-1-robert.foley@linaro.org>
 <20200519132259.405-8-robert.foley@linaro.org>
 <87blmgdod7.fsf@linaro.org>
In-Reply-To: <87blmgdod7.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Fri, 22 May 2020 14:53:29 -0400
Message-ID: <CAEyhzFvVpibA7cBD-P1hLu-89MuJPqS-ym-G+rhruHZShp1BYw@mail.gmail.com>
Subject: Re: [PATCH v7 07/12] tests/vm: Add ability to select QEMU from
 current build.
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,
These changes all seem like a good idea.  I will add them in the next
version of the patch.

Thanks & Regards,
-Rob
On Fri, 22 May 2020 at 10:40, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Robert Foley <robert.foley@linaro.org> writes:
>
> > Added a new special variable QEMU_LOCAL=3D1, which
> > will indicate to take the QEMU binary from the current
> > build.
> >
> > Signed-off-by: Robert Foley <robert.foley@linaro.org>
> > Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> > ---
> >  tests/vm/Makefile.include |  4 ++++
> >  tests/vm/basevm.py        | 25 ++++++++++++++++++++++---
> >  2 files changed, 26 insertions(+), 3 deletions(-)
> >
> > diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> > index e22c391a2a..83a33b1044 100644
> > --- a/tests/vm/Makefile.include
> > +++ b/tests/vm/Makefile.include
> > @@ -41,6 +41,7 @@ endif
> >       @echo "    J=3D[0..9]*                     - Override the -jN par=
ameter for make commands"
> >       @echo "    DEBUG=3D1                       - Enable verbose outpu=
t on host and interactive debugging"
> >       @echo "    V=3D1                           - Enable verbose ouput=
 on host and guest commands"
> > +     @echo "    QEMU_LOCAL=3D1                 - Use QEMU binary local=
 to this build."
> >       @echo "    QEMU=3D/path/to/qemu            - Change path to QEMU =
binary"
> >       @echo "    QEMU_IMG=3D/path/to/qemu-img    - Change path to qemu-=
img tool"
> >  ifeq ($(PYTHON_YAML),yes)
> > @@ -63,6 +64,7 @@ $(IMAGES_DIR)/%.img:        $(SRC_PATH)/tests/vm/% \
> >               $(PYTHON) $< \
> >               $(if $(V)$(DEBUG), --debug) \
> >               $(if $(GENISOIMAGE),--genisoimage $(GENISOIMAGE)) \
> > +             --build-path $(BUILD_DIR)\
>
> We can do:
>
>   $(if $(QEMU_LOCAL), --build-path $(BUILD_DIR)) \
>
> here and at the other points, then....
>
> > +             --build-path $(BUILD_DIR)\
> >               --image "$<" \
> >               $(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
> >               --snapshot \
> > @@ -98,6 +101,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
> >               $(PYTHON) $(SRC_PATH)/tests/vm/$* \
> >               $(if $(J),--jobs $(J)) \
> >               $(if $(V)$(DEBUG), --debug) \
> > +             --build-path $(BUILD_DIR)\
> >               --image "$<" \
> >               --interactive \
> >               false, \
> > diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> > index 0bc1bad839..d717b967ca 100644
> > --- a/tests/vm/basevm.py
> > +++ b/tests/vm/basevm.py
> > @@ -89,6 +89,7 @@ class BaseVM(object):
> >      def __init__(self, args, config=3DNone):
> >          self._guest =3D None
> >          self._genisoimage =3D args.genisoimage
> > +        self._build_path =3D args.build_path
> >          # Allow input config to override defaults.
> >          self._config =3D DEFAULT_CONFIG.copy()
> >          if config !=3D None:
> > @@ -273,15 +274,15 @@ class BaseVM(object):
> >          args =3D self._args + boot_params.split(' ')
> >          args +=3D self._data_args + extra_args + self._config['extra_a=
rgs']
> >          logging.debug("QEMU args: %s", " ".join(args))
> > -        qemu_bin =3D os.environ.get("QEMU", "qemu-system-" + self.arch=
)
> > -        guest =3D QEMUMachine(binary=3Dqemu_bin, args=3Dargs)
> > +        qemu_path =3D get_qemu_path(self.arch, self._build_path)
> > +        guest =3D QEMUMachine(binary=3Dqemu_path, args=3Dargs)
> >          guest.set_machine(self._config['machine'])
> >          guest.set_console()
> >          try:
> >              guest.launch()
> >          except:
> >              logging.error("Failed to launch QEMU, command line:")
> > -            logging.error(" ".join([qemu_bin] + args))
> > +            logging.error(" ".join([qemu_path] + args))
> >              logging.error("Log:")
> >              logging.error(guest.get_log())
> >              logging.error("QEMU version >=3D 2.10 is required")
> > @@ -480,6 +481,22 @@ class BaseVM(object):
> >                                stderr=3Dself._stdout)
> >          return os.path.join(cidir, "cloud-init.iso")
> >
> > +def get_qemu_path(arch, build_path=3DNone):
> > +    """Fetch the path to the qemu binary."""
> > +    qemu_local =3D os.environ.get("QEMU_LOCAL", 0)
>
> drop the enviroment test here because...
>
> > +    # If QEMU environment variable set, it takes precedence
> > +    if "QEMU" in os.environ:
> > +        qemu_path =3D os.environ["QEMU"]
> > +    elif qemu_local:
> > +        if not build_path:
> > +            raise Exception("--build-path option required with
> > QEMU_LOCAL")
>
> If we can't do it without build_path anyway we may as well make it a
> single option.
>
> > +        qemu_path =3D os.path.join(build_path, arch + "-softmmu")
> > +        qemu_path =3D os.path.join(qemu_path, "qemu-system-" + arch)
> > +    else:
> > +        # Default is to use system path for qemu.
> > +        qemu_path =3D "qemu-system-" + arch
> > +    return qemu_path
> > +
> >  def parse_config(config, args):
> >      """ Parse yaml config and populate our config structure.
> >          The yaml config allows the user to override the
> > @@ -554,6 +571,8 @@ def parse_args(vmcls):
> >      parser.add_option("--config", "-c", default=3DNone,
> >                        help=3D"Provide config yaml for configuration. "=
\
> >                             "See config_example.yaml for example.")
> > +    parser.add_option("--build-path", default=3DNone,
> > +                      help=3D"Path of build directory. ")
>
> .."for using build tree QEMU binary"
>
>
> Otherwise:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> --
> Alex Benn=C3=A9e


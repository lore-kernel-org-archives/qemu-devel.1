Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F279C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:48:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE47206A2
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rk+n3BrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE47206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw7Yz-0001U3-Qc
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 11:48:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iw7YH-00012N-A0
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:47:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iw7YF-0004kB-Mn
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:47:53 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:45759)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iw7YC-0004cK-IP
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:47:49 -0500
Received: by mail-lj1-x243.google.com with SMTP id j26so11410755ljc.12
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 08:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wKMtRaqBEdbpKQkt1ssBU/j/+xLRopKcVXqpmg62N0I=;
 b=rk+n3BrJUzjTZvQGwdxDkB1pmP/zvgGNvh7elP98QPSaLqkq7XLtYc74/RZYF9UW/I
 6By5hFZdvBr5IPCz0oXClJgHyky8fkI3d3T9gxg9Jvxb+r9SR+DGmoomXze35RN0C2+x
 1PSCY93zSYgefeM5DhnqIQ7Ib+UJqwUMfSMPQDvZ8c9XY3qULTQG1+hHtzT7bzcbJqkw
 bPG/vy100heEByOkO00HLG2pIlfEhrAoVB9WyxmrcNxP68UUBlOxFiQpbarX1oSkyZIv
 LgdmPeYVFGz/uxWqo4VrsxwwWYuFPHO465US6B3D690b0TxrcO65xtmR0HscFIfm//+X
 DC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wKMtRaqBEdbpKQkt1ssBU/j/+xLRopKcVXqpmg62N0I=;
 b=qvsinjfEfhWyEasgmMlakIiJeuMQxhzXZV5Oa960bi3cbbHC57/M4d6ZaHfWm+7Qzm
 k3A/PadFExX9hGwVvPX8MQrvE3ujEsMvyyzk/CXESDMu5kaGFuK6TjcvBIeL9y6bV/sY
 D8XdDcCR537nn3YvWEQQfmnwj2BpKgWnSPqkScRXX1t1PzAPWvcrhm5zHlKDz98cMGRv
 f4VOBUpdJ/SVPncBIc+p7jTZspmSvKp0dbROVvdzxBNpyjxJBJHNhlyJIsAocF+t8O9z
 O7fjsY7mP0RsoZwdRJbHVzJzsnM3Qbwn2kdeVDi56Zqk5YVpMNa+dh3FxJP8xwBW+9Au
 o1kw==
X-Gm-Message-State: APjAAAXXCp1NtGP2J1iVC13MZJvSv+fClkD9QQkB7e+wN6kCV9EMrhe0
 ahR72auo+BrauNQBYUYxVc35lBOklScXFPNMjscikg==
X-Google-Smtp-Source: APXvYqx822DohOozS4+sapQbFqeG3fO5oL4zF98mlRB/itZ/RA1BV9icV8LeNAnwuvP53VkJ+LjqUjh2TRwcJBtTX2E=
X-Received: by 2002:a2e:924d:: with SMTP id v13mr11051420ljg.267.1580143666861; 
 Mon, 27 Jan 2020 08:47:46 -0800 (PST)
MIME-Version: 1.0
References: <20200124165335.422-1-robert.foley@linaro.org>
 <20200124165335.422-8-robert.foley@linaro.org>
 <87imkxeyew.fsf@linaro.org>
In-Reply-To: <87imkxeyew.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 27 Jan 2020 11:47:35 -0500
Message-ID: <CAEyhzFtRV_4oss4gxYJi5ojGrXvNZExXfM+Ae-idLqidtcPpcQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] tests/vm: Added a new script for ubuntu.aarch64.
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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

On Mon, 27 Jan 2020 at 10:01, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> >  vm-boot-ssh-%: $(IMAGES_DIR)/%.img
> >       $(call quiet-command, \
> > -             $(SRC_PATH)/tests/vm/$* \
> > +             $(PYTHON) $(SRC_PATH)/tests/vm/$* \
>
> This seems like it should be in a different patch.

Good point, will move it to a different patch.

> > +
> > +DEFAULT_CONFIG =3D {
> > +    'cpu'          : "max",
> > +    'machine'      : "virt,gic-version=3Dmax",
>
> According to virt.c:
>
>   Valid values are 2, 3 and host
>
> but max should work on TCG. However we need a more recent QEMU than my
> system one for it to work. Otherwise you see:
>
>   DEBUG:qemu.machine:Error launching VM

Good point.  We were trying to avoid having different values for KVM
vs TCG, which we
could do with the latest QEMU.
We will update this to make sure this works with older versions of QEMU as =
well.

On my system I have qemu 2.11.1 installed by default.
It seems that we will need the following defaults based on our environment.

For KVM we end up with the below args since max cpu and max
gic-version is not available.
kvm:  -cpu host -machine virt,gic-version=3Dhost

For TCG max cpu is also not available: qemu-system-aarch64: unable to
find CPU model 'max',
so we pick cortex-a57.
TCG: -cpu cortex-a57 -machine virt,gic-version=3D3

I suppose we could check the version of QEMU and use the above
defaults only for earlier versions of QEMU.
This is something we will probably move to aarch64vm.py since it is common.

> > +class UbuntuAarch64VM(basevm.BaseVM):
> > +    name =3D "ubuntu.aarch64"
> > +    arch =3D "aarch64"
> > +    image_name =3D "ubuntu-18.04-server-cloudimg-arm64.img"
> > +    image_link =3D "https://cloud-images.ubuntu.com/releases/18.04/rel=
ease/" + image_name
> > +    login_prompt =3D "ubuntu-guest login:"
> > +    BUILD_SCRIPT =3D """
> > +        set -e;
> > +        cd $(mktemp -d);
> > +        sudo chmod a+r /dev/vdb;
> > +        tar --checkpoint=3D.10 -xf /dev/vdb;
> > +        ./configure {configure_opts};
> > +        make --output-sync {target} -j{jobs} {verbose};
> > +    """
> > +    def _gen_cloud_init_iso(self):
__snip__
> > +
> > +        return os.path.join(cidir, "cloud-init.iso")
>
> It seems this function is proliferating. It certainly seems common
> enough to be basevm functionality.

Makes sense.  Will look at making this common to basevm.

>
> > +
> > +    def boot(self, img, extra_args=3DNone):
> > +        aarch64vm.create_flash_images()
> > +        default_args =3D aarch64vm.get_pflash_args()
> > +        if extra_args:
> > +            extra_args.extend(default_args)
> > +        else:
> > +            extra_args =3D default_args
> > +        # We always add these performance tweaks
> > +        # because without them, we boot so slowly that we
> > +        # can time out finding the boot efi device.
> > +        if os.geteuid() !=3D 0:
> > +            extra_args.extend(["-accel", "tcg,thread=3Dmulti"])
>
> Hmmm thread=3Dmulti should already be enabled by default where it is safe
> to do so. Also what has it to do with euid?

OK.  Will look into removing this.
We were trying to check for KVM, to only add this under KVM.
I see now, we need to use kvm_available() instead of euid.

Thanks & Regards,
-Rob


>
> > +        if '-smp' not in extra_args and \
> > +           '-smp' not in self._config['extra_args'] and \
> > +           '-smp' not in self._args:
> > +            # Only add if not already there to give caller option to c=
hange it.
> > +            extra_args.extend(["-smp", "8"])
> > +
> > +        # We have overridden boot() since aarch64 has additional param=
eters.
> > +        # Call down to the base class method.
> > +        super(UbuntuAarch64VM, self).boot(img, extra_args=3Dextra_args=
)
> > +
> > +    def build_image(self, img):
> > +        os_img =3D self._download_with_cache(self.image_link)
> > +        img_tmp =3D img + ".tmp"
> > +        subprocess.check_call(["cp", "-f", os_img, img_tmp])
> > +        subprocess.check_call(["qemu-img", "resize", img_tmp, "+50G"])
> > +        ci_img =3D self._gen_cloud_init_iso()
> > +
> > +        self.boot(img_tmp, extra_args =3D ["-cdrom", ci_img])
> > +        self.wait_ssh(wait_root=3DTrue)
> > +        # Fix for slow ssh login.
> > +        self.ssh_root("chmod -x /etc/update-motd.d/*")
> > +        self.ssh_root("touch /etc/cloud/cloud-init.disabled")
> > +        # Disable auto upgrades.
> > +        # We want to keep the VM system state stable.
> > +        self.ssh_root('sed -ie \'s/"1"/"0"/g\' /etc/apt/apt.conf.d/20a=
uto-upgrades')
> > +
> > +        # If the user chooses *not* to do the second phase,
> > +        # then we will jump right to the graceful shutdown
> > +        if self._config['install_cmds'] !=3D "":
> > +            # Don't check the status in case the guest hang up too qui=
ckly
> > +            self.ssh_root("sync && reboot")
> > +
> > +            self.wait_ssh(wait_root=3DTrue)
> > +            # The previous update sometimes doesn't survive a reboot, =
so do it again
> > +            self.ssh_root("sed -ie s/^#\ deb-src/deb-src/g /etc/apt/so=
urces.list")
> > +
> > +            # Issue the install commands.
> > +            # This can be overriden by the user in the config .yml.
> > +            install_cmds =3D self._config['install_cmds'].split(',')
> > +            for cmd in install_cmds:
> > +                self.ssh_root(cmd)
> > +        self.graceful_shutdown()
> > +        self.wait()
> > +        os.rename(img_tmp, img)
> > +        return 0
> > +
> > +if __name__ =3D=3D "__main__":
> > +    sys.exit(basevm.main(UbuntuAarch64VM, DEFAULT_CONFIG))
>
>
> --
> Alex Benn=C3=A9e


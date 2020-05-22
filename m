Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4927BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 19:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBE84206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 19:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZKRn1Mxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE84206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcDI4-00059I-25
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 15:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcDHP-0004ge-Dl
 for qemu-devel@nongnu.org; Fri, 22 May 2020 15:24:27 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:38268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jcDHN-00081V-Gs
 for qemu-devel@nongnu.org; Fri, 22 May 2020 15:24:26 -0400
Received: by mail-lj1-x244.google.com with SMTP id m18so14000498ljo.5
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 12:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pB7G33MbbmjRXoKyui0VUUplhFhfexsVSp3+F8nH4ns=;
 b=ZKRn1MxdfOH5cshI+tpU813Gpk7K7GNXD0MtEMBMnZpQShlCigbU3Ihftl6VskgMl5
 Yrya+YGH1gG+F/Fx9ugnSslGLLIrhdaw1FTNnkVkoGHZBcamw679EonLowxfZeTqAbm0
 nigLshzUPavWVqPzuzoqmYnCWhCqAYDAVFIIz0OLj8KOfxMopcV0G5QYy55ybbbp60Gv
 6OhStjyYn6331PpSs1ZkPQI3VSW3m3EDKdkHN+DHFMEK5J0pTI8eXX/BNJGq4m/ediyU
 dS1Tq+0051SEEegLpTFzOoESxmrZj+wgKg+JhkZqmCYO4tf0rBICWlfFYWHrao4nyqzR
 BNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pB7G33MbbmjRXoKyui0VUUplhFhfexsVSp3+F8nH4ns=;
 b=JfMrBTCpUGyaoHfgaKQ2inCmZd4P4az9qc+cQ+4Ic9LvcEmyZ34/vAn20cg40HvVB7
 n7hP5VYeAhvZI+gvOWmxmK5teXazU6XGkmQkHt5WjGfooy4N8J7P9FzOGjFwxg/Q4hIM
 elgzDqwCpfgkIcf7FXpHwioqMmoWN3LpZ4iT7q2Mp/+YxJyIyFz+yruOaXT7xtdGdMK4
 FjdlJyJ16DqlN2gYtyH4whFUhYBtskb/FuxqrR8LD9shz7+Dtj/9nwiaC+4g5n8JaoGy
 ssy3+WI0IXRGb9vN8cAwutn/Lsa1mIutDBIVt+562QjHbRRIck/fa5JvMXelYo2tk+or
 0mIQ==
X-Gm-Message-State: AOAM531L4/krwSWkZrIysBNCCPM8zagtScDX2VxCUE7lRZG6ndWYAJC4
 zvScV+pBfTejaBqh+tI4f7x1BVUAz3YIFzxgEYVQQg==
X-Google-Smtp-Source: ABdhPJwb+gxiMWZy+Y8gcp7ornMiXhtJ++CDLJdeJkBplJud3i/YVrSc9uitvFqKPxsjyz33LQICd2YDSQtJMMAGJn0=
X-Received: by 2002:a2e:b551:: with SMTP id a17mr5530534ljn.380.1590175463644; 
 Fri, 22 May 2020 12:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200519132259.405-1-robert.foley@linaro.org>
 <20200519132259.405-10-robert.foley@linaro.org>
 <878shkdlvg.fsf@linaro.org>
In-Reply-To: <878shkdlvg.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Fri, 22 May 2020 15:24:16 -0400
Message-ID: <CAEyhzFtJC8zGm9fESE4k5Yvojk5Yvw8ey5ECz2c9S69s16j=UA@mail.gmail.com>
Subject: Re: [PATCH v7 09/12] tests/vm: Added a new script for ubuntu.aarch64.
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

On Fri, 22 May 2020 at 11:34, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Robert Foley <robert.foley@linaro.org> writes:
<snip>
> >
> > +############################################
> > +# efi-aarch64 probe
> > +# Check for efi files needed by aarch64 VMs.
> > +# By default we will use the efi included with QEMU.
> > +# Allow user to override the path for efi also.
> > +qemu_efi_aarch64=3D$PWD/pc-bios/edk2-aarch64-code.fd
>
> as you only define this once there is no harm in just having a long line
> bellow rather than running the potential confusion when looking at the
> variables.

OK, makes sense, will change to just go for the longer line.

> > +for fd in $efi_aarch64_arg $qemu_efi_aarch64
> > +do
> > +    if test -f $fd; then
> > +        efi_aarch64=3D$fd
> > +        break
> > +    fi
> > +done
>
> This only detects the pc-bios bundled version of edk on a directory
> which has already been built. Maybe we need to do a straight forward:
>
>   if not test -f $efi_aarch64; then
>       if test -f $SRC/pc-bios/edk2-aarch64-code.fd.bz2; then
>           # valid after build
>           efi_aarch64=3D$PWD/pc-bios/edk2-aarch64-code.fd
>       else
>           efi_aarch64=3D""
>       fi
>   fi
>
> what do you think?

I agree.  The straight up if check is easier to read.  Will change to this.

> <snip>
> > +
> > +    def build_image(self, img):
> > +        os_img =3D self._download_with_cache(self.image_link)
> > +        img_tmp =3D img + ".tmp"
> > +        subprocess.check_call(["cp", "-f", os_img, img_tmp])
> > +        subprocess.check_call(["qemu-img", "resize", img_tmp, "+50G"])
> > +        ci_img =3D self.gen_cloud_init_iso()
> > +
> > +        self.boot(img_tmp, extra_args =3D ["-cdrom", ci_img])
> > +        if self.debug:
> > +            self.wait_boot()
> > +        # First command we issue is fix for slow ssh login.
> > +        self.wait_ssh(wait_root=3DTrue,
> > +                      cmd=3D"chmod -x /etc/update-motd.d/*")
> > +        # Wait for cloud init to finish
> > +        self.wait_ssh(wait_root=3DTrue,
> > +                      cmd=3D"ls /var/lib/cloud/instance/boot-finished"=
)
> > +        self.ssh_root("touch /etc/cloud/cloud-init.disabled")
> > +        # Disable auto upgrades.
> > +        # We want to keep the VM system state stable.
> > +        self.ssh_root('sed -ie \'s/"1"/"0"/g\' /etc/apt/apt.conf.d/20a=
uto-upgrades')
> > +        # If the user chooses *not* to do the second phase,
> > +        # then we will jump right to the graceful shutdown
> > +        if self._config['install_cmds'] !=3D "":
> > +            self.ssh_root("sync")
> > +            # Shutdown and then boot it again.
> > +            # Allows us to know for sure it is booting (not shutting d=
own)
> > +            # before we call wait_ssh().
> > +            self.graceful_shutdown()
> > +            self.boot(img_tmp)
> > +            if self.debug:
> > +                self.wait_boot()
> > +            self.wait_ssh(wait_root=3DTrue)
> > +            self.wait_ssh(wait_root=3DTrue, cmd=3D"locale")
>
> Why do we need to shutdown before proceeding with the install commands?
> I see ubuntu.i386 does it as well although with a slightly hackier
> approach.

The reboot was carried over from the way i386 did things.
I have a guess as to why the reboot is there, it is just after the
install of cloud-initramfs-growroot, which does require a reboot.
So I assume that we wanted to grow the root, reboot, and then
begin installation of all the new packages.

However, at this point, it looks like even without installing that package,
(with i386 or aarch64) the root is growing to fill the new size of the imag=
e,
so it seems that package and the reboot is no longer needed.
Will plan to remove these as part of making build_image common
(discussed below).

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
>
> How come we are diverging from the ubuntu.i386 install here? You've
> moved all the complications for aarch64 into a it's own handling so
> these steps are almost but not quite the same. Couldn't the ubuntu
> build_img code be common and then just have a slightly different set of
> install commands?

I'm glad you brought this up.  I was noticing the commonality here especial=
ly if
we wanted to add another architecture of Ubuntu VM.
For example, we brought up a ppc64 Ubuntu VM script the other day and it re=
ally
cried out for creating a common Ubuntu module here since most of the
code is the same.

As suggested, I will plan to create a common Ubuntu module here and share
the build_img code, but have a different set of install commands.

Thanks & Regards,
-Rob

>
> > +
> > +if __name__ =3D=3D "__main__":
> > +    defaults =3D aarch64vm.get_config_defaults(UbuntuAarch64VM, DEFAUL=
T_CONFIG)
> > +    sys.exit(basevm.main(UbuntuAarch64VM, defaults))
>
>
> --
> Alex Benn=C3=A9e


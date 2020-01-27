Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE428C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78DF22087F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NGFnZnLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DF22087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw6zA-0007SB-NT
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 11:11:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iw6yH-0006cV-9p
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:10:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iw6yF-0006og-Vf
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:10:41 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232]:44639)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iw6yF-0006mi-Mv
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:10:39 -0500
Received: by mail-lj1-x232.google.com with SMTP id q8so11274772ljj.11
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 08:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KmHvGloxj6scvbdA/M7Ea4iCSKg5n66TIQBrTFBoGFY=;
 b=NGFnZnLO/0i4Npw0/p1/4DyzzRMwa1Cb1PS611Pp4rAYaoB7KXPar7yUuwCekncfBX
 t1DMeLDa+MgMR2TpNG66Vzsk4RmJuOv/L28l7bPrEC5VhsKR0dLcyqj5R64aawFTk+TO
 faLpVwaM9wKzpMStrz+S2e8KuXwMf2mAxZguU4FW33VxzpnjXlPCEOWv1OtNaAWL3W9B
 MY9HxcNlBjQH2OY3eypnKocHvbBLuhE+17BW+Ykw3sot/LrMsQd1+9weu0LYtMNnlsdV
 Dq1g5rQV9fxqAGISuOQ+zU9Chwse6A9/KE5WIwmu2aVCHtFaFUVulmdIy8HnGfaTcXJJ
 8cOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KmHvGloxj6scvbdA/M7Ea4iCSKg5n66TIQBrTFBoGFY=;
 b=aJVj0yrB/YIysmQGCamLrCbz115F3FOd7YgbqMnY1LnryoHW0BPGUSb5JuXkSG+rsg
 3MPfTG6uO0P26BT8SDFMzJEUO/BZjfFZVTGDejlozauJocn8Q6hkjpFwfhtHIoMAsFIR
 B/xfecz82Hrmtu2mmY6EWsfUMh8Jg1h/iDHBI9vPKShwncboOylbp7JuRGa9qktU411o
 /Ojz8ZjFx4P2BladdtG711hgr3MLIJ7B6XSF3YNd/cAs0w+FS2ebybxxI0jvpqJW0DdO
 YJKfk80ljwnfP/mhP1jRyKCuPgDrrRd2MuDhAKJZBuJlRzopgNeZyVme9VeZYjcCMmzO
 H+0g==
X-Gm-Message-State: APjAAAW1oOrYQrLB5VJsk/0/43MzLw017IYfRuK3xvZi2gRohgDQEf4S
 QaeO6+seOgYle0n+xijQvMI0AvpespaeAXG5jo3N/w==
X-Google-Smtp-Source: APXvYqz//xkwDsSOj0h+ggvFpMdHAXFXLwXWYSjB7Tz3sj/udJFvQnzGyYOaFy3TuUR52HnWEFryqx3qiqgG6XEj1Nc=
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr10797312ljg.166.1580141437649; 
 Mon, 27 Jan 2020 08:10:37 -0800 (PST)
MIME-Version: 1.0
References: <20200124165335.422-1-robert.foley@linaro.org>
 <20200124165335.422-6-robert.foley@linaro.org>
 <87pnf5f50x.fsf@linaro.org>
In-Reply-To: <87pnf5f50x.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 27 Jan 2020 11:10:26 -0500
Message-ID: <CAEyhzFtEv8ewo82efBE8BMVwxLiNCwz8_9NWmNGx3zqszCGBhQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] tests/vm: Added configuration file support
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

On Mon, 27 Jan 2020 at 07:38, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> > +        if 'password' in target_dict:
> > +            config['root_pass'] =3D target_dict['password']
> > +            config['guest_pass'] =3D target_dict['password']
>
> This seems like impedance matching between two dictionaries. Surely it
> would be nicer for the config to be read in fully formed and referable by
> the rest of the code. We can also change the internal references.

Good point.  Will rework it to avoid this matching.  Basically we can
put the values we
read directly into the config dictionary in one step.
>
> > +        if any (k in target_dict for k in ("ssh_key","ssh_pub_key")) a=
nd \
> > +           not all (k in target_dict for k in ("ssh_key","ssh_pub_key"=
)):
> > +            missing_key =3D "ssh_pub_key" \
> > +              if 'ssh_key' in target_dict else "ssh_key"
> > +            raise Exception("both ssh_key and ssh_pub_key required. "
> > +                            "{} key is missing.".format(missing_key))
>
> I guess validation has to be done at some time.. but
>
> > +        if 'ssh_key' in target_dict:
> > +            config['ssh_key_file'] =3D target_dict['ssh_key']
> > +            if not os.path.exists(config['ssh_key_file']):
> > +                raise Exception("ssh key file not found.")
> > +        if 'ssh_pub_key' in target_dict:
> > +            config['ssh_pub_key_file'] =3D target_dict['ssh_pub_key']
> > +            if not os.path.exists(config['ssh_pub_key_file']):
> > +                raise Exception("ssh pub key file not found.")
>
> here we are both munging dictionaries again before checking the data.
> Given we bail with an exception I'm now rethinking if it makes sense to
> validate up here. It depends on how many places in the code expect to
> use this data.

Makes sense.  We will change it to validate in one place just before
we expect to use this data.

> > +    # By default we do not set the DNS.
> > +    # You override the defaults by setting the below.
> > +    #dns: 1.234.567.89
> > +
> > +    # By default we will use a "block" device, but
> > +    # you can also boot from a "scsi" device.
> > +    # Just keep in mind your scripts might need to change
> > +    # As you will have /dev/sda instead of /dev/vda (for block device)
> > +    #boot_dev_type: "scsi"
> > +
> > +    # By default the ssh port is not fixed.
> > +    # A fixed ssh port makes it easier for automated tests.
> > +    #ssh_port: 5555
> > +
> > +    # To install a different set of packages, provide a command to iss=
ue
> > +    #install_cmds: "apt-get update ; apt-get build-dep -y qemu"
> > +

>
> Having the example is great. It would be nice to see at least one of the
> others converted to a config driven approach as well

The example we provided was primarily for aarch64, we will add one or
more examples here for the other VMs to
help provide a ready to use template for providing a config file.

> - is the config driven approach going to reduce duplication across the va=
rious bits of
> VM configuring python? Should everything be config driven? Are we in
> danger of re-inventing an exiting tooling?

All interesting questions to explore.  Here is my take on this.

One goal we had in mind is to not require a config file for any given
VM.  So in this sense we are
not going in the direction of a config driven approach.
Even the VMs that we added for aarch64 do not require a config file.
The VM scripts will work as is without a config file since the script
itself provides all required defaults.
Our intention was for the config approach to be used to allow
overriding the defaults for any
given VM, to give the flexibility of overriding the parameters.
But on the other hand by not requiring a config file, we make is
simpler and easier to
only override the parameters that the user is interested in.  And also
to limit the cases where
we could generate a non-working VM if the user forgot to provide
certain defaults.

Thanks & Regards,
-Rob


Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A832C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ADC420855
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CB+EHJCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADC420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3yfv-0001xx-IC
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k3yf7-0001BD-0Z
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:27:41 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:38500)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k3yf5-0002WM-9r
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:27:40 -0400
Received: by mail-pl1-x62d.google.com with SMTP id t11so789702plr.5
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 02:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Z0unf06zzTFwoLNxlXEbQnixk00aaxjxl7uhwFcvxjY=;
 b=CB+EHJCcTQPxfvIY2tBYhCpIYzBg9Rn+UncaiNYz7+edkdInmTxGO0p+smecmmPd6K
 WghtwR75WlmNWYlPexWt/eaGnIsnAi9epamp2dWUBSmAQqoO0VAu6x7CQuCQJFNgHNHs
 CfSBDB67jmsBDEaT2gVO6SQo1p+hKyYeHEGQo/HD84LMCW3rRUB9bzbZ4eY9uVMI1rQ2
 FcZ2I6eg/Mxiio3tbc+bM9Ul4kbUi1wJuldM6QmUf/r7y5pAr0zmMrQpv4bXZRO7rMgx
 P/mn1zs8mxTxgwyml0GzHdFASztdRKV1b0SgeI9YAFqI9qptrWyjWgv7e8RMwvvVHyTg
 mXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Z0unf06zzTFwoLNxlXEbQnixk00aaxjxl7uhwFcvxjY=;
 b=t9GacEbqNqnOUzXwqgEVWu3+n33+pWE7hFx5exWvNGsIrHO+HCKlVulMhoN/WPxn8U
 sGpkBBPJtA7Kb1iXF95oIGjj57P8g5h+p05zaoLg5rqcaPeV1x9l1K26vXePL0dM3aRc
 KfJYD6WhaCMFCbLnK3Ltkh37N2ZJQhRiNOxlQ4ILR/eHZJcsatwuIZlsv/iZWg5D179R
 e0MAvsAeBfwHxgphT8UtBKeRnXg7+hssKWcQKaLt8QsKb7W610uePYEQAXPagUtkZZJN
 4+TqQLFZzxBgNzAQu4gsEZVnkZDoW0sAt3WjbBeZ1LYqnFTu+gMwtFNgWQ7HPoPB44PL
 ljyQ==
X-Gm-Message-State: AOAM5327R459ZFim0OoPl3Nzcpnm7n9A9LKaY56XIAFklvF40cOe6XoL
 h5ZNrEtLxiDQl4JxA3AWwq6DZw6GFEzxBT4WZxM=
X-Google-Smtp-Source: ABdhPJxt6LLfcRIfyyBpZaWwGjUL0zagkoEt397YNglKgZ9tMpi9jNf/5X1+bPJM4aTwrggJ+aljaiybqSn/JR8VYl0=
X-Received: by 2002:a17:902:6bca:: with SMTP id
 m10mr11675541plt.210.1596792457629; 
 Fri, 07 Aug 2020 02:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QWF8g7r5VqU_PRbskWZU3ahCq+eobR8GexUcPrAiYoCPQ@mail.gmail.com>
 <20200806115148.7lz32dro645a3wv6@mhamilton>
 <20200806120130.GK4159383@redhat.com>
 <20200806133845.maouiwnazkjtpklr@mhamilton>
In-Reply-To: <20200806133845.maouiwnazkjtpklr@mhamilton>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 7 Aug 2020 10:27:26 +0100
Message-ID: <CAJSP0QWJV=DrsAmVR7Mm9Gb_YtMiwE0geGTvq_R2tgQ=BCxKUg@mail.gmail.com>
Subject: Re: Why QEMU should move from C to Rust (clickbait alert ;))
To: Sergio Lopez <slp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=stefanha@gmail.com; helo=mail-pl1-x62d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Dave Gilbert <dgilbert@redhat.com>, "Oleinik, Alexander" <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 6, 2020 at 2:38 PM Sergio Lopez <slp@redhat.com> wrote:
> On Thu, Aug 06, 2020 at 01:01:30PM +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, Aug 06, 2020 at 01:51:48PM +0200, Sergio Lopez wrote:
> > > On Thu, Aug 06, 2020 at 11:24:13AM +0100, Stefan Hajnoczi wrote:
> > > <snip>
> > > > Conclusion
> > > > ---------------
> > > > Most security bugs in QEMU today are C programming bugs. Switching =
to
> > > > a safer programming language will significantly reduce security bug=
s
> > > > in QEMU. Rust is now mature and proven enough to use as the languag=
e
> > > > for device emulation code. Thanks to vhost-user and vfio-user using
> > > > Rust for device emulation does not require a big conversion of QEMU
> > > > code, it can simply be done in a separate program. This way attack
> > > > surfaces can be written in Rust to make them less susceptible to
> > > > security bugs going forward.
> > > >
> > >
> > > Having worked on Rust implementations for vhost-user-fs and
> > > vhost-user-blk, I'm 100% sold on this idea.
> > >
> > > That said, there are a couple things that I think may help getting
> > > more people into implementing vhost-user devices in Rust.
> > >
> > >  1. Having a reference implementation for a simple device somewhere
> > >  close or inside the QEMU source tree. I'd say vhost-user-blk is a
> > >  clear candidate, given that a naive implementation for raw files
> > >  without any I/O optimization is quite easy to read and understand.
> > >
> > >  2. Integrating the ability to start-up vhost-user daemons from QEMU,
> > >  in an easy and portable way. I know we can always rely on daemons
> > >  like libvirt to do this for us, but I think it'd be nicer to be able
> > >  to define a vhost-user device from the command line and have QEMU
> > >  execute it with the proper parameters (BTW, Cloud-Hypervisor already
> > >  does that). This would probably require some kind of configuration
> > >  file, to be able to define which binary provides each vhost-user
> > >  device personality, but could also be a way for "sanctioning"
> > >  daemons (through the configuration defaults), and to have them adher=
e
> > >  to a standardized command line format.
> >
> > This second point is such a good idea that we already have defined
> > how todo this in QEMU - see the docs/interop/vhost-user.json file.
> > This specifies metadata files that should be installed into a
> > defined location such that QEMU/libvirt/other mgmt app can locate
> > vhost-user impls for each type of device, and priortize between
> > different impls.
>
> Nice, but AFAIK QEMU still lacks the ability to process those files
> and run the vhost-user device providers by itself. Or perhaps I just
> can't find it (?).

How about a Python script? It can list available vhost-user programs
and their options:

  $ qemu-vhost-launcher list
  vhost-user-gpu Paravirtualized GPU with OpenGL support
  ...vhost-user-gpu --help output...
  vhost-user-blk Block device
  ...vhost-user-blk --help output...

You can write a configuration file:

  $ cat vhost-devices.conf # or yaml/toml/json?
  [blk1]
  backend=3Dvhost-user-blk
  blk-file=3D/path/to/image.img

  [iso]
  backend=3Dvhost-user-blk
  blk-file=3D/path/to/installer.iso
  read-only=3Dtrue

And launch QEMU like this:

  $ qemu-vhost-launcher run -c vhost-devices.conf -- -M accel=3Dkvm -m
1G -cpu host

The 'run' command builds QEMU command-line options for the devices
described in the configuration file. It launches the vhost-user device
backends and then QEMU. The QEMU vhost-user command-line options
(-chardev, -device) are appended to the command-line options.

Stefan


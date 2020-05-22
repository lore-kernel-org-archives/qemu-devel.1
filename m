Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB5AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 12:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D38206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 12:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U5clz4FV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D38206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc7HI-0002Wf-IY
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 08:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jc7GP-0001bj-JF
 for qemu-devel@nongnu.org; Fri, 22 May 2020 08:59:01 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:39813)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jc7GO-000123-Cv
 for qemu-devel@nongnu.org; Fri, 22 May 2020 08:59:01 -0400
Received: by mail-lj1-x243.google.com with SMTP id m12so10111592ljc.6
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 05:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QVF0ymDGvg4uigRnZT0ilTiBmUmjP6X2HYaoK2JpkWs=;
 b=U5clz4FVOag2tCf8d7dVzTM7BOP3LxRreOR3w2b6MsLAraZNXZh8yeONx8wi2Oscqe
 245TR4y0/RAsXAHelkX52bjPaltpk79Y29SwKiBanjNjxjc6UBahar5S05ldWbXvrdmu
 i30+sY+NUF0nkqJPHgLqEbhmdrUqv/lEBh942VkEW4N4015aaSGOyvPIThQol340/ce3
 zJ4dyKiUG3Vo6ziYMRgn3+GR01JPs1e5Oa094ZpNBvRMsrglfTf7/6GC9gfD1hdegT6M
 YfWg1ZYNkGf5SvnjEYNaFYUbtUNDPIeV8eq1dezTB7CRLQRv8DRa5m3fCnM8gzN7ESG7
 xIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QVF0ymDGvg4uigRnZT0ilTiBmUmjP6X2HYaoK2JpkWs=;
 b=ehEx5++tKGZXNgVq7D9Ky6iZ67Rl3Li6PAhmsXnS617mSaJ/QNBo7BpQYhcSWfd4T6
 wYR2GjW/5Nh4oaCrkPeoruW8tqLeLmggWBdS7U+Vnuyz2DH97zNzd2NrXD6dobOi+HmG
 j1YnV3b9tPLxFQsHPReyt4gJpFSrPlpsRl+QZPQuNEmTxG1tv9nbtALIc3lwg+2WVZFq
 LsDqLbIBqAlQ3SmkKOv7FXgW3aDk2gatOUp/jff/eOv8I81IJgMDeNzmiMDb4K6tEXEm
 xy0oQN+r55uQMvFiEGe0RPYcQzH6YB4Kd/Bg8Wih1QgboWvUsXyRaD6izoXm0D11731v
 Mh0w==
X-Gm-Message-State: AOAM530KlAOIpJE82kZNAAzL7FxBl1dkujUG6TpxurObMyRWGPKLfLE4
 yBFnxng1gdK/HgpL9nYLLA5TxdqpezN3t0jxz5+XIg==
X-Google-Smtp-Source: ABdhPJx+8cmG8mlfKRGdM9CxtoJYzHG1quSUTWlbqZFXdI7JDARdJ7+HqpNOYIq8KEUtlvl9QmyRSjGrqZ4iyB60oC8=
X-Received: by 2002:a2e:150f:: with SMTP id s15mr7269039ljd.102.1590152338485; 
 Fri, 22 May 2020 05:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200519132259.405-1-robert.foley@linaro.org>
 <20200519132259.405-4-robert.foley@linaro.org>
 <87h7waff9p.fsf@linaro.org>
In-Reply-To: <87h7waff9p.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Fri, 22 May 2020 08:58:51 -0400
Message-ID: <CAEyhzFuPgPmPQX5HCaxud5kvF8Soaxv888Ja+zgnWORNA+3+zw@mail.gmail.com>
Subject: Re: [PATCH v7 03/12] tests/vm: pass args through to BaseVM's __init__
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x243.google.com
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

On Wed, 20 May 2020 at 17:49, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Robert Foley <robert.foley@linaro.org> writes:
>
> A brief rationale wouldn't go amiss in the commit message. e.g. "We will
> shortly need to pass more parameters to the class so lets just pass args
> rather than growing the parameter list."

Good point. I will add this to the commit message.

Thanks & Regards,
-Rob

>
> Otherwise:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>
> > Signed-off-by: Robert Foley <robert.foley@linaro.org>
> > ---
> >  tests/vm/basevm.py | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> > index a2d4054d72..fbefda0595 100644
> > --- a/tests/vm/basevm.py
> > +++ b/tests/vm/basevm.py
> > @@ -61,9 +61,9 @@ class BaseVM(object):
> >      # 4 is arbitrary, but greater than 2,
> >      # since we found we need to wait more than twice as long.
> >      tcg_ssh_timeout_multiplier =3D 4
> > -    def __init__(self, debug=3DFalse, vcpus=3DNone, genisoimage=3DNone=
):
> > +    def __init__(self, args):
> >          self._guest =3D None
> > -        self._genisoimage =3D genisoimage
> > +        self._genisoimage =3D args.genisoimage
> >          self._tmpdir =3D os.path.realpath(tempfile.mkdtemp(prefix=3D"v=
m-test-",
> >                                                           suffix=3D".tm=
p",
> >                                                           dir=3D"."))
> > @@ -76,7 +76,7 @@ class BaseVM(object):
> >          self._ssh_pub_key_file =3D os.path.join(self._tmpdir, "id_rsa.=
pub")
> >          open(self._ssh_pub_key_file, "w").write(SSH_PUB_KEY)
> >
> > -        self.debug =3D debug
> > +        self.debug =3D args.debug
> >          self._stderr =3D sys.stderr
> >          self._devnull =3D open(os.devnull, "w")
> >          if self.debug:
> > @@ -90,8 +90,8 @@ class BaseVM(object):
> >                         (",ipv6=3Dno" if not self.ipv6 else ""),
> >              "-device", "virtio-net-pci,netdev=3Dvnet",
> >              "-vnc", "127.0.0.1:0,to=3D20"]
> > -        if vcpus and vcpus > 1:
> > -            self._args +=3D ["-smp", "%d" % vcpus]
> > +        if args.jobs and args.jobs > 1:
> > +            self._args +=3D ["-smp", "%d" % args.jobs]
> >          if kvm_available(self.arch):
> >              self._args +=3D ["-enable-kvm"]
> >          else:
> > @@ -438,8 +438,7 @@ def main(vmcls):
> >              return 1
> >          logging.basicConfig(level=3D(logging.DEBUG if args.debug
> >                                     else logging.WARN))
> > -        vm =3D vmcls(debug=3Dargs.debug, vcpus=3Dargs.jobs,
> > -                   genisoimage=3Dargs.genisoimage)
> > +        vm =3D vmcls(args)
> >          if args.build_image:
> >              if os.path.exists(args.image) and not args.force:
> >                  sys.stderr.writelines(["Image file exists: %s\n" % arg=
s.image,
>
>
> --
> Alex Benn=C3=A9e


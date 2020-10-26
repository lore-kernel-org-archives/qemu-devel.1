Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7003AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 06:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9FC22247
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 06:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XsEtdnHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9FC22247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWw7k-00084E-7a
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 02:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1kWw74-0007dn-Cu
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 02:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1kWw70-00047X-Pm
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 02:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603694167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bgL9sQZRfay6L/RP2n3RAzF4RMmXZzmaN4d7+RuD2io=;
 b=XsEtdnHhIYWB+/wzIWRDs6ph5JX8guz9D+rlsgKOM7D6TwqFjzQ2DA0wbediuHtXa9vB3Z
 n/CBtuIyLPGyvufy5qml+aCx/N3fa8hrYTy7OVtj9kxYBJk+C3qAYgeC2e6ZuCCeyGFky7
 vrl+SpqG1SQdvErJJpwxuzVn1tGa0uA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-t2FQPotiP4GUdxFCgHQfTg-1; Mon, 26 Oct 2020 02:36:01 -0400
X-MC-Unique: t2FQPotiP4GUdxFCgHQfTg-1
Received: by mail-pg1-f199.google.com with SMTP id j5so1229816pgt.4
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2020 23:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version;
 bh=bFXzCNJ5u3hW7ju9P0QDAKj01Wht8wM+nf/pvEuvaA4=;
 b=XDCdYmoXVEgYgMU9/r6MTNSuwnrmIip6LN3kQgw+n+1oSYkYea6BSfL7w1FCqIWyNg
 jF8u+Bj55iD4L8nr4tv+9UPIDXIz6s50Sf+slmLDiXGZFce1XTLxjNLM+xRhemLoDUmZ
 3g6KE8xZiqceKyEESJicp9I8Xbc/yJbkLEb413xvnRd5MMU34/V4XfISyHhFkWx/KH/g
 GJ8WTRZGfQvUnPm4Eiafq1SFe8zuk967tFP/Yyxy1vKWdw+EmWNVPcjVHUsSjytSBppK
 cwd6AQxDxMaSwlaUOcyR18rqQjVzDS/u1bbuNmfrcwzN0iZ8//Tu8gKOPCw80tSaTM7m
 WhQA==
X-Gm-Message-State: AOAM530/VZquxVB92C2sMo366XeToCLtCVw3tgZbpBvt+FTnGUePWJ4a
 c4Q2DSSArXgv7IBxQC+hwRaWp9ZcWDa009goigyR7/ZY8rc3Bo/XbPmfclFtxhUDMXuEz1DDTCK
 MMOmgIzYLhbbn/N4=
X-Received: by 2002:aa7:9192:0:b029:15c:ebd2:971c with SMTP id
 x18-20020aa791920000b029015cebd2971cmr9894003pfa.33.1603694160297; 
 Sun, 25 Oct 2020 23:36:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlItANGTexBqkYS91yzKD8Ec75MZoVON9seWniHM94mtuEBCb/kGeX4eJNIoZUVcOGjA3+Zg==
X-Received: by 2002:aa7:9192:0:b029:15c:ebd2:971c with SMTP id
 x18-20020aa791920000b029015cebd2971cmr9893978pfa.33.1603694159908; 
 Sun, 25 Oct 2020 23:35:59 -0700 (PDT)
Received: from yekko.fritz.box ([2001:4479:e200:1100:3c24:4d96:ea81:be55])
 by smtp.gmail.com with ESMTPSA id t10sm11167847pjr.37.2020.10.25.23.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2020 23:35:59 -0700 (PDT)
Date: Mon, 26 Oct 2020 17:35:48 +1100
From: David Gibson <dgibson@redhat.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] pci: Refuse to hotplug PCI Devices when the Guest OS is
 not ready
Message-ID: <20201026173548.113ce1fd@yekko.fritz.box>
In-Reply-To: <CAC_L=vUh8LU5c8c00OhnbEiW7EzZFWKU61vOdub7c11wDMXeRg@mail.gmail.com>
References: <20201022114026.31968-1-marcel.apfelbaum@gmail.com>
 <20201022080354-mutt-send-email-mst@kernel.org>
 <20201022235632.7f69ddc9@yekko.fritz.box>
 <CAC_L=vVi6ngD6j0sZ2uLZ-NHF2WGzKfiOvmsHxOZaBRv6FuBug@mail.gmail.com>
 <20201022100028-mutt-send-email-mst@kernel.org>
 <CAC_L=vWctLK0Yjod_Vz=+xzFKFp4UoUdjSVa4jWeDm+g8en6wQ@mail.gmail.com>
 <20201022102857-mutt-send-email-mst@kernel.org>
 <CAC_L=vX0+H-SfQHneVPd-Mc3wFxHBSbkKHt3SpNOBOY_JsYDUA@mail.gmail.com>
 <20201022110016-mutt-send-email-mst@kernel.org>
 <20201023144901.5bd908a1@yekko.fritz.box>
 <CAC_L=vUh8LU5c8c00OhnbEiW7EzZFWKU61vOdub7c11wDMXeRg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgibson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/CO1kh3IKGZ08rNtjX0YlAeR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgibson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Julia Suvorova <jusual@redhat.com>, qemu devel list <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/CO1kh3IKGZ08rNtjX0YlAeR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Oct 2020 09:47:14 +0300
Marcel Apfelbaum <marcel.apfelbaum@gmail.com> wrote:

> Hi David,
>=20
> On Fri, Oct 23, 2020 at 6:49 AM David Gibson <dgibson@redhat.com> wrote:
>=20
> > On Thu, 22 Oct 2020 11:01:04 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > =20
> > > On Thu, Oct 22, 2020 at 05:50:51PM +0300, Marcel Apfelbaum wrote:
> > >  [...]
> > >
> > > Right. After detecting just failing unconditionally it a bit too
> > > simplistic IMHO. =20
> >
> > There's also another factor here, which I thought I'd mentioned
> > already, but looks like I didn't: I think we're still missing some
> > details in what's going on.
> >
> > The premise for this patch is that plugging while the indicator is in
> > transition state is allowed to fail in any way on the guest side.  I
> > don't think that's a reasonable interpretation, because it's unworkable
> > for physical hotplug.  If the indicator starts blinking while you're in
> > the middle of shoving a card in, you'd be in trouble.
> >
> > So, what I'm assuming here is that while "don't plug while blinking" is
> > the instruction for the operator to obey as best they can, on the guest
> > side the rule has to be "start blinking, wait a while and by the time
> > you leave blinking state again, you can be confident any plugs or
> > unplugs have completed".  Obviously still racy in the strict computer
> > science sense, but about the best you can do with slow humans in the
> > mix.
> >
> > So, qemu should of course endeavour to follow that rule as though it
> > was a human operator on a physical machine and not plug when the
> > indicator is blinking.  *But* the qemu plug will in practice be fast
> > enough that if we're hitting real problems here, it suggests the guest
> > is still doing something wrong.
> > =20
>=20
> I personally think there is a little bit of over-engineering here.
> Let's start with the spec:
>=20
>     Power Indicator Blinking
>     A blinking Power Indicator indicates that the slot is powering up or
> powering down and that
>     insertion or removal of the adapter is not permitted.

Right, but the weird bit here is that IIUC, the kernel during general
probe is switching the indicator from off -> blinking -> off without it
ever going to "on" state.  And it seems to do the power on and presence
check with the indicator still in blinking state.  This is different
from the normal sequence on a hotplug:
=09press button
=09indicator goes to blinking
=09...wait...
=09indicator goes to full on
=09slot powers on
=09presence detect

Or am I missing something?

> What exactly is an interpretation here?
> As you stated, the races are theoretical, the whole point of the indicato=
r
> is to let the operator know he can't plug the device just yet.
>=20
> I understand it would be more user friendly if the QEMU would wait
> internally for the
> blinking to end, but the whole point of the indicator is to let the
> operator (human or machine)
> know they can't plug the device at a specific time.
> Should QEMU take the responsibility of the operator? Is it even correct?

I don't think there's an unambiguous correct answer here.  But I think
it's reasonable to interpret a general "device_add" as "instruct the
virtual operator to plug in the card ASAP" as easily as "shove the
virtual card in right now".  device_add already covers a bunch of
different pluggable interfaces, so I don't think precisely aligning to
pci-e semantics is really a priority.

> Even if we would want such a feature, how is it related to this patch?
> The patch simply refuses to start a hotplug operation when it knows it wi=
ll
> not succeed.

I don't think I was clear.  There are two separate and unrelated things
I'm bringing up here.  The first is that having the device_add fail for
transitory reasons that the management layer doesn't really care about
is really bad UX.

But the second point I'm raising here is that "don't plug when blinking"
is not, strictly speaking an implementable strategy for a human
operator.  That makes me conclude that the idea here is plugs started
at basically the same time as the blinking starts (which could be a
little before or a little after, humans being fuzzy) should actually be
acceptable, even if they finish after the indicator is blinking.  It's
not clear to me that the kernel's current behaviour actually permits
that.

> Another way that would make sense to me would be  is a new QEMU interface
> other than
> "add_device", let's say "adding_device_allowed", that would return true i=
f
> the hotplug is allowed
> at this point of time. (I am aware of the theoretical races)
>=20
> The above will at least mimic the mechanics of the pyhs world.  The
> operator looks at the indicator,
> the management software checks if adding the device is allowed.
> Since it is a corner case I would prefer the device_add to fail rather th=
an
> introducing a new interface,
> but that's just me.

Oh, no, that's not what I'm suggesting.  Adding an "is allowed" command
is even worse.  It makes the management's task *more* complex, which
making any possible race here even wider.

--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/CO1kh3IKGZ08rNtjX0YlAeR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+WbkQACgkQbDjKyiDZ
s5J5AhAA3gSSQAjnPwCO/9iCAw6lI49HXEev4Unl7NQvPuZLNuq2U0sMfdAC6rgU
HqXNCOrMMjGHTctV6gsNdZjOHLkkkATIErGVu6A3rrVJCXxoDMGJln/WxEMILaAu
G7SEjOqshOfDJpr0MTvYQweOdtGIXGJA+BTIhvybi75fNfJrxUdwNSOrFTH/izWb
lauY7RcISbmqBCr0Snv/jCji8OJJQzVBht78IPvg00de0yUFba/pUY7ZB/V48v82
GQccFpTyDmtNY6E4bt7FtFHWimuU8w/+t8JIRx6USqyeKlQQqorVXrBBF84pJIyc
ppV+LaLglbmbe6+ysXY/r92DeaTk/5EMOjPS8g6aHODhKI0nxCnKDDB5FHcjmlFP
WwT3yTA1oYt5FsJ+awrEWmn4XRbuuxfXiKHLxVX/uxcEO+DPiFap1SyDireIOkDs
Z34mHT69w+gIA8NssMck5v82ExmQ4bKywO43L1v+MYZg+zuzfdixr12urRZa6+2d
kQr1OnJxu0OByy+BcQijYiPaUFWevdVNo2Gv2gpv3WAlbUpGtEQjqwQEDQvQRsr9
O/DMKmp6ZWbRAmkFcl1BpAnEQ6Un6YcAMTOXnJuZxUNOIN14rFi8E58gwCmgpAo0
kLMx5jMFg/gOOlebuKh77Qr1Rq/0zUmSJgVnzNyKaxj9QbKbwcI=
=Ot+d
-----END PGP SIGNATURE-----

--Sig_/CO1kh3IKGZ08rNtjX0YlAeR--



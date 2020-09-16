Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBBEC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:16:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7414422225
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=blade-group.com header.i=@blade-group.com header.b="K8XWKn49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7414422225
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=blade-group.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWMi-0000vs-Au
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antoine.damhet@blade-group.com>)
 id 1kIWKE-0007mt-Uv
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:14:20 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:41758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antoine.damhet@blade-group.com>)
 id 1kIWKC-0003L8-RH
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:14:14 -0400
Received: by mail-wr1-x42e.google.com with SMTP id w5so6657807wrp.8
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 05:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blade-group.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KCNq1kcLAzch4JZNKsiYZ2eTwrfwnQJKJpGA55R7N+o=;
 b=K8XWKn49ExH6luNHgZPmjXtRGWw2wWQ757wus7WEVlqYGrWeGlv/18G6+zCHrQJyfD
 j3l2FVnYuR6q1m+RrzNukyb0E79lupQNP5ukzMwlClRupiQ93KPsLmRRfJw6o8GNzaoq
 TGoAXC0r+Krty4yupNVZDkG/HP3rlCDWmngJSuePfD8NnE4NIbBtb989CRYYERGuh4hz
 YUIIeckh6OLYplKcFgyCC16ELq/Q1roxAdUP/PYaYijQf4nvakwXB1gMOfoccbFY/8x6
 I2/dHQvCoCX1hLZqVkAphlQ+XuBdmNic9uZ7Wm/BSsjuEM5G0ha+Lq3we6GLf+yB0Dun
 kVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KCNq1kcLAzch4JZNKsiYZ2eTwrfwnQJKJpGA55R7N+o=;
 b=EZdBkvLu3+3hE2KgDMhTPW1bE1oes+YAf97ezDYjvRLGsjXTyJbZVM90Rspd9e4yUW
 g5hqJ//FP5j+8kzBnp25aca8NNBw58rTwZ2YuX2p2Ya1X4q7UVeAUEClbp+xLUN3ri4d
 pXkCSlCFSOnzYczXGhwuqkT6mkZ0RujUN/AfuJnrCAXmpSzlnFxBODogp4Ha/ZADg1Va
 +x4VmGEwInMZEAAghSDKtSfItIbe06d8zhDaNECHOXv2N4tFD2Btq8U2FdkCQD3v+j4P
 1IxgvjOmd71rm5eRaj825sqL0UIMeqTtEoPmCFp//acPV6yCrCcokwU5jhJypgLqrCwB
 oX7w==
X-Gm-Message-State: AOAM533I2aHFyTvtsInpQmdCF1o6AgOmsHUTqzkqGSqumqtcpdehEv9d
 o+k332xLdxLguk/SnnN7uqKd6A==
X-Google-Smtp-Source: ABdhPJyl6+kUlaBmAvxl/GxulULSQJQNAt9lx1T5MXU64rpoOKuJ+9BvPNvYhcFJhCJxSiz13V0OIw==
X-Received: by 2002:adf:fed1:: with SMTP id q17mr25338531wrs.85.1600258450592; 
 Wed, 16 Sep 2020 05:14:10 -0700 (PDT)
Received: from localhost ([2a01:e34:ec16:8a90:4e1d:96ff:fe49:7109])
 by smtp.gmail.com with ESMTPSA id 91sm35867338wrq.9.2020.09.16.05.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 05:14:09 -0700 (PDT)
Date: Wed, 16 Sep 2020 14:14:09 +0200
From: Antoine Damhet <antoine.damhet@blade-group.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [BUG] Migration hv_time rollback
Message-ID: <20200916121409.sid2vs3fjuktfude@tartarus>
References: <20200916090602.blkm7eym6g5bnvvk@tartarus>
 <20200916112956.GE2833@work-vm>
 <87bli6hqz4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="llfv5it77tqeiclu"
Content-Disposition: inline
In-Reply-To: <87bli6hqz4.fsf@vitty.brq.redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=antoine.damhet@blade-group.com; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--llfv5it77tqeiclu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 01:59:43PM +0200, Vitaly Kuznetsov wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>=20
> > cc'ing in Vitaly who knows about the hv stuff.
> >
>=20
> cc'ing Marcelo who knows about clocksources :-)
>=20
> > * Antoine Damhet (antoine.damhet@blade-group.com) wrote:
> >> Hi,
> >>=20
> >> We are experiencing timestamp rollbacks during live-migration of
> >> Windows 10 guests
>=20
> Are you migrating to the same hardware (with the same TSC frequency)? Is
> TSC used as the clocksource on the host?

Yes we are migrating to the exact same hardware. And yes TSC is used as
a clocksource in the host (but the bug is still happening with `hpet` as
a clocksource).

>=20
> >>  with the following qemu configuration (linux 5.4.46
> >> and qemu master):
> >> ```
> >> $ qemu-system-x86_64 -enable-kvm -cpu host,kvm=3Doff,hv_time [...]
> >> ```
>=20
> Out of pure curiosity, what's the purpose of doing 'kvm=3Doff'? Windows is
> not going to check for KVM identification anyway so we pretend we're
> Hyper-V.=20

Some softwares explicitly checks for the presence of KVM and then crash
if they find it in CPUID :/

>=20
> Also, have you tried adding more Hyper-V enlightenments?=20

Yes, I published a stripped-down command-line for a minimal reproducer
but even `hv-frequencies` and `hv-reenlightenment` don't help.

>=20
> >
> > How big a jump are you seeing, and how did you notice it in the guest?
> >
> > Dave
> >
> >> I have tracked the bug to the fact that `kvmclock` is not exposed and
> >> disabled from qemu PoV but is in fact used by `hv-time` (in KVM).
> >>=20
> >> I think we should enable the `kvmclock` (qemu device) if `hv-time` is
> >> present and add Hyper-V support for the `kvmclock_current_nsec`
> >> function.
>=20
> AFAICT kvmclock_current_nsec() checks whether kvmclock was enabled by
> the guest:
>=20
>    if (!(env->system_time_msr & 1ULL)) {
>         /* KVM clock not active */
>         return 0;
>     }
>=20
> and this is (and way) always false for Windows guests.

Hooo, I missed this piece. When is `clock_is_reliable` expected to be
false ? Because if it is I still think we should be able to query at
least `HV_X64_MSR_REFERENCE_TSC`

>=20
> >>=20
> >> I'm asking for advice because I am unsure this is the _right_ approach
> >> and how to keep migration compatibility between qemu versions.
> >>=20
> >> Thank you all,
> >>=20
> >> --=20
> >> Antoine 'xdbob' Damhet
>=20
> --=20
> Vitaly
>=20

--=20
Antoine 'xdbob' Damhet

--llfv5it77tqeiclu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEArm1WbQx2GmOsfF83AmjLzzljz4FAl9iAY4ACgkQ3AmjLzzl
jz7lQQf+N2hB4FMN4JDTKZvMjhAqhObrr+c/CNGSBRkMNFV5mSA3gAimHGzpzpyV
YKvBxkFj0TpUBJ99FUD9ut2CMS1pmi/swAW7gSHpW+vQbgjlfLny/G6c0tMqu9cn
vQJIp3v0WQ5UNxjQZhiwT55eKJb/XLffZftLazSRD1yeiK1qU0xO7R/AHyUsg50b
FzmTVe4xh/boourn/DT+ii8fWbF38PO7z1rOSLaK9qmWUwgyPeWoAe8rPzCigVZj
NzpkCLa2KvW7PEv3zCudysq3VPqvt0nsqSeusCll5qe9GZ3msfibwQmoGehKPZ4U
8axHH4maS9TBbYhkMZ5AK/liWKiDtw==
=jRc5
-----END PGP SIGNATURE-----

--llfv5it77tqeiclu--


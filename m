Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB62BC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 03:50:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D8121D43
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 03:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7RNX6lw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D8121D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVo63-0003gR-Ih
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 23:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1kVo4z-00032R-Av
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 23:49:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53754)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1kVo4w-0001D3-GC
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 23:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603424960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EplKYPGgG7MT5JBz2XlBFKTm3TfK17tfeuwnhjdjKn4=;
 b=E7RNX6lwOet9IAI8Sc9T0fII6OCd1Mi5pxbgSKFoBycZFLEuKnqu7QTG5jFq/Dyx9tzGP9
 AQG3pBN8JTEOgJ44ZkQqxoqvXh6lmFPSSpzfkjhxXCSwEdB0ji9ioCM7ey61IoUynE303Z
 6vT/u/7XB2sDMg1qmz3aO+cjZNF4ssQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-ctoQpwi5PbOVo3LHjaAB8Q-1; Thu, 22 Oct 2020 23:49:18 -0400
X-MC-Unique: ctoQpwi5PbOVo3LHjaAB8Q-1
Received: by mail-pf1-f199.google.com with SMTP id q16so37081pfj.7
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 20:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version;
 bh=EplKYPGgG7MT5JBz2XlBFKTm3TfK17tfeuwnhjdjKn4=;
 b=dF3KHjHsUr1qYgGXd4Jb2roDCa9PXXJfcM9Kqdd6npkTTvNsksRkDPx92F7scKjD4l
 bxP3sA6d5SHDIO3AkBRU/SEVdfhmg5xG+9uOHY4Ai0hdpCE9pT6DlyqzW2poXJAD8EDV
 YtGW6hM4p1ySlmNwqFt+av9YYJuJ2W7RVeJ5e4zdqV1eTSw9LUW3zMv7XsDGdFcJIS+3
 AdL5+YT3zPAri9mtB+X3d2sI568YyT9n5cRViSEhoLclregaGynH/SFOzTjUnZI14qfG
 5OKDsIWxv5sNrZhi1i9kOv24Nom/ugnkMbjmO7uye62vkj9F2ESXa5lHGmo+tEE6WuJv
 PIyQ==
X-Gm-Message-State: AOAM530d/I8ZsZES5QYu3BuRkx0wOdDgz9WZZn2m9/S0L7V6QfWzi6ks
 E4+R1ewhKBwzfi1bouUVU8JD2t6uOgRqQON7dkuYmEoHUentgXkWswgUl/r31LbOdxpC8TiZYpN
 R4I1/WM0+KjihDQc=
X-Received: by 2002:aa7:8055:0:b029:15f:cbe9:1aad with SMTP id
 y21-20020aa780550000b029015fcbe91aadmr402947pfm.71.1603424956943; 
 Thu, 22 Oct 2020 20:49:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKyWayu0xH4slxnym1oV39K1gCH6MenoZQqfQpRIGJjlNxzzOwrbxcrfoHgOhrbsyBQNUEYw==
X-Received: by 2002:aa7:8055:0:b029:15f:cbe9:1aad with SMTP id
 y21-20020aa780550000b029015fcbe91aadmr402927pfm.71.1603424956606; 
 Thu, 22 Oct 2020 20:49:16 -0700 (PDT)
Received: from yekko.fritz.box ([2001:4479:e000:a00:52ee:f101:6b37:1519])
 by smtp.gmail.com with ESMTPSA id j15sm156829pgn.32.2020.10.22.20.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 20:49:16 -0700 (PDT)
Date: Fri, 23 Oct 2020 14:49:01 +1100
From: David Gibson <dgibson@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] pci: Refuse to hotplug PCI Devices when the Guest OS is
 not ready
Message-ID: <20201023144901.5bd908a1@yekko.fritz.box>
In-Reply-To: <20201022110016-mutt-send-email-mst@kernel.org>
References: <20201022114026.31968-1-marcel.apfelbaum@gmail.com>
 <20201022080354-mutt-send-email-mst@kernel.org>
 <20201022235632.7f69ddc9@yekko.fritz.box>
 <CAC_L=vVi6ngD6j0sZ2uLZ-NHF2WGzKfiOvmsHxOZaBRv6FuBug@mail.gmail.com>
 <20201022100028-mutt-send-email-mst@kernel.org>
 <CAC_L=vWctLK0Yjod_Vz=+xzFKFp4UoUdjSVa4jWeDm+g8en6wQ@mail.gmail.com>
 <20201022102857-mutt-send-email-mst@kernel.org>
 <CAC_L=vX0+H-SfQHneVPd-Mc3wFxHBSbkKHt3SpNOBOY_JsYDUA@mail.gmail.com>
 <20201022110016-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgibson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/IJV2YoS78.j3Di7NdwIBPqB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgibson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 23:30:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Julia Suvorova <jusual@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/IJV2YoS78.j3Di7NdwIBPqB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Oct 2020 11:01:04 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Oct 22, 2020 at 05:50:51PM +0300, Marcel Apfelbaum wrote:
>  [...] =20
>=20
> Right. After detecting just failing unconditionally it a bit too
> simplistic IMHO.

There's also another factor here, which I thought I'd mentioned
already, but looks like I didn't: I think we're still missing some
details in what's going on.

The premise for this patch is that plugging while the indicator is in
transition state is allowed to fail in any way on the guest side.  I
don't think that's a reasonable interpretation, because it's unworkable
for physical hotplug.  If the indicator starts blinking while you're in
the middle of shoving a card in, you'd be in trouble.

So, what I'm assuming here is that while "don't plug while blinking" is
the instruction for the operator to obey as best they can, on the guest
side the rule has to be "start blinking, wait a while and by the time
you leave blinking state again, you can be confident any plugs or
unplugs have completed".  Obviously still racy in the strict computer
science sense, but about the best you can do with slow humans in the
mix.

So, qemu should of course endeavour to follow that rule as though it
was a human operator on a physical machine and not plug when the
indicator is blinking.  *But* the qemu plug will in practice be fast
enough that if we're hitting real problems here, it suggests the guest
is still doing something wrong.

--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/IJV2YoS78.j3Di7NdwIBPqB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+SUq0ACgkQbDjKyiDZ
s5KI9A//cqJDUCFIQcHmBZMOQqGSMUTdlpNzUb62h8z6XVUW8nxqTe5tEsWOH4i8
MwBOpqvLx3UpPUYtDRDbb0HGeDRFOjd73lxSaULBdOUQjk/POQif+steeKc8pVJ5
SYCw35+nNcBrMLbAYradmDLG3hWuqgVWpfDHjIDJifiBuJMRMKDPkBxo3Bu1vw/Y
XAIEACdKe6/N23ijwxKE0jhkw7+8W1j0LtNGS4VXwCBPnqfMB846x8QcLp8vSt4i
8yR/Oymgs09c0b6QwO4/XASQ8cmGpKBsMGOFLUVAvyqlg2YmLlUuyUWOWJ7suoPA
VZWWVGvJoHQsN/MPRJfUW0z5z1mmGv5WMzzU9PEC6jKKGDjK4P3az60W4bM4/qt2
J1MuqwffZbuhD9tJZeiZyIAUUKc0f+f0eTr4m21y3HNovRdLhvfwTs8qPRIOks4b
lAhCK/fwq67wnrlEu5WuGSl6zmRl3Zi1eaWtbfXBRH8dB3ET6PkgpYSs14qSavu/
oiApDU3dxin5BmS9Ov1SPQKsshoYJLvCF4lcIqmT61+r1YT/VQ5ZDCBl1ndNDSTK
DHScACA3WDdI3cP3MaTglfF5rgXWLXiAGRjJtZHMZgnyMYG0T9YRhnEt2BdebxjM
/xIQB+uqRYaFYLaBesMxOHv+kRHxv1HXXoP5pjuSYq3vn+KEDnY=
=UOuT
-----END PGP SIGNATURE-----

--Sig_/IJV2YoS78.j3Di7NdwIBPqB--



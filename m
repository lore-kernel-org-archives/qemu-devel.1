Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA815C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 06:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0052022247
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 06:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqzhyBMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0052022247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWwBL-0000rl-1D
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 02:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1kWw9z-0000Fa-Jg
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 02:39:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1kWw9u-00058A-V5
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 02:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603694349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6zHz96WNFkifywiq6D57QNzvgzD89m27/d1O1VEDojY=;
 b=LqzhyBMJmI9Y2HvWn5ztOuTQG+LXv3JqL1nu2PdXOat7R4qLX1AwevsKRHiU8VbQOydoyn
 T1gG+N49nDF8VKjIR346eIbkR+TWgvcIp7j/HSV8yo33Fi77uIxy6UzYEyBbTakv/oK8dA
 f0LSc13a4POrvWByY+BmpZ2UQq3/wxw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-P3ko9pUdMzilnk7kNopKSQ-1; Mon, 26 Oct 2020 02:39:07 -0400
X-MC-Unique: P3ko9pUdMzilnk7kNopKSQ-1
Received: by mail-pf1-f200.google.com with SMTP id 203so2059429pfx.10
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2020 23:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version;
 bh=6zHz96WNFkifywiq6D57QNzvgzD89m27/d1O1VEDojY=;
 b=M4mUhHXswww0y3ZKa1q7sWqKhnLZF3WPmqhXRT63W8ePpeGEv88htXE61sKZNvsfU7
 SLoXZzvfTBiqVNjqoBuoQZDXKfMd/jIJqGeEH5/ZVPyFfLYDMeN/ruhG6s9Lomm02EzD
 pYLzqihG/YxE059AFB4p6klul9H3ld7SOu3osFL4Ap1Ajn/emkg4ll6ST1FxMqrDbmvU
 CgHAT38C+iXcsfhbZ1edJOtco6i7V0M0ln44Rd/hhSfkPLs1uVyCAjxwrwRgRF9c4IOt
 NGorq8hykFhEwBsMt4ELtkVXkpOkPJTKtRAFSfERyyT5tq7QUqDQMpsH8p10Akie4cVS
 hNFw==
X-Gm-Message-State: AOAM531h5vzDzpwvghleM+49xR2mDH8nTtH9NNPHle/Ah5R9sBUhRDc9
 iJfzAOqJ7SUhXcc0UaBY+sU3tyjD3jy2bss2Z5V5vzBX68aMpKQDWANwhIb/np6KpvIHDjB8ITR
 nK5rk/gbMRs2hPHM=
X-Received: by 2002:a63:9a41:: with SMTP id e1mr12222644pgo.371.1603694346049; 
 Sun, 25 Oct 2020 23:39:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/ES6CLPeKWUWZ+ZCHgMyMrbTFjt3jBiDhSYQn0qCz9OV/xm1Wj6w2dyrlYrQQF+SEyudKkQ==
X-Received: by 2002:a63:9a41:: with SMTP id e1mr12222631pgo.371.1603694345762; 
 Sun, 25 Oct 2020 23:39:05 -0700 (PDT)
Received: from yekko.fritz.box ([2001:4479:e200:1100:3c24:4d96:ea81:be55])
 by smtp.gmail.com with ESMTPSA id b20sm10459547pft.55.2020.10.25.23.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2020 23:39:05 -0700 (PDT)
Date: Mon, 26 Oct 2020 17:38:57 +1100
From: David Gibson <dgibson@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] pci: Refuse to hotplug PCI Devices when the Guest OS is
 not ready
Message-ID: <20201026173857.414878fb@yekko.fritz.box>
In-Reply-To: <20201023192755.1845b060@redhat.com>
References: <20201022080354-mutt-send-email-mst@kernel.org>
 <20201022235632.7f69ddc9@yekko.fritz.box>
 <CAC_L=vVi6ngD6j0sZ2uLZ-NHF2WGzKfiOvmsHxOZaBRv6FuBug@mail.gmail.com>
 <20201022100028-mutt-send-email-mst@kernel.org>
 <CAC_L=vWctLK0Yjod_Vz=+xzFKFp4UoUdjSVa4jWeDm+g8en6wQ@mail.gmail.com>
 <20201022102857-mutt-send-email-mst@kernel.org>
 <CAC_L=vX0+H-SfQHneVPd-Mc3wFxHBSbkKHt3SpNOBOY_JsYDUA@mail.gmail.com>
 <20201022110016-mutt-send-email-mst@kernel.org>
 <20201023144901.5bd908a1@yekko.fritz.box>
 <CAC_L=vUh8LU5c8c00OhnbEiW7EzZFWKU61vOdub7c11wDMXeRg@mail.gmail.com>
 <20201023115029-mutt-send-email-mst@kernel.org>
 <20201023192755.1845b060@redhat.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgibson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/DMid0c9XUYQHHdsPQ_bsUnR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgibson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Libvirt Mailing List <libvir-list@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, qemu devel list <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/DMid0c9XUYQHHdsPQ_bsUnR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Oct 2020 19:27:55 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Fri, 23 Oct 2020 11:54:40 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
> >=20
> > Rather than adding_device_allowed, something like "query slot"
> > might be helpful for debugging. That would help user figure out
> > e.g. why isn't device visible without any races. =20
>=20
> Would be new command useful tough? What we end up is broken guest
> (if I read commit message right) and a user who has no idea if=20
> device_add was successful or not.
> So what user should do in this case
>   - wait till it explodes?
>   - can user remove it or it would be stuck there forever?
>   - poll slot before hotplug, manually?
>=20
> (if this is the case then failing device_add cleanly doesn't sound bad,
> it looks similar to another error we have "/* Check if hot-plug is disabl=
ed on the slot */"
> in pcie_cap_slot_pre_plug_cb)
>=20
> CCing libvirt, as it concerns not only QEMU.
>=20
>  [...] =20
>  [...] =20
> >=20
> > I think we want QEMU management interface to be reasonably
> > abstract and agnostic if possible. Pushing knowledge of hardware
> > detail to management will just lead to pain IMHO.
> > We supported device_add which practically never fails for years, =20
>=20
> For CPUs and RAM, device_add can fail so maybe management is also
> prepared to handle errors on PCI hotplug path.

There can be unarguable reasons for PCI hotplug to fail as well
(attempting to plug to a bus that can't support it for one).  The
difference here is that it's a failure that we expect to be transitory.

--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/DMid0c9XUYQHHdsPQ_bsUnR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+WbwEACgkQbDjKyiDZ
s5L0/BAA1nt3jQRIK/RTUUAOKvQp/WJLu+lf+8qqGrrqJcZ26wLHIW0TwbwTYcEp
6kDF8yxMBQ9eSAULw4f12QebhynYieQb4FnHakmUW65neLBFu0fFwK9AIBEayCMx
YPvL5lFxsXi5TSWARfvSKvNkETh0tSWnzNbzKJXPZvnaP2P712sXcFawbGGm7+bi
dlT19tvTYNkYi61V0HH8POmrv2J15tYkTon/H4G3Q8RnCA8ZemNbRX9U7myHxTkE
W4JbZUA7Ouc7AoQH9YrD9hyGHJuXxfbS+YIRsm3fuuqNNAhkDR8+v4YKbhR8rQVj
c13zIfTprx09Uas2x4bROQtu03PyHQBvGK+43BRzBkxXYx3lDVdxQi74mrPxIfAz
7AK//NcEfHhReAzfCMWd0shmNiXmNVsVbtTD2LucfeX/zPLH/vr41J67G1qeAbYd
1Ye58cZFl3HJqp9ouXgJpHsvn4XAzTcW/nWx4NoLWjJmV99km3MQb5sNX3sFNkTX
e+ZIUsOEgL6YI8v2bRMK1urrJRyvL1pmqZy3mvoYMV6qhZ/SanSVTkug87yuzOZD
LdyXppGYdVcvlixZtJcxw9ANZhHw/LUGQ8CKsV4XPh2hEeaLf3XNWkCTaETOsij3
Dos8w/RYV8w4KuRY4ky97UELKPK1V2xlRKvWMtIB36m8J21M3mw=
=TeJt
-----END PGP SIGNATURE-----

--Sig_/DMid0c9XUYQHHdsPQ_bsUnR--



Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC69C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 03:33:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2A32076A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 03:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4xS7YX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2A32076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVnpd-0004dF-4P
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 23:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1kVnoI-0003k2-BH
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 23:32:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43112)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1kVno8-0003ER-1H
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 23:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603423917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hfF62pdkmFMHE9sbW5heM7C+wBferFkFP6iHXGLk1xA=;
 b=f4xS7YX0Ukdrg4LmzxuzuigiD5biGKSTAslXwVpFtGXdwwQH6/H7KmeEiJLidmSgSgrCB7
 rv1ywQWtXkD6vSsc7G8tm7unWXh/+vNIZnbrcyQSS+QI0f9SLneomtUXqtWyJyh6EyOYR6
 uieFlPalUsIeqr5vjD7hntpsTwZSSEg=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-fJXYgBaDN4CHpwLYLmHO8g-1; Thu, 22 Oct 2020 23:31:55 -0400
X-MC-Unique: fJXYgBaDN4CHpwLYLmHO8g-1
Received: by mail-pf1-f197.google.com with SMTP id y7so2619714pff.20
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 20:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version;
 bh=hfF62pdkmFMHE9sbW5heM7C+wBferFkFP6iHXGLk1xA=;
 b=ULvwtGvOVIY0daD8bLmafqd6m/ri0gnozDTs0VAKz9ehaTUe+3KOB1PJpSSiMiqBnL
 Q5hSVUi+FVF0Dn/+B9kYDYB9iGt+tuM0y7THRIErTHfKhsDJD9xW4+BwnfZHMGijLfPp
 5G+FWQI30mWoYoKWvJtX8dK8DmtPThNO43C4ZIEi0xTvkfxJVFg+Y/EJfIFw0+cBhknF
 YFRPbbx50LV/YWS9AAL24I0Cv/ZkK50ECHiiY1kKXcYnw0e/yKO+wTMMyiAknRnN0z1o
 7kTJhfpOJSe+siy06hqeqTDTppHhC6C0XPzGcLcXaAt6zIuCcBk6mxPJLK+TCSPkm3aT
 oVSQ==
X-Gm-Message-State: AOAM531euWQWp8WjjiVvyUBfK+WqJH+upSrOmprrom3flN/Gqv41sC2D
 XXx2OzWdeEMWqMJ3zxsaGoVZbhqKkoxIdhZzjD6wnlqwRqwWyzrOxD2YDU/JGo2Snn2mSicJQgk
 K5IL2LpbM6AL4jWw=
X-Received: by 2002:a63:ed01:: with SMTP id d1mr441396pgi.58.1603423914479;
 Thu, 22 Oct 2020 20:31:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmzYJCoVf5NxlarSwQOdQAlaPpB+Bln9L4y2aOVmaP35oVLjOIr0TKywie8w6dujD+c5KIXw==
X-Received: by 2002:a63:ed01:: with SMTP id d1mr441380pgi.58.1603423914248;
 Thu, 22 Oct 2020 20:31:54 -0700 (PDT)
Received: from yekko.fritz.box ([2001:4479:e000:a00:52ee:f101:6b37:1519])
 by smtp.gmail.com with ESMTPSA id w74sm175459pff.200.2020.10.22.20.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 20:31:53 -0700 (PDT)
Date: Fri, 23 Oct 2020 14:31:46 +1100
From: David Gibson <dgibson@redhat.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] pci: Refuse to hotplug PCI Devices when the Guest OS is
 not ready
Message-ID: <20201023143146.2a17e6d8@yekko.fritz.box>
In-Reply-To: <CAC_L=vVi6ngD6j0sZ2uLZ-NHF2WGzKfiOvmsHxOZaBRv6FuBug@mail.gmail.com>
References: <20201022114026.31968-1-marcel.apfelbaum@gmail.com>
 <20201022080354-mutt-send-email-mst@kernel.org>
 <20201022235632.7f69ddc9@yekko.fritz.box>
 <CAC_L=vVi6ngD6j0sZ2uLZ-NHF2WGzKfiOvmsHxOZaBRv6FuBug@mail.gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgibson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/c.aYYpU+9HB3C2gBYrmiCCs";
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
Cc: Julia Suvorova <jusual@redhat.com>, qemu devel list <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/c.aYYpU+9HB3C2gBYrmiCCs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Oct 2020 16:55:10 +0300
Marcel Apfelbaum <marcel.apfelbaum@gmail.com> wrote:

> Hi David, Michael,
>=20
> On Thu, Oct 22, 2020 at 3:56 PM David Gibson <dgibson@redhat.com> wrote:
>=20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
> > >
> > > Probably the only way to handle for existing machine types. =20
> > =20
>=20
> I agree
>=20
>=20
> > > For new ones, can't we queue it in host memory somewhere? =20
> >
> > =20
> I am not sure I understand what will be the flow.
>   - The user asks for a hotplug operation.
>   -  QEMU deferred operation.
> After that the operation may still fail, how would the user know if the
> operation
> succeeded or not?
>=20
>=20
>=20
> > I'm not actually convinced we can't do that even for existing machine
> > types. =20
>=20
>=20
> Is a Guest visible change, I don't think we can do it.

How is it a guest visible change?

> > So I'm a bit hesitant to suggest going ahead with this without
> > looking a bit closer at whether we can implement a wait-for-ready in
> > qemu, rather than forcing every user of qemu (human or machine) to do
> > so.
>=20
> While I agree it is a pain from the usability point of view, hotplug
> operations
> are allowed to fail. This is not more than a corner case, ensuring the ri=
ght
> response (gracefully erroring out) may be enough.
>=20
> Thanks,
> Marcel
>=20
>=20
>=20
>  [...] =20


--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/c.aYYpU+9HB3C2gBYrmiCCs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+STqIACgkQbDjKyiDZ
s5KEjw/9HLvu9OOLPVA2GqcA57vehjNi3tRzJOZFkPNlr6vHKh57t2LkGF/j1qeO
SbI+KMgLjuoyVntMK3kqmBJ145P59q0fbe5Csim4KXA0xmMcW36MKg9uI8r1i54P
YJEjSoH51w259Ypj2AvQRqyCzSU2/Y+bYGBpzYb6vw6JIBupEvYdI1qKtKRX+lJX
CjxbiQn6N1RM50vvop6dqEwLvGlZaPJhPVdoMmo42Bcbf9HhbsA6f4ViOjYgaYNO
upQjpuhFeeQaHjLm2J96Zh+G57+6KwjpyfxOEiSa67q39wNRlX0m/SRfwfMFqUSN
gnu4V86pf3haco2OXKP+EC8WOKAw8s33EI0/b6tA7i95hMN7W3Zct0mYz0yUaOxI
b/wPrrh0LBimlOKI+t8sUJBL71zjMVqWXhEG0zrf+PJSt549PoY5jprTkQXrVUsf
w+hTKWOe1RHymJSavtLrUKwzbfJ5KVUJVPivN3iAQ9g44dzTXRKJwHkPRwEjcdKP
u+opKf3I71TZL7LZAu3tsFK+VvijxglogJBEtX/LgBG1a05fqukzmxGEkPYUJatK
LR2OrQmtA6jQN2+jINoc0Gh1j+eOpifPmUWNRSeSqWxp0iHzjJofmF5lf/o4zAlm
S9ncoCXw9vUCUBR5ddf+Hu1Ic8T6qMNN0Vl6mnIS0kD9L+ue2fI=
=e+rj
-----END PGP SIGNATURE-----

--Sig_/c.aYYpU+9HB3C2gBYrmiCCs--



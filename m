Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9317C43465
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D66E20717
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=blade-group.com header.i=@blade-group.com header.b="Q6XVFUCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D66E20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=blade-group.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJIEl-00016L-67
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antoine.damhet@blade-group.com>)
 id 1kJI3q-0005mc-0A
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:12:30 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antoine.damhet@blade-group.com>)
 id 1kJI3g-0001ad-Nv
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:12:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id a17so5988159wrn.6
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 08:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blade-group.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=vWO0GxZPSzUmUvceKOmk/WZLHMm1bPXUy2StGvkw9n8=;
 b=Q6XVFUCGJmryzTxlI8QN6QZu6y9StdDfo5IV6mHG6Wiv6bZgDYkxvwYgYei+3aaion
 gsMNq/oGaGJ4o21ad5hPTSvrV1NBuXBneJZlcbqj6vZVOl4d1BtN8h1Fvo0GH/EHSveV
 hSo0rrRIk3FJDSBBh3ILTUi3MXe57R5ALss3hvEQcGlL7WJmHdWhrUCZw6n2rDDN2qnO
 1Q+porI2bfBomtKBMd3csXsUBw4HFzHfbRnDUJDa58nUiWFjYyRs+IuaLYNwM/wCk6tx
 o/6XTuHKvp5hCZl4OuCe/x591M8gxekd2IKemj+OrKvC8JWwEcNB16Ga9WtERhYZHB+z
 FxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vWO0GxZPSzUmUvceKOmk/WZLHMm1bPXUy2StGvkw9n8=;
 b=fk9w8lnMZxsoSJAxA2yAgiJ3zVU3a+MOTgZXl6F2m6SX1Exd2Sx1oiPNMBuNus5Ego
 OknA8V6DiKJ/AF84+/s0tuai+yybUNZgb5OkAhGBbmr216viPyTFXcCDKuus7iM02kmX
 aKQVCrcOlFCYYYBmGenwNFCot2DK/Tjt2diZYaIORI8pPKE6Fb6V/AfXx4MiUAP1JBcX
 5U+8cRmA/rYl7vEBfSlXjooUQ2zVN8ZxC+ECMDfRz3FbDwX4uIZREYkj1QBf5Ty9TC54
 ZFU/UBvMid1u71UvgHI5mfZ7LQdxkXnrSrVv/Uc02zS+FgPzZ2S+Az62/6DB8s7Txg2o
 TB2Q==
X-Gm-Message-State: AOAM531QWm++t6VVRsVBDFDO5EM0Y29O4z2MDFl/CH80HC9U2z0f8hby
 Y0NSCF+Q/754Zt9WrT7d2r7bSw==
X-Google-Smtp-Source: ABdhPJxTF3I+dW8FvkHSyHvVPR0BIiJgbr567ypI3G/sSTnvghB69FUFXlBHiJ4F5m6VWyz8vKoAzQ==
X-Received: by 2002:a5d:4448:: with SMTP id x8mr40885845wrr.207.1600441936163; 
 Fri, 18 Sep 2020 08:12:16 -0700 (PDT)
Received: from localhost ([2a01:e34:ec16:8a90:4e1d:96ff:fe49:7109])
 by smtp.gmail.com with ESMTPSA id t188sm5853811wmf.41.2020.09.18.08.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 08:12:14 -0700 (PDT)
Date: Fri, 18 Sep 2020 17:12:13 +0200
From: Antoine Damhet <antoine.damhet@blade-group.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] target/i386: always create kvmclock device
Message-ID: <20200918151213.x2dntgytybh7dkmx@tartarus>
References: <20200917111306.819263-1-vkuznets@redhat.com>
 <20200917122559.e7i5o64k7rw7urdh@tartarus>
 <87ft7gh6gy.fsf@vitty.brq.redhat.com>
 <20200917144237.GK2793@work-vm>
 <875z8ch2m6.fsf@vitty.brq.redhat.com>
 <20200917174410.GU2793@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rdv35oe3dr4lqk3l"
Content-Disposition: inline
In-Reply-To: <20200917174410.GU2793@work-vm>
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=antoine.damhet@blade-group.com; helo=mail-wr1-x442.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--rdv35oe3dr4lqk3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2020 at 06:44:10PM +0100, Dr. David Alan Gilbert wrote:

[...]

> > >> >
> > >> > Shouldn't the old check used when machine type <=3D 5.1 in order t=
o avoid
> > >> > migration incompatibility ?
> > >>=20
> > >> Hm, when the check fails we just don't create the device and no erro=
r is
> > >> reported, so even if we have kvmclock data in the migration stream b=
ut
> > >> fail to create it migration will still succeed, right? (not a migrat=
ion
> > >> expert here :-)
> > >
> > > When the migration stream is parsed, it'll try and find a "kvmclock"
> > > device to pass the data it's reading to; if one doesn't exist it'll
> > > fail.
> >=20
> > This may happen with an older machine type when the destination is
> > running an unfixed QEMU and the source has the fix, right?
>=20
> Yes I think so.
>=20
> > The solution
> > would be to introduce a flag for older machine types (or for new ones)
> > like 'kvmclock_always'.
>=20
> Yep sounds the normal answer.
> (You might want to try it first to trigger the bug)

So, I tried the patch and:

# patched -> patched

Everything working as expected

# patched -> unpatched

Migration failure with:

```
Unknown savevm section or instance 'kvmclock' 0. Make sure that your curren=
t VM setup matches your saved VM setup, including any hotplugged devices
load of migration failed: Invalid argument
```

# unpatched -> patched

The guest hangs upon arrival, I don't know which value is restored but
something is restored (and far enough from 0 to confuse Windows).

>=20
> > > The other question is in the incoming direction from an older VM;
> > > you'll have a kvm clock created here, but you won't load the kvm clock
> > > state from the migration stream - what is this clock going to do?
> >=20
> > This is not really a problem I believe: the clock was absent on the
> > source and things somehow worked for the guest so even if we don't
> > initialize kvmclock properly on the destination nothing bad is expected.
>=20
> OK.
>=20
> Dave

[...]

--=20
Antoine 'xdbob' Damhet

--rdv35oe3dr4lqk3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEArm1WbQx2GmOsfF83AmjLzzljz4FAl9kzkoACgkQ3AmjLzzl
jz5zQQgAuMCjg4pmYFysPTv87l6btxz8H4Q6llT2STDkZwLlLzpATHYbxkJyRBPI
JmpTIk43axj+4dkdUOn/H3lHQEFPQzU9GkVLGQQQ+0UYn5u4H00f/PXIoXwtPOro
X8BgzMkXfmbZzeuYkOpz9h1SkXLjTGF+ovWGOS5OHb79wnEBlFINdU0/eKbEjnqD
Xii+RBxfDtb1QsuXIK6h6HJNIh7LrDk4h0mPUuvN88BjfzI4tXQcq+JyQVpNEM/a
2n5iCSsk1f/HtvCiN8hl9uJxSOQV3serWNZ2c/SQk1gEJtUsPQFdk6jgpjcJAPwY
QXU4yfhU86v5B1uiFvN/yv7ro0D5ow==
=QAga
-----END PGP SIGNATURE-----

--rdv35oe3dr4lqk3l--


Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03C9C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:48:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67F7207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67F7207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDASy-0003Zk-91
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 12:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45502)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iDARI-0002Mh-KG
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:46:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iDARG-0001nd-BQ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:46:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38820)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iDARG-0001nQ-38
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:46:50 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8C022C057F88
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 16:46:48 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id r21so2328972wme.5
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to;
 bh=X7YFzOfAVchCcxH3XWuVQGSUW6YbXNCaigLfeevxIPY=;
 b=irkOlqw00+esn5yFWe9Ob8p7ixdcKfETfu806D25bg2T6Ee0GMk3OHU8wGQMlxeZ/8
 TlHNrVQt8qa6Bsqjo4HHQtdQ3UsF5TpJVwWWZqNxzgULwFyoVC0hsoDCXZIatHFYw5II
 40gzEWfE1c9Dbi9nnUDzn/dAtPx4OxpPCofW32DCh9oM/9D9+Nq6ckk3g2iXsPegQLAy
 ES/NUvOHBLNV98vWvcFHKeaj5HtxokBH0ow9uTHum2EeVgVb9V3aorRRar97aB9+1PIg
 Z9WBYuzgA4P5SfXD3yj4e9gfJipYlN4mzh8hwxU6coIBJa/REFMDkSL20Wxxj5DzlJip
 VUeA==
X-Gm-Message-State: APjAAAXHTmcUIHWjc5Yd0O+wbYRSUq8UDaZnGmM2YyhZIQ0sO5HIQcIC
 xmcTZejl65pnViXeDYRbZziA8akn0HB5bGzyJ25vWK4ds+xGtW0b+Yy4+ZSUn+v0VXAYATmrASW
 XAu4K0qf6FCd/68o=
X-Received: by 2002:a7b:ce08:: with SMTP id m8mr8463363wmc.106.1569430007211; 
 Wed, 25 Sep 2019 09:46:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw8IsSisqpRcgtpgERV145uk+s8N3VwCIWAluVOchilJzAHSd7C/X2cu8rzzW6vh4FC5bgxWg==
X-Received: by 2002:a7b:ce08:: with SMTP id m8mr8463347wmc.106.1569430006958; 
 Wed, 25 Sep 2019 09:46:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id b22sm4959864wmj.36.2019.09.25.09.46.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 09:46:46 -0700 (PDT)
Subject: Re: [PATCH v4 7/8] docs/microvm.txt: document the new microvm machine
 type
To: Sergio Lopez <slp@redhat.com>
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-8-slp@redhat.com>
 <23a6e891-c3ba-3991-d627-433eb1fe156d@redhat.com> <87a7ass9ho.fsf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d70d3812-fd84-b248-7965-cae15704e785@redhat.com>
Date: Wed, 25 Sep 2019 18:46:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87a7ass9ho.fsf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5tm1M1F58Yf5lz0Wk21bqJMURQODhbHNR"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mst@redhat.com, lersek@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 imammedo@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5tm1M1F58Yf5lz0Wk21bqJMURQODhbHNR
Content-Type: multipart/mixed; boundary="D1wog4nmJbRr7fGJTC0s1dm5JzKzjOYCT";
 protected-headers="v1"
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com,
 marcel.apfelbaum@gmail.com, rth@twiddle.net, ehabkost@redhat.com,
 philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com,
 mtosatti@redhat.com, kvm@vger.kernel.org
Message-ID: <d70d3812-fd84-b248-7965-cae15704e785@redhat.com>
Subject: Re: [PATCH v4 7/8] docs/microvm.txt: document the new microvm machine
 type
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-8-slp@redhat.com>
 <23a6e891-c3ba-3991-d627-433eb1fe156d@redhat.com> <87a7ass9ho.fsf@redhat.com>
In-Reply-To: <87a7ass9ho.fsf@redhat.com>

--D1wog4nmJbRr7fGJTC0s1dm5JzKzjOYCT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25/09/19 17:04, Sergio Lopez wrote:
> I'm going back to this level of the thread, because after your
> suggestion I took a deeper look at how things work around the PIC, and
> discovered I was completely wrong about my assumptions.
>=20
> For virtio-mmio devices, given that we don't have the ability to
> configure vectors (as it's done in the PCI case) we're stuck with the
> ones provided by the platform PIC, which in the x86 case is the i8259
> (at least from Linux's perspective).
>=20
> So we can get rid of the IOAPIC, but we need to keep the i8259 (we have=

> both a userspace and a kernel implementation too, so it should be fine)=
=2E

Hmm...  I would have thought the vectors are just GSIs, which will be
configured to the IOAPIC if it is present.  Maybe something is causing
Linux to ignore the IOAPIC?

> As for the PIT, we can omit it if we're running with KVM acceleration,
> as kvmclock will be used to calculate loops per jiffie and avoid the
> calibration, leaving it enabled otherwise.

Can you make it an OnOffAuto property, and default to on iff !KVM?

Paolo


--D1wog4nmJbRr7fGJTC0s1dm5JzKzjOYCT--

--5tm1M1F58Yf5lz0Wk21bqJMURQODhbHNR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl2LmfQACgkQv/vSX3jH
roPqLgf/fADq+4BmYtHUsUQhtxvhNQ/Ampl+pdfcB814jrw6Q21Gdb7VzD4rHFYl
gH/1euoSW8GArThQtAVDp4cvJscvDCx7vL0gusl0lJniMFMc9ZJWivRbVTTxBfYW
k0/ZZYJ12HoMQcP0OAhAjdTbJANxk7gK2V5mNNT0K7jhkWbUoN1ku8nMHjMPoM/i
PrlEAyA1Og/j4jVN84aV3wnbyG6zT4G0Dze6ObLUY9e9JZoaUwDrrCivegaNmsiQ
fofPlZMHtlbkEL1EshbNy16pHR9hN5YH4A/YuhNSgcxIGdolkEdOVD1yeqrZWDn/
Ojnl7ZLgcl55HHhvwMFK/QJ3r2vUZA==
=mPMS
-----END PGP SIGNATURE-----

--5tm1M1F58Yf5lz0Wk21bqJMURQODhbHNR--


Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7A1C7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 15:49:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D67E1208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 15:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67E1208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho8eX-00077T-LB
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 11:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54210)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1ho8eL-0006iv-QZ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 11:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ho8eK-0003dY-3B
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 11:48:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39225)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ho8eJ-0003bt-9s
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 11:48:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so29224803wrt.6
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 08:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to;
 bh=73bFbB+tUihvLLQzX8RTQN7t2vmzgLksX5VkdXavY1g=;
 b=dYElUEAiypWHkoBbSmsVQMoLo5E/gXJsJtFzFKloePhD452OqdRTTPUpDKbwKwYGqh
 jQXzy4pd2WS3sf5FVWsB8RgAMmUQCzho38CesUCXtcxBoa3HH2/YxL2eo34VJj9Dr+lY
 wZP01u8eMiyLzG33YPr5dZ4wZKdMZhxfm9KBqXcCV3fUV5Lm2vOt9qLDymmkaWa0lO+f
 6jqAHK8eMEEfBVx5LoqGi5y+etHvEs+47TsXleRF0kq/VqT5IENTKcuOgABJ98N6fUnl
 ry2umSSUTvo0FEF6k8TldoD1hY8+79zxy1jsbwnYTh9GNxm9jLfGYuLbN0p/ZWNXN3WZ
 q4Ew==
X-Gm-Message-State: APjAAAXS36xbrKcMsVz+GklMmmbuZ98sREc0p6xqnxUdtiw+xcu4U/k0
 M0omp6hoEdT2JXXTRoYhvqlg4de578+CqQ==
X-Google-Smtp-Source: APXvYqzCXduhmQA3zfBek4s/4mhvJnlOV0kr+0kRkJw+EtZwNRI2LnkB/m7/IcCvtTziYdO66D5g2A==
X-Received: by 2002:adf:df8b:: with SMTP id z11mr48063626wrl.62.1563464928515; 
 Thu, 18 Jul 2019 08:48:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2?
 ([2001:b07:6468:f312:e427:3beb:1110:dda2])
 by smtp.gmail.com with ESMTPSA id k9sm19830845wmi.33.2019.07.18.08.48.47
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Jul 2019 08:48:47 -0700 (PDT)
To: Sergio Lopez <slp@redhat.com>
References: <20190701144705.102615-1-slp@redhat.com>
 <20190701144705.102615-5-slp@redhat.com>
 <20190702081733.ff6cboiddln5wmti@sirius.home.kraxel.org>
 <878stgygiu.fsf@redhat.com>
 <20190702101625.trsg5dnnf2a4woqs@sirius.home.kraxel.org>
 <875zokyahg.fsf@redhat.com> <8c3b4619-f779-fb0c-7a53-b67150036a07@redhat.com>
 <8736joxzv4.fsf@redhat.com> <87ef2ntnr1.fsf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8cc45a56-1d12-838c-e746-e10df8804bc9@redhat.com>
Date: Thu, 18 Jul 2019 17:48:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87ef2ntnr1.fsf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UPj0B3lNfL0q7xgEYX1eJw0XejTiTpaBF"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/i386: Introduce the microvm
 machine type
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
Cc: ehabkost@redhat.com, maran.wilson@oracle.com, mst@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UPj0B3lNfL0q7xgEYX1eJw0XejTiTpaBF
Content-Type: multipart/mixed; boundary="kvtw2X5OQ5jeBluFb0rQpkmfm9zdbNNVU";
 protected-headers="v1"
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, mst@redhat.com,
 marcel.apfelbaum@gmail.com, rth@twiddle.net, ehabkost@redhat.com,
 maran.wilson@oracle.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Message-ID: <8cc45a56-1d12-838c-e746-e10df8804bc9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/i386: Introduce the microvm
 machine type
References: <20190701144705.102615-1-slp@redhat.com>
 <20190701144705.102615-5-slp@redhat.com>
 <20190702081733.ff6cboiddln5wmti@sirius.home.kraxel.org>
 <878stgygiu.fsf@redhat.com>
 <20190702101625.trsg5dnnf2a4woqs@sirius.home.kraxel.org>
 <875zokyahg.fsf@redhat.com> <8c3b4619-f779-fb0c-7a53-b67150036a07@redhat.com>
 <8736joxzv4.fsf@redhat.com> <87ef2ntnr1.fsf@redhat.com>
In-Reply-To: <87ef2ntnr1.fsf@redhat.com>

--kvtw2X5OQ5jeBluFb0rQpkmfm9zdbNNVU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18/07/19 16:34, Sergio Lopez wrote:
> I've just added support for starting the machine from SeaBIOS (Stefan
> Hajnoczi pointed in another thread that it can be as fast as qboot, and=

> given that the latter doesn't support mptables, I just tested this
> one). I tried to keep it as minimalistic as possible, but it still
> required an RTC (mc146818), which dragged in an ISA BUS, and this one a=

> KVM PIT.
>=20
> I ran some numbers using Stefano Garzarella's qemu-boot-time scripts
> [1] on a server with 2xIntel Xeon Silver 4114 2.20GHz, using the
> upstream QEMU (474f3938d79ab36b9231c9ad3b5a9314c2aeacde) built with
> minimal features [2]. The VM boots a minimal kernel [3] without initrd,=

> using a kata container image as root via virtio-blk (though this isn't
> really relevant, as we're just taking measurements until the kernel is
> about to exec init).
>=20
>  ---------------------
>  | QEMU with SeaBIOS |
>  ---------------------
>=20
>  qemu_init_end: 65.958714
>  linux_start_kernel: 77.735803 (+11.777089)
>  linux_start_user: 127.360739 (+49.624936)
>=20
>  -------------------
>  | QEMU direct PVH |
>  -------------------
>=20
>  qemu_init_end: 64.043264
>  linux_start_kernel: 65.481782 (+1.438518)
>  linux_start_user: 114.938353 (+49.456571)
>=20
>  --------------
>  | Comparison |
>  --------------
>=20
> Average boot time:
>=20
>  * Relying on SeaBIOS, when compared with direct PVH boot, as a total
>    average overhead of ~12ms. The cost of initializing QEMU increases i=
n
>    ~2ms (probably due to need to instantiate more devices), while the
>    other ~10ms is the SeaBIOS overhead.
>=20
>  ---------------
>  | Conclusions |
>  ---------------
>=20
> Objectively, the version that boots directly the kernel using PVH is 10=
%
> faster and has a slightly larger exposed surface. Whether this is enoug=
h
> to justify its existence is quite subjective.
>=20
> In my opinion, not only I think it makes sense to have it, but I also
> think there's little reason to have the firmware reliant version, given=

> the nature and purpose of microvm.

The advantage of firmware is support for vmlinuz and multiboot in
addition to PVH, and removing code from QEMU.  So I think it's still
worth doing a comparison with qboot, and trying to understand where
SeaBIOS is spending its time (qboot should not need additional devices
other than fw_cfg, and since SeaBIOS has never been optimized for
microvm I expect it's possible to shave quite a few of those 12 ms).

On the other hand I agree that microvm is showing great promise compared
to PCI-based machine types.

Paolo


--kvtw2X5OQ5jeBluFb0rQpkmfm9zdbNNVU--

--UPj0B3lNfL0q7xgEYX1eJw0XejTiTpaBF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl0wlN4ACgkQv/vSX3jH
roM+nwf8CgyWaKQlfxC/YRcvcEmxsfQ3jYrTQNvmSaY9PLH6fH7DMYFoj2NIH45Q
mRx/+uMnnakPoIGo+4suvaebXz8veSUSRAu28NHigtfztUOvN+v/KLmJWVf2Nxey
CdKxIRpf1fdFVOBk4U5mrrVEGYtZ15o1ecpHAYhZNtVFLe923B1IzrPDo/MZOqPx
ZBMLQOjXVXZCiVWY77QjHGepI7E+PlrM/CUtBoVnY3cbU2csMeZtSvPI2N6z9OBi
zbuZbUeJyE5HoffVQFztUYYMbD6X1fW2ciDssb3AYWSAVldj0HGiDad9qIHf40Jg
4E3kEON/sJAZ5KuY0XHDa/zwyEdlTA==
=ESJt
-----END PGP SIGNATURE-----

--UPj0B3lNfL0q7xgEYX1eJw0XejTiTpaBF--


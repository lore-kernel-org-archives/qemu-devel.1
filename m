Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDF1C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 759BA22CBB
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 759BA22CBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqbCi-00084n-MU
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 06:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36367)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hqbCY-0007gS-EC
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hqbCX-0004tz-GJ
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:42:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44030)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hqbCX-0004tR-7a
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:42:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so50188610wru.10
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 03:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=r0kPm7I8DujpEKhxNsK2lPbWbC/6EZ11RPdaUSbWD/8=;
 b=FTOTBjpRBecfxSiPFvm4C39nxYIGYAcDkMaEO0wvMKwwBREFToFehEfTjm0h5qzMO8
 7uVo9EWwSFCVR2ONMWf3U9IhVPlfxPcX8zMsRLaXB+FCGPX4g4THK5fEUpiX3uINMq3P
 89F+OXjv0xEebwuUvaNNuNxKeXr3VfDNnUuHSzIwwSaktL5OZ4hGnE1P8QkGhcOkI0Sk
 8gS02vbtZpCWP5F030NKsA2cwO1dRuALSB/J+3IAIUBGQWBIDxzl8+aiSJsc+lCCyeCp
 TawqX22Ebg+1RY7OB+yP/hMjGYbk1KhrjDUNEGWVO2Rg4WHdrJg9O5WcjdBCg0yh0UyB
 wtNw==
X-Gm-Message-State: APjAAAWkLUCysb8vxAwYAx5yJVsH851V/s40RXrDgDJzW41J2ehBMphq
 ieFlqgLZHQodANs7ZyOSdFsYV4oBYkQ=
X-Google-Smtp-Source: APXvYqx7Rvhoh29UY3aLBPYPDFj3jfOriHo875cpjMIcohDTMyJ2YSSmm5HVN6kPwl4XuUWBGpk67A==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr60794116wru.179.1564051339847; 
 Thu, 25 Jul 2019 03:42:19 -0700 (PDT)
Received: from dritchie.redhat.com (18.red-83-35-20.dynamicip.rima-tde.net.
 [83.35.20.18])
 by smtp.gmail.com with ESMTPSA id y2sm40083086wrl.4.2019.07.25.03.42.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 03:42:19 -0700 (PDT)
References: <20190702121106.28374-1-slp@redhat.com>
 <CAFEAcA-k76t9_TJnYSF_kocgba9dYMyf=Q6OBY2VVuhiWsbqrw@mail.gmail.com>
 <87a7dwnxwj.fsf@redhat.com>
 <CAFEAcA_XfRS1b-4ANmR5WLL=19Md6Dp7+M_FAK8pQAJn2MaCOA@mail.gmail.com>
 <20190702220400.GA13923@localhost>
 <20190725055908-mutt-send-email-mst@kernel.org>
 <CAFEAcA-uDtTFOyTwMY5KtWeqvirxDejQdvnx5OCZ8pyUhKhE+w@mail.gmail.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA-uDtTFOyTwMY5KtWeqvirxDejQdvnx5OCZ8pyUhKhE+w@mail.gmail.com>
Date: Thu, 25 Jul 2019 12:42:16 +0200
Message-ID: <87pnlymm47.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, maran.wilson@oracle.com,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 25 Jul 2019 at 10:59, Michael S. Tsirkin <mst@redhat.com> wrote:
>> OK so please start with adding virtio 1 support. Guest bits
>> have been ready for years now.
>
> I'd still rather we just used pci virtio. If pci isn't
> fast enough at startup, do something to make it faster...

Actually, removing PCI (and ACPI), is one of the main ways microvm has
to reduce not only boot time, but also the exposed surface and the
general footprint.

I think we need to discuss and settle whether using virtio-mmio (even if
maintained and upgraded to virtio 1) for a new machine type is
acceptable or not. Because if it isn't, we should probably just ditch
the whole microvm idea and move to something else.

Sergio.



--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl05h4gACgkQ9GknjS8M
AjUnbw//ToHji1kh/Ly4FNZGKGiqBhB1nxegw5b5sYQWLqmURWfFfsOLVNvRlJks
hWtyn4/cpY8eexCu7lNA9Zrog44eTUaIa1fSH8u3dLCx6gRHV1mArgevfKOcIfNL
PACPXOrG0trISeGsIpGvXoUSkdmp+nLomVEw6Ypxo3gY7VrmvjJO73nZHMS0zrwx
Z32hQK1YPr7mq15UWC5/WfBoa3vBL2bsor5BvB95oWDDfd2hRYpiXFjyFvaZYKzd
WGulMrq6lgqnOxM2KfDEj3/9xGIVWJzsMGmL6zs0/qZ0sutK7wpt1Kn+F9kLEeM1
/aUCk6zlc59SAExqWiq5qd36ncKGzrldyGL0DqwvFtOaB8U6xT75uSBZoQIIuZrl
p0tzWyQWoNOn1h7wXXzAvN2LnUQ03GNolde/DyCwn79eCSCS6kBlIAEBpQ0zzsf/
pCeLoLY3RhoBl/96qED5VgACNEKvKdnwaFntrmNyMQknMEcMP7rh46mIZQ6Gtytj
7UDUdIEVkYt14oXLSDoYFWv7Axxm4Jju8R7ueEbCyHF4G7GkkoD1MpAHsNZ+OQte
EUhSN78M2UiYFWlqcrlR9GeQkjGVHLOa/IFSE8VKQjBL20BIBzBKcUF/K+w5lTZg
E5G9tEcqQxgG31siq8mCjcUohvvwHjPfRGSfn7N/3j+Z+huI3Ws=
=CgQn
-----END PGP SIGNATURE-----
--=-=-=--


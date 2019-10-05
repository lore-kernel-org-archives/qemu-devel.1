Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC43FC47404
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 21:47:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7E34222C0
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 21:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E34222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGrta-0000kC-Rf
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 17:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iGrsU-0008LZ-JQ
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iGrsT-0000Ma-0A
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:46:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47904)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iGrsS-0000Li-ML
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:46:12 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A5A72C057E9F
 for <qemu-devel@nongnu.org>; Sat,  5 Oct 2019 21:46:10 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id k67so10685587qkc.3
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 14:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=w9cp5WOMnA8f6hUE+AzPrHfl7EdcqEtT+8UzwMy/tUA=;
 b=il2NCozM2BgZNSCoXOyUD9/1u7I9ZBtzO8ksaTe9GEpYqwgKqUpLlqIACCXN/rad7p
 l5O4KffA5oezO/bVlsDYGCTF/8akEBPVyQ0vsfg97DwdmqyEKhZdMUi4pgSSHGE5gTkS
 7RCQBjlsqE9HJNGRndBVzABZVpecrkUcdi/SB5UtaO65vuA9iMT1cbEY2u3Z/fnd0k3o
 WZr+GWartea9oqnCFUknLS2gi4S71/YWqapWRVBH7ssIOxwRzdAelU4FGv2OJmwHrslH
 j4aslr7pqg6iyX6nAz/R/LVipiz4DHYTNzX72euhmEvkZiQu+GfhMfuYxlFYaCF04nv1
 u2lQ==
X-Gm-Message-State: APjAAAWmjtaXfXby5B3fEJyr0aJ5rb87kEFdD/QxZw/WOQJRPBVFAYTF
 ZeV22LVBpAkQ/6QznpYgeLbr3v1+kW4YDRqB4vFZ7tnK+sbyhYLDJypbsJrI6eVPj6f38sbjLd2
 fME1mleBq4hYuSWk=
X-Received: by 2002:ad4:5572:: with SMTP id w18mr20866503qvy.220.1570311969972; 
 Sat, 05 Oct 2019 14:46:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyzUVmREyQGN2ebE9/p5KmnrPF3x0+kP/8mY6eUlFiD+kv5Ek7D6K1h7KzdijPfyFqbMnb4xA==
X-Received: by 2002:ad4:5572:: with SMTP id w18mr20866481qvy.220.1570311969747; 
 Sat, 05 Oct 2019 14:46:09 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 i30sm7337786qte.27.2019.10.05.14.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 14:46:09 -0700 (PDT)
Date: Sat, 5 Oct 2019 17:46:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 00/11] hw: Convert various reset() handler to DeviceReset
Message-ID: <20191005174531-mutt-send-email-mst@kernel.org>
References: <20190926151733.25349-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190926151733.25349-1-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 26, 2019 at 05:17:22PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Hi.
>=20
> Following the thread discussion between Peter/Markus/Damien about
> reset handlers:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg617103.html
> I started to remove qemu_register_reset() calls from few qdevified
> devices (the trivial ones).
>=20
> Regards,
>=20
> Phil.

How do you want these patches merged? Trivial tree?

> Philippe Mathieu-Daud=E9 (11):
>   hw/acpi/piix4: Convert reset handler to DeviceReset
>   hw/ide/piix: Convert reset handler to DeviceReset
>   hw/isa/piix4: Convert reset handler to DeviceReset
>   hw/pci-host/piix: Convert reset handler to DeviceReset
>   hw/ide/sii3112: Convert reset handler to DeviceReset
>   hw/ide/via82c: Convert reset handler to DeviceReset
>   hw/isa/vt82c686: Convert reset handler to DeviceReset
>   hw/input/lm832x: Convert reset handler to DeviceReset
>   hw/pci-host/bonito: Convert reset handler to DeviceReset
>   hw/timer/etraxfs: Convert reset handler to DeviceReset
>   hw/misc/vmcoreinfo: Convert reset handler to DeviceReset
>=20
>  hw/acpi/piix4.c          |  7 +++----
>  hw/ide/piix.c            |  8 +++-----
>  hw/ide/sii3112.c         |  7 +++----
>  hw/ide/via.c             | 10 ++++------
>  hw/input/lm832x.c        | 12 +++++-------
>  hw/isa/piix4.c           |  7 +++----
>  hw/isa/vt82c686.c        | 11 ++++-------
>  hw/misc/vmcoreinfo.c     |  5 ++---
>  hw/pci-host/bonito.c     |  8 +++-----
>  hw/pci-host/piix.c       |  8 +++-----
>  hw/timer/etraxfs_timer.c |  7 +++----
>  11 files changed, 36 insertions(+), 54 deletions(-)
>=20
> --=20
> 2.20.1


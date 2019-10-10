Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7975BC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 09:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 501102054F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 09:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501102054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIVCi-0008Te-EJ
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 05:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39977)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iIVBy-00084T-Gx
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 05:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iIVBw-00013A-Lr
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 05:57:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37526)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iIVBw-00012r-DX
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 05:57:04 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0AB96C05686D
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 09:57:03 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id e13so5180294qto.18
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 02:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=xiYGZT9D5cTpzWz2K294XkiUlw689RxLq9ECq1TIB7o=;
 b=smzkGicR5VsQ4r99hO8DIN5vG1wYvkoK31SbFLrcHrIL31GiCgbk0tFXmctxpBFt2b
 HVzvkhQiArOLiaJOqGPmfv16kMWaSV5BUeHynpnRTZ9e5SfcA8EVHQWplpptmJ2FIMPZ
 Jve9AJEiaf8G7aKeZ0Hf8oUFjG/u/fMPIaG/x7RlTGNEhO0pmU5Bf0Y35E3pGZQVF7xR
 ENvqifuv6VBry/ymkSogLSqu0nILmSYS333pY80mSpdVL44ZSG8qu+yCvN8w1RKAhMpe
 ZslCyLTW96Jazz5H8QrmPWbts/ctJM6g+1q+sFXGOWLYfsRdJH4ZMXrsnohrkulw/BiV
 8j9Q==
X-Gm-Message-State: APjAAAW9klfNsssubC44aK76H0HZtap5vYTOaD8EldXTKfa80a2jWO4h
 vqVa6SHJH/CWFLUMbc99RNkwvQH7yT9fin2Sfi56Viiy1/LEL6i0ZZZesFHoN2SWkYUiQnDKfEc
 fr09Fnh7Q38hUGUg=
X-Received: by 2002:a37:8b01:: with SMTP id n1mr8419529qkd.315.1570701422309; 
 Thu, 10 Oct 2019 02:57:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw2vjwOozRNAEQeffYbfdfILjDAZXdMmteul5S8WQDf0vyIcOtoQrsy6WaG8DBIhZ7wUGy2UA==
X-Received: by 2002:a37:8b01:: with SMTP id n1mr8419517qkd.315.1570701422033; 
 Thu, 10 Oct 2019 02:57:02 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 w2sm2851253qtc.59.2019.10.10.02.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2019 02:57:01 -0700 (PDT)
Date: Thu, 10 Oct 2019 05:56:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [RFC 0/3] acpi: cphp: add CPHP_GET_CPU_ID_CMD command to cpu
 hotplug MMIO interface
Message-ID: <20191010055356-mutt-send-email-mst@kernel.org>
References: <20191009132252.17860-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191009132252.17860-1-imammedo@redhat.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 09, 2019 at 09:22:49AM -0400, Igor Mammedov wrote:
> As an alternative to passing to firmware topology info via new fwcfg fi=
les
> so it could recreate APIC IDs based on it and order CPUs are enumerated=
,
>=20
> extend CPU hotplug interface to return APIC ID as response to the new c=
ommand
> CPHP_GET_CPU_ID_CMD.

One big piece missing here is motivation:
Who's going to use this interface?

So far CPU hotplug was used by the ACPI, so we didn't
really commit to a fixed interface too strongly.

Is this a replacement to Laszlo's fw cfg interface?
If yes is the idea that OVMF going to depend on CPU hotplug directly then=
?
It does not depend on it now, does it?

If answers to all of the above is yes, then I don't really like it: it
is better to keep all paravirt stuff in one place, namely in fw cfg.



>=20
> CC: Laszlo Ersek <lersek@redhat.com>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: "Michael S. Tsirkin" <mst@redhat.com>
> CC: Gerd Hoffmann <kraxel@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> CC: Richard Henderson <rth@twiddle.net>
> =20
> Igor Mammedov (3):
>   acpi: cpuhp: fix 'Command data' description is spec
>   acpi: cpuhp: add typical usecases into spec
>   acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command
>=20
>  docs/specs/acpi_cpu_hotplug.txt | 37 ++++++++++++++++++++++++++++++---
>  hw/acpi/cpu.c                   | 15 +++++++++++++
>  hw/acpi/trace-events            |  1 +
>  3 files changed, 50 insertions(+), 3 deletions(-)
>=20
> --=20
> 2.18.1


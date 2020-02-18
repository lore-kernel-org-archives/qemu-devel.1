Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9943C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85188206E2
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jsryhc4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85188206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zP5-0000Ew-O9
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:42:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3zOJ-0007od-U2
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:42:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3zOI-0004oc-Or
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:42:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48487
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3zOI-0004oM-LA
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:42:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582018926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2lRg00utCoXLvEMHvhnMiAsgpOV7NsemGMGxrPmPJgc=;
 b=Jsryhc4ITHL/kbxAtkDNy18X1j9G9xfZUUBu+fIxmT7SjbmEmfu37w1UyV2k3kBlLl9s8s
 sgVqqi5SNZc9WyEQGkN6rvs2A3vlLzAsVm4pw/Ve9uZJt6TeQxDb+3Ok5WuQd8xs9v3F9E
 hwVvCFlFOpGY/PMtJDWniJWPLmI5iqo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-kcGebbr2NFaeg_hdl3zYeQ-1; Tue, 18 Feb 2020 04:42:02 -0500
Received: by mail-wr1-f71.google.com with SMTP id z15so10557527wrw.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 01:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=66Ntbv0X0m09s77Ux7unmL4nTH6VUea47MP7vHegJxA=;
 b=kXyIYkK408wuiy63foBCrQqYnxlwi0wznuURMi3SIrqz1rboZalTmftHAH3GW+zrLw
 hAtMVvDLs0Db5iwuQjgp2QJrm4nSkdRoln+YoCFHwD7ID2bUYhGW7J8fzYHM+UsIJ8mt
 JSIGWFhzGVHySB67/fbgI/pynpgycEyQsqhcyG0K0ZIgSCGqhSuLD5XbgP5PboHyrgSe
 VzNZnFmfhKeoo72wD5rFuk7BL5ouV42bX8iD60MBe4vfxQ6+8dQIMzYE5RNE0u8Sku/G
 w5v5wZo2ocJKSiOD57YjGNcti5iXfRZDxdY4S7Iq44UlEoDN30DtCxMF3bM3MtmPlnbx
 +dpg==
X-Gm-Message-State: APjAAAWeiIC9m6bMmryLd3wqh/f+O6LXD8xYuei7sWkiFsqYFbhnkv42
 zxCQMFCOz/ED786t61/u38uDh5nSpt5DArmvYiMrY+nQsKgq4a9LhfYDPgN1CwW76A9jzoa3CgV
 A3EVtiwMFSNBb8vA=
X-Received: by 2002:adf:e2cf:: with SMTP id d15mr28157526wrj.225.1582018921240; 
 Tue, 18 Feb 2020 01:42:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqw2AXJ0thpIvO2iOxXU/Y1Ab6veD5kV027akG5IebpocALy21A7cS6wXnpbaAx2Ep9UdEk3dw==
X-Received: by 2002:adf:e2cf:: with SMTP id d15mr28157498wrj.225.1582018921011; 
 Tue, 18 Feb 2020 01:42:01 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id g21sm2788515wmh.17.2020.02.18.01.41.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 01:42:00 -0800 (PST)
Subject: Re: [PATCH 00/13] trivial: Detect and remove superfluous semicolons
 in C code
To: qemu-devel@nongnu.org
References: <20200218093720.25640-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f4133050-49ad-f517-740b-1460e88ed79e@redhat.com>
Date: Tue, 18 Feb 2020 10:41:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218093720.25640-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: kcGebbr2NFaeg_hdl3zYeQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Julia Suvorova <jusual@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/18/20 10:37 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Luc noticed a superfluous trailing semicolon:
> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg04593.html
>=20
> Prevent that by modifying checkpatch.pl and clean the codebase.
>=20
> Philippe Mathieu-Daud=C3=A9 (13):
>    scripts/checkpatch.pl: Detect superfluous semicolon in C code
>    audio/alsaaudio: Remove superfluous semicolons
>    block: Remove superfluous semicolons
>    block/io_uring: Remove superfluous semicolon
>    hw/arm/xlnx-versal: Remove superfluous semicolon
>    hw/m68k/next-cube: Remove superfluous semicolon
>    hw/scsi/esp: Remove superfluous semicolon
>    hw/vfio/display: Remove superfluous semicolon
>    migration/multifd: Remove superfluous semicolon
>    ui/input-barrier: Remove superfluous semicolon
>    target/i386/whpx: Remove superfluous semicolon
>    tests/qtest/libqos/qgraph: Remove superfluous semicolons
>    contrib/rdmacm-mux: Remove superfluous semicolon

Please ignore this incomplete series, git-send-email aborted again:

Sent [PATCH 00/13] trivial: Detect and remove superfluous semicolons in=20
C code
Sent [PATCH 01/13] scripts/checkpatch.pl: Detect superfluous semicolon=20
in C code
5.5.2 Syntax error. v8sm5146891wrw.2 - gsmtp

Offending recipient is: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gm=
ail.com> which=20
probably needs quoting.



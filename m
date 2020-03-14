Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BA2C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 18:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF3820784
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 18:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1nK+wEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF3820784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDBWH-0002qy-I1
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 14:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jDBVj-0002SX-1m
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 14:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jDBVh-00079t-LD
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 14:27:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40495
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jDBVh-00077w-GG
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 14:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584210465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1KkC3J2vHT5ODGQByAOEXWwJj6vw8GW2WGOXF7v633c=;
 b=B1nK+wEtiTsTW/I+KpqTNBeoN7tg6uZQRVcAWxBNwSwpboBZoEnDiE+V1wmxm0XTHoSIU/
 lj6uDD/PTwrgl+65aJ4LySU+XO4E6Mu1vxHnCLwJIzgWi47xFyKz51JhhbtYm8SofanS/h
 hkZeHo9H4+vylajgEXNxnCrBBVmwajg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-MBXO8376NY2lh3NjO11Hkg-1; Sat, 14 Mar 2020 14:27:40 -0400
X-MC-Unique: MBXO8376NY2lh3NjO11Hkg-1
Received: by mail-wm1-f72.google.com with SMTP id z26so4050205wmk.1
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 11:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2StV+w+XHy2WUEiTo1l/BRbato+66GHf31YhceTJyFk=;
 b=sE6Zc/OjoSgX3/JxayVR3htSecvYFEMpTfbhnNCDOwf+ysiOSv7M7BpuiAYuU6dwBI
 mflIfSeu2wj1fYBAx0KZpw0yL3x5q+xAMB5JtsNlf4ZhmdJ2nA5pwA+xMD0w77ItQtT/
 xt8qLq0m33MyvAly/sxL51sjcGADfoLRzanpyo2E6zFWmSIIjXhIoCmzBADQYt+87L5x
 alXbtjDMNvgrxQcjLRBE4CZ3Z22VYpA5na+93iqYUnmf33Tp0rCia8kZcoZ2MCd6vY2c
 o7kU5VTKV91Pb4YeTyyU9TZXVp4fj0Uus9m89nigKgbmEbi8mBYzsFmqD9mV8PluCSXK
 57cg==
X-Gm-Message-State: ANhLgQ21yd2XmXV2ZDR+soQ8USm9WX5aVYOf5xP9PWHbwv20uyDnVsqe
 K1GYRcGm3yVJqP/lyvPrPO+w9t4I00/5X/jZDP1lXkAcPwJL3D7Q56+AIbqN+bjG9Q7GuZgZB7w
 rzTfqR9ztiWX6gY4=
X-Received: by 2002:adf:f58f:: with SMTP id f15mr26375714wro.16.1584210458712; 
 Sat, 14 Mar 2020 11:27:38 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvv3oYC786lvL7eiKhVpE7gCtgMJeWpCeiQDZ3pDZPGE+j8vVoDWg1bPniYnGQ0wAfCSppGdQ==
X-Received: by 2002:adf:f58f:: with SMTP id f15mr26375695wro.16.1584210458475; 
 Sat, 14 Mar 2020 11:27:38 -0700 (PDT)
Received: from redhat.com (bzq-79-180-7-202.red.bezeqint.net. [79.180.7.202])
 by smtp.gmail.com with ESMTPSA id
 l8sm22696256wmj.2.2020.03.14.11.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2020 11:27:37 -0700 (PDT)
Date: Sat, 14 Mar 2020 14:27:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/3]: acpi: Add Windows ACPI Emulated Device Table
 (WAET)
Message-ID: <20200314142708-mutt-send-email-mst@kernel.org>
References: <20200313145009.144820-1-liran.alon@oracle.com>
 <158411510863.16773.11681485784155170393@39012742ff91>
MIME-Version: 1.0
In-Reply-To: <158411510863.16773.11681485784155170393@39012742ff91>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pbonzini@redhat.com, rth@twiddle.net, liran.alon@oracle.com,
 ehabkost@redhat.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 13, 2020 at 08:58:30AM -0700, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200313145009.144820-1-liran.alon@=
oracle.com/
>=20
>=20
>=20
> Hi,
>=20
> This series seems to have some coding style problems. See output below fo=
r
> more information:
>=20
> Subject: [PATCH v2 0/3]: acpi: Add Windows ACPI Emulated Device Table (WA=
ET)
> Message-id: 20200313145009.144820-1-liran.alon@oracle.com
> Type: series
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> e9129fb acpi: unit-test: Update WAET ACPI Table expected binaries
> 76eaa7a acpi: Add Windows ACPI Emulated Device Table (WAET)
> 041dfae acpi: unit-test: Ignore diff in WAET ACPI table
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> 1/3 Checking commit 041dfaefd37e (acpi: unit-test: Ignore diff in WAET AC=
PI table)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #17:=20
> new file mode 100644
>=20
> total: 0 errors, 1 warnings, 3 lines checked
>=20
> Patch 1/3 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 2/3 Checking commit 76eaa7ac6ef4 (acpi: Add Windows ACPI Emulated Device =
Table (WAET))
> ERROR: line over 90 characters
> #43: FILE: hw/i386/acpi-build.c:2520:
> + * Spec: http://download.microsoft.com/download/7/E/7/7E7662CF-CBEA-470B=
-A97E-CE7CE0D98DC2/WAET.docx
>=20
> WARNING: Block comments use a leading /* on a separate line
> #61: FILE: hw/i386/acpi-build.c:2538:
> +    build_append_int_noprefix(table_data, 1 << 1 /* ACPI PM timer good *=
/, 4);

Looks like a false positive - this is not a block comment.
What's going on?


> total: 1 errors, 1 warnings, 43 lines checked
>=20
> Patch 2/3 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> 3/3 Checking commit e9129fbd5cf2 (acpi: unit-test: Update WAET ACPI Table=
 expected binaries)
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 1
>=20
>=20
> The full log is available at
> http://patchew.org/logs/20200313145009.144820-1-liran.alon@oracle.com/tes=
ting.checkpatch/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com



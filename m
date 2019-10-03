Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96769C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 11:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D26721A4C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 11:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D26721A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFz7j-0003t2-E3
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 07:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iFz6K-0002pH-Mm
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 07:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iFz6J-0006y0-Ks
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 07:16:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37016)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iFz6J-0006xN-CT
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 07:16:51 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7FEA181DF1
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 11:16:50 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id h6so971562wrh.6
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 04:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=XZHTG2NxI/sCv5/Vz+QMeAuSBRiTvi9dmDnddP+vhz0=;
 b=Kz4I5eaTWEWyqtWtt4TwgOZuKYKQkZj/zkP0geaYe6gvEY8aUMlwH3ycWL3OUw6JZb
 VQOYzljMlfXfCm8A5sZjUDvY0C6yQZXbiy8bB/rXQtVyOSHDVJ6L0a/vPZ66IStKzovI
 X7uYNSqQ8U448fjLeHDLV/cyFJNemzM3+HCiJ8JvkRHs3NuiE0DHzz7A/xeRHqWpmURZ
 /MpZim1ij1+Bm1Q9um8gpjX2DB11FTXbVqJPCehmoOZsmYX5HCM0puFjktM5KAkzCiDn
 WnAHN6bQhkuqzcV+g1L2npvCD6n6+soaEzMtGDRh+qRh1pqS4NClCoeUZBnvjeKe8qkH
 ea1Q==
X-Gm-Message-State: APjAAAWpho4aj4qAL79048QVF8P48fjoUtVq8Ze/kgUcqiEV/3GHlj5c
 JxGXeSYcp7EsgnmfT5qjQrtvIk/TwvYbzdOWrJFDEwYtRuFd7W0y7Vt+/NdTEWAPungaRs55ZqC
 i/LTrwGkra66C+lU=
X-Received: by 2002:a05:600c:2290:: with SMTP id
 16mr6253900wmf.161.1570101409228; 
 Thu, 03 Oct 2019 04:16:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwCP9a2nToaiM4T3zzq7m2edEM72zdzo9W0uTp/Tw27Y99z/KWTt6FtlNOsO0iC+LqIWsF/jw==
X-Received: by 2002:a05:600c:2290:: with SMTP id
 16mr6253879wmf.161.1570101409030; 
 Thu, 03 Oct 2019 04:16:49 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id c18sm2142859wrv.10.2019.10.03.04.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2019 04:16:48 -0700 (PDT)
References: <20191002113103.45023-1-slp@redhat.com>
 <20191002113103.45023-9-slp@redhat.com> <87lfu2i1mh.fsf@redhat.com>
 <59b1b371-f0f3-de63-6cac-dbb86e17c1d1@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 08/10] roms: add microvm-bios (qboot) as binary and git
 submodule
In-reply-to: <59b1b371-f0f3-de63-6cac-dbb86e17c1d1@redhat.com>
Date: Thu, 03 Oct 2019 13:16:46 +0200
Message-ID: <87h84qhye9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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
Cc: Peter Maydell <peter.maydell@linaro.org>, ehabkost@redhat.com,
 mst@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 imammedo@redhat.com, sgarzare@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 03/10/19 12:07, Sergio Lopez wrote:
>>=20
>>> qboot is a minimalist x86 firmware for booting Linux kernels. It does
>>> the mininum amount of work required for the task, and it's able to
>>> boot both PVH images and bzImages without relying on option roms.
>> I've just noticed all other submodules refer to mirrors hosted in
>> git.qemu.org. What's our policy regarding this submodules? Can we add a
>> reference to an external repo or should I somehow request a mirror in
>> the aforementioned repo?
>
> We usually start with an external repo and then sooner or later change
> it to a mirror on qemu.org.

OK, good to know.

Thanks,
Sergio.



--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2V2J4ACgkQ9GknjS8M
AjXjsxAAnAq+HWHQtLRd0tM7ce85EXsX8wmOZ2OecBiRrJ10Pr3vwrzAw+gL5KOr
k4fRlJDRn2psKC0LRJwOQfXRXL4BF8Buhm8P50d7zP7L97WV2SnutEIaIn2zqpj+
WcYVVBh9pBSAJeCOeUdSgbM8BwWbZzeTzB60r5UO+bwjYaJrKIFvchmVOP4XNDxj
dm2gzEpTzk3Brcui3zTsnbwBjUuSEbzUmXHlrWoDdx8Wd7RHKh422jlCfmM2Oive
4Hf3vbe4vQWRCgGwDa9bJQ2LEmqIVPrgNrlWyBDaKobhZtBVSNlWQ6BTsfSZFPBI
cCHO6w53xBsBoxG/NvFJa8weFJ9cYPJnYbbdU1mmyty+V6vruei9zUdigub07CZU
oO/LR3uWQvON52RDcdQ1blX1CHRTAA95/pM8TGJZ0EiltUVntrgDg8a3DUFd4W4d
BCmU2QwnuM/2lAunm7/FpL8afWVcTWAYqy8OEk0yGsZmbGifF/D1S/iRZyNgWYlI
yVaeZFA/u+c+MUNqVgQ6yhcPJeexMfpsD1W7YgbTgwhsWGpbOvIpEoKlXfqWzULg
pTGIrcUqPQKexqQkkgFNkViIMI24pDPYJG3hsIqttEnUyrnAto0BarTV3bhrnwBb
jvT7RSKDMKvtJRNZ6MRBMSgo3+gDdgCwhORrWOG9ulqeuY5cyuM=
=SFXl
-----END PGP SIGNATURE-----
--=-=-=--


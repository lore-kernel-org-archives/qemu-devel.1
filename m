Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA993C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 20:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304452145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 20:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=livius-net.20150623.gappssmtp.com header.i=@livius-net.20150623.gappssmtp.com header.b="lvlYS/BH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304452145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=livius.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG6Tn-0004Sq-Uy
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 16:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1kG6T4-00042Z-P5
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 16:13:23 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b]:41938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1kG6T2-0002sc-Ul
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 16:13:22 -0400
Received: by mail-ed1-x52b.google.com with SMTP id ay8so3960324edb.8
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 13:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=9MlREy7L3QFhB60t2LA0WP1Jgs6suM8MmKPscakz4co=;
 b=lvlYS/BHg1hW7m16s1OYeBWOy/92FwKZxfUQC9+AguyzQ4NdfBDPmlNR/qXC8COmW4
 ej7W2gtqTnhjVgq+roxYGTQHDprspYsBhlvMmrgC95An4BDbNeQnGAcTbToHlQCXM2tr
 xo+h9zDkOCstf1b5GSmEl1vRQ4bZ8+RRmlR1bQihI0KlCg44f6zH9HoOahwalDLv4yKZ
 aDaNzfae14BPIxyP+UQO7/F8bpjOqipT12YqdNorvet9fy5HBakBXHIr1hmXie11QMBc
 ZbcZRmlkjuOcz70RZ0rLNwDrLFxvwJxqFgNtiP+KbjtgEsWpVk42T3F8w0frmoIgHbuE
 Da0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=9MlREy7L3QFhB60t2LA0WP1Jgs6suM8MmKPscakz4co=;
 b=I+cVp757qPlgiy1MgrpOUxUnzlhWknEvVXQ7cheby0+hseT95wF+cpuV9L9QbsPEFA
 pcdZjFbtLRr6DVRLJ4d16ze0u8775XbGA4GknsPjtMvQzFvCyr5BTSqQGJsOtGj/OGfy
 zOAiBaTtqtFqsbAhaqll+AwLH08/uofwjc99WkKN8escFTNL5Tu1/1cNVlxJ3J2db2xw
 6O5eiTosC6hehl4CJyWJPXfS7plW/e4L7lAknL6YAQUnsnQ5HETWV/HuQAP1fcXwZs9r
 Gdzi4aoGoC6AAc7bvhzKl0b6TNrC7gIVXYknnO6GJ9ZOvqZDJZun5YyYuwXv9JC/Or6P
 L38A==
X-Gm-Message-State: AOAM533x4mtI7VztTKhCbMt6IFoTUHAFNCC8IMIKPLjCaEbXpPnBN7jZ
 iMd+iv2EwF0tmZaCy//CJ8I4zg==
X-Google-Smtp-Source: ABdhPJzu5h1VCfKlgl/Wo2hHx8CMQgo05jNGBWucgHGskqM7I1B+hYlwlxM56D0ZCd+OWXM43AilzA==
X-Received: by 2002:a05:6402:1656:: with SMTP id
 s22mr6158642edx.160.1599682399135; 
 Wed, 09 Sep 2020 13:13:19 -0700 (PDT)
Received: from wks.local ([86.120.181.246])
 by smtp.gmail.com with ESMTPSA id w1sm3700222eds.18.2020.09.09.13.13.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Sep 2020 13:13:18 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [RFC] QEMU as Xcode project on macOS
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <CAFEAcA9m6Qd1C2EXHKBfVrq_bd_AJo8ggf0t02bLufkmT5jZ=w@mail.gmail.com>
Date: Wed, 9 Sep 2020 23:13:17 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <F0F8F9BF-0B9F-430E-8381-87AD6B3077C8@livius.net>
References: <2764135.D4k31Gy3CM@silver> <13443969.F0S6BcH2UH@silver>
 <20200909181355.GV1011023@redhat.com> <1695914.5EixHECA2G@silver>
 <CAFEAcA9m6Qd1C2EXHKBfVrq_bd_AJo8ggf0t02bLufkmT5jZ=w@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Received-SPF: none client-ip=2a00:1450:4864:20::52b;
 envelope-from=ilg@livius.net; helo=mail-ed1-x52b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 QEMU Developers <qemu-devel@nongnu.org>, G 3 <programmingkidx@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 9 Sep 2020, at 22:16, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> ... You still need a Python 3.5 or better for the other scripts
> QEMU has as part of its build process, so you will still
> need a python other than the Apple /usr/bin/python to build
> even if you have a standalone meson with its own python.

Ah, sure, if the build script uses Python for other purposes you'll need =
one, but the embedded Python will allow the standalone meson to run =
properly regardless of what Python you install.

One less dependency to worry about is usually a good thing.


Regards,

Liviu



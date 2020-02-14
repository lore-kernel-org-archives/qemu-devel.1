Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4202C3B1B2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:02:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8038B20848
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HbPWbvur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8038B20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fHz-0008G3-J5
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1j2fGb-0006Sx-Fn
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:00:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1j2fGa-0002Gk-HT
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:00:41 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:36430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1j2fGa-0002FT-AO
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:00:40 -0500
Received: by mail-lj1-x242.google.com with SMTP id r19so11689675ljg.3
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3toDS6zflbiY4DczInEVMl4zblVU+HqLGz3G1OH81aE=;
 b=HbPWbvurxe462B8aTfwC0111uPpnI0csQOSB6toL76D9P9oTX4Zh1qa+CwGsc534Sk
 JVw6XD4juT9GvY7awFVUD5wBpJW1+NpJ3qh1TOCnf0kTGjZXbjJM6aTdMSnKE4D2Y7ny
 uGVRQCb6nL340KjQu5fLwjf3pdvjenBYOMD1AK5GWGnTVjhy+wq7ba2QmfKFs1XU2S0S
 NZPTII7NGicE/dAkT+reL8EuYGU525vMBvNkB3Vfn2petSe+8YsBGeP2MBZZH9OPKiND
 qbiYItWLebiwOBYiirOwmALqT942WP9VmX5q+FKRuZJr2M4XHdM6P2Ez7WpyKbXSnCw8
 s7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3toDS6zflbiY4DczInEVMl4zblVU+HqLGz3G1OH81aE=;
 b=Hg7KQRLXn7mT9y1f3IAvmDEfLlhIxPYsgJxAYYI4Rq153Nh0Q/KNnP2d51DrxFj19F
 QIjAWswLxxle72dVK8bFiUEW6wDyKV/WO4Mh5mRattK9kBgkEWStPP4sJs+b9ODGQgcS
 kaybwqKhXlb5N5e/ELGDlQPRG1PwJ7wFYcOi5avfJrbdh9mvaFNxxG5xWCNW5TGmuJ5i
 YbElsSW0rWjWfsob6H/5IA+wR0SwZ5xxD8K+eY/ozBxLqsvI7R5Fc9P+zGfOm6QUQ0Dp
 X3gF/1ZpZjmPqL1yukkm19YM0avcPH8PUFX3Xbf/pfCyv/AnlG1RwVnfQq0SYaNuINV6
 H0Pw==
X-Gm-Message-State: APjAAAXDaC4yL5D8mei6RGU1SMLkYwYYiesRrsU8dWxhLhMwCPx5eago
 LPM6REoAOlWJpi4krRMGXN2f0O+xuAblncie1V7vWw==
X-Google-Smtp-Source: APXvYqw43m7+ojC28mW53Ftx9dMBXRGhVo5jp7lBX3TvYCi4mSv7uuAbducyyic9gcvVzIGZrT1KUDweA+o86wE0E+8=
X-Received: by 2002:a2e:9744:: with SMTP id f4mr2981207ljj.267.1581703238513; 
 Fri, 14 Feb 2020 10:00:38 -0800 (PST)
MIME-Version: 1.0
References: <20200205212920.467-1-robert.foley@linaro.org>
 <20200205212920.467-9-robert.foley@linaro.org>
 <87r1yxp0t6.fsf@linaro.org>
In-Reply-To: <87r1yxp0t6.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Fri, 14 Feb 2020 13:00:03 -0500
Message-ID: <CAEyhzFu8GhRKWU-HAxq8wxKy9Mo-=hKRvzCtuZFBUX+352ROng@mail.gmail.com>
Subject: Re: [PATCH v1 08/14] tests/vm: Added configuration file support
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: fam@euphon.net, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 at 11:54, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> >  from socket_thread import SocketThread
> > +import yaml
>
> So this throws my setup on my Gentoo SynQuacer. Is this meant to be in
> the standard library or is this a separate dependency?
>
This is a separate dependency.  On Ubuntu the package is python3-yaml.
This brings up an interesting point.
If the yaml dependency is not there, should we expect to gracefully
handle this in the python script, and
simply not allow yaml files?  I suppose we could error out if a yaml
file is supplied
and ask for the dependency to get installed.
Or is there something we should do earlier, maybe in the configure, to
warn or error about the missing
dependency?

Thanks & Regards,
-Rob


> --
> Alex Benn=C3=A9e


Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B0EC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD92C2078E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=livius-net.20150623.gappssmtp.com header.i=@livius-net.20150623.gappssmtp.com header.b="TrJ9VNpy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD92C2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=livius.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJin-000856-Sb
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1kGJiG-0007eF-2b
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:21:56 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f]:42394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1kGJiE-0001NJ-A8
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:21:55 -0400
Received: by mail-ej1-x62f.google.com with SMTP id q13so7883920ejo.9
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 03:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=SujVWcvMzIXiXIMI4TBXgOHM5sANwhKYyHMj51H/WBc=;
 b=TrJ9VNpyk6rXoNOqL3Ck8QaWB9HFKA1Zbjx7LRwFQxTWAtiWJ27RyMOxrWhZihcISA
 zC+UGTg8cl8wZ2Z6iJlIKWNa5gFcpfnRfoW683YggxoTf3cKXAUElphEjNuW8+x3l/fR
 /FTO2Tl43wZegN1SHKY7K73OYIb7kbdw0mzof6xhTdrflqXCnmwInwQNrewOG3HEOEop
 kWD8JEHVfwNzdWIOU7i2yGX/vtDfEXhNejXRHG//11If3eeVbxBCiaz6CHGxZlYkbk5P
 FtX0beyy5mzu484YTxLiHzZtKYrnj2jwFYCPy06zfD86If7KgW9+Ues3qzBXJAHgpBet
 dSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=SujVWcvMzIXiXIMI4TBXgOHM5sANwhKYyHMj51H/WBc=;
 b=GlHSF0hE8cleFH0fX8aqLI+pInEsq5ecOPPekizROhChLugy01Jzs1GyMLMiP7q18T
 TcWMMUG2HcGMFBNnSy/SFB9AoQrOKmlCG95MhahvgD/JFcII3VaaFSp2XqgIqPVoFJBi
 J0RmW07Gz4EM6vS2rIKLnUfjE4GsSPkbXRQzWlD5ObmvFD4/SDWjEMjjMms0jjizJHln
 93kbsuVbrtvoo/R2UuH0Q2m3aQQ0wcEVlyWH7YxZRAdSKGh+irC2TlGOTli/Ug2WlCsY
 +srlfxteXc+8IAYGVFx6czlGVY2+EPexaP3cuGXOczWgfmcj/Ut7iCF91cT8oKdAFfVA
 Gk9w==
X-Gm-Message-State: AOAM532VRpOKDAOQxEJ1VYDsTJpE+VrIG2vsZ9S7PUn6MOlnc19j8iAt
 xjmRWOz1rUNkpSUhK5n72L0HtQ==
X-Google-Smtp-Source: ABdhPJwk8AZXkJ1CaKesbNb3KfOzg0pCS3C4DpkOkLXes8OYvDm2tQD16E1QiPJ15VtrzhSyDn81FQ==
X-Received: by 2002:a17:906:b813:: with SMTP id
 dv19mr7847707ejb.70.1599733312649; 
 Thu, 10 Sep 2020 03:21:52 -0700 (PDT)
Received: from wks.local ([86.120.181.246])
 by smtp.gmail.com with ESMTPSA id s7sm6272426ejd.103.2020.09.10.03.21.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Sep 2020 03:21:51 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [RFC] QEMU as Xcode project on macOS
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <8640871f-366c-e7a9-549a-8403c36c5a0b@redhat.com>
Date: Thu, 10 Sep 2020 13:21:50 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <0E642A74-0472-47F7-A01F-FD776082B6D0@livius.net>
References: <2764135.D4k31Gy3CM@silver> <13443969.F0S6BcH2UH@silver>
 <20200909181355.GV1011023@redhat.com> <1695914.5EixHECA2G@silver>
 <CAFEAcA9m6Qd1C2EXHKBfVrq_bd_AJo8ggf0t02bLufkmT5jZ=w@mail.gmail.com>
 <F0F8F9BF-0B9F-430E-8381-87AD6B3077C8@livius.net>
 <8640871f-366c-e7a9-549a-8403c36c5a0b@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Received-SPF: none client-ip=2a00:1450:4864:20::62f;
 envelope-from=ilg@livius.net; helo=mail-ej1-x62f.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 QEMU Developers <qemu-devel@nongnu.org>, G 3 <programmingkidx@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 10 Sep 2020, at 12:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
>  --python=3D/path/to/python3 --meson=3Dinternal
>=20
> and the build will automatically use that same Python executable to =
run
> the scripts.

Ok, good to know.

My standalone meson is intended for integration into Eclipse and Visual =
Studio Code, and should also run on CI servers, so it has a different =
audience.

Regards,

Liviu



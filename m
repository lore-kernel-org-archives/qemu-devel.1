Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB6BC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:46:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CB5921D46
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=livius-net.20150623.gappssmtp.com header.i=@livius-net.20150623.gappssmtp.com header.b="VCniAHAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB5921D46
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=livius.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG4AY-0001p9-5I
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 13:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1kG49e-0001BF-3g
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 13:45:10 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:34879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1kG49c-0007ZR-2P
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 13:45:09 -0400
Received: by mail-ej1-x62a.google.com with SMTP id u21so4814796eja.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 10:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=GDKayPzz0I+V7wMlamDrFZZ5hlW9UKS/t7IcmxyQVfQ=;
 b=VCniAHAOFjw+iSoo9FoCeSAH35fDI6B+SIKixZpZk2JdPpiR/w6nsf7t/3jK1eEvRE
 8jFfjRN1nReAKbHMwa9EuZKz+gNVXGeTsr/DDvcM3XFCjepPwyYbf24u5Lfdp3nRclfy
 4S9Q1bNV++OKnXVkdGtC8q4To075RlrnP0lpW4oVQEMZa5bRFZkESw0SPAndbl94aIJU
 qITJYGlXjwPw/IMAbQjbbsypByVHsYfFJv0q7VGQwyIdZnKKyXS3iNfP7vWcdGzel8sE
 GMKIWUpoHMyWa+autgOrXMlAUNkHvKup1CCkShcx+oM6/syGbwfJtVa26td7DNB4ZjHT
 o3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=GDKayPzz0I+V7wMlamDrFZZ5hlW9UKS/t7IcmxyQVfQ=;
 b=suUuBIQZ1zwGtTt/CpevLxE2s9VtVXqh9NETRYdAtLE1N1yMqxBKIg3T4fBWqk12tf
 IRQHcqKgVKoOBEQP6wafc+i4auHWOpOYtmnUiMcKTpw/WUgOrKeEjhtcw1IEQfBgxxKU
 sstvxWZBudGDe5ys2kEjLYNxyumIdtndhqsXBC1NyIyXvnOYvAtFNPBQGb7KpsMM1+/6
 ZsJzY9lA7TWI5+KnkDlnxoNscEiqkHrgOBbFRScolU2kIrcxxYOPXSgGGy2jloyU9Av+
 +cG2HZBJ2KWiCG6+sKpz4TLPcfJjKJaPHDmuBTVkaaGucQup1MM5wGWi1N9pBY8GWf1d
 eblQ==
X-Gm-Message-State: AOAM531NPvzf7w1rdvk8iOu24uNJhbuXsFkZK44pNaI5rmGjqRdsVQaJ
 nMB/CoCFsyOyV1VzqzXwMpGzDw==
X-Google-Smtp-Source: ABdhPJxQGDkl0GCZdvhAV/I32kl8qU8qsFgHlSjLTtm/tEDDQHpoH8ToPMslFkGPA99u4aI462Cwqg==
X-Received: by 2002:a17:906:19c7:: with SMTP id
 h7mr4699444ejd.517.1599673506573; 
 Wed, 09 Sep 2020 10:45:06 -0700 (PDT)
Received: from wks.local ([86.120.181.246])
 by smtp.gmail.com with ESMTPSA id jo26sm3184414ejb.120.2020.09.09.10.45.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Sep 2020 10:45:05 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [RFC] QEMU as Xcode project on macOS
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <13443969.F0S6BcH2UH@silver>
Date: Wed, 9 Sep 2020 20:45:04 +0300
Content-Transfer-Encoding: quoted-printable
Message-Id: <8BBE8FE9-5403-46A7-A1E4-9DAFECD25132@livius.net>
References: <2764135.D4k31Gy3CM@silver>
 <CAFEAcA8Wgbqm15DB1YLXBzQJwNeZjKGcdLFHe8G4FS6YT5Tcmw@mail.gmail.com>
 <13443969.F0S6BcH2UH@silver>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Received-SPF: none client-ip=2a00:1450:4864:20::62a;
 envelope-from=ilg@livius.net; helo=mail-ej1-x62a.google.com
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
 QEMU Developers <qemu-devel@nongnu.org>, G 3 <programmingkidx@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 9 Sep 2020, at 20:32, Christian Schoenebeck =
<qemu_oss@crudebyte.com> wrote:
>=20
> And being forced to use Meson=20
> on Mac with all its Python dependencies does not make it easier.

FYI, I'm working on a cross-platform standalone meson package, a .tar.gz =
that you can install in any location and includes the python run-time.

I already have the build scripts functional for Windows (which is =
generally the most difficult platform); the build scripts for =
Linux/macOS will follow soon.

=
https://github.com/xpack-dev-tools/meson-build-xpack/blob/xpack-develop/sc=
ripts/common-apps-functions-source.sh


Regards,

Liviu



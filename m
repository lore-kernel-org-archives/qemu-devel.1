Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB9CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 02:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CADCF2076C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 02:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZF4j6Ua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CADCF2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvtzm-0003Oa-P6
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 22:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sundeep.lkml@gmail.com>)
 id 1jvtyv-0002oZ-AX; Wed, 15 Jul 2020 22:50:45 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29]:45831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sundeep.lkml@gmail.com>)
 id 1jvtyt-0007p3-K2; Wed, 15 Jul 2020 22:50:45 -0400
Received: by mail-io1-xd29.google.com with SMTP id e64so4466219iof.12;
 Wed, 15 Jul 2020 19:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Gpyqdj0qZNNM20TScXYZlSyxF6Er9xUAYkIBSIg/Tw0=;
 b=FZF4j6UaAT95alh7gcJrfQrrYffVD8rv+njuvqtaPA4PsXsIiJXQx1m0J9SjUWqFZ1
 QhO/iCqQS1hT30BJjsD+SoW8ZiXbOzZ+yKwpl4pMP7jTGZGU1ixU7le0Zp06lybm4ww0
 VqCbZCJyPW7lQZPKGNfPsEZbZaiieAP2Hz8PMcc6Db+D2RLvOmfNUi+CXw2OU/YOpItq
 6KPNQ8pTHSQK3fHyEzm69sm1JD6C//AMlA+URIfgh4fnVIKwEGOQP5T64RIWKDdhdgej
 e7mYatjej3KnpHW6MUNABVN5kkr1Z/dT8tJjSYO5GeUN3PvT2pDaBkVQbZatOa7ee8dk
 V6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Gpyqdj0qZNNM20TScXYZlSyxF6Er9xUAYkIBSIg/Tw0=;
 b=GoDPpxjmB03Z1Txtyh9Q/w7XxETgVuZejJpjRXIeeJhMahPdWk6874IU2t+4jLaJJr
 rWx/IlGuKmsOQK7Hmfzt3vmBGhfY2WOhL07LgikOlrd51pCXFEBWetalo9Slw9/4zU8X
 zd8/yyfduDnt2R5B4A4tJqCckuzH/IRxkZf530Xo4gt60yx2IK0IUpnvGdnY4vA0D/qi
 +r0QLWb53/ffOMwjOWMGq/hUIwzyaYn8cbUhtVqTkh/lRl9ZO2n0LiLhuEcdaKNjaMCE
 FCBa6VTtv70dnExveKjhKexnhBZxdD1UZ8dBNsztO3hk+B6yOqJQdta3O1GIDg0DLEkH
 zPvQ==
X-Gm-Message-State: AOAM53307teSDjKpxmPsWcd12YHOVlJaZFECzQFySVneI3F98D34itC6
 6oA0Zm01gcd1nPoI1q/JXP2STZNKvUK33Rd0tDM=
X-Google-Smtp-Source: ABdhPJyxr85bC/iEiSE+DG95y5DGP/+cQruX0h1sxYlxJAL/4SQlcCSRlwxZJ8ZEFzsNYZ7gIUQoTrWFD/kMKShibak=
X-Received: by 2002:a5e:c311:: with SMTP id a17mr2429768iok.12.1594867841718; 
 Wed, 15 Jul 2020 19:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <e010da48-cfbe-9616-d750-a922cb463a94@redhat.com>
 <f457f5d9-2405-4456-4a26-b3a9784e2cd9@redhat.com>
 <efc16370-869b-15b9-36db-19ea28398e0c@amsat.org>
In-Reply-To: <efc16370-869b-15b9-36db-19ea28398e0c@amsat.org>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Thu, 16 Jul 2020 08:20:31 +0530
Message-ID: <CALHRZureR-QU7OUgMdxx0cOGpR4R+7i-bLvZfOKzYws5hWhJqA@mail.gmail.com>
Subject: Re: Test failure with Smartfusion2 emac block (msf2-emac)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d29;
 envelope-from=sundeep.lkml@gmail.com; helo=mail-io1-xd29.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Thomas,

I will check and get back to you in a week.
Hope that's okay.

Thanks,
Sundeep

On Tue, Jul 14, 2020 at 8:12 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Ping?
>
> On 7/7/20 7:32 AM, Thomas Huth wrote:
> > On 07/07/2020 07.18, Thomas Huth wrote:
> >>
> >>  Hi Subbaraya,
> >>
> >> today, I noticed that there is a test failure with msf2-emac when
> >> running the device-introspect-test in slow mode. Either run:
> >>
> >>  make check-qtest-aarch64 SPEED=3Dslow
> >>
> >> or as a shortcut:
> >>
> >>  make tests/qtest/device-introspect-test
> >>  QTEST_QEMU_BINARY=3D"aarch64-softmmu/qemu-system-aarch64" \
> >>   ./tests/qtest/device-introspect-test -m slow
> >>
> >> Then the test fails with:
> >>
> >> Unexpected error in error_set_from_qdev_prop_error() at
> >> hw/core/qdev-properties.c:1251:
> >> Property 'msf2-emac.netdev' can't take value 'hub0port0', it's in use
> >>
> >> Could you please have a look?
> >
> > The problem might be related to m2sxxx_soc_initfn() in msf2-soc.c. Look=
s
> > like you are using nd_table in an instance_init function. This is almos=
t
> > always wrong, and should be done by the machine code instead (e.g. in
> > msf2-som.c).
> >
> >  Thomas
> >
> >
> > PS: Maybe also have a look at this article, it might help to understand
> > the idea behind instance_init a little bit:
> > http://people.redhat.com/~thuth/blog/qemu/2018/09/10/instance-init-real=
ize.html
> >
> >


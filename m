Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A257FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 08:28:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C82420774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 08:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mp4UXicq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C82420774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5m7A-0007UP-MF
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 04:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5m6J-0006r0-L5
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 04:27:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60225
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5m6H-0006qq-17
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 04:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597220827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cjUtvRa2r4xacFFHaP0xigN+zzAyZHt59NiylHeTS6E=;
 b=Mp4UXicqqu3D01p/mlfzvWVqwdGVGUKJJTQpxRPRUeRqbay/DLN9QLe7OoC2/LC2wr3jlP
 13NBKCOZLrccpRyVi6m6hLmAit4zcPqWA6nio1Nk/JtTJtVAz+3sqmLackoMAPkCdjbnvf
 K9bBJhlXJI6kLsxeTPdDd0OssI93j/8=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-BrUToYziMz-5veRMT5rmyw-1; Wed, 12 Aug 2020 04:27:03 -0400
X-MC-Unique: BrUToYziMz-5veRMT5rmyw-1
Received: by mail-oi1-f199.google.com with SMTP id r62so787779oif.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 01:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cjUtvRa2r4xacFFHaP0xigN+zzAyZHt59NiylHeTS6E=;
 b=UApnEm1lBzWDcPStINbYON3bxYmjanKXdtQeznH0rqTXMc9egNBeLB14+HoEMcQDH7
 nmmfvJYMG4Zczie/aHnKZm7LEyb1KCu0uahqvzmypOkaEV8Am7I3j6e5dMoLQn+3mC2N
 RMf8OjXPNCruUkV9Hc8nlseVorfyeIe3J7wzViKpdwSY1pznXIP/jYqIL75hH3zJ+OvN
 mKawRo2CIU7bsO/v1SD+frMOPqH0EzL0NIPp3QMui9GzjR6+xez+b2pCp2RaejadzjZ3
 yGWLyOgefkAcOx0eWF3iHDCG1NtnD8Umuo4RSlEozEX0aI36K0907dMd+HGQ5Km8ERIW
 fCpA==
X-Gm-Message-State: AOAM532EfuLmwEiVACCct2jbpiWJ4eR7rtqb5AOG26zk+uI2plOTkOZL
 ZSm0LhZWIYqM1aXSdWuusszJdHhsBykZfj1dgoSgkTI62WjV1C1iOpizNPvN5ui+/mZGWcw1QZz
 HlD4gARlVvH+nWAB5VIAa+wbRomgGTvM=
X-Received: by 2002:a9d:538a:: with SMTP id w10mr8322340otg.355.1597220822941; 
 Wed, 12 Aug 2020 01:27:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvOU8uHij2arFPmxv8Oytw6x4z3u1jOB7wE/qgEXQsE68ssO6mFhzT5HCuUztHwE/X1Tt6/jIfJRrWZqNPSQk=
X-Received: by 2002:a9d:538a:: with SMTP id w10mr8322328otg.355.1597220822715; 
 Wed, 12 Aug 2020 01:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200610035102.20192-1-thuth@redhat.com>
 <706060db-46c4-2dee-d746-eba24e6b137d@redhat.com>
 <a8195883-fb78-0cc1-5e15-e100dcb807de@redhat.com>
 <c5be50d5-5158-ddcc-8de0-bc6c3cfce12a@vivier.eu>
In-Reply-To: <c5be50d5-5158-ddcc-8de0-bc6c3cfce12a@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Wed, 12 Aug 2020 10:26:51 +0200
Message-ID: <CAP+75-XgBOc5-poVsN9qrJ9xKiBdpmHcyE0OGygtBHsJJ6y=Qw@mail.gmail.com>
Subject: Re: [PATCH] hw/vfio/pci-quirks: Fix broken legacy IGD passthrough
To: Laurent Vivier <laurent@vivier.eu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 04:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 10, 2020 at 3:17 PM Laurent Vivier <laurent@vivier.eu> wrote:
> Le 10/06/2020 =C3=A0 09:50, Thomas Huth a =C3=A9crit :
> > On 10/06/2020 09.31, Philippe Mathieu-Daud=C3=A9 wrote:
> >> On 6/10/20 5:51 AM, Thomas Huth wrote:
> >>> The #ifdef CONFIG_VFIO_IGD in pci-quirks.c is not working since the
> >>> required header config-devices.h is not included, so that the legacy
> >>> IGD passthrough is currently broken. Let's include the right header
> >>> to fix this issue.
> >>>
> >>> Buglink: https://bugs.launchpad.net/qemu/+bug/1882784
> >>> Fixes: 29d62771c81d8fd244a67c14a1d968c268d3fb19
> >>>        ("hw/vfio: Move the IGD quirk code to a separate file")
> >>
> >> What about shorter tag?
> >>
> >> Fixes: 29d62771c81 ("vfio: Move the IGD quirk code to a separate file"=
)
> >
> > I always forget whether to use the short or the long version for
> > "Fixes:" ... this can hopefully be fixed (if necessary) when the patch
> > gets picked up.
>
> you can add in your ~/.gitconfig
>
> [alias]
>         showfix =3D log -1 --format=3Dfixes
> [pretty]
>         fixes =3D Fixes: %h (\"%s\")%nCc: %ae

From git-show (1):

           =C2=B7   %ae: author email
           =C2=B7   %aE: author email (respecting .mailmap, see
git-shortlog(1) or git-blame(1))

Since we have .mailmap, the %aE form is highly recommended:

With %ae:
$ git showfix 3e3d5815cbc1fdbf33adbe55f63ede3acead886f
Fixes: 3e3d5815cb ("NAND Flash memory emulation and ECC calculation
helpers for use by NAND controllers.")
Cc: balrog@c046a42c-6fe2-441c-8c8c-71466251a162

With %aE:
$ git showfix 3e3d5815cbc1fdbf33adbe55f63ede3acead886f
Fixes: 3e3d5815cb ("NAND Flash memory emulation and ECC calculation
helpers for use by NAND controllers.")
Cc: balrogg@gmail.com

>
> and then:
>
> $ git showfix 29d62771c81d8fd244a67c14a1d968c268d3fb19
> Fixes: 29d62771c81d ("hw/vfio: Move the IGD quirk code to a separate file=
")
>
> Thanks,
> Laurent
>



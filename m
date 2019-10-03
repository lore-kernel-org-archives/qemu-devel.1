Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADFDC10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 09:23:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2D82133F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 09:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2D82133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFxKb-00044C-2p
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 05:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47650)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iFxJY-0003cq-0t
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iFxJU-0007kX-Hw
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:22:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40888)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iFxJU-0007jq-69
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 05:22:20 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CE50C2A09A8
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 09:22:17 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id w10so848503wrl.5
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 02:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=HAKXNqxlu9hZBy+XRHRcb7TZaV3lei632APcndVyxUk=;
 b=LLEP0udk3S0/XlQp4XP72ryNz9xKIB5e0hBVDygJRgGDXv6KkfM8X7TbxR5htp8eNM
 aVl4TVPJuBbSSCtVoh2fgRc5Iaj1zoa2KP4ADEb7LRoDqp+uyJcy+Dg2VZSX+xur705t
 IrzS55zW/2pdxMwos4pMUxXVBG0lIesbrWLjKAvcau3DpjzPXLD/JvRXV1jA6v+pQYsd
 wt1xQN3vuWxCH+C3ZjWlXpce48hHcxbatfHlK43XJ9dnudadk1oHOqXx8Abgk2digWjS
 Dry0XUrqDSQv8ZIVA6iSNP9RSrrcBf4E58iKfduRcE6ZT1PvPLbLosepmuIcLlf2ahrY
 z9QA==
X-Gm-Message-State: APjAAAUwTwuq2UE9WV1wbBoDPvD7pbsESgver3AnKp1jzN4FPEVfygyi
 5LsoIyCY8JDDiePshXMB37yAarzDCT8xfPood+JQUDMkhq4LFHCdpPvneXjeVpUF8q0NDXypGzM
 +7ds9nYz5S87wfBo=
X-Received: by 2002:adf:e701:: with SMTP id c1mr6393787wrm.296.1570094536555; 
 Thu, 03 Oct 2019 02:22:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyKdm7DfRH9ongAz9t7tr/3VrJ7SkrtbeY99qjcjiPSRnYpusQl2V4khxoImjgoyGDORVpe6Q==
X-Received: by 2002:adf:e701:: with SMTP id c1mr6393773wrm.296.1570094536306; 
 Thu, 03 Oct 2019 02:22:16 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it.
 [79.52.200.174])
 by smtp.gmail.com with ESMTPSA id l11sm2106255wmh.34.2019.10.03.02.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2019 02:22:15 -0700 (PDT)
Date: Thu, 3 Oct 2019 11:22:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] accel/kvm: ensure ret always set
Message-ID: <20191003092213.etjzlwgd7nlnzqay@steredhat>
References: <20191002102212.6100-1-alex.bennee@linaro.org>
 <05d59eb3-1693-d5f4-0f6d-9642fd46c32a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <05d59eb3-1693-d5f4-0f6d-9642fd46c32a@redhat.com>
User-Agent: NeoMutt/20180716
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
Cc: qemu-devel@nongnu.org, "open list:Overall KVM CPUs" <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 02, 2019 at 01:08:40PM +0200, Paolo Bonzini wrote:
> On 02/10/19 12:22, Alex Benn=E9e wrote:
> > Some of the cross compilers rightly complain there are cases where re=
t
> > may not be set. 0 seems to be the reasonable default unless particula=
r
> > slot explicitly returns -1.
> >=20

Even Coverity reported it (CID 1405857).

> > Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> > ---
> >  accel/kvm/kvm-all.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index aabe097c41..d2d96d73e8 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -712,11 +712,11 @@ static int kvm_physical_log_clear(KVMMemoryList=
ener *kml,
> >      KVMState *s =3D kvm_state;
> >      uint64_t start, size, offset, count;
> >      KVMSlot *mem;
> > -    int ret, i;
> > +    int ret =3D 0, i;
> > =20
> >      if (!s->manual_dirty_log_protect) {
> >          /* No need to do explicit clear */
> > -        return 0;
> > +        return ret;
> >      }
> > =20
> >      start =3D section->offset_within_address_space;
> > @@ -724,7 +724,7 @@ static int kvm_physical_log_clear(KVMMemoryListen=
er *kml,
> > =20
> >      if (!size) {
> >          /* Nothing more we can do... */
> > -        return 0;
> > +        return ret;
> >      }
> > =20
> >      kvm_slots_lock(kml);
> >=20
>=20
> Queued, thanks.
>=20
> Paolo
>=20

--=20


Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD73C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 16:04:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FA102076A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 16:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XaSy138N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA102076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHV00-0001yM-ND
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 12:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jHUz8-0001T1-5C
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 12:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jHUz5-0006yJ-PL
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 12:03:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:26663)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jHUz5-0006y6-IP
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 12:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585238635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FLtUfzsRcWyd8uAh5BFCRjKsOJ4tBrQgmmiezkOe20g=;
 b=XaSy138N0kqkq9B2JyXiOI5OeAgzyduZvXs7AWos9DN9L4t+sE00Xlal9wq82AK3v3Dogb
 MJZx/rYSXxYgTe8ixKfFqFTf7gse19zSLAVFfMDHwkOrIfc/iIlqkkgZ4SWHEt052/qrie
 /gF82QZhZUuZxMc8meWjxr+zCDEO1Rs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-fTHvZHdDPvuK_4VvFB3JpQ-1; Thu, 26 Mar 2020 12:03:53 -0400
X-MC-Unique: fTHvZHdDPvuK_4VvFB3JpQ-1
Received: by mail-wm1-f72.google.com with SMTP id f9so2343816wme.7
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 09:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3kUmODSMlcGLxJZjTryNuzgi8sIif3VEfcEZ+A80HHY=;
 b=N4XAZrk2LWJy+b/CwqhGYsvepM5bzyncV6FoHAXgZvJxYs5Rg0JiRn+6UrY2LZ3d9l
 Hijs2e8iOVxpeGg9Iz3jvWJtcBBUbx3p7vyf+C98LEYg58+BdyBwhFZ6cezkuXy/f4QH
 iXfwT2aeNKIktNg2BX8TgZ3l1FLekpu1cU0N6sDxm9+awwaoaUKql/n0tvLUSQyrK+80
 OgjRI830+94ZAQNgM+Sy/akE3oVxRaUIRkRxykZXg3Z3QOQEnaS7kH29oVjgerYoDQuM
 uhxfiFvbqQe/hEM6Eixx8YThALjbC9YJWhn9do1/OCrTvV9wzBKMlo1xzFQVXnAx56hQ
 6pQw==
X-Gm-Message-State: ANhLgQ1ipyzq55KC8rIqf1zToY1oWEFUUdC+jiXdTQ/IuuHiudH0tY9i
 pr6tSsmGTmudY8vTewisBj7dg9spQCFdJflmPIJw6BBxvkdFM2Q5x3wzHQG9sKFciBOFbv8ZiBS
 lmmTD1qQhh+OXQfk=
X-Received: by 2002:adf:dd10:: with SMTP id a16mr9956157wrm.26.1585238632163; 
 Thu, 26 Mar 2020 09:03:52 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsILrDuTawt02iGxb0o/8qDkbVg2RMaEsz0MKTGB2eFG86XLKTKMtmdv+yAjSUMVKhvWOP7EQ==
X-Received: by 2002:adf:dd10:: with SMTP id a16mr9954509wrm.26.1585238610070; 
 Thu, 26 Mar 2020 09:03:30 -0700 (PDT)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca.
 [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id p3sm4227567wrj.91.2020.03.26.09.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 09:03:29 -0700 (PDT)
Date: Thu, 26 Mar 2020 12:03:26 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH RFC 8/9] KVM: Add dirty-ring-size property
Message-ID: <20200326160326.GF422390@xz-x1>
References: <20200205141749.378044-1-peterx@redhat.com>
 <20200205141749.378044-9-peterx@redhat.com>
 <20200325200031.GG2635@work-vm> <20200325204214.GD404034@xz-x1>
 <20200326134144.GC2713@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200326134144.GC2713@work-vm>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 26, 2020 at 01:41:44PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Wed, Mar 25, 2020 at 08:00:31PM +0000, Dr. David Alan Gilbert wrote:
> > > > @@ -2077,6 +2079,33 @@ static int kvm_init(MachineState *ms)
> > > >      s->memory_listener.listener.coalesced_io_add =3D kvm_coalesce_=
mmio_region;
> > > >      s->memory_listener.listener.coalesced_io_del =3D kvm_uncoalesc=
e_mmio_region;
> > > > =20
> > > > +    /*
> > > > +     * Enable KVM dirty ring if supported, otherwise fall back to
> > > > +     * dirty logging mode
> > > > +     */
> > > > +    if (s->kvm_dirty_ring_size > 0) {
> > > > +        /* Read the max supported pages */
> > > > +        ret =3D kvm_vm_check_extension(kvm_state, KVM_CAP_DIRTY_LO=
G_RING);
> > > > +        if (ret > 0) {
> > > > +            if (s->kvm_dirty_ring_size > ret) {
> > > > +                error_report("KVM dirty ring size %d too big (maxi=
mum is %d). "
> > > > +                             "Please use a smaller value.",
> > > > +                             s->kvm_dirty_ring_size, ret);
> > > > +                goto err;
> > > > +            }
> > > > +
> > > > +            ret =3D kvm_vm_enable_cap(s, KVM_CAP_DIRTY_LOG_RING, 0=
,
> > > > +                                    s->kvm_dirty_ring_size);
> > > > +            if (ret) {
> > > > +                error_report("Enabling of KVM dirty ring failed: %=
d", ret);
> > > > +                goto err;
> > > > +            }
> > > > +
> > > > +            s->kvm_dirty_gfn_count =3D
> > > > +                s->kvm_dirty_ring_size / sizeof(struct kvm_dirty_g=
fn);
> > >=20
> > > What happens if I was to pass dirty-ring-size=3D1 ?
> > > Then the count would be 0 and things would get upset somewhere?
> > > Do you need to check for a minimum postive value?
> >=20
> > The above kvm_vm_enable_cap() should fail directly and QEMU will stop.
> > Yes we should check it, but kernel will do that in all cases, so I
> > just didn't do that explicitly again in the userspace.
>=20
> We probably should have that check since you can give them a more
> obvious error message.

Yes we can.  Or I can enhance the error message when we failed with
kvm_vm_enable_cap() so the user will get the important hints.  I think
maybe that's more important than the explicit check itself.

>=20
> > I was planning this to be an advanced feature so the user of this
> > parameter should know the rules to pass values in.
>=20
> Advanced users just make advanced mistakes :-)
>=20
> I did wonder if perhaps this option should be a count of entries rather
> than a byte size.

Sometimes it's easier to know "how many bytes we used", while instead
sometimes we want to know "how many dirty addresses we can track".
But sure I can switch, considering the users might be more interested
in the latter. :)

Thanks,

--=20
Peter Xu



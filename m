Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFC3C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4706320737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWaijT4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4706320737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK3xs-0005Oz-Fb
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 13:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jK3xH-0004zS-Ci
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jK3xG-0006Ds-BV
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:48:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47654
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jK3xG-0006DZ-7y
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585849717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hALcoRc2eopaOdLq9G7y+Hf6uM4BExQ1XFaRYaVJWr0=;
 b=bWaijT4YBczoIJQJY06z+51M9lAJHMNKU8u0UAF8YKoBCfXDOCgoPHEOX//u3egey0RoOv
 CPrhKIm8hP4kY+pfYTXn4e52q1U+kNoZs+5yp4rs54YS4rRZFwblhUt/2h4chYeiU85ZwL
 yTMFPzlRuy49n7C8N4OlpudNqZk2o9s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-D8n-DKeTPhm2cnK2-YYPBQ-1; Thu, 02 Apr 2020 13:48:36 -0400
X-MC-Unique: D8n-DKeTPhm2cnK2-YYPBQ-1
Received: by mail-wm1-f70.google.com with SMTP id s22so1239962wmh.8
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 10:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=K6TPuqROVpVqzrPnO3BYC8M6RMzL0tSXsSg+H0xap6c=;
 b=A7BAQn7WHmgrLMams91fEbCpgDVg/dvuf/LznQBh+K1bJNwXUO8a6gaUi4NRKKmei3
 x+4Pl4DF50kMVHnmjX3Vn+aAtQs2334kne1KMHNWhvZx2STGLbXP5Ajojm3TqJcUcRmV
 fh1m0kyyPmGrUTVrqHB5UqGNRG3ZYmRHhmWU5iDQZLwlb+fu443Sv7BMTugYdnB++745
 qvBAXaRIN7uYNhppCOIrABIOsVgXIdpPhroVFazxcV5mkLwiFRgSEn/WjI9fGYImXINe
 tenoBWwgvkNqskf/HqiyR0jIoEH610aRnrmR4uC9S6xEqZQUm6GD4u+BjzTQC8RxsSYl
 8CrQ==
X-Gm-Message-State: AGi0PuaofxSTTGiASVszKWz85onXzXvBRw7uaOhUzIipvNLXl1RAU3YO
 m9WKWw4MSx7LKwdE8jYU6e59rHy9/0sH4Ck0FxvGMYCHYqRENRlD1HuX9mf2ekeKvAVH8Kel+0z
 y1IJpfYXAXA4Q+h4=
X-Received: by 2002:a5d:4146:: with SMTP id c6mr4440888wrq.181.1585849714977; 
 Thu, 02 Apr 2020 10:48:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypIdOFKxgZXLOKV5rPfEGdMaQ5xvcQ5oV/CWhbypUXNtSQWXZyhNn89pv0pMdiLcfgc2398nFA==
X-Received: by 2002:a5d:4146:: with SMTP id c6mr4440872wrq.181.1585849714745; 
 Thu, 02 Apr 2020 10:48:34 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id n6sm8456197wrp.30.2020.04.02.10.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 10:48:34 -0700 (PDT)
Date: Thu, 2 Apr 2020 13:48:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v3 1/1] vl/s390x: fixup ram sizes for compat machines
Message-ID: <20200402174830.GC103677@xz-x1>
References: <20200401123754.109602-1-borntraeger@de.ibm.com>
 <20200401183456.09ba3540@redhat.com>
 <20200402112735.6961297d.cohuck@redhat.com>
 <20200402133958.72fabf45@redhat.com>
 <e3dfecd4-2905-dc8b-92e7-2194a52ea9ea@de.ibm.com>
 <20200402140536.1b9e7c41@redhat.com>
 <03077928-4d17-f860-1907-3d1fcea3ab3c@de.ibm.com>
 <98d87752-ba5d-7ac1-6074-978ade3d2652@de.ibm.com>
 <20200402170123.2e132d0a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200402170123.2e132d0a@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 02, 2020 at 05:01:23PM +0200, Igor Mammedov wrote:
> On Thu, 2 Apr 2020 14:35:21 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>=20
> > On 02.04.20 14:09, Christian Borntraeger wrote:
> > >=20
> > >=20
> > > On 02.04.20 14:05, Igor Mammedov wrote: =20
> > >> On Thu, 2 Apr 2020 13:42:22 +0200
> > >> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> > >> =20
> > >>> On 02.04.20 13:39, Igor Mammedov wrote:
> > >>> [...] =20
> > >>>>>>      =20
> > >>>>>>> +                    "MB to match machine restrictions. Conside=
r updating "
> > >>>>>>> +                    "the guest definition.i\n", sz / MiB, news=
z / MiB);       =20
> > >>>>>>
> > >>>>>> also it might be better to use size_to_str() to format numbers  =
   =20
> > >>>>>
> > >>>>> The text explicitly talks about 'MB'... not sure if it would be
> > >>>>> confusing if the user specified MB and ended up with GB or so in =
this
> > >>>>> message.   =20
> > >>>>
> > >>>> MB can be dropped, since it still might not match what user specif=
ied with -m
> > >>>> it could be specified in b/kb/mb/gb over there
> > >>>>
> > >>>> so I'd drop MB and print value size_to_str() returns
> > >>>> (it will add appropriate suffix if I'm not mistaken) =20
> > >=20
> > > Another thing: size_to_str is also do rounding (whenever the integer =
part is >1000).
> > > Doesnt this result in potential messages where both numbers are the s=
ame? =20
> >=20
> > For example
> >=20
> > 10241263616-> 9.54 GiB
> > 10241262592-> 9.54 GiB
>=20
> doesn't seem to be working as one would expect (and it's used in number o=
f places now)
> CCing original author of it

That looks sane to me.  Gib is IEC binary unit as explained by the
comment of the function, and the function prints with %0.3g so that we
keep three digits.  IIUC that's ideal when we want to display
something like disk image sizes, but for sure it won't satisfy any
formatting of digits.  Maybe add a new helper?

Thanks,

>=20
> > The only guaranteed way to actually see a difference is to use MB.
> >=20
> >=20
>=20

--=20
Peter Xu



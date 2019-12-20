Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6847FC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3356A21655
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JttNDB4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3356A21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJis-00007A-DW
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jdillama@redhat.com>) id 1iiJiI-00089H-JG
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jdillama@redhat.com>) id 1iiJiG-0005V2-Nv
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:57:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29758
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jdillama@redhat.com>) id 1iiJiG-0005Tn-Km
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576853827;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2zlq1jmdN6jHL/qC2ehSFnIcuPiguGWfCttf7u5bY94=;
 b=JttNDB4s6jtHLW4zxIMS5ArosBprg+RPO3olSQMMwjsoGgttLOMSuY/D1e5cHzrip4hjXw
 LNZ+i0t3RcVVG5h6PdxfzVtgmpEfb3/0kkYLEd/DiruHRVkqT05jUr9bX+J2ldQuNEVpMc
 CfZK6wRNmImkx8kVKQklDEeouSWWiXc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-CZ5bioOqND2PTcEpqOdXvQ-1; Fri, 20 Dec 2019 09:57:04 -0500
Received: by mail-ed1-f69.google.com with SMTP id v5so2068197edq.8
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 06:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=u4u/+dOED4/eOx+Zp58upTazZMp9OvS2KIFsNnM8/qc=;
 b=ZNxnIWdnX6cYbNONy0HjmKMeV+cooTy5voanMVlFaUMCwd56oy5hYG7ULVd9mJdVMT
 I6u4k9JbS18nJl7DQT6OYsQHo+kf1WXjGbcta/OWhrKAc8qeNQENOzkNulawUqLduH1S
 GL5KoUtDsQ0bHxylWgw3tIbgzH/h+ZkhhXRjugsRJsJuxaB2j1UHfRDH54zpOQnSqZms
 0sRIJkLIbgu+e/gluy6BK+MPX072DmX17GQu0/rnYEnwgEwvi/iFxDquY9ogX9Vp7Rrs
 GuUM/4uxXvrqlkjoXyl6wIKuOLe2aG6ZCxmdoUwlbALjrxR/WDeU/iqgcQOYAr2aQ5zd
 qsGw==
X-Gm-Message-State: APjAAAXI+7XSuGuUxdmfkxJcj/fIHTRhRmLOPzdlwRWEtPQHU53Llfla
 ne0nWveAFvB6tqQ8r58NxiazvaxvRewpt9buAzDo/u2/dxDg7unBKZcr67F71HhXB6mhxlQJSWM
 e/xb75FJ5XfTPrdUXjOqD+DVkON86ah8=
X-Received: by 2002:a17:906:60c9:: with SMTP id
 f9mr15349566ejk.273.1576853823783; 
 Fri, 20 Dec 2019 06:57:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqzXLoh1Ybkbr5InuzF4ro2q4ly4WIP2lN6LnWuogiTo5E2f8v7NLm0gPf2jXCse3P8R2wXfk9xiSKqupXpU2m8=
X-Received: by 2002:a17:906:60c9:: with SMTP id
 f9mr15349523ejk.273.1576853823429; 
 Fri, 20 Dec 2019 06:57:03 -0800 (PST)
MIME-Version: 1.0
References: <20191219133416.671431-1-fflorensa@online.net>
 <20191219145125.iwhxhzmt5mow5pea@steredhat>
 <20191220141125.wxlm4eizbwie6522@flash.localdomain>
In-Reply-To: <20191220141125.wxlm4eizbwie6522@flash.localdomain>
From: Jason Dillaman <jdillama@redhat.com>
Date: Fri, 20 Dec 2019 09:56:51 -0500
Message-ID: <CA+aFP1DuNzvWZo7d8sFX6UEYV175HKm0Wo9PJWyHs91dA_WkHQ@mail.gmail.com>
Subject: Re: [PATCH] block/rbd: Add support for ceph namespaces
To: Florian Florensa <fflorensa@online.net>
X-MC-Unique: CZ5bioOqND2PTcEpqOdXvQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Reply-To: dillaman@redhat.com
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 dillaman <dillaman@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 20, 2019 at 9:11 AM Florian Florensa <fflorensa@online.net> wro=
te:
>
> Hello Stefano and Jason,
>
> First of all thanks for the quick reply,
> Response inline belowe
> > Hi Florian,
> >
> > I think we need to add (Since: 5.0).
>
> Are you implying by that (Since: 5.0) that we need to specify its
> availability target is qemu 5.0 ?

FWIW, I took this as just a comment to add some documentation that the
field is only valid starting w/ qemu v5.

> I guess that maybe a version check would be better ? Like try to do
> namespaces stuff only if we have a recent enough librbd in the system ?
> Using something like :
>
> int rbd_major;
>
> rbd_version(&rbd_major, NULL, NULL);
> /*
>  * Target only nautilus+ librbd for namespace support
> */
> if (rbd_major >=3D 14) // tar
>  <process namespace>

Unfortunately, those versions weren't updated in the Mimic nor
Nautilus release so it would still return 1/12 (whoops). I think that
means you would need to add a probe in "configure" to test for librbd
namespace support (e.g. test for the existence of the `rbd_list2`
function or the `rbd_linked_image_spec_t` structure). I'll fix this
before the forthcoming Octopus release.

> > The patch LGTM, but I'd like to use 'namespace' instead of cryptic
> > 'nspace'. (as BlockdevOptionsNVMe did)
> > What do you think?
> >
> Yes no worries, I can rename it to 'rbd_namespace' to avoid any possible
> confusion, is this Ok for you ?

We use "pool_namespace" in the rbd CLI if you are trying to avoid the
word "namespace".

> > With those fixed:
> >
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> >
> > Thanks,
> > Stefano
>
> Regards,
> Florian

--=20
Jason



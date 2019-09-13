Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA06FC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 07:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5ACE20830
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 07:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5ACE20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8flv-0000Om-Rb
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 03:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1i8fl2-0008Ky-Dn
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 03:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1i8fkz-00063S-LL
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 03:12:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45372)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1i8fkz-000632-GO
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 03:12:37 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9831189AC5
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 07:12:36 +0000 (UTC)
Received: by mail-ot1-f70.google.com with SMTP id v51so4679505otb.5
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 00:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EK/42hhOXH8Ux2Lr1zGYIfaPvZqGgL1EK/f7aOogMnk=;
 b=Ui6I0OJf2lBoc0UVed4cvgvY2uqs2OpEXySbOePVkfReHmulE84++Yq9pEPCxI2c72
 QN6aD5ztBlO043GJTgANuUzjSBEAkGuFBQqYK0s0gnxUCMZlqv/kesN0T+Ozm9CPQRap
 bSdgcMg1CqBxv7j10yCo6tgDZJrKLLNcIjliJzy+Cax7EUgiK6ulyzc0kgaQ9bS2xf14
 B16jUGJvbNwba+1Yjv1m6+Eg+UaQ6gZo5CBSPB97N67cYJfKhAyRLYTyXJBncMP5GbE7
 H0ddP9EAndSgio+DZygWEBzinaK2Ko4aPBboCROnvXkV29MY1as3jz+x58MJr/b25pRk
 7+iQ==
X-Gm-Message-State: APjAAAXwBEn4BuF5RbXPTs/s2xu0vHqTerhmHbWO3ZzVA+rGIcVV8M/p
 1eGZSEfuTKpPjM2I4Lg5TO5Rvth361fqGPe4OZgpyNliCr8UQ8WPDmDoVkoCLL/HdYWk1pld5TF
 avxgM7DJ5eTUmUJAIPYa6y0gFgtBCN8s=
X-Received: by 2002:aca:38d6:: with SMTP id f205mr2088881oia.76.1568358756137; 
 Fri, 13 Sep 2019 00:12:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwyrErLG+OFledqxksHOuaRPLhfRqr/cjRmaLHF41HAkX9vwI/md89DP+DpsIL/3KxJsYbG/v1ZpHR+XzN3I4I=
X-Received: by 2002:aca:38d6:: with SMTP id f205mr2088873oia.76.1568358755876; 
 Fri, 13 Sep 2019 00:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190912122514.22504-1-marcandre.lureau@redhat.com>
 <20190912122514.22504-4-marcandre.lureau@redhat.com>
 <20190912181855.54f20a7e.pasic@linux.ibm.com>
In-Reply-To: <20190912181855.54f20a7e.pasic@linux.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Sep 2019 11:12:24 +0400
Message-ID: <CAMxuvazwZa7-as+Ef7t-CnCw+G0NFV66-9814T2wM0g6Ag-1YQ@mail.gmail.com>
To: Halil Pasic <pasic@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 3/6] vmstate: replace DeviceState with
 VMStateIf
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
Cc: "P. Berrange, Daniel" <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, "Privoznik, Michal" <mprivozn@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Bonzini,
 Paolo" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Sep 12, 2019 at 8:19 PM Halil Pasic <pasic@linux.ibm.com> wrote:
>
> On Thu, 12 Sep 2019 16:25:11 +0400
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>
> > diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
> > index d4807f7777..16b9bbf04d 100644
> > --- a/hw/s390x/s390-skeys.c
> > +++ b/hw/s390x/s390-skeys.c
> > @@ -392,7 +392,7 @@ static inline void s390_skeys_set_migration_enabled=
(Object *obj, bool value,
> >          register_savevm_live(NULL, TYPE_S390_SKEYS, 0, 1,
> >                               &savevm_s390_storage_keys, ss);
> >      } else {
> > -        unregister_savevm(DEVICE(ss), TYPE_S390_SKEYS, ss);
> > +        unregister_savevm(VMSTATE_IF(ss), TYPE_S390_SKEYS, ss);
> >      }
> >  }
>
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
>

thanks

> BTW what does the 'f' in VMStateIf stand for? (I've had a look
> at 2/6 but didn't figure out the answer).

"If" stands for interface, and seems to be more common in qemu.
gobject code usually uses "Iface", and other prefer "I" prefix.


Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6D6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8722C24672
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 08:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5QYA590"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8722C24672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuBqA-00014T-LD
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 03:58:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuBp7-0008Hh-Mx
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuBp6-000475-FH
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:57:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32089
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuBp6-00046p-B1
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 03:57:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579683435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WqA8KNOo0LwZEK8LU7PEvulWdwQpWBmq7KeBQobr4HI=;
 b=c5QYA590KsqFEDTbZqa9+D/mrDAnqimEHeOb4me11wX+Aw50oH7EgGJCULkdLwibZoQ+9u
 ulfpwHanqIAUP+lZwHMDASi0eLzRjG4fQQgTzt5IqWVsF+bg63lgK4m/VVCUOue6AThgY2
 AhE2sNNFQwl92V/T2TdunmFTOZ1S7sY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-ax-KZaygNvCQXC-2FPldaw-1; Wed, 22 Jan 2020 03:57:11 -0500
Received: by mail-wm1-f70.google.com with SMTP id p5so1091611wmc.4
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 00:57:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=2PRw/c7M1OEIe+8hOgvN+62V2jAmS2j+lxHwh9qYn5I=;
 b=hZ5JumQJG+xra7+fN311lKxgzRWvtFG4KXk3r3Y8s57fBFHz029e7ok25SHD2E4FwQ
 vRdTC8506uvOpDsHNui9grEdAPW/MuxzPB+pEGU5KAVYRc/ptuqEpBBN7FeN/WjujO2P
 wwjAQA/7xIbjREw0sWWqZy6CiqRh9Adu+qANi/PqScSedF22d1ljPgRG/ubO7FA7+CEB
 zicsAevLXhRY5Z/5QEJtKI60rAgLNW0mX5vsvkasikN4jd9L7RybpofhTSBBLyCYJXfq
 VTo72BNKsoHyNDlPl5Lt3Ho4A5lbYJvsLRJvbjk17u1pnpoDzZ3gtEZ1lFOuEAfdWOqC
 QrMA==
X-Gm-Message-State: APjAAAXZgpshQD5evOvn5TvojHx3Xp8/CI13y1sZjvTcrru4T+IDddYA
 fC4lLuuzYk7etfpxeUkKtMEa/45c5deaNSB4N6wdOdcHcXxKsk9+3yXlotOffCHkHZUZtjoHhp8
 zToJ9kM613sJKJfU=
X-Received: by 2002:adf:ec41:: with SMTP id w1mr9820002wrn.212.1579683430438; 
 Wed, 22 Jan 2020 00:57:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqwNyY8pQne6yOfIU/u+vNxoP9MlHU32S96G+BhuYc3kAfznFJNoO2dvTN+CpUhb4ZcQ22JHqg==
X-Received: by 2002:adf:ec41:: with SMTP id w1mr9819977wrn.212.1579683430208; 
 Wed, 22 Jan 2020 00:57:10 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 q14sm3035071wmj.14.2020.01.22.00.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 00:57:09 -0800 (PST)
Date: Wed, 22 Jan 2020 03:57:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [RFC PATCH 3/3] Introduce Configurable Number of Memory Slots
 Exposed by vhost-user:
Message-ID: <20200122035639-mutt-send-email-mst@kernel.org>
References: <1575874847-5792-1-git-send-email-raphael.norwitz@nutanix.com>
 <1575874847-5792-4-git-send-email-raphael.norwitz@nutanix.com>
 <20200114020807-mutt-send-email-mst@kernel.org>
 <20200116032314.GA86980@raphael-norwitz.user.nutanix.com>
MIME-Version: 1.0
In-Reply-To: <20200116032314.GA86980@raphael-norwitz.user.nutanix.com>
X-MC-Unique: ax-KZaygNvCQXC-2FPldaw-1
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 15, 2020 at 07:23:14PM -0800, Raphael Norwitz wrote:
> > > +        error_report("The VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS prot=
ocol "
> > > +                     "feature is not supported when the "
> > > +                     "VHOST_USER_PROTOCOL_F_REPLY_ACK features has a=
lso "
> > > +                     "been negotiated");
> > > +        return -1;
> > > +    }
> > > +
> > > +    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
> > > +        return -1;
> > > +    }
> >=20
> > This will send the message each time e.g. memory hotplug
> > triggers. Why not just get this value during init time?
> > Also, any way we can cut down number of round trips?
> > Can we combine this value in a single message with
> > some other stuff we are fetching on startup?
> >=20
>=20
> Agreed, sending a VHOST_USER_GET_MEMSLOTS message on every hot-add is
> unnessesary. I can think of a couple ways to get number of memslots witho=
ut
> adding any additional round trips. I don=E2=80=99t like either of them th=
ough.`
>=20
> 1.
> Only 14 of the 64 bits are used in the VHOST_USER_GET_FEATURES message ar=
e
> used to store feature flags. If CONFIGURE SLOTS is enabled, we could use
> the remaining 64 - VHOST_USER_PROTOCOL_F_MAX bits to store the maximum nu=
mber
> of memory slots. We would only need around 10 bits to express a reasonabl=
e
> number of slots so that still leaves room for plenty of future features w=
ith
> VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS negotiated.
>=20
> 2.
> We could always have it sent from the backend with an existing VHOST_USER=
_GET_*
> message in vhost_user_backend_init(). The best option I see is using the
> VHOST_USER_GET_QUEUE_NUM if the VHOST_USER_PROTOCOL_F_MQ is negotiated. T=
his has
> the obvious drawback of requiring VHOST_USER_PROTOCOL_F_MQ to negotiate
> VHOST_USER_PROTOCOL_F_CONFIGURE_SOTS. I don=E2=80=99t see another option =
without such a
> limitation.
>=20
> Both (1) and (2) seem hacky. I think it=E2=80=99s preferable to keep the
> VHOST_USER_GET_MAX_MEM_SLOTS message but send it once on init and cache t=
he
> response in the vhost-user struct.
>=20
> Do you agree?


Makes sense.



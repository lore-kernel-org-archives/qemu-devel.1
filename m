Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32141C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 12:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F05B921775
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 12:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0V/hPPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05B921775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jACTt-0002WJ-3W
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 07:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jACSk-0001at-GO
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:52:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jACSi-0007h0-Fu
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:52:22 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45267)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jACSi-0007e7-9E
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:52:20 -0500
Received: by mail-wr1-x444.google.com with SMTP id v2so2196961wrp.12
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 04:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZICCo4TUf5G6LQkMng9dbkynMnvkJScM5ClPSfxPVV0=;
 b=L0V/hPPOA95Qx5I44qrewO72Y+r6t062fjodT24VesCD+olpB2CgEmrJy0KlZSM/V7
 9w6bgbP4xOvaqztKiv8w7TLyivgvKm/RtiUokcVgWmsgo8mWUPftpNkGzw34dymaP24c
 4bA7dLRlcnt2OoIzpiRMIwPS/BlVgYIEndjDfDGnBckF385UGv15wnNwOIdaDV9X65J4
 Ek30/+lAcQza+oTwM9GPlSBCXW0/GiMOTlzhFpDOAzDyqvYDgct7kroA8TKRSfKnaYZC
 WLeEdBS0BHkCY86bKRk6uJmrQZZEvgqW17SmUQhYv8XdxbumPVGrI7LWqIRqoMUu+pHQ
 f0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZICCo4TUf5G6LQkMng9dbkynMnvkJScM5ClPSfxPVV0=;
 b=uTroJERE+94brQitwyDCVxrdntGKfqE/nWPoYlkM8iwrFefu5L8sTzmsf6BLGQY7uB
 aL833aJdoWNTk494hQx/guy8Jdov4cPVk1BO/Vyxfny2nIjjInNosj32g8CdKBQ7gBNT
 Aovh3eibmogoqSQfNkhzSwc8bpkZzHJB0Vda5hvT2oTyLxSDQRIofc48cF+RBhcIK7IY
 Ex4/DGTXrN2xk8Ma1+2MaLAExsSUaHbVJD6fYfcLtLKhY4DY4RnxE+t4JANE/IZwCIGH
 wEMumoRlBQacOGhk7euZiTEB5rr9lHwvGVil4iWPEU6wltuCZ34+F9o4J8ScAyPq+3Cm
 Xw+g==
X-Gm-Message-State: ANhLgQ0EU+pDjzSNNreNJr+zOmN36jamiHAZt/h0F663Y4NBg5R5yH5S
 jnhzceYRpdR//58t9rOutLaa4WfRwirgFPRZu9g=
X-Google-Smtp-Source: ADFU+vtPC062XAlS1F5cKDdUHuwPNVE5yCe9j+ZF3XjIO/5gg+LN+5/7Z7k0F5iuGXB9ldx/l6TiYqGsSLs4hZvFXHI=
X-Received: by 2002:a05:6000:4a:: with SMTP id
 k10mr3721518wrx.381.1583499139190; 
 Fri, 06 Mar 2020 04:52:19 -0800 (PST)
MIME-Version: 1.0
References: <20200224182454.24610-1-sebastien.boeuf@intel.com>
 <20200306123453.GI1335569@stefanha-x1.localdomain>
In-Reply-To: <20200306123453.GI1335569@stefanha-x1.localdomain>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 6 Mar 2020 13:52:06 +0100
Message-ID: <CAJ+F1CJpMzra8VSYWKgtwZJkxvEX_HTqT=Sr9yvmX=NMH=9MSg@mail.gmail.com>
Subject: Re: [PATCH v2] docs: Update vhost-user spec regarding backend program
 conventions
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Mar 6, 2020 at 1:35 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Mon, Feb 24, 2020 at 07:24:54PM +0100, Sebastien Boeuf wrote:
> > The vhost-user specification is not clearly stating the expected
> > behavior from a backend program whenever the client disconnects.
> >
> > This patch addresses the issue by defining the default behavior and
> > proposing an alternative through a command line option.
> >
> > By default, a backend program will terminate whenever the client
> > disconnects, unless told otherwise through the newly introduced
> > option --keep-listening.
> >
> > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  docs/interop/vhost-user.rst | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
>
> Perhaps --keep-listening should be optional?

I think it should be optional, and flagged by a capability.

>
> If the maintainers are happy with the patch as is then so am I:
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>



--=20
Marc-Andr=C3=A9 Lureau


Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1191BC31E47
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 05:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D266A2168B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 05:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6Pii8mP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D266A2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58772 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hc19y-0001Rj-6s
	for qemu-devel@archiver.kernel.org; Sat, 15 Jun 2019 01:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50362)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rfried.dev@gmail.com>) id 1hc16A-0006H0-T2
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 01:19:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rfried.dev@gmail.com>) id 1hc0y6-0007jo-Qa
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 01:11:11 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40009)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rfried.dev@gmail.com>)
 id 1hc0y6-0007dI-I8; Sat, 15 Jun 2019 01:11:10 -0400
Received: by mail-wm1-x342.google.com with SMTP id v19so4124305wmj.5;
 Fri, 14 Jun 2019 22:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ahfDBaZpWRRMUSU14banV4tDohtU7GQ0/Bn+quR5tGk=;
 b=H6Pii8mP5cGFjrndSVNTbbCrqkCZCpdxTHGt3dfZKexIc6mkQmVjWo0A6jlX4Uh1y6
 305+BMsGhuZ39++nsrJuYSqShsPbY1fqxbBS4OV3JTC8RiK4VjqAHqXhd00TsR7P+GZ/
 OWFlhpt2ntPOPAglUk8+Xt126Dq4GcLOUgnDIneZli64AGXFQzZplzlRwY6LzV5dBpFm
 WIlMLeC0Z8r/ij9lff5QATCbfa9MTdIfmjIrdScjgE68lB6DPYjBUcUK4EoYJkWSR2BZ
 MimoVGGgoy7cR/mgo3z6VzBNM7r5daWiX838mTGlprEkWsETfZipJnEdwy4FzU6l8zdd
 L5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ahfDBaZpWRRMUSU14banV4tDohtU7GQ0/Bn+quR5tGk=;
 b=YMn9uLm0mgVvCMxdMhJDN0/kRDyO2l4jblOP+kz6aiDdRVN/QT1VyL0bnrD54AHviA
 WIcE1WNEN8ZWnCmefz/TXWEOtTO5i3uHVvPZgM7RvZb/zmXiPyQsnUPsijxrzra1O1OJ
 13SY7/+vr4mYwqcOUqK0rbrtCrfE/ldctJ36jJKXjmE2/Z7lbFIQSAmR4nZ1GZF0Gtob
 yBEp2S4+VicgdgKoblWp29wt7MO38j97dsrQrl9YQJZfNw7xIgNY3fVaZEZVbyntZoS2
 riWWFCTcIdO/H9q/VsfQn5gx3jG7Z7gRugj2VHS5tsYToIsyv1Kz+zsItiGdxG/1/yKZ
 tgXw==
X-Gm-Message-State: APjAAAWQu+eQ5UX/sSqeqKuUdJpKKzqRmBb35OFqvr+pZAxYhVlAudzp
 XXWyLY7+AjbR7Qd9FuLIREOhPctbzeXdBWKQ5ps=
X-Google-Smtp-Source: APXvYqyvg8omQXD5iOnlCHDqIqdKLK57j/uE+dVxbVyhVCgJIT7XLhgfwq0A9H2AIQTZFcuAXD7AV7RS5m6n3+s7bIw=
X-Received: by 2002:a1c:c255:: with SMTP id s82mr10881568wmf.6.1560575467518; 
 Fri, 14 Jun 2019 22:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190611145556.12940-1-rfried.dev@gmail.com>
 <f826d073-da60-96f0-9a37-c33761844cc2@vivier.eu>
 <CAGi-RUL2QThfiYPeZOE6iuryxT7Daj-y-Q=SSgUBRFcDsWP+zw@mail.gmail.com>
 <200eff56-ffff-904d-eeef-408b52ce2fa5@vivier.eu>
In-Reply-To: <200eff56-ffff-904d-eeef-408b52ce2fa5@vivier.eu>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Sat, 15 Jun 2019 08:10:56 +0300
Message-ID: <CAGi-RUKY_WPsaL+aYfuZzKLGcPj7=+PCUo94Oxm5-ERCGEgtzQ@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2] net: cadence_gem: fix compilation error
 when debug is on
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-devel@nongnu.org, "open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 12, 2019 at 10:40 AM Laurent Vivier <laurent@vivier.eu> wrote:

> Le 12/06/2019 =C3=A0 06:27, Ramon Fried a =C3=A9crit :
> >
> >
> > On Tue, Jun 11, 2019 at 7:21 PM Laurent Vivier <laurent@vivier.eu
> > <mailto:laurent@vivier.eu>> wrote:
> >
> >     Le 11/06/2019 =C3=A0 16:55, Ramon Fried a =C3=A9crit :
> >     > defining CADENCE_GEM_ERR_DEBUG causes compilation
> >     > errors, fix that.
> >     >
> >     > Signed-off-by: Ramon Fried <rfried.dev@gmail.com
> >     <mailto:rfried.dev@gmail.com>>
> >     > ---
> >     > v2: change %lx to HWADDR_PRIx and %lx to %zdx
> >
> >     HWADDR_PRIx is to use with hwaddr type (packet_desc_addr).
> >     rx_desc_get_buffer() is uint64_t, you must use PRIx64.
> >     It may be better to remove also the cast to unsigned.
> >
> > Other places in the code also use HWADDR_PRIx with  rx_desc_get_buffer(=
).
> > Should I change them also ?
>
> No, in fact you should change the return type of rx_desc_get_buffer() to
> hwaddr.
>
Make sense.
I'll do it in a different patch.

>
> Thanks,
> Laurent
>

Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F6DC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 22:04:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEEAD21927
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 22:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evjugmOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEEAD21927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBmzd-00086g-S9
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 18:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBmz0-0007V7-Qb
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 18:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBmyz-0003hK-Q6
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 18:04:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34499
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBmyz-0003fW-M5
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 18:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583877853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+q674ZvOsEdxdbUgGhuwX1koHmAjLHe3dwzmZ9BGF04=;
 b=evjugmOw9bPScYNPRIA3wXhgTgdDnFX6jKjXso6IaloThiSB9G3GK76feQW4r1zVp82lJ0
 VgfbgoOe7sCCDpXC3bWqPi3ittfBwJDSCq1OI88B9Of5LL0Odfr1Lq3yZGJawNDzV2dq5h
 QyKHRrVe5l49xaPnZItDF+8pCqLgYY0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-fZiitepkM3iZikvk6w6q9w-1; Tue, 10 Mar 2020 18:04:11 -0400
X-MC-Unique: fZiitepkM3iZikvk6w6q9w-1
Received: by mail-qk1-f200.google.com with SMTP id h6so103641qkj.14
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 15:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RoN2XJMeMxIYBkUhH2CZ/6kkFontFLMNyZAIhXigUoE=;
 b=XKNHflupMySlB0dfuAFjG2iXsxnyaRiovCvGYRoD6V5i96y5umeLNlz4pXZKUEKA0J
 HXQSbY+GeIX8qJ2AckQDCpKDL+sYdBqYDhpB0VAIYSO6XMpSHJWefzosS4I9arE8ozN2
 QHdvDSco3hWiTo/BfixSHQb4GZSkuiAhk9+H9OB3mhYrJmA1e3AqwkJwiGNcoCWxQR75
 XWvuoHSbltHytihP8y+lVn8SZ/edT33UnE5NH4qqtrkhgzYrfG9G4Rw0X495tKlan3ZK
 bm6fZjGanoTBLwzZiNyuUysrPAOgi8YWW6rsfuHOcfACSQs0EPrxwjjR8oKtlY6oGF+e
 dHCA==
X-Gm-Message-State: ANhLgQ2EupVsIoxohebS0NgwI0C6iuH8QYBWpph4wCu81cXsXcSu/YKb
 3yZVCsqsSS+hz2++6eX8sLLl2tc4qfbgUc2egtlc2AdmufdikDHjCOck67/Q0gxjbLxvBNVNrxW
 8rC6E20jiqwZlztg=
X-Received: by 2002:ac8:5211:: with SMTP id r17mr105202qtn.80.1583877850825;
 Tue, 10 Mar 2020 15:04:10 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtKGBhdGkLd2h0LUWmQvA+iuXspVX2R1mSGeSrU3Le1/gvzD69b7dDlXgTkZfMPRaL7BphBuw==
X-Received: by 2002:ac8:5211:: with SMTP id r17mr105184qtn.80.1583877850575;
 Tue, 10 Mar 2020 15:04:10 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id w1sm9377341qkc.117.2020.03.10.15.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 15:04:09 -0700 (PDT)
Date: Tue, 10 Mar 2020 18:04:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 05/14] hw/i386/vmport: Report VMX type in CMD_GETVERSION
Message-ID: <20200310180110-mutt-send-email-mst@kernel.org>
References: <20200310082730-mutt-send-email-mst@kernel.org>
 <506ba498-ba50-9415-18b3-bcaff1561c55@oracle.com>
 <20200310084758-mutt-send-email-mst@kernel.org>
 <1f4766b2-9683-8ebf-752e-a0378bb0cbc3@oracle.com>
 <20200310094350-mutt-send-email-mst@kernel.org>
 <6d3c248f-f8fe-754d-59e5-8f2740a55263@oracle.com>
 <20200310133646-mutt-send-email-mst@kernel.org>
 <91053e38-8bd1-d316-acd0-561dfc016fd5@oracle.com>
 <20200310174604-mutt-send-email-mst@kernel.org>
 <e5b9ddc1-b0dc-6f95-50e3-5a4a5b8933a3@oracle.com>
MIME-Version: 1.0
In-Reply-To: <e5b9ddc1-b0dc-6f95-50e3-5a4a5b8933a3@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 11:59:29PM +0200, Liran Alon wrote:
>=20
> On 10/03/2020 23:49, Michael S. Tsirkin wrote:
> > On Tue, Mar 10, 2020 at 11:34:00PM +0200, Liran Alon wrote:
> > > On 10/03/2020 23:16, Michael S. Tsirkin wrote:
> > > > On Tue, Mar 10, 2020 at 04:46:19PM +0200, Liran Alon wrote:
> > > > > There is no license issue here. It's only definitions.
> > > > So it seems that in your opinion
> > > > - definition names in the interface do not need a license
> > > > and
> > > > - it is fair to reuse them without a license for the purpose
> > > >     of making your compatible interface easier to use for
> > > >     people familiar with the original
> > > >=20
> > > > Did I get that right?
> > > I'm for sure not an expert on open source code licenses. You probably=
 know
> > > this area much more than I do.
> > > But yes, this is what I would have thought. That it's not an issue to=
 copy
> > > the enum definition.
> > I'm not a lawyer. I think attribution is important even for small
> > things, and it was missing in v1. v2 has it but link would be better.  =
I
> > also think respecting author's wishes is important, and a license gives
> > a hint as to that.
> >=20
> Oh maybe I misunderstood you.
> So you're saying I should just add a link to open-vm-tools git-repo for
> attribution?

I even posted a code snippet, feel free to reuse.

> Which author's wishes you refer to?
>=20
> -Liran

I really just said one should check before copying code.
In this case if we don't really need to make vmport depend on GPL only
code we shouldn't since original author wanted it to be copyleft.

--=20
MST



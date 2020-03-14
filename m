Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532DCC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 19:15:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC812078B
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 19:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAOnJQSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC812078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDCFz-0004Lx-8v
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 15:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jDCFG-0003rZ-PX
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 15:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jDCFE-0003IJ-Vm
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 15:14:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41862
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jDCFE-0003ER-Pb
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 15:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584213288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v3sXLBOJuzDiLhTyky69dLbKcFVDrFgNFAQLBcP9K8Q=;
 b=LAOnJQSvPO2UrYPgxwt7b3pmNZMH14LtSzlC10qvc5S8VVt6yPl0m2q9vC78mnvq1Q//Xw
 6oQspBwnq0/K+qrd2rJBr4Et42eTuZYZ4Mu1kdYwNuddCc8niKXdSLFo7UcARkgwRpRCV9
 qS1jsyhxlSah3Ab8WIczzaBQTjUGkpA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-B-dtyXYAP-KCgXJjrjz3KQ-1; Sat, 14 Mar 2020 15:14:46 -0400
X-MC-Unique: B-dtyXYAP-KCgXJjrjz3KQ-1
Received: by mail-qv1-f72.google.com with SMTP id t3so88274qvr.13
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 12:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tRVS0CfVkTmLfZsFBhhjDwAX5mfd5nhgZ5r/3Cq2C+Y=;
 b=Aro5F4xzye2gNJvTy9DiTI+KYzfRFInRdU8MiXizej42kDNiuWT35+lMpp6g0fzRhK
 qzrOt8JnGY462RszxNW1m+fF6BJooPkSKYJ6VLmjWtUsHB/CWimISTok4y1RP+xdJMNd
 xnqFljYjcmkOk1fVqB/t7P3gyb8/hZdJLh7tkSQcN3EzqvKiKXz0JhU39WxByMU49XcU
 wijllNoBQTrW30knDOQcjKkzaEv8MpZjf7zPUxprt4nAac6Kpz1hOt2d/sW8GdV9PqN2
 4u4rczu6ZTwGOkn5N+EN0bI+pqxNVgv6xQ0GvLLxVN49KEpljkRqo3QW4fjymWj9rez6
 QUaA==
X-Gm-Message-State: ANhLgQ2AQekaTmU9qIhiZxZfU6cC4vyBTOmycuFGOJ8jC/IZDH1egBtu
 XrlX/pbZexbjFEuqZDPnx7KFdFIisDPQ72eB9tY19gEDyn5eXoUWb+1SxyRBrx4aWBx0qUaa4w1
 XFubo81G0RKrwmRU=
X-Received: by 2002:ac8:7410:: with SMTP id p16mr18492698qtq.70.1584213285965; 
 Sat, 14 Mar 2020 12:14:45 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vst8NLc6BhjwAwZ/tYn0alkDrQxY1v+pTalyzxeA96Zbm94ZSp/ceaUYvCXvUfMm6Tg/Wn1wQ==
X-Received: by 2002:ac8:7410:: with SMTP id p16mr18492683qtq.70.1584213285659; 
 Sat, 14 Mar 2020 12:14:45 -0700 (PDT)
Received: from redhat.com (bzq-79-180-7-202.red.bezeqint.net. [79.180.7.202])
 by smtp.gmail.com with ESMTPSA id
 v1sm9052459qtc.30.2020.03.14.12.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2020 12:14:44 -0700 (PDT)
Date: Sat, 14 Mar 2020 15:14:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v3 10/16] hw/i386/vmport: Add support for CMD_GETTIME
Message-ID: <20200314151236-mutt-send-email-mst@kernel.org>
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-11-liran.alon@oracle.com>
 <20200312195652-mutt-send-email-mst@kernel.org>
 <0bc7dac9-41a6-5af2-a1d5-ef1e79f92eea@oracle.com>
 <20200313113049-mutt-send-email-mst@kernel.org>
 <3c0d9308-f56c-0766-9815-241a28d9a246@oracle.com>
 <20200313170914-mutt-send-email-mst@kernel.org>
 <67d158f3-9d6c-cba8-6b3a-87702abdc6f0@oracle.com>
MIME-Version: 1.0
In-Reply-To: <67d158f3-9d6c-cba8-6b3a-87702abdc6f0@oracle.com>
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

On Sat, Mar 14, 2020 at 09:04:30PM +0200, Liran Alon wrote:
>=20
> On 14/03/2020 20:18, Michael S. Tsirkin wrote:
> > On Fri, Mar 13, 2020 at 06:26:54PM +0200, Liran Alon wrote:
> > > On 13/03/2020 17:47, Michael S. Tsirkin wrote:
> > > > On Fri, Mar 13, 2020 at 05:25:20PM +0200, Liran Alon wrote:
> > > > > > > @@ -168,6 +169,20 @@ static uint32_t vmport_cmd_ram_size(void=
 *opaque, uint32_t addr)
> > > > > > >         return ram_size;
> > > > > > >     }
> > > > > > > +static uint32_t vmport_cmd_time(void *opaque, uint32_t addr)
> > > > > > > +{
> > > > > > > +    X86CPU *cpu =3D X86_CPU(current_cpu);
> > > > > > > +    qemu_timeval tv;
> > > > > > > +
> > > > > > > +    if (qemu_gettimeofday(&tv) < 0) {
> > > > > > > +        return UINT32_MAX;
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    cpu->env.regs[R_EBX] =3D (uint32_t)tv.tv_usec;
> > > > > > > +    cpu->env.regs[R_ECX] =3D port_state->max_time_lag_us;
> > > > > > > +    return (uint32_t)tv.tv_sec;
> > > > > > > +}
> > > > > > > +
> > > > > > >     /* vmmouse helpers */
> > > > > > >     void vmmouse_get_data(uint32_t *data)
> > > > > > >     {
> > > > > > That's a very weird thing to return to the guest.
> > > > > > For example it's not monotonic across migrations.
> > > > > That's the VMware PV interface... I didn't design it. :P
> > > > > Regarding how it handles the fact time is not monotonic across mi=
grations,
> > > > > see big comment at the start of services/plugins/timeSync/timeSyn=
c.c in
> > > > > open-vm-tools regarding the time-sync algorithm used by VMware To=
ols.
> > > > > Specifically:
> > > > > """
> > > > > During normal operation this plugin only steps the time forward a=
nd only if
> > > > > the error is greater than one second.
> > > > Looks like guest assumes this time only moves forward.
> > > > So something needs to be done to avoid it moving
> > > > backward across migrations.
> > > Where do you see this assumption in guest code? I don't think this is=
 true.
> > > Guest code seems to handle this by making sure to only step the time
> > > forward.
> > Exactly. So if host time moved backward e.g. by 100s, then for 100s
> > time is not correcting. Which possibly vmware has a way to mitigate
> > against e.g. by synchronising host time using their
> > management app.
> >=20
> > > Read carefully services/plugins/timeSync/timeSync.c and point me to w=
hat I'm
> > > missing if you think otherwise (i.e. I missed something).
> > I'm just going by what you write in a patch.
> >=20
> So guest doesn't assume that this time only moves forward...
>=20
> Can you clarify then which change do you suggest making to this patch in
> this regard? It seems correct to me.
> i.e. The CMD_GETTIME implementation seems correct to me and it doesn't ne=
ed
> to do anything special to handle host time moving backwards.
>=20
> -Liran
>=20

I think something needs to be done to make sure host time as reported by
this command does not move backwards significantly. Just forwarding
gettimeofday won't cut it IMHO. Look at kvm clock for inspiration of
things to do.


--=20
MST



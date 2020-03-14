Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB015C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 19:27:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B56D2078D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 19:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VU3a0P4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B56D2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDCRu-0007nl-Mo
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 15:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jDCR4-0007Mx-Py
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 15:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jDCR3-0007st-D0
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 15:27:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51785
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jDCR3-0007hd-4J
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 15:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584214020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DEs6Tx2qHJrOSNw2MC/NA2bdnk5cmZ5/i4HgfDf3+5o=;
 b=VU3a0P4n8l1kzL52FQ3LVOVaithXWVsizmWh98PT6H/3I6fLGmF8mJ+yIqZJ3H59yh/uCX
 gVYLpZQpTePEVgiUPV3thVom7S8nw0BxK83geJ28eqqwgEIfmniyX8+WMuD7u7MUIEKCO/
 UiAK3EO/L7nSTHC2Y7ERIY/AimAcLgI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-M5_rVDBDNoOvuMjzQM7ulg-1; Sat, 14 Mar 2020 15:26:58 -0400
X-MC-Unique: M5_rVDBDNoOvuMjzQM7ulg-1
Received: by mail-qk1-f198.google.com with SMTP id x21so12428857qkn.18
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 12:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ilY0zq7onuXofhBJ9pn/QoLEtsF23S44E8wCL7gwM0Y=;
 b=TSWxM+xYAmNU3mFx+AKbmEo10wMuHpvOF9CNmkUwVPshrXii6t3plugbm6ZIGkTC+s
 cc2Gt2ObzV7MYOri7HcSb9++Qt9BQIXzpH45gSquU+nshne9OKgznH30Ge0L3/6ECsG1
 ttKrO1snTL8WmNdLF6DWig17kNXryN944UW8PE9ZXi166XDFwlPZwmuVrMsWUw/mFHN9
 Z4D5xOUIIKiOTcH+BNru6BA4v1I5VsY3Cc2sqs5Eoe18DL9C6DY8Surngasot3xXZWKg
 Wyq3+T11aCKTCSW1SiuTmI1VxUtDaJNKT4/jgDsLUCFBbQzIoWTd4+tsS237znrTlcTW
 Ygbw==
X-Gm-Message-State: ANhLgQ23uPLmfxYt31/d0NOfY/APdCIGN2qcTwBGNVcDT/XNArnUG9j2
 V6f8ZcWbG3VmHqFTuHipgOXZoKO6Zu2Oj3XXtc40Ih8fLZ5Yleew9VeSruqo+kBIJHylhWBSTso
 2LJhW+RTR4zHEQqI=
X-Received: by 2002:ac8:4659:: with SMTP id f25mr11080186qto.273.1584214017609; 
 Sat, 14 Mar 2020 12:26:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs38rhKKkjyaJtWAo+QuHZTqoo+IhbmOzSqwuSv0+UiW4s0yiPAVV1SMtuYDpTHWi5mh/MRBg==
X-Received: by 2002:ac8:4659:: with SMTP id f25mr11080171qto.273.1584214017356; 
 Sat, 14 Mar 2020 12:26:57 -0700 (PDT)
Received: from redhat.com (bzq-79-180-7-202.red.bezeqint.net. [79.180.7.202])
 by smtp.gmail.com with ESMTPSA id
 w4sm18495330qts.92.2020.03.14.12.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2020 12:26:56 -0700 (PDT)
Date: Sat, 14 Mar 2020 15:26:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v3 10/16] hw/i386/vmport: Add support for CMD_GETTIME
Message-ID: <20200314152119-mutt-send-email-mst@kernel.org>
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-11-liran.alon@oracle.com>
 <20200312195652-mutt-send-email-mst@kernel.org>
 <0bc7dac9-41a6-5af2-a1d5-ef1e79f92eea@oracle.com>
 <20200313113049-mutt-send-email-mst@kernel.org>
 <3c0d9308-f56c-0766-9815-241a28d9a246@oracle.com>
 <20200313170914-mutt-send-email-mst@kernel.org>
 <67d158f3-9d6c-cba8-6b3a-87702abdc6f0@oracle.com>
 <20200314151236-mutt-send-email-mst@kernel.org>
 <a9ac1106-67be-5d5d-fd30-669a483f09b0@oracle.com>
MIME-Version: 1.0
In-Reply-To: <a9ac1106-67be-5d5d-fd30-669a483f09b0@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Sat, Mar 14, 2020 at 09:17:30PM +0200, Liran Alon wrote:
>=20
> On 14/03/2020 21:14, Michael S. Tsirkin wrote:
> > On Sat, Mar 14, 2020 at 09:04:30PM +0200, Liran Alon wrote:
> > > On 14/03/2020 20:18, Michael S. Tsirkin wrote:
> > > > On Fri, Mar 13, 2020 at 06:26:54PM +0200, Liran Alon wrote:
> > > > > On 13/03/2020 17:47, Michael S. Tsirkin wrote:
> > > > > > On Fri, Mar 13, 2020 at 05:25:20PM +0200, Liran Alon wrote:
> > > > > > > > > @@ -168,6 +169,20 @@ static uint32_t vmport_cmd_ram_size(=
void *opaque, uint32_t addr)
> > > > > > > > >          return ram_size;
> > > > > > > > >      }
> > > > > > > > > +static uint32_t vmport_cmd_time(void *opaque, uint32_t a=
ddr)
> > > > > > > > > +{
> > > > > > > > > +    X86CPU *cpu =3D X86_CPU(current_cpu);
> > > > > > > > > +    qemu_timeval tv;
> > > > > > > > > +
> > > > > > > > > +    if (qemu_gettimeofday(&tv) < 0) {
> > > > > > > > > +        return UINT32_MAX;
> > > > > > > > > +    }
> > > > > > > > > +
> > > > > > > > > +    cpu->env.regs[R_EBX] =3D (uint32_t)tv.tv_usec;
> > > > > > > > > +    cpu->env.regs[R_ECX] =3D port_state->max_time_lag_us=
;
> > > > > > > > > +    return (uint32_t)tv.tv_sec;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >      /* vmmouse helpers */
> > > > > > > > >      void vmmouse_get_data(uint32_t *data)
> > > > > > > > >      {
> > > > > > > > That's a very weird thing to return to the guest.
> > > > > > > > For example it's not monotonic across migrations.
> > > > > > > That's the VMware PV interface... I didn't design it. :P
> > > > > > > Regarding how it handles the fact time is not monotonic acros=
s migrations,
> > > > > > > see big comment at the start of services/plugins/timeSync/tim=
eSync.c in
> > > > > > > open-vm-tools regarding the time-sync algorithm used by VMwar=
e Tools.
> > > > > > > Specifically:
> > > > > > > """
> > > > > > > During normal operation this plugin only steps the time forwa=
rd and only if
> > > > > > > the error is greater than one second.
> > > > > > Looks like guest assumes this time only moves forward.
> > > > > > So something needs to be done to avoid it moving
> > > > > > backward across migrations.
> > > > > Where do you see this assumption in guest code? I don't think thi=
s is true.
> > > > > Guest code seems to handle this by making sure to only step the t=
ime
> > > > > forward.
> > > > Exactly. So if host time moved backward e.g. by 100s, then for 100s
> > > > time is not correcting. Which possibly vmware has a way to mitigate
> > > > against e.g. by synchronising host time using their
> > > > management app.
> > > >=20
> > > > > Read carefully services/plugins/timeSync/timeSync.c and point me =
to what I'm
> > > > > missing if you think otherwise (i.e. I missed something).
> > > > I'm just going by what you write in a patch.
> > > >=20
> > > So guest doesn't assume that this time only moves forward...
> > >=20
> > > Can you clarify then which change do you suggest making to this patch=
 in
> > > this regard? It seems correct to me.
> > > i.e. The CMD_GETTIME implementation seems correct to me and it doesn'=
t need
> > > to do anything special to handle host time moving backwards.
> > >=20
> > > -Liran
> > >=20
> > I think something needs to be done to make sure host time as reported b=
y
> > this command does not move backwards significantly. Just forwarding
> > gettimeofday won't cut it IMHO. Look at kvm clock for inspiration of
> > things to do.
> >=20
> It isn't required by the command interface definition.
> It's explicitly specified in timeSync.c that guest code handles the case
> host time goes backwards.

According to what you wrote it does not crash but also does not do
updates. That will work well only if the time difference isn't large.
Then with time as guest gets interrupted by host, the time difference
shrinks and eventually you are resyncing again.  And I'm guessing there
are hypervisor management interfaces in place to make sure that is so.
Linux is not guaranteed to have such interfaces so you have to come
up with QEMU specific ones.


> We are not inventing the interface, we just implement it according to it'=
s
> definition.
>=20
> -Liran

Host time is a vague enough terminology. I suspect this implementation
is too simplistic to cover all cases.

--=20
MST



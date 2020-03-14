Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E93C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 18:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21B0D20751
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 18:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0FAy24o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B0D20751
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDBNd-0006lk-9R
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 14:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jDBMy-0006EP-3G
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 14:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jDBMv-0000HC-HN
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 14:18:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56162
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jDBMv-0000Ai-Aq
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 14:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584209920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kUgTNr0H0/JSBJjEYVR12JgdzWy84UQtuE7u2d+2kMc=;
 b=A0FAy24ojw6YhOBPL+ZVHQ2ebRh0jV1nXZvB5A2rfLxjEaXjwkxpg/B7MKTFjzk84uxyR0
 8npqml7sbsRcLqzYFwhPpJUSc4L9hFAIm8LBfMU0RIt3Vr8FiGZGA1HHBl55OCfaqJJWao
 GLaAXHqMYlp8t6NfIeAeaJqubEozmQU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-BJkt3-CDMe6v8eJbLYy_4g-1; Sat, 14 Mar 2020 14:18:36 -0400
X-MC-Unique: BJkt3-CDMe6v8eJbLYy_4g-1
Received: by mail-wr1-f70.google.com with SMTP id o9so6271823wrw.14
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 11:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JsMidcAh4+41u0NxG/5sCM6Yds79JFRSq6ZsIkV8NhU=;
 b=ljYMetjCbi2xS1bZ2+CZC3F4KxQI5b5/LXERxvbelms+s0LZ1cu8gaXbOJYP0gnjWK
 qd2d2AHbUVkloUmjNbVycTGBJgBZanX1j91Go7rQ8tUJBaa6rhCd/R05I1uXuWSrLBvN
 WFg+3RQAsRoVeBqUpAaGriyFrFcx5+IcHcvHhu35RG+sI7BQDc03FhIs/JTDxMDwhC/d
 o86arRzNttIZ7A08afBYXvvlcCXnOzi8wzJHxr6q1qyByi2NbpndU10Czm6Fo/z7DHra
 sWqEMTNekBgxSYCMFQzENeFPz0hhdpWxbodXzpar9v/f8WR2PALCYk4WrZat1OzXFH0o
 zpiA==
X-Gm-Message-State: ANhLgQ0V9i/r3iBlSzh/U4FTD7JG71s/WLRlPiqVpCVzxXbIhxAj5W8V
 bzEpOc3jeUt/EVcVwcWKWKRJqaM6kqhRvasOX328g6mCGI0Wn/k1BqGMT8rffYYpndkRjRBHiNA
 7XN9DlR5YkTUIMEU=
X-Received: by 2002:adf:fa87:: with SMTP id h7mr14311879wrr.50.1584209915129; 
 Sat, 14 Mar 2020 11:18:35 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt5tCwZO4+py0pwNIVfSG/nnIWkFeQE2XK4zceuwHn+6Xw/HSnGEZlhJtnDhDaZziIjDaMZQw==
X-Received: by 2002:adf:fa87:: with SMTP id h7mr14311855wrr.50.1584209914833; 
 Sat, 14 Mar 2020 11:18:34 -0700 (PDT)
Received: from redhat.com (bzq-79-180-7-202.red.bezeqint.net. [79.180.7.202])
 by smtp.gmail.com with ESMTPSA id
 n186sm1692774wme.25.2020.03.14.11.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2020 11:18:33 -0700 (PDT)
Date: Sat, 14 Mar 2020 14:18:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v3 10/16] hw/i386/vmport: Add support for CMD_GETTIME
Message-ID: <20200313170914-mutt-send-email-mst@kernel.org>
References: <20200312165431.82118-1-liran.alon@oracle.com>
 <20200312165431.82118-11-liran.alon@oracle.com>
 <20200312195652-mutt-send-email-mst@kernel.org>
 <0bc7dac9-41a6-5af2-a1d5-ef1e79f92eea@oracle.com>
 <20200313113049-mutt-send-email-mst@kernel.org>
 <3c0d9308-f56c-0766-9815-241a28d9a246@oracle.com>
MIME-Version: 1.0
In-Reply-To: <3c0d9308-f56c-0766-9815-241a28d9a246@oracle.com>
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

On Fri, Mar 13, 2020 at 06:26:54PM +0200, Liran Alon wrote:
>=20
> On 13/03/2020 17:47, Michael S. Tsirkin wrote:
> > On Fri, Mar 13, 2020 at 05:25:20PM +0200, Liran Alon wrote:
> > > > > @@ -168,6 +169,20 @@ static uint32_t vmport_cmd_ram_size(void *op=
aque, uint32_t addr)
> > > > >        return ram_size;
> > > > >    }
> > > > > +static uint32_t vmport_cmd_time(void *opaque, uint32_t addr)
> > > > > +{
> > > > > +    X86CPU *cpu =3D X86_CPU(current_cpu);
> > > > > +    qemu_timeval tv;
> > > > > +
> > > > > +    if (qemu_gettimeofday(&tv) < 0) {
> > > > > +        return UINT32_MAX;
> > > > > +    }
> > > > > +
> > > > > +    cpu->env.regs[R_EBX] =3D (uint32_t)tv.tv_usec;
> > > > > +    cpu->env.regs[R_ECX] =3D port_state->max_time_lag_us;
> > > > > +    return (uint32_t)tv.tv_sec;
> > > > > +}
> > > > > +
> > > > >    /* vmmouse helpers */
> > > > >    void vmmouse_get_data(uint32_t *data)
> > > > >    {
> > > > That's a very weird thing to return to the guest.
> > > > For example it's not monotonic across migrations.
> > > That's the VMware PV interface... I didn't design it. :P
> > > Regarding how it handles the fact time is not monotonic across migrat=
ions,
> > > see big comment at the start of services/plugins/timeSync/timeSync.c =
in
> > > open-vm-tools regarding the time-sync algorithm used by VMware Tools.
> > > Specifically:
> > > """
> > > During normal operation this plugin only steps the time forward and o=
nly if
> > > the error is greater than one second.
> > Looks like guest assumes this time only moves forward.
> > So something needs to be done to avoid it moving
> > backward across migrations.
> Where do you see this assumption in guest code? I don't think this is tru=
e.
> Guest code seems to handle this by making sure to only step the time
> forward.

Exactly. So if host time moved backward e.g. by 100s, then for 100s
time is not correcting. Which possibly vmware has a way to mitigate
against e.g. by synchronising host time using their
management app.

> Read carefully services/plugins/timeSync/timeSync.c and point me to what =
I'm
> missing if you think otherwise (i.e. I missed something).

I'm just going by what you write in a patch.

> > > """
> > > > And what does max_time_lag_us refer to, anyway?
> > > According to the comment in open-vm-tools TimeSyncReadHost():
> > > """
> > > maximum time lag allowed (config option), which is a threshold that k=
eeps
> > > the tools from being over eager about resetting the time when it is o=
nly a
> > > little bit off.
> > > """
> > >=20
> > > Looking at open-vm-tools timeSync.c code, it defines the threshold of=
 how
> > > far guest time can be from host time before deciding to do a "step
> > > correction".
> > > A "step correction" is defined as explicitly setting the time in the =
guest
> > > to the time in the host.
> > > >=20
> > > > So please add documentation about what this does.
> > > You are right. I agree.
> > > I think it would be best to just point to open-vm-tools
> > > services/plugins/timeSync/timeSync.c.
> > > Do you agree or should I copy some paragraphs from there?
> > Neither. Their documentation will be from guest point of view.  Please
> > look at that code and write documentation from host point of view.
> > Your documentation for the lag parameter is I think a good
> > example of how to do it.
> Ok. Will try to phrase something for v4.
> >=20
> > > > If there's no document to refer to then pls write
> > > > code comments or a document under docs/ - this does not
> > > > belong in commit log.
> > > >=20
> > > >=20
> > > >=20
> > > > > @@ -214,6 +229,7 @@ static void vmport_realizefn(DeviceState *dev=
, Error **errp)
> > > > >        vmport_register(VMPORT_CMD_GETRAMSIZE, vmport_cmd_ram_size=
, NULL);
> > > > >        if (s->compat_flags & VMPORT_COMPAT_CMDS_V2) {
> > > > >            vmport_register(VMPORT_CMD_GETBIOSUUID, vmport_cmd_get=
_bios_uuid, NULL);
> > > > > +        vmport_register(VMPORT_CMD_GETTIME, vmport_cmd_time, NUL=
L);
> > > > >        }
> > > > >    }
> > > > > @@ -249,6 +265,11 @@ static Property vmport_properties[] =3D {
> > > > >         * 5 - ACE 1.x (Deprecated)
> > > > >         */
> > > > >        DEFINE_PROP_UINT8("vmware-vmx-type", VMPortState, vmware_v=
mx_type, 2),
> > > > > +    /*
> > > > > +     * Max amount of time lag that can go uncorrected.
> > > > What does uncorrected mean?
> > > You are right this is a bad phrasing taken from open-vm-tools.
> > > It should mean "How far we allow guest time to go from host time befo=
re
> > > guest VMware Tools will sync it to host time".
> > > How you prefer to phrase this?
> > Sounds like a good explanation. Maybe we allow -> can
> > since "we" is hypervisor and it's actually under guest control.
> Ok. Will add this to v4.
> >=20
> >=20
> > > > > +     * Value taken from VMware Workstation 5.5.
> > > > How do we know this makes sense for KVM? That has significantly
> > > > different runtime characteristics.
> > > This is just a threshold as you can understand from the above reply o=
f mine
> > > (I should rephrase the comments to make this clearer).
> > > So we just chose a threshold that makes sense for common workloads.
> > > One of the reasons to put this as a property, is to still allow user =
to
> > > override it.
> > Well close to 100% of users will have no idea what to set it to.
> I agree. :) That's why there is a default value.
> >=20
> >=20
> > > >=20
> > > > Also, the version returns ESX server, why does it make
> > > > sense to take some values from workstation?
> > > I believe (don't remember) that ESXi was observed to return similar v=
alue.
> > > Most of our workloads that runs with this came from ESXi and we never
> > > examined an issue regarding this in our production environment.
> > > Which makes sense as this is just a thresthold that specifies when gu=
est
> > > time should be synced to host time.
> > > You prefer I would just remove this comment?
> > Maybe add " TODO: should this depend on vmare-vmx-type? ".
>=20
> Ok. Will add to v4.
>=20
> Thanks,
> -Liran
>=20



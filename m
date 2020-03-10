Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E0AC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 14:40:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3343F20848
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 14:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YabmGjdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3343F20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBg3t-00065Q-Fk
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 10:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBg3D-0005aC-2e
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBg3B-00024J-Rf
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:40:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57777
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBg3B-00023g-N7
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583851205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F3fjsmRleaLKra6RhiVl8ud63m2+oikvRtyy7O5tLck=;
 b=YabmGjdEWL1vvLY0Z5UamWg9JXRls56NWnTm4HLF5Vya/jDh2hX78ZvaFgf9jsuJn6Jvjh
 eIgOVkim2E02sPJ7vQ4j/GQt0kQ4SamYVfV4z0vhV+oMIO5P4QBQKDaXGci4knK2gUU7D0
 asVoVl+iZI951pWUQqkYsKvLQxye/zw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-Gk1YO-S2Nui3UjyBcavscA-1; Tue, 10 Mar 2020 10:40:01 -0400
X-MC-Unique: Gk1YO-S2Nui3UjyBcavscA-1
Received: by mail-qk1-f198.google.com with SMTP id a21so9851396qkg.6
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 07:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bD/1ypvq1QpOFCTcrz5iEfXt2h85auzgRqV4onTJ0Bk=;
 b=NuVg77RQ1r1rgVew173iN5mRKq0HqiVODBRaslvJHZtfWljBJhwy8nEn9JZvAG31dl
 igSpKFCU5LWM9rQcb3m6f7NHoQU53voypGVPlAh8GkDu/IoH0pwOrnfhp7YIWncp9DEu
 GWayyMJtKF+sXx3sH9qskwL5JiM6ioRwMcuPp02PL9EC7eWWQu5pOxR/CqFVsW53yKR9
 1vBzDyBIK/HTtvHf+YG216w8GOlLXp0/MzyHN3WoC6kiBX2X2rnYdkfzTvLCRgyYw0LT
 reG+qDI1aJtAvVrfqNd5zSJDg35kiaZ04pw3Qg/lQBWKgG3sjgA0EPAfQIbWpE9vZcNI
 5vxg==
X-Gm-Message-State: ANhLgQ3fzCQML+SbVosH4anrO0T5SQnSC6erWhXaZxkDOQwXfDS7+Vgf
 Dg8dPxm6/T9RbPIRVQ2Io5tvwE3fbuj227O9UTG2ZjwyHY0I818S8x/C66RuRMmjCfJFbQ0ozSi
 5n8z7eQ0IaRDs2kw=
X-Received: by 2002:ac8:8d6:: with SMTP id y22mr18501068qth.85.1583851201020; 
 Tue, 10 Mar 2020 07:40:01 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtOJ6Cpoufee0fVl7dE8wU27rUi6hFVWoCTeJoIJBvTMqSXszoqIarwvZbWK8qM4J6/qIyRDQ==
X-Received: by 2002:ac8:8d6:: with SMTP id y22mr18501042qth.85.1583851200690; 
 Tue, 10 Mar 2020 07:40:00 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id v19sm8316734qtb.67.2020.03.10.07.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 07:39:59 -0700 (PDT)
Date: Tue, 10 Mar 2020 10:39:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 07/14] hw/i386/vmport: Add support for CMD_GETBIOSUUID
Message-ID: <20200310103555-mutt-send-email-mst@kernel.org>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-8-liran.alon@oracle.com>
 <20200310053305-mutt-send-email-mst@kernel.org>
 <9213671d-75e9-b4d6-6e3d-c9221c2b7cc4@oracle.com>
 <20200310071934-mutt-send-email-mst@kernel.org>
 <0a826472-2fd4-75f8-2b32-9029fe980556@oracle.com>
MIME-Version: 1.0
In-Reply-To: <0a826472-2fd4-75f8-2b32-9029fe980556@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On Tue, Mar 10, 2020 at 04:24:45PM +0200, Liran Alon wrote:
>=20
> On 10/03/2020 13:22, Michael S. Tsirkin wrote:
> > On Tue, Mar 10, 2020 at 01:13:21PM +0200, Liran Alon wrote:
> > > On 10/03/2020 11:34, Michael S. Tsirkin wrote:
> > > > On Tue, Mar 10, 2020 at 01:54:04AM +0200, Liran Alon wrote:
> > > > > This is VMware documented functionallity that some guests rely on=
.
> > > > > Returns the BIOS UUID of the current virtual machine.
> > > > >=20
> > > > > Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> > > > > Signed-off-by: Liran Alon <liran.alon@oracle.com>
> > > > So this at least seems guest-visible.
> > > >=20
> > > > So I suspect you need to add properties to
> > > > disable this for old machine types, to avoid
> > > > breaking compatibility with live-migration.
> > > It is indeed guest visible.
> > > In theory, you are right that for every guest-visible change, we shou=
ld make
> > > sure to expose it to only new machine-types.
> > >=20
> > > However, in this case, I feel it just unnecessary over-complicates th=
e code.
> > > I don't see how a guest which previously failed to use this command, =
will
> > > fail because after Live-Migration it could succeed.
> > The reverse can happen, start guest on a new qemu, command seems to
> > work, then we migrate and it fails.
> >=20
> > And I guess this applies to the version right?
> >=20
> > > If you insist, I will add such functionality. In that case, do you th=
ink a
> > > single flag will suffice for the addition of all new commands
> > > (i.e. "commands-version" that it's number specifies set of commands t=
o
> > > expose), or you want to have a per-command flag?
> > >=20
> > > -Liran
> > Can be a single flag but I'd just do it a boolean that enables a group
> > of commands. E.g. "commands-v2".
> >=20
> Re-thinking about this...
>=20
> QEMU VMPort interface was quite broken already (See first patch in series
> "hw/i386/vmport: Propagate IOPort read to vCPU EAX register").
> The introduction of that fix already changes the result of all existing
> commands from guest perspective which relied on return-value from
> vmport_ioport_read().
> E.g. CMD_GETVERSION and CMD_GETRAMSIZE.
>=20
> In theory, we should have also made that bug-fix be tied to machine-type.=
 To
> similarly avoid the issue of migrating a VM from a working VMPort command
> implementation to a non-working one.
> i.e. In case of migrating from new QEMU to old QEMU. Do we wish to create=
 a
> property-flag for that fix as-well?

Yes, I meants that too. Just include everything in the same property.

> Or can we just drop all the machine-type
> flags alltogether (Including the suggested "commands-v2")
> and declare this the first actually working VMPort implementation?
>=20
> -Liran

It's hard to be sure no one used this, and the overhead isn't big.  But
that would be a maintainer call. In any case you need to call this out
explicitly in the commit log, and I guess block migration for old
machine types.



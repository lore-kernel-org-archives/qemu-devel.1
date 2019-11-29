Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA167C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C7620869
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hiKg9E2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C7620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iafZf-0004Va-SZ
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 07:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iafUw-0002rj-2l
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:35:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iafUq-0004m8-M2
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:35:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54823)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iafUq-0004en-H5
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575030938;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U+CYnFvYDi6FYD+y7yJFFnm6yKgXIwavdUPgdTQjdzc=;
 b=hiKg9E2kjD9pse7dgtkl5Nw13ytmQUggDHtpvg1VvNr40WeUvGpI9z0do2qP4bZRStUAH+
 74HPSyMlbkeQGfAf4v38zovDJFPhx2wqSTyzlehfk96vuhox2ZEHGBsCxUsBJU04/aTM0u
 JPE9jfaOgnW/g/zC+v8bxrdheAdC75M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-flm8b1w6PVqI4EGOQJyE1w-1; Fri, 29 Nov 2019 07:35:34 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 638F1593A6;
 Fri, 29 Nov 2019 12:35:33 +0000 (UTC)
Received: from redhat.com (ovpn-112-31.ams2.redhat.com [10.36.112.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A071C1001B09;
 Fri, 29 Nov 2019 12:35:27 +0000 (UTC)
Date: Fri, 29 Nov 2019 12:35:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 00/15] s390x: Protected Virtualization support
Message-ID: <20191129123524.GI2260471@redhat.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191129110820.GF2260471@redhat.com>
 <699bb3bc-f42a-2fcf-acb3-b91d783e7ce4@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <699bb3bc-f42a-2fcf-acb3-b91d783e7ce4@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: flm8b1w6PVqI4EGOQJyE1w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 29, 2019 at 01:14:27PM +0100, Janosch Frank wrote:
> On 11/29/19 12:08 PM, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Nov 20, 2019 at 06:43:19AM -0500, Janosch Frank wrote:
> >> Most of the QEMU changes for PV are related to the new IPL type with
> >> subcodes 8 - 10 and the execution of the necessary Ultravisor calls to
> >> IPL secure guests. Note that we can only boot into secure mode from
> >> normal mode, i.e. stfle 161 is not active in secure mode.
> >>
> >> The other changes related to data gathering for emulation and
> >> disabling addressing checks in secure mode, as well as CPU resets.
> >>
> >> While working on this I sprinkled in some cleanups, as we sometimes
> >> significantly increase line count of some functions and they got
> >> unreadable.
> >=20
> > Can you give some guidance on how management applications including
> > libvirt & layers above (oVirt, OpenStack, etc) would/should use this
> > feature ?  What new command line / monitor calls are needed, and
> > what feature restrictions are there on its use ?
>=20
> management applications generally do not need to know about this
> feature. Most of the magic is in the guest image, which boots up in a
> certain way to become a protected machine.
>=20
> The requirements for that to happen are:
> * Machine/firmware support
> * KVM & QEMU support
> * IO only with iommu
> * Guest needs to use IO bounce buffers
> * A kernel image or a kernel on a disk that was prepared with special
> tooling

If the user has a guest image that's expecting to run in protected
machine mode, presumably this will fail to boot if run on a host
which doesn't support this feature ?

As a mgmt app I think there will be a need to be able to determine
whether a host + QEMU combo is actually able to support protected
machines. If the mgmt app is given an image and the users says it
required protected mode, then the mgmt app needs to know which
host(s) are able to run it.

Doing version number checks is not particularly desirable, so is
there a way libvirt can determine if QEMU + host in general supports
protected machines, so that we can report this feature to mgmt apps ?


If a guest has booted & activated protected mode is there any way
for libvirt to query that status ? This would allow the mgmt app
to know that the guest is not going to be migratable thereafter.

Is there any way to prevent a guest from using protected mode even
if QEMU supports it ?  eg the mgmt app may want to be able to
guarantee that all VMs are migratable, so don't want a guest OS
secretly activating protected mode which blocks migration.

> Such VMs are started like any other VM and run a short "normal" stub
> that will prepare some things and then requests to be protected.
>=20
> Most of the restrictions are memory related and might be lifted in the
> future:
> * No paging
> * No migration

Presumably QEMU is going to set a migration blocker when a guest
activates protected mode ?

> * No huge page backings
> * No collaborative memory management

> There are no monitor changes or cmd additions currently.
> We're trying to insert protected VMs into the normal VM flow as much as
> possible. You can even do a memory dump without any segfault or
> protection exception for QEMU, however the guest's memory content will
> be unreadable because it's encrypted.

Is there any way to securely acquire a key needed to interpret this,
or is the memory dump completely useless ?

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|



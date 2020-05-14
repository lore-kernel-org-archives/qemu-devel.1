Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA17C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 09:48:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2CB206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 09:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Po754wdP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2CB206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZAU2-00020c-WA
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 05:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jZATR-0001Gs-Fh
 for qemu-devel@nongnu.org; Thu, 14 May 2020 05:48:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36163
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jZATP-0001Ls-GO
 for qemu-devel@nongnu.org; Thu, 14 May 2020 05:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589449694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wezZf97zHc1vER7xhcCBW4T6vrvcCMZsNkBbLhG1L4g=;
 b=Po754wdPdTajF/TTmELW8eTeDDRQO3qS7WDGeQefCTyxodo96tYsX2xnFwsfGNxd+UDWm1
 q1JLJbEywnmsMtw8zXCXYiUvC+DJbFa1ka8EXnn+XB9qFX6Hr5BTjDUwc5ZNDVLdMU6h1Z
 GQOU/VOhmRhpAVEVEbXEFeOKysvPPEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-qH78R0bUMeej200-QHx9lQ-1; Thu, 14 May 2020 05:48:10 -0400
X-MC-Unique: qH78R0bUMeej200-QHx9lQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D561E107B79F;
 Thu, 14 May 2020 09:48:07 +0000 (UTC)
Received: from localhost (unknown [10.40.208.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7CC8247337;
 Thu, 14 May 2020 09:47:48 +0000 (UTC)
Date: Thu, 14 May 2020 11:47:43 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jag Raman <jag.raman@oracle.com>
Subject: Re: [PATCH RESEND v6 01/36] memory: alloc RAM from file at offset
Message-ID: <20200514114743.6061dff4@redhat.com>
In-Reply-To: <C83E7EA9-7813-4C81-A635-E1A513902330@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <cb792b8d6f93d00c10790de8698c468b6ff4ab69.1587614626.git.elena.ufimtseva@oracle.com>
 <20200512084855.GC1191162@redhat.com>
 <B4DB4B9E-E7E3-4F1F-917C-898F9B150EFB@oracle.com>
 <20200513084042.GA317907@stefanha-x1.localdomain>
 <20200513172547.48d87447@redhat.com>
 <C83E7EA9-7813-4C81-A635-E1A513902330@oracle.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 John G Johnson <john.g.johnson@oracle.com>, qemu-devel@nongnu.org,
 kraxel@redhat.com, quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, Stefan Hajnoczi <stefanha@redhat.com>,
 pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 Daniel Berrange <berrange@redhat.com>, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 13 May 2020 16:08:06 -0400
Jag Raman <jag.raman@oracle.com> wrote:

> > On May 13, 2020, at 11:25 AM, Igor Mammedov <imammedo@redhat.com> wrote=
:
> >=20
> > On Wed, 13 May 2020 09:40:42 +0100
> > Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >  =20
> >> On Tue, May 12, 2020 at 07:56:33AM -0400, Jag Raman wrote: =20
> >>>=20
> >>>  =20
> >>>> On May 12, 2020, at 4:48 AM, Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> >>>>=20
> >>>> On Wed, Apr 22, 2020 at 09:13:36PM -0700, elena.ufimtseva@oracle.com=
 wrote:   =20
> >>>>> From: Jagannathan Raman <jag.raman@oracle.com>
> >>>>>=20
> >>>>> Allow RAM MemoryRegion to be created from an offset in a file, inst=
ead
> >>>>> of allocating at offset of 0 by default. This is needed to synchron=
ize
> >>>>> RAM between QEMU & remote process.   =20
> >>>>=20
> >>>> Can you elaborate on why remote processes require the RAM to be offs=
et
> >>>> from zero ?   =20
> >>>=20
> >>> Hi Daniel,
> >>>=20
> >>> As it turns out, the RAM is scattered across the physical address spa=
ce
> >>> (system_memory) of QEMU. Therefore, the system memory is composed
> >>> of multiple sections of RAM, and some sections start at a non-zero RA=
M
> >>> offset.
> >>>=20
> >>> As a result, the remote process needs the ability to map these RAM
> >>> sections into system_memory.   =20
> >>=20
> >> To explain a bit more, my understanding is that the offset is
> >> specifically for mmap(2). As Jag alluded to, multiple sections can use=
 a
> >> single backing RAM file. These sections have different offsets in the
> >> file.
> >>=20
> >> Jag, maybe you can include a concrete explanation like the following i=
n
> >> the commit description:
> >>=20
> >> Launch QEMU like this:
> >>=20
> >>  qemu-system-x86_64 -mem-path /dev/shm -m 8G
> >>=20
> >> There is only one RAM file descriptor:
> >>=20
> >>  $ cat /proc/$(pidof qemu)/fd
> >>  ...
> >>  lrwx------. 1 stefanha stefanha 64 May 13 09:34 19 -> '/dev/shm/qemu_=
back_mem.pc.ram.7YAlqn (deleted)'
> >>=20
> >> But the memory tree shows that single file is split into multiple rang=
es
> >> of guest physical address space:
> >>=20
> >>  (qemu) info mtree
> >>  memory-region: system
> >>  0000000000000000-ffffffffffffffff (prio 0, i/o): system
> >>    0000000000000000-00000000bfffffff (prio 0, i/o): alias ram-below-4g=
 @pc.ram 0000000000000000-00000000bfffffff
> >>    ...
> >>    0000000100000000-000000023fffffff (prio 0, i/o): alias ram-above-4g=
 @pc.ram 00000000c0000000-00000001ffffffff
> >>=20
> >> This means QEMU needs to send two regions to the remote device process=
.
> >> They both mmap the same file but from different starting file offsets.=
 =20
> >=20
> > are we talking here about GPA offests her or about host offsets in mmap=
ed host file?
> > If it's the later then above mtree doesn't show true picture (those ent=
ries are just aliases),
> > main guest RAM is allocated as a single continuous chunk (so far) which=
 belongs
> > to a memory-backend. =20
>=20
> Thanks for the info about =E2=80=98mtree=E2=80=99 QMP option. We=E2=80=99=
ll use that to better explain the need for offset
> during memory allocation.
>=20
> As we can observe from the =E2=80=98mtree=E2=80=99 output, different sect=
ions of system memory vector into the
> RAM. Since we have only one file descriptor available for all of RAM, we =
need to mmap() these
> sections at different offsets within the memory file.
>=20
> Hey Igor, the offset passed into the mmap() syscall is the offset within =
host file. Thanks for
> pointing out that these are aliases. I believe the mmap() operation is eq=
uivalent to the =E2=80=9Calias=E2=80=9D
> operation within MemoryRegion framework. We are sending the =E2=80=98fd=
=E2=80=99, =E2=80=98offset=E2=80=99 within the fd and
> the size of these RAM regions to the remote device over the unix socket. =
Hopefully, this looks
> good to you.

could you point to a specific patch where on remote device that is being re=
ceived and used?

>=20
> Thanks!
> --
> Jag
>=20
> >  =20
> >> Stefan =20
> >=20
> >  =20
>=20



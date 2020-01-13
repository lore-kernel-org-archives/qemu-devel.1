Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29EFC33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 14:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CDE820661
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 14:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gHW6t3bo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDE820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir16n-0005Y5-N2
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 09:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ir15n-0004cd-7p
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:53:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ir15i-0003WC-28
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:53:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60813
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ir15h-0003Vg-Ua
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578927197;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c8gJ8Vjw2GM971v7+eY/mXlqOnqJ53ZXdglBXcMK7eo=;
 b=gHW6t3bojG/GYNz4rMZhkBJIY8sfaeungq0GV0ncWOs5MFmW0dZj/DJRwY8/0FQtaR0ROJ
 5+bRC632gC7tLcSuUg3ML98SDXpwOTc17tAujyY/8XDwphLvByY+P089AKP4277Kwf6yio
 piov1GaYUEZg+9nZMP2JcqGvnRdavE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-PgTAkRagMZix3UAdvFZTzQ-1; Mon, 13 Jan 2020 09:53:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C4238024E2;
 Mon, 13 Jan 2020 14:53:13 +0000 (UTC)
Received: from redhat.com (ovpn-116-99.ams2.redhat.com [10.36.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5803B60FC4;
 Mon, 13 Jan 2020 14:53:01 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PULL 00/28] Migration pull patches
In-Reply-To: <20200113132632.GD4033206@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Mon, 13 Jan 2020 13:26:32 +0000")
References: <20200110173215.3865-1-quintela@redhat.com>
 <CAFEAcA97ZqynDV6b6YUL_7iF=zsmB2Mwogi0k4ViAUAFTwsTnA@mail.gmail.com>
 <20200113132632.GD4033206@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Mon, 13 Jan 2020 15:53:00 +0100
Message-ID: <878smbxvar.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: PgTAkRagMZix3UAdvFZTzQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Corey Minyard <cminyard@mvista.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Stefan Berger <stefanb@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>> I also saw this on aarch32 host (more precisely, on the
>> aarch32-environment-in-aarch64-chroot setup I use for aarch32 build
>> and test):
>>=20
>> malloc_consolidate(): invalid chunk size
>> Broken pipe
>> qemu-system-i386: check_section_footer: Read section footer failed: -5
>> qemu-system-i386: load of migration failed: Invalid argument
>> /home/peter.maydell/qemu/tests/libqtest.c:140: kill_qemu() tried to
>> terminate QEMU process but encountered exit status 1 (expected 0)
>> Aborted
>> ERROR - too few tests run (expected 14, got 13)
>>=20
>> The memory corruption is reproducible running just the
>> /x86_64/migration/multifd/tcp subtest:
>>=20
>> (armhf)pmaydell@mustang-maydell:~/qemu/build/all-a32$
>> QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
>> tests/migration-test -p /x86_64/migration/multifd/tcp
>> /x86_64/migration/multifd/tcp: qemu-system-x86_64: -accel kvm: invalid
>> accelerator kvm
>> qemu-system-x86_64: falling back to tcg
>> qemu-system-x86_64: -accel kvm: invalid accelerator kvm
>> qemu-system-x86_64: falling back to tcg
>> qemu-system-x86_64: multifd_send_sync_main: multifd_send_pages fail
>> qemu-system-x86_64: failed to save SaveStateEntry with id(name): 3(ram)
>> double free or corruption (!prev)
>> Broken pipe
>> qemu-system-x86_64: Unknown combination of migration flags: 0
>> qemu-system-x86_64: error while loading state section id 3(ram)
>> qemu-system-x86_64: load of migration failed: Invalid argument
>> /home/peter.maydell/qemu/tests/libqtest.c:140: kill_qemu() tried to
>> terminate QEMU process but encountered exit status 1 (expected 0)
>> Aborted
>>=20
>> Here's what a valgrind run in that aarch32 setup produces:
>>=20
>
> Missing initialization of     MultiFDInit_t msg; to all zeros

I *thought* it was in.  Sorry.

>
>> =3D=3D12102=3D=3D
>> =3D=3D12102=3D=3D Thread 6 multifdsend_1:
>> =3D=3D12102=3D=3D Invalid write of size 4
>> =3D=3D12102=3D=3D    at 0x25CC08: multifd_send_fill_packet (ram.c:806)
>> =3D=3D12102=3D=3D    by 0x25CC08: multifd_send_thread (ram.c:1157)
>> =3D=3D12102=3D=3D    by 0x557551: qemu_thread_start (qemu-thread-posix.c=
:519)
>> =3D=3D12102=3D=3D    by 0x53BE613: start_thread (pthread_create.c:463)
>> =3D=3D12102=3D=3D    by 0x54767FB: ??? (clone.S:73)
>> =3D=3D12102=3D=3D  Address 0x1d89c470 is 0 bytes after a block of size 8=
32 alloc'd
>> =3D=3D12102=3D=3D    at 0x4841BC4: calloc (vg_replace_malloc.c:711)
>> =3D=3D12102=3D=3D    by 0x49EE269: g_malloc0 (in
>> /usr/lib/arm-linux-gnueabihf/libglib-2.0.so.0.5600.4)
>
> This is the same issue that was reported last time this mulitfd unit
> test was proposed for merge. Back then I pointed out the likely cause.
> We were allocating  ram_addr_t sized quantity for an array which is
> uint64_t, and ram_addr_t is probably 32-bit on this particular build.
>
>   https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg03428.html
>
> That suggested fix doesn't seem to have been included

Thanks again.

And sorry for the disturbance.



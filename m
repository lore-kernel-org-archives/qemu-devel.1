Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0424C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 12:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91D421841
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 12:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91D421841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42027 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTQ3a-0005E7-2H
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 08:09:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hTQ1x-0004KQ-GF
	for qemu-devel@nongnu.org; Wed, 22 May 2019 08:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hTQ1w-0002sD-7z
	for qemu-devel@nongnu.org; Wed, 22 May 2019 08:07:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hTQ1w-0002rR-0V; Wed, 22 May 2019 08:07:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA8CE3D953;
	Wed, 22 May 2019 12:07:34 +0000 (UTC)
Received: from gondolin (dhcp-192-213.str.redhat.com [10.33.192.213])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AC615100200D;
	Wed, 22 May 2019 12:07:31 +0000 (UTC)
Date: Wed, 22 May 2019 14:07:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Message-ID: <20190522140729.25970e17.cohuck@redhat.com>
In-Reply-To: <6e216877-60be-ddcd-3f15-604e870ca8ba@redhat.com>
References: <20190521152810.21353-1-cohuck@redhat.com>
	<20190521152810.21353-3-cohuck@redhat.com>
	<6e216877-60be-ddcd-3f15-604e870ca8ba@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Wed, 22 May 2019 12:07:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL v3 47/55] linux headers: update against
 Linux 5.2-rc1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 May 2019 13:47:25 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 5/21/19 5:28 PM, Cornelia Huck wrote:
> > commit a188339ca5a396acc588e5851ed7e19f66b0ebd9
> >=20
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > --- =20
> [...]
> >  #define __NR_mq_notify 184
> >  __SC_COMP(__NR_mq_notify, sys_mq_notify, compat_sys_mq_notify)
> >  #define __NR_mq_getsetattr 185
> > @@ -536,8 +567,10 @@ __SC_COMP(__NR_msgsnd, sys_msgsnd, compat_sys_msgs=
nd)
> >  __SYSCALL(__NR_semget, sys_semget)
> >  #define __NR_semctl 191
> >  __SC_COMP(__NR_semctl, sys_semctl, compat_sys_semctl)
> > +#if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG !=3D 32

Eww. It seems only aarch64 sets __ARCH_WANT_TIME32_SYSCALLS, and the
second condition probably catches others but not mipsel.

> >  #define __NR_semtimedop 192
> > -__SC_COMP(__NR_semtimedop, sys_semtimedop, compat_sys_semtimedop)
> > +__SC_COMP(__NR_semtimedop, sys_semtimedop, sys_semtimedop_time32)
> > +#endif
> >  #define __NR_semop 193
> >  __SYSCALL(__NR_semop, sys_semop) =20
> [...]
>=20
> https://app.shippable.com/github/qemu/qemu/runs/1703/summary/console
>=20
> It seems this commit introduce a regression on mips32:
>=20
>   CC      mipsel-linux-user/linux-user/syscall.o
> ./linux-user/syscall.c: In function 'safe_semtimedop':
> ./linux-user/syscall.c:697:25: error: '__NR_semtimedop' undeclared
> (first use in this function)
>      return safe_syscall(__NR_##name, arg1, arg2, arg3, arg4); \

So, we unconditionally deal with this syscall, i.e. we assume it is
always present? (I'm not sure of the logic in linux-user code.)

Does this need to be escaped somehow?

>                          ^
> ./linux-user/syscall.c:769:1: note: in expansion of macro 'safe_syscall4'
>  safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
>  ^~~~~~~~~~~~~
> ./linux-user/syscall.c:697:25: note: each undeclared identifier is
> reported only once for each function it appears in
>      return safe_syscall(__NR_##name, arg1, arg2, arg3, arg4); \
>                          ^
> ./linux-user/syscall.c:769:1: note: in expansion of macro 'safe_syscall4'
>  safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
>  ^~~~~~~~~~~~~
> ./linux-user/syscall.c:770:45: error: control reaches end of non-void
> function [-Werror=3Dreturn-type]
>                unsigned, nsops, const struct timespec *, timeout)
>                                              ^
> ./linux-user/syscall.c:695:61: note: in definition of macro 'safe_syscall=
4'
>  static type safe_##name(type1 arg1, type2 arg2, type3 arg3, type4 arg4) \
>                                                              ^~~~~
> cc1: all warnings being treated as errors
> ./rules.mak:69: recipe for target 'linux-user/syscall.o' failed
> make[1]: *** [linux-user/syscall.o] Error 1
> Makefile:458: recipe for target 'subdir-mipsel-linux-user' failed
> make: *** [subdir-mipsel-linux-user] Error 2



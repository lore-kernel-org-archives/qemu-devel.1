Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC71C433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 19:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F30D2085B
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 19:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F30D2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwXAH-00015w-08
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 15:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44633)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hwX8O-0005an-9y
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 15:34:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hwX8M-000055-GV
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 15:34:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59608)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hwX8M-0008WJ-8i
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 15:34:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EFA65301302E;
 Sat, 10 Aug 2019 19:34:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F12C417570;
 Sat, 10 Aug 2019 19:34:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6AB9D12A7A81; Sat, 10 Aug 2019 21:34:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20190809064645.22656-1-armbru@redhat.com>
 <20190809064645.22656-21-armbru@redhat.com>
 <c76aaebc-d4bf-cb25-fe27-7a9c9ba644c9@redhat.com>
 <87k1bmpn7y.fsf@dusky.pond.sub.org> <87zhkigwhd.fsf@linaro.org>
Date: Sat, 10 Aug 2019 21:34:17 +0200
In-Reply-To: <87zhkigwhd.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Fri, 09 Aug 2019 17:00:14 +0100")
Message-ID: <87r25ske6e.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Sat, 10 Aug 2019 19:34:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 20/29] Include qemu/main-loop.h less
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>
>>> On 8/9/19 8:46 AM, Markus Armbruster wrote:
>>>> In my "build everything" tree, changing qemu/main-loop.h triggers a
>>>> recompile of some 5600 out of 6600 objects (not counting tests and
>>>> objects that don't depend on qemu/osdep.h).  It includes block/aio.h,
>>>> which in turn includes qemu/event_notifier.h, qemu/notify.h,
>>>> qemu/processor.h, qemu/qsp.h, qemu/queue.h, qemu/thread-posix.h,
>>>> qemu/thread.h, qemu/timer.h, and a few more.
>>>>
>>>> Include qemu/main-loop.h only where it's needed.  Touching it now
>>>> recompiles only some 1700 objects.  For block/aio.h and
>>>> qemu/event_notifier.h, these numbers drop from 5600 to 2800.  For the
>>>> others, they shrink only slightly.
>>>>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>> [...]
>>>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>>>> index 77f5df59b0..ac18a1184a 100644
>>>> --- a/include/sysemu/sysemu.h
>>>> +++ b/include/sysemu/sysemu.h
>>>> @@ -5,7 +5,6 @@
>>>>  #include "qapi/qapi-types-run-state.h"
>>>>  #include "qemu/timer.h"
>>>>  #include "qemu/notify.h"
>>>> -#include "qemu/main-loop.h"
>>>>  #include "qemu/bitmap.h"
>>>>  #include "qemu/uuid.h"
>>>>  #include "qom/object.h"
>>>
>>> netmap failing again :S
>>>
>>> $ make docker-image-debian-amd64 V=3D1 DEBUG=3D1
>>> [...]
>>>   CC      net/netmap.o
>>> net/netmap.c: In function 'netmap_update_fd_handler':
>>> net/netmap.c:109:5: error: implicit declaration of function
>>> 'qemu_set_fd_handler' [-Werror=3Dimplicit-function-declaration]
>>>      qemu_set_fd_handler(s->nmd->fd,
>>>      ^~~~~~~~~~~~~~~~~~~
>>> net/netmap.c:109:5: error: nested extern declaration of
>>> 'qemu_set_fd_handler' [-Werror=3Dnested-externs]
>>
>> I managed to lose the fix somehow.
>>
>> I admit I ran "make docker-test-build", realized docker needs root, and
>> went "sod it, cross fingers & send out the patches".
>
> I've sent some patches to make docker-test-build more closely resemble
> what shippable exercises.
>
> As for root you can setup a docker group and do it that way (see the
> docs in docs/devel/testing.rst). It's not recommended for production
> machines as it makes escalation fairly trivial (the daemon itself still
> runs as root).

As Dan Walsh explained in a blog post[*], access to the docker socket is
equivalent to root.  Might be okay on a throwaway or special-purpose
box, but definitely not on my desktop.

The solution the blog post recommends for now is sudo with password,
which I consider only marginally better: instead of leaving the safe
door open, we install a security camera to log access to the safe,
*then* leave the safe door open.  Just in case whoever helps himself to
the contents of the safe is too lazy to help himself to the logs, too.

In the great tradition of throwing security under the bus to get work
done, I set up sudo.  Avoiding NOPASSWD: turns out to be impractical.

Running "make docker-test-build" fails for me on master (v4.1.0-rc4),
details appended.

>                Hopefully Marc's podman support:
>
>   Subject: [PATCH v2 0/5] tests/docker: add podman support
>   Date: Tue,  9 Jul 2019 23:43:25 +0400
>   Message-Id: <20190709194330.837-1-marcandre.lureau@redhat.com>
>
> will make these requirements a little less onerous.

Sounds like a much needed upgrade to me.

[...]

[*] https://www.projectatomic.io/blog/2015/08/why-we-dont-let-non-root-user=
s-run-docker-in-centos-fedora-or-rhel/


My failure:

$ make -C bld docker-test-build
make: Entering directory '/work/armbru/qemu/bld'
  BUILD   centos7
make[1]: Entering directory '/work/armbru/qemu/bld'
  GEN     /work/armbru/qemu/bld/docker-src.2019-08-10-07.29.32.8915/qemu.tar
  COPY    RUNNER
    RUN test-build in qemu:centos7
[...]
make[1]: Leaving directory '/work/armbru/qemu/bld'
  BUILD   debian9
  BUILD   debian-amd64
make[1]: Entering directory '/work/armbru/qemu/bld'
  GEN     /work/armbru/qemu/bld/docker-src.2019-08-10-07.30.18.17180/qemu.t=
ar
  COPY    RUNNER
    RUN test-build in qemu:debian-amd64
[...]
install -c -m 0644 /tmp/qemu-test/build/trace-events-all "/tmp/qemu-test/bu=
ild/=3Ddestdir/tmp/qemu-test/install/share/qemu/trace-events-all"
Error in atexit._run_exitfuncs:
Traceback (most recent call last):
  File "/usr/lib64/python2.7/atexit.py", line 24, in _run_exitfuncs
    func(*targs, **kargs)
  File "/work/armbru/qemu/tests/docker/docker.py", line 234, in _kill_insta=
nces
    return self._do_kill_instances(True)
  File "/work/armbru/qemu/tests/docker/docker.py", line 213, in _do_kill_in=
stances
    for i in self._output(cmd).split():
  File "/work/armbru/qemu/tests/docker/docker.py", line 239, in _output
    **kwargs)
  File "/usr/lib64/python2.7/subprocess.py", line 223, in check_output
    raise CalledProcessError(retcode, cmd, output=3Doutput)
CalledProcessError: Command '['sudo', 'docker', 'ps', '-q']' returned non-z=
ero exit status 1
Error in sys.exitfunc:
Traceback (most recent call last):
  File "/usr/lib64/python2.7/atexit.py", line 24, in _run_exitfuncs
    func(*targs, **kargs)
  File "/work/armbru/qemu/tests/docker/docker.py", line 234, in _kill_insta=
nces
    return self._do_kill_instances(True)
  File "/work/armbru/qemu/tests/docker/docker.py", line 213, in _do_kill_in=
stances
    for i in self._output(cmd).split():
  File "/work/armbru/qemu/tests/docker/docker.py", line 239, in _output
    **kwargs)
  File "/usr/lib64/python2.7/subprocess.py", line 223, in check_output
    raise CalledProcessError(retcode, cmd, output=3Doutput)
subprocess.CalledProcessError: Command '['sudo', 'docker', 'ps', '-q']' ret=
urned non-zero exit status 1
    CLEANUP /work/armbru/qemu/bld/docker-src.2019-08-10-07.30.18.17180=20
make[1]: Leaving directory '/work/armbru/qemu/bld'
  BUILD   debian-arm64-cross
Traceback (most recent call last):
  File "/work/armbru/qemu/tests/docker/docker.py", line 615, in <module>
    sys.exit(main())
  File "/work/armbru/qemu/tests/docker/docker.py", line 611, in main
    return args.cmdobj.run(args, argv)
  File "/work/armbru/qemu/tests/docker/docker.py", line 366, in run
    dkr =3D Docker()
  File "/work/armbru/qemu/tests/docker/docker.py", line 193, in __init__
    self._command =3D _guess_docker_command()
  File "/work/armbru/qemu/tests/docker/docker.py", line 65, in _guess_docke=
r_command
    commands_txt)
Exception: Cannot find working docker command. Tried:
  docker
  sudo docker
make: *** [/work/armbru/qemu/tests/docker/Makefile.include:53: docker-image=
-debian-arm64-cross] Error 1
make: Leaving directory '/work/armbru/qemu/bld'

There are a few SELinux gripes in my logs, like this one:

type=3DAVC msg=3Daudit(1565418107.93:125036): avc:  denied  { module_reques=
t } for  pid=3D19599 comm=3D"configure" kmod=3D"binfmt-464c" scontext=3Dsys=
tem_u:system_r:container_t:s0:c611,c653 tcontext=3Dsystem_u:system_r:kernel=
_t:s0 tclass=3Dsystem permissive=3D0


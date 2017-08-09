Received: from eggs.gnu.org ([2001:4830:134:3::10]:41736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dfMFc-00041B-72
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 04:22:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1dfMFY-0007Me-7N
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 04:22:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21549)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1dfMFX-0007Ly-Tu
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 04:21:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BAC868553E
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 08:21:54 +0000 (UTC)
Date: Wed, 9 Aug 2017 10:21:41 +0200
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20170809082141.4dlhvvlintzpaata@dhcp-192-218.str.redhat.com>
References: <20170808203900.7661-1-jfreimann@redhat.com>
	<150223674179.30.1367378707991546414@dd743fd916bd>
	<20170809041535-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20170809041535-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/5] tests/pxe-test: add testcase using
 vhost-user-bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, victork@redhat.com, jasowang@redhat.com, maxime.coquelin@redhat.com, stefanha@redhat.com, marcandre.lureau@redhat.com

On Wed, Aug 09, 2017 at 04:17:05AM +0300, Michael S. Tsirkin wrote:
>On Tue, Aug 08, 2017 at 04:59:02PM -0700, no-reply@patchew.org wrote:
>> Hi,
>>
>> This series failed automatic build test. Please find the testing comma=
nds and
>> their output below. If you have docker installed, you can probably rep=
roduce it
>> locally.
>>
>> Message-id: 20170808203900.7661-1-jfreimann@redhat.com
>> Subject: [Qemu-devel] [PATCH v2 0/5] tests/pxe-test: add testcase usin=
g vhost-user-bridge
>> Type: series
>> /tmp/qemu-test/src/tests/pxe-test.c: In function =E2=80=98test_pxe_vho=
st_user=E2=80=99:
>> /tmp/qemu-test/src/tests/pxe-test.c:106: error: =E2=80=98G_SPAWN_SEARC=
H_PATH_FROM_ENVP=E2=80=99 undeclared (first use in this function)
>> /tmp/qemu-test/src/tests/pxe-test.c:106: error: (Each undeclared ident=
ifier is reported only once
>> /tmp/qemu-test/src/tests/pxe-test.c:106: error: for each function it a=
ppears in.)
>> make: *** [tests/pxe-test.o] Error 1
>> make: *** Waiting for unfinished jobs....
>> Traceback (most recent call last):
>>   File "./tests/docker/docker.py", line 382, in <module>
>>     sys.exit(main())
>>   File "./tests/docker/docker.py", line 379, in main
>>     return args.cmdobj.run(args, argv)
>>   File "./tests/docker/docker.py", line 237, in run
>>     return Docker().run(argv, args.keep, quiet=3Dargs.quiet)
>>   File "./tests/docker/docker.py", line 205, in run
>>     quiet=3Dquiet)
>>   File "./tests/docker/docker.py", line 123, in _do_check
>>     return subprocess.check_call(self._command + cmd, **kwargs)
>>   File "/usr/lib64/python2.7/subprocess.py", line 186, in check_call
>>     raise CalledProcessError(retcode, cmd)
>> subprocess.CalledProcessError: Command '['docker', 'run', '--label', '=
com.qemu.instance.uuid=3D534034f67c9511e78af152540069c830', '-u', '0', '-=
t', '--rm', '--net=3Dnone', '-e', 'TARGET_LIST=3D', '-e', 'EXTRA_CONFIGUR=
E_OPTS=3D', '-e', 'V=3D', '-e', 'J=3D8', '-e', 'DEBUG=3D', '-e', 'SHOW_EN=
V=3D1', '-e', 'CCACHE_DIR=3D/var/tmp/ccache', '-v', '/var/tmp/patchew-tes=
ter-tmp-ku3bj8a1/src/docker-src.2017-08-08-19.57.20.28326:/var/tmp/qemu:z=
,ro', '-v', '/root/.cache/qemu-docker-ccache:/var/tmp/ccache:z', 'qemu:ce=
ntos6', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status=
 2
>> make[1]: *** [tests/docker/Makefile.include:139: docker-run] Error 1
>> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-ku3bj8a1/src'
>> make: *** [tests/docker/Makefile.include:168: docker-run-test-quick@ce=
ntos6] Error 2
>>
>> real	1m41.298s
>> user	0m5.189s
>> sys	0m1.753s
>> =3D=3D=3D OUTPUT END =3D=3D=3D
>>
>> Test command exited with code: 2
>
>
>OK given this - it seems clear the right thing to do is to merge 2-4
>and leave 1 and 5 for 2.11.

Agreed. I'll fix this and send a new version.=20

Thanks!

regards,
Jens=20

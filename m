Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF93C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A958A2071C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uw+p3jBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A958A2071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCP3k-0007SY-RY
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 10:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jCP2u-00070V-Ts
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jCP2s-0004jq-TG
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:42:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59386
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jCP2r-0004fc-DE
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584024163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rCUlshCZCGLjnI3twpgV075+5LIdCiCirDYWGIOBErk=;
 b=Uw+p3jBhhzPzeV9m3sL4kU/qJ0/3TlXEEVYWhfTnPzpp+kBvM6Fqn0LP2X8gujwLk8hSzm
 RRUPUSl63e9b4Xjxects2Kb/2r5xOxe3AhYIdQnZlCupYDTE0FJXfoc3xT3FUgbPWmhGaw
 8YNv8vxgYj7Nb96h1UM03GiH9S/cmMo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-YfWENBw6O6qX8DhrOf-Dgw-1; Thu, 12 Mar 2020 10:42:41 -0400
X-MC-Unique: YfWENBw6O6qX8DhrOf-Dgw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 683F9977E7;
 Thu, 12 Mar 2020 14:42:39 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-146.ams2.redhat.com [10.36.117.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D21F19C6A;
 Thu, 12 Mar 2020 14:42:38 +0000 (UTC)
Date: Thu, 12 Mar 2020 15:42:36 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/13] Block layer patches
Message-ID: <20200312144236.GA5498@linux.fritz.box>
References: <20200311154218.15532-1-kwolf@redhat.com>
 <CAFEAcA9uFFWfAaqtMD4BOu78aVoCae7+g61hFPzpSH7eHx=D6w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9uFFWfAaqtMD4BOu78aVoCae7+g61hFPzpSH7eHx=D6w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 12.03.2020 um 14:46 hat Peter Maydell geschrieben:
> On Wed, 11 Mar 2020 at 15:42, Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > The following changes since commit ba29883206d92a29ad5a466e679ccfc2ee61=
32ef:
> >
> >   Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20200310=
' into staging (2020-03-10 16:50:28 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://repo.or.cz/qemu/kevin.git tags/for-upstream
> >
> > for you to fetch changes up to 8bb3b023f2055054ee119cb45b42d2b14be7fc8a=
:
> >
> >   qemu-iotests: adding LUKS cleanup for non-UTF8 secret error (2020-03-=
11 15:54:38 +0100)
> >
> > ----------------------------------------------------------------
> > Block layer patches:
> >
> > - Relax restrictions for blockdev-snapshot (allows libvirt to do live
> >   storage migration with blockdev-mirror)
> > - luks: Delete created files when block_crypto_co_create_opts_luks fail=
s
> > - Fix memleaks in qmp_object_add
> >
> > ----------------------------------------------------------------
>=20
>=20
> iotest 030 hung on x86-64 Linux (Ubuntu):
>=20
> petmay01 11801  0.0  0.0  34668 26112 ?        S    11:24   0:03  |
>                    \_ make --output-sync -C build/alldbg check V=3D1 -j8
> petmay01 15277  0.0  0.0   4628   792 ?        S    11:25   0:00  |
>                        \_ /bin/sh
> /home/petmay01/linaro/qemu-for-merges/tests/check-block.sh
> petmay01 15344  0.0  0.0  14172  3360 ?        S    11:25   0:00  |
>                            \_ bash ./check -makecheck -qcow2 -g auto
> petmay01 27902  0.0  0.0  14172  2128 ?        S    11:25   0:00  |
>                                \_ bash ./check -makecheck -qcow2 -g
> auto
> petmay01 27903  0.0  0.0  52660 16400 ?        S    11:25   0:00  |
>                                    \_ python3 -B 030
> petmay01  1728  0.0  0.1 1011792 51604 ?       Sl   11:26   0:01  |
>                                        \_
> /home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests/../=
../x86_64-softmmu/qemu-system-x86_64
> -display none -vga none -chardev
> socket,id=3Dmon,path=3D/tmp/tmp.QBQTAAybTi/qemu-27903-monitor.sock -mon
> chardev=3Dmon,mode=3Dcontrol -qtest
> unix:path=3D/tmp/tmp.QBQTAAybTi/qemu-27903-qtest.sock -accel qtest
> -nodefaults -display none -accel qtest -drive
> if=3Dvirtio,id=3Ddrive0,file=3Dblkdebug::/home/petmay01/linaro/qemu-for-m=
erges/build/alldbg/tests/qemu-iotests/scratch/test.img,format=3Dqcow2,cache=
=3Dwriteback,aio=3Dthreads,backing.node-name=3Dmid,backing.backing.node-nam=
e=3Dbase
>=20
> I had to manually kill the offending QEMU process; resulting
> output in the log:
>=20
> --- /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/030.out
>  2019-07-15 17:18:35.251364738 +01
> 00
> +++ /home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/qemu-iotests=
/030.out.bad
>   2020-03-12 13:44:
> 43.101182680 +0000
> @@ -1,5 +1,27 @@
> -...........................
> +........................E..
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +ERROR: test_stream_pause (__main__.TestSingleDrive)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "030", line 93, in test_stream_pause
> +    self.pause_wait('drive0')
> +  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/iotests=
.py",
> line 927, in pause_wait
> +    result =3D self.vm.qmp('query-block-jobs')
> +  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/../../p=
ython/qemu/machine.py",
> line 405, in qmp
> +    return self._qmp.cmd(cmd, args=3Dqmp_args)
> +  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/../../p=
ython/qemu/qmp.py",
> line 215, in cmd
> +    return self.cmd_obj(qmp_cmd)
> +  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/../../p=
ython/qemu/qmp.py",
> line 198, in cmd_obj
> +    resp =3D self.__json_read()
> +  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/../../p=
ython/qemu/qmp.py",
> line 89, in __json_read
> +    data =3D self.__sockfile.readline()
> +  File "/usr/lib/python3.6/socket.py", line 586, in readinto
> +    return self._sock.recv_into(b)
> +  File "/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/iotests=
.py",
> line 383, in timeout
> +    raise Exception(self.errmsg)
> +Exception: Timeout waiting for job to pause
> +
>  ----------------------------------------------------------------------

For the record (discussed on IRC):

This seems to be intermittent failure where a short timeout (1 second)
might have been too short under heavy load. That this results in a hang
is a test case bug, but it already exists on master.

Peter will retry the test later.

Kevin



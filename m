Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05122C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C516420706
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6lzooKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C516420706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRxr0-0005wO-UL
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 08:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jRxq3-0005C6-5Y
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jRxq1-0006Kd-Fb
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:53:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45835
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jRxq1-00067b-1Y
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587732827;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8M13wEibJU5cPy3caocfKul9iSoQUXdLeFWPwCuIK5M=;
 b=b6lzooKKLgc2jSR1aBIUgOPOP53acJx0IANU5IN3TO7ngiA+PrAnugw274F0GfapIIKmCs
 IDorLYceUUkkS+x4hmFZ4lE3R9N4e3poAGFheGNtDAa3AiEX/0az5OTcCunsnVjA9zsLTi
 VrztyaP33g9U4WUnbRaUi/Q/UBNzj5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-YOfRiJY_M1W8l5VOmhe22g-1; Fri, 24 Apr 2020 08:53:42 -0400
X-MC-Unique: YOfRiJY_M1W8l5VOmhe22g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C70E8014D6;
 Fri, 24 Apr 2020 12:53:40 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 92BD0605CF;
 Fri, 24 Apr 2020 12:53:25 +0000 (UTC)
Date: Fri, 24 Apr 2020 13:53:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RESEND v6 00/36] Initial support for multi-process qemu
Message-ID: <20200424125322.GI1212635@redhat.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <20200424124823.GC189569@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200424124823.GC189569@stefanha-x1.localdomain>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 02:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 mreitz@redhat.com, ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 24, 2020 at 01:48:23PM +0100, Stefan Hajnoczi wrote:
> On Wed, Apr 22, 2020 at 09:13:35PM -0700, elena.ufimtseva@oracle.com wrot=
e:
> > There is an error in travis-ci build test which does not get reproduced=
.
> >=20
> >  TEST    iotest-qcow2: 041 [fail]
> > QEMU          -- "/home/travis/build/elena-ufimtseva/qemu-multiprocess/=
out-of-tree/build/dir/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x=
86_64" -nodefaults -display none -accel qtest
> > QEMU_IMG      -- "/home/travis/build/elena-ufimtseva/qemu-multiprocess/=
out-of-tree/build/dir/tests/qemu-iotests/../../qemu-img"=20
> > QEMU_IO       -- "/home/travis/build/elena-ufimtseva/qemu-multiprocess/=
out-of-tree/build/dir/tests/qemu-iotests/../../qemu-io"  --cache writeback =
--aio threads -f qcow2
> > QEMU_NBD      -- "/home/travis/build/elena-ufimtseva/qemu-multiprocess/=
out-of-tree/build/dir/tests/qemu-iotests/../../qemu-nbd"=20
> > IMGFMT        -- qcow2 (compat=3D1.1)
> > IMGPROTO      -- file
> > PLATFORM      -- Linux/x86_64 travis-job-fc4e2553-b470-4a8b-812e-a4fcf8=
ba094f 5.0.0-1031-gcp
> > TEST_DIR      -- /home/travis/build/elena-ufimtseva/qemu-multiprocess/o=
ut-of-tree/build/dir/tests/qemu-iotests/scratch
> > SOCK_DIR      -- /tmp/tmp.LOmYANt5Od
> > SOCKET_SCM_HELPER -- /home/travis/build/elena-ufimtseva/qemu-multiproce=
ss/out-of-tree/build/dir/tests/qemu-iotests/socket_scm_helper
> > --- /home/travis/build/elena-ufimtseva/qemu-multiprocess/tests/qemu-iot=
ests/041.out=092020-04-22 00:17:23.701844698 +0000
> > +++ /home/travis/build/elena-ufimtseva/qemu-multiprocess/out-of-tree/bu=
ild/dir/tests/qemu-iotests/041.out.bad=092020-04-22 00:24:39.234343858 +000=
0
> > @@ -1,5 +1,29 @@
> > -......................................................................=
........................
> > +........................FF............................................=
........................
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +FAIL: test_with_other_parent (__main__.TestRepairQuorum)
> > +----------------------------------------------------------------------
> > +Traceback (most recent call last):
> > +  File "041", line 1049, in test_with_other_parent
> > +    self.assert_qmp(result, 'return', {})
> > +  File "/home/travis/build/elena-ufimtseva/qemu-multiprocess/tests/qem=
u-iotests/iotests.py", line 821, in assert_qmp
> > +    result =3D self.dictpath(d, path)
> > +  File "/home/travis/build/elena-ufimtseva/qemu-multiprocess/tests/qem=
u-iotests/iotests.py", line 797, in dictpath
> > +    self.fail('failed path traversal for "%s" in "%s"' % (path, str(d)=
))
> > +AssertionError: failed path traversal for "return" in "{'error': {'cla=
ss': 'GenericError', 'desc': "UNIX socket path '/home/travis/build/elena-uf=
imtseva/qemu-multiprocess/out-of-tree/build/dir/tests/qemu-iotests/scratch/=
nbd.sock' is too long"}}"
>=20
> UNIX Domain Socket paths have to be 108 characters or less.  The path in
> the failed test case is 110 characters long.  You could rename your
> branch to "mpqemu" to solve this failure.

Renaming is a pretty poor band-aid.

We should fix the i/o tests instead, so that they use a scratch dir under
$TMP to store unix sockets needed by tests instead.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|



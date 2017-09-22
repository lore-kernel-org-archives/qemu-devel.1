Received: from eggs.gnu.org ([2001:4830:134:3::10]:44878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dvGsZ-0008A2-8s
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 01:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dvGsW-0005mF-7u
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 01:51:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dvGsW-0005ib-1B
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 01:51:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E8384E334
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 05:51:52 +0000 (UTC)
Date: Fri, 22 Sep 2017 13:51:46 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170922055146.GI30661@pxdev.xzpeter.org>
References: <20170921230812.7095-1-quintela@redhat.com>
	<150603654377.39.6000423576102095707@d650bbe78fe3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <150603654377.39.6000423576102095707@d650bbe78fe3>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/18] Migration PULL request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, famz@redhat.com, lvivier@redhat.com, dgilbert@redhat.com

On Thu, Sep 21, 2017 at 04:29:04PM -0700, no-reply@patchew.org wrote:

[...]

> /var/tmp/patchew-tester-tmp-b0y2ycie/src/util/bitmap.c: In function =E2=
=80=98bitmap_to_from_le=E2=80=99:
> /var/tmp/patchew-tester-tmp-b0y2ycie/src/util/bitmap.c:383:6: error: "_=
_WORD_SIZE" is not defined [-Werror=3Dundef]
>  # if __WORD_SIZE =3D=3D 64
>       ^~~~~~~~~~~
>   CC      util/acl.o
> cc1: all warnings being treated as errors
> /var/tmp/patchew-tester-tmp-b0y2ycie/src/rules.mak:66: recipe for targe=
t 'util/bitmap.o' failed
> make: *** [util/bitmap.o] Error 1
> make: *** Waiting for unfinished jobs....
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 2

This is the same error with previous one.  We need to replace the
single usage of __WORD_SIZE into either __WORDSIZE or HOST_LONG_BITS
(as suggested by Dave).

Again, please let me know if you want me to repost, and sorry for the
trouble!

--=20
Peter Xu

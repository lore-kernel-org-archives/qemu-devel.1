Received: from eggs.gnu.org ([2001:4830:134:3::10]:48841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dvJHB-0002O6-Hy
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dvJH8-0004qs-Eo
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:25:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dvJH8-0004qW-8w
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:25:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF99D7C839
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 08:25:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170922055146.GI30661@pxdev.xzpeter.org> (Peter Xu's message of
	"Fri, 22 Sep 2017 13:51:46 +0800")
References: <20170921230812.7095-1-quintela@redhat.com>
	<150603654377.39.6000423576102095707@d650bbe78fe3>
	<20170922055146.GI30661@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Fri, 22 Sep 2017 10:25:28 +0200
Message-ID: <87vakbi1hj.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, lvivier@redhat.com, dgilbert@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Thu, Sep 21, 2017 at 04:29:04PM -0700, no-reply@patchew.org wrote:
>
> [...]
>
>> /var/tmp/patchew-tester-tmp-b0y2ycie/src/util/bitmap.c: In function =E2=
=80=98bitmap_to_from_le=E2=80=99:
>> /var/tmp/patchew-tester-tmp-b0y2ycie/src/util/bitmap.c:383:6: error: "__=
WORD_SIZE" is not defined [-Werror=3Dundef]
>>  # if __WORD_SIZE =3D=3D 64
>>       ^~~~~~~~~~~
>>   CC      util/acl.o
>> cc1: all warnings being treated as errors
>> /var/tmp/patchew-tester-tmp-b0y2ycie/src/rules.mak:66: recipe for target=
 'util/bitmap.o' failed
>> make: *** [util/bitmap.o] Error 1
>> make: *** Waiting for unfinished jobs....
>> =3D=3D=3D OUTPUT END =3D=3D=3D
>>=20
>> Test command exited with code: 2
>
> This is the same error with previous one.  We need to replace the
> single usage of __WORD_SIZE into either __WORDSIZE or HOST_LONG_BITS
> (as suggested by Dave).
>
> Again, please let me know if you want me to repost, and sorry for the
> trouble!

I think we can let that in in the PULL request and fix it later if
needed, not?

Thanks, Juan.

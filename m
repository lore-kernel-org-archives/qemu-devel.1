Received: from eggs.gnu.org ([2001:4830:134:3::10]:54253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dZYUk-0004Ce-EA
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 04:13:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dZYUh-00029u-AP
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 04:13:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dZYUh-00029m-3z
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 04:13:35 -0400
References: <150064965492.105.17172556674137846483@5d477a5b5989>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e31aa9be-a900-f901-3b2c-f96c54dcf0b4@redhat.com>
Date: Mon, 24 Jul 2017 10:05:12 +0200
MIME-Version: 1.0
In-Reply-To: <150064965492.105.17172556674137846483@5d477a5b5989>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/5] target/s390x: Fix broken build with
 --disable-tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, no-reply@patchew.org
Cc: famz@redhat.com, cohuck@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, rth@twiddle.net

On 21.07.2017 17:07, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed build test on s390x host. Please find the details be=
low.
[...]
>   CC      s390x-linux-user/target/s390x/interrupt.o
>   CC      sh4eb-linux-user/linux-user/linuxload.o
>   CC      sparc32plus-linux-user/accel/tcg/cpu-exec-common.o
> /var/tmp/patchew-tester-tmp-_vbxifz5/src/target/s390x/interrupt.c: In f=
unction =E2=80=98program_interrupt=E2=80=99:
> /var/tmp/patchew-tester-tmp-_vbxifz5/src/target/s390x/interrupt.c:44:9:=
 error: implicit declaration of function =E2=80=98kvm_s390_program_interr=
upt=E2=80=99 [-Werror=3Dimplicit-function-declaration]
>          kvm_s390_program_interrupt(cpu, code);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~
> /var/tmp/patchew-tester-tmp-_vbxifz5/src/target/s390x/interrupt.c:44:9:=
 error: nested extern declaration of =E2=80=98kvm_s390_program_interrupt=E2=
=80=99 [-Werror=3Dnested-externs]
> cc1: all warnings being treated as errors
> /var/tmp/patchew-tester-tmp-_vbxifz5/src/rules.mak:66: recipe for targe=
t 'target/s390x/interrupt.o' failed
> make[1]: *** [target/s390x/interrupt.o] Error 1
> Makefile:328: recipe for target 'subdir-s390x-linux-user' failed
> make: *** [subdir-s390x-linux-user] Error 2

*bummer* ... looks like I forgot to check target=3Ds390x-linux-user this
time :-( Sorry, I'll fix it and send a v3 ...

 Thomas

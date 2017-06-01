Received: from eggs.gnu.org ([2001:4830:134:3::10]:34098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dGLFg-0004SR-13
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 04:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dGLFf-00005n-AP
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 04:14:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dGLFf-0008Vg-5D
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 04:14:39 -0400
References: <1496212144-14947-1-git-send-email-yang.zhong@intel.com>
	<c5d963e7-ef71-0ed5-aaae-01d492e4fd8b@redhat.com>
	<20170601052736.GA17625@yangzhon-Virtual>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fc8f01b6-5b87-bd9e-0648-b489e00a6dfe@redhat.com>
Date: Thu, 1 Jun 2017 10:14:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170601052736.GA17625@yangzhon-Virtual>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/6] tcg: move the tcg files into tcg/
 subdirectory.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhong Yang <yang.zhong@intel.com>
Cc: Eric Blake <eblake@redhat.com>, Laurent Desnogues <laurent.desnogues@gmail.com>, anthony.xu@intel.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 01/06/2017 07:27, Zhong Yang wrote:
>   In the first phase, there are three patchsets to
>   deal with split code and separate the files.
>   1) split the tcg exec code.
>      a)split the tcg accelerators from accel.c file and re-name
>        tcg accelerator to tcg-all.c, like kvm-all.c did.
>      b)create one accel directory, which will include kvm,
>        tcg and general exec files.
>      c)move tcg exec files into ./accel/tcg directory.
>   2) move tcg related backend files into tcg/ directory
>      those files include translate-all.(ch), translate-common.c,
>      tci.c and tcg-runtime.c.
>   3) move kvm exec and exec.c file.
>      a)move kvm related exec files into ./accel/kvm directory.
>      b)move exec.c in ./accel directory.
>=20
>   after 1) and 3) done, the file tree like below:
>   accel/
>   =E2=94=9C=E2=94=80=E2=94=80 accel.c
>   =E2=94=9C=E2=94=80=E2=94=80 exec.c
>   =E2=94=9C=E2=94=80=E2=94=80 kvm
>   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 kvm-all.c
>   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 kvm-stub.c
>   =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 Makefile.objs
>   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 trace-events
>   =E2=94=9C=E2=94=80=E2=94=80 Makefile.objs
>   =E2=94=94=E2=94=80=E2=94=80 tcg
>       =E2=94=9C=E2=94=80=E2=94=80 cpu-exec.c
>       =E2=94=9C=E2=94=80=E2=94=80 cpu-exec-common.c
>       =E2=94=9C=E2=94=80=E2=94=80 cputlb.c
>       =E2=94=9C=E2=94=80=E2=94=80 Makefile.objs
>       =E2=94=9C=E2=94=80=E2=94=80 tcg-all.c
>       =E2=94=94=E2=94=80=E2=94=80 trace-events
>  =20
>   please help me check whether this kind of arrange is suitable?=20

Oh, I see now.  I think translate-all.[ch] and translate-common.c belong
in accel/tcg more than tcg/.

Thanks,

Paolo

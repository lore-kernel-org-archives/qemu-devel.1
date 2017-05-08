Received: from eggs.gnu.org ([2001:4830:134:3::10]:42472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d7pQP-000872-0q
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d7pQL-0002JE-Uv
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:38:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d7pQL-0002Hj-OR
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:38:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 706CA61D19
	for <qemu-devel@nongnu.org>; Mon,  8 May 2017 20:38:28 +0000 (UTC)
Date: Mon, 8 May 2017 17:38:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170508203825.GX3482@thinpad.lan.raisama.net>
References: <20170508201628.32502-1-ehabkost@redhat.com>
	<149427558833.258.8729008947473825070@c05f1edc8ed1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <149427558833.258.8729008947473825070@c05f1edc8ed1>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/3] arch_init: Move soundhw code to
 hw/audio/soundhw.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kraxel@redhat.com

On Mon, May 08, 2017 at 01:33:09PM -0700, no-reply@patchew.org wrote:
[...]
>   CC      s390x-softmmu/hw/cpu/core.o
>   CC      ppc-softmmu/hw/ppc/ppc440_bamboo.o
>   CC      s390x-softmmu/hw/display/virtio-gpu.o
>   CC      ppc64-softmmu/hw/ppc/spapr_hcall.o
>   CC      ppc-softmmu/hw/ppc/ppc4xx_pci.o
>   CC      ppc-softmmu/hw/ppc/prep.o
>   CC      ppc64-softmmu/hw/ppc/spapr_iommu.o
> /var/tmp/patchew-tester-tmp-ibdexxkb/src/hw/ppc/prep.c: In function =E2=
=80=98ibm_40p_init=E2=80=99:
> /var/tmp/patchew-tester-tmp-ibdexxkb/src/hw/ppc/prep.c:785:5: error: im=
plicit declaration of function =E2=80=98audio_init=E2=80=99 [-Werror=3Dim=
plicit-function-declaration]
>      audio_init();
>      ^~~~~~~~~~
> /var/tmp/patchew-tester-tmp-ibdexxkb/src/hw/ppc/prep.c:785:5: error: ne=
sted extern declaration of =E2=80=98audio_init=E2=80=99 [-Werror=3Dnested=
-externs]
> cc1: all warnings being treated as errors
> /var/tmp/patchew-tester-tmp-ibdexxkb/src/rules.mak:69: recipe for targe=
t 'hw/ppc/prep.o' failed
> make[1]: *** [hw/ppc/prep.o] Error 1
> Makefile:327: recipe for target 'subdir-ppc-softmmu' failed
> make: *** [subdir-ppc-softmmu] Error 2
> make: *** Waiting for unfinished jobs....
>   CC      ppc64-softmmu/hw/ppc/spapr_rtas.o

Oops, I should have built all targets instead of assuming that
nothing would break on a trivial rebase.

Expect v3 with a fix for that. Sorry for the noise.

--=20
Eduardo

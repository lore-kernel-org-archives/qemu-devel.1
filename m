Received: from eggs.gnu.org ([2001:4830:134:3::10]:53802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOk46-0007vl-96
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 09:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOk45-0005NI-7A
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 09:25:58 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:41133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOk45-0005Mv-16
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 09:25:57 -0400
Received: by mail-ot0-x241.google.com with SMTP id t1-v6so29250010oth.8
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 06:25:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0184EA26B2509940AA629AE1405DD7F201CAECD7@DGGEMA503-MBX.china.huawei.com>
References: <0184EA26B2509940AA629AE1405DD7F201CAECD7@DGGEMA503-MBX.china.huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Jun 2018 14:25:35 +0100
Message-ID: <CAFEAcA9y_A5x-ELXbOGFp34FGKBED0v568tD8=corZn9cjJGzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RESEND v1 0/3] add support for VCPU event
 states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "famz@redhat.com" <famz@redhat.com>, "james.morse@arm.com" <james.morse@arm.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Linuxarm <linuxarm@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>

On 1 June 2018 at 14:17, gengdongjiu <gengdongjiu@huawei.com> wrote:
> Hi Peter,
>> This series failed build test on s390x host. Please find the details bel=
ow.

>> /var/tmp/patchew-tester-tmp-hwsn3wsl/src/hw/display/virtio-gpu-3d.c: In =
function =E2=80=98virgl_cmd_get_capset_info=E2=80=99:
>> /var/tmp/patchew-tester-tmp-hwsn3wsl/src/hw/display/virtio-gpu-3d.c:366:=
26: error: =E2=80=98VIRTIO_GPU_CAPSET_VIRGL2=E2=80=99 undeclared (first
>> use in this function); did you mean =E2=80=98VIRTIO_GPU_CAPSET_VIRGL=E2=
=80=99?
>>          resp.capset_id =3D VIRTIO_GPU_CAPSET_VIRGL2;
>>                           ^~~~~~~~~~~~~~~~~~~~~~~~
>>                           VIRTIO_GPU_CAPSET_VIRGL
>> /var/tmp/patchew-tester-tmp-hwsn3wsl/src/hw/display/virtio-gpu-3d.c:366:=
26: note: each undeclared identifier is reported only once for
>> each function it appears in
>> /var/tmp/patchew-tester-tmp-hwsn3wsl/src/hw/display/virtio-gpu-3d.c: In =
function =E2=80=98virtio_gpu_virgl_get_num_capsets=E2=80=99:
>> /var/tmp/patchew-tester-tmp-hwsn3wsl/src/hw/display/virtio-gpu-3d.c:646:=
32: error: =E2=80=98VIRTIO_GPU_CAPSET_VIRGL2=E2=80=99 undeclared (first
>> use in this function); did you mean =E2=80=98VIRTIO_GPU_CAPSET_VIRGL=E2=
=80=99?

> This build failure is due to kernel missing the definition of "VIRTIO_GPU=
_CAPSET_VIRGL2", I sync the mainline kernel tree header file to the mainlin=
e QEMU using the scripts[1],
> So happen this failure, It does not related with myself patch, so can I d=
iscard the patch [1] or add the =E2=80=98VIRTIO_GPU_CAPSET_VIRGL2=E2=80=99 =
definition to mainline kernel tree?

This is a known issue with the kernel headers (hopefully somebody
will fix them). There are several nits and also bugs in the
update-headers script that I sent a patchset to fix recently:
 https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg05803.html

You should wait for that to get into master (it is in Paolo's
most recent patchset but that has an issue with a different
patch, so is waiting on Paolo to do a respin). Then you can
base on that. At that point a simple script update should
work fine (if you need anything in rc7 that wasn't in rc6).

thanks
-- PMM

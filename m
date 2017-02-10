Received: from eggs.gnu.org ([2001:4830:134:3::10]:58830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.hung@canonical.com>) id 1cc0Cg-0003SI-DE
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 20:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.hung@canonical.com>) id 1cc0Cf-0004S3-7i
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 20:40:50 -0500
Received: from mail-qk0-x231.google.com ([2607:f8b0:400d:c09::231]:34870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.hung@canonical.com>)
	id 1cc0Cf-0004Rj-26
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 20:40:49 -0500
Received: by mail-qk0-x231.google.com with SMTP id u25so24617217qki.2
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 17:40:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <374fb64f-9590-2b23-871a-90bbf08ce70d@linaro.org>
References: <1486560712-44171-1-git-send-email-agraf@suse.de>
	<ef6b903b-5224-b4eb-1080-a3689fcec70a@redhat.com>
	<f2f119bc-9c22-ad52-ff26-7d6ecc213a3c@suse.de>
	<c1ff3829-b068-881a-1523-317ef0d31689@redhat.com>
	<C4E1DF44-1626-425D-880E-0053AD688422@linaro.org>
	<CAFEAcA8rjjzgvN-RuNPVHM53R9V9xry1Uj_ArmF1va-Y920eBQ@mail.gmail.com>
	<991fc2e7-e483-c7bc-fc45-3d32d9d37857@redhat.com>
	<374fb64f-9590-2b23-871a-90bbf08ce70d@linaro.org>
From: Alex Hung <alex.hung@canonical.com>
Date: Fri, 10 Feb 2017 09:40:47 +0800
Message-ID: <CAJ=jquaaiX1GM_ea9b2X2NOW47q456kp71mcvtc1q_q+OnpCRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] target-arm: Declare virtio-mmio
 as dma-coherent in dt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Heyi Guo <heyi.guo@linaro.org>
Cc: Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Shannon Zhao <shannon.zhao@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>

Hi,

FWTS supports multiple architectures:

- amd64
- arm64
- armhf
- i386
- ppc64el
- s390x

Package details are available @
https://launchpad.net/~firmware-testing-team/+archive/ubuntu/ppa-fwts-stabl=
e/+packages

FWTS also supports device tree to some extent, thanks to contributions
from Jeremy Kerr & Deb McLemore.

Cheers,
Alex Hung

On Thu, Feb 9, 2017 at 8:04 PM, Heyi Guo <heyi.guo@linaro.org> wrote:
> Hi all,
>
> Just to confirm that FWTS is supporting aarch64.
>
> Alex is the maintainer of FWTS and may provide more information.
>
> Regards,
>
> Gary (Heyi Guo)
>
>
> =E5=9C=A8 2/9/2017 2:47 AM, Laszlo Ersek =E5=86=99=E9=81=93:
>>
>> On 02/08/17 19:23, Peter Maydell wrote:
>>>
>>> On 8 February 2017 at 16:27, Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> wrote:
>>>>
>>>> The _CCA property is mandatory on arm64, and there is no default.
>>>
>>> Is there a tool that can check this kind of requirement
>>> and complain about issues in the ACPI tables (and
>>> ditto, device tree)? It's really easy to produce a
>>> dt or ACPI table that works with current kernels and
>>> then turns out to have a problem six or twelve
>>> months down the line :-(
>>
>> I think the "bios bits" project or the FWTS (firmware test suite)
>> project might do some ACPI sanity checks. They could be run in guests.
>>
>> https://biosbits.org/
>> https://wiki.ubuntu.com/FirmwareTestSuite
>>
>> However, I'm unsure if they support aarch64. Also... it's not like those
>> projects are stationary. Even the ACPI spec is a moving target (and
>> spec-level regressions exist).
>>
>> I believe Heyi Guo @ Linaro used to work with FWTS on aarch64. CC'd.
>>
>> No clue about DT conformance testing. Is there an industry standard or a
>> working group behind DT?
>>
>> Thanks
>> Laszlo
>>
>



--=20
Cheers,
Alex Hung

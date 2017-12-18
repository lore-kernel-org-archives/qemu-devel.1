Received: from eggs.gnu.org ([2001:4830:134:3::10]:43459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQtwM-0006Nn-Dk
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:50:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQtwI-0007n1-3J
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:50:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eQtwH-0007lD-CX
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 06:50:34 -0500
From: Thomas Huth <thuth@redhat.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAFEAcA96q6RGAmWJj=jYgYBC_yrP-NcZ6A4_w=S7vgn=-pL3Jw@mail.gmail.com>
	<35bf84c9-271d-5ded-0876-0edb9304b2fc@redhat.com>
Message-ID: <8520cb93-2dce-7b51-87a1-834652890751@redhat.com>
Date: Mon, 18 Dec 2017 12:50:29 +0100
MIME-Version: 1.0
In-Reply-To: <35bf84c9-271d-5ded-0876-0edb9304b2fc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v1 00/32] Merge tpm 2017/12/15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18.12.2017 12:18, Thomas Huth wrote:
> On 17.12.2017 22:34, Peter Maydell wrote:
>> On 16 December 2017 at 17:41, Stefan Berger <stefanb@linux.vnet.ibm.co=
m> wrote:
>>> The following patch series refactors the TPM TIS and backend drivers =
for
>>> easier addition of new front-end devices. Further, the TPM buffer siz=
es
>>> are read from the backend and the backend's buffer size can be adjust=
ed
>>> by the frontend, if necessary.
>>>
>>>
>>> The following changes since commit 0ef0583d5adceb9138bdb47494dabd1549=
ac5b6d:
>>>
>>>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-201712=
14' into staging (2017-12-14 15:32:32 +0000)
>>>
>>> are available in the git repository at:
>>>
>>>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2017-12-15=
-1
>>>
>>> for you to fetch changes up to 683c4b775355cc7acd301e8efe7d4c1c9acdaf=
d8:
>>>
>>>   tpm: tpm_passthrough: Fail startup if FE buffer size < BE buffer si=
ze (2017-12-14 23:39:15 -0500)
>>>
>>> ----------------------------------------------------------------
>>> Merge tpm 2017/12/15 v1
>>
>> Applied, thanks.
>=20
> This apparently broke compilation on non-x86 architectures:
>=20
>   LINK    s390x-softmmu/qemu-system-s390x
> ../hw/core/qdev-properties-system.o: In function `release_tpm':
> /home/thuth/devel/qemu/hw/core/qdev-properties-system.c:291: undefined =
reference to `tpm_backend_reset'
> ../hw/core/qdev-properties-system.o: In function `set_tpm':
> /home/thuth/devel/qemu/hw/core/qdev-properties-system.c:274: undefined =
reference to `qemu_find_tpm_be'
> /home/thuth/devel/qemu/hw/core/qdev-properties-system.c:278: undefined =
reference to `tpm_backend_init'
> collect2: error: ld returned 1 exit status
> make: Leaving directory `/home/thuth/s390x/qemu'
> make[1]: *** [qemu-system-s390x] Error 1
> make: *** [subdir-s390x-softmmu] Error 2
>=20
> Could you please fix this ASAP?

FWIW, looks like there was a "--disable-tpm" in my config.status file,
not sure why. So that's likely causing the issue here, not the non-x86
system.

 Thomas

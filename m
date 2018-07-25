Received: from eggs.gnu.org ([2001:4830:134:3::10]:54493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1fiFrG-0002rY-Fq
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1fiFrD-0003eU-E6
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:13:22 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:50756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1fiFrD-0003d6-8W
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:13:19 -0400
Received: by mail-it0-x244.google.com with SMTP id w16-v6so7706380ita.0
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 02:13:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHmQWvCqKqQXnXxOUgi=kLTyE5BhV2NxqaKzvPp63HX02V=X2g@mail.gmail.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<20180725084824.GA12855@redhat.com>
	<CAKv+Gu_RHsed0KAH8njKB8UPvbUDeoTZ5sP76f_br6azisZzSQ@mail.gmail.com>
	<CAHmQWvCqKqQXnXxOUgi=kLTyE5BhV2NxqaKzvPp63HX02V=X2g@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 25 Jul 2018 11:13:18 +0200
Message-ID: <CAKv+Gu_eFjS_UvOuEKhbsWr34o3Jqd4h2duJ-gG1ofsFbwkGbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>

On 25 July 2018 at 11:09, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> On 25 July 2018 at 17:01, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrot=
e:
>> On 25 July 2018 at 10:48, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>>> On Wed, Jul 25, 2018 at 01:30:52PM +0800, Hongbo Zhang wrote:
>>>> For the Aarch64, there is one machine 'virt', it is primarily meant to
>>>> run on KVM and execute virtualization workloads, but we need an
>>>> environment as faithful as possible to physical hardware, for supporti=
ng
>>>> firmware and OS development for pysical Aarch64 machines.
>>>>
>>>> This patch introduces new machine type 'Enterprise' with main features=
:
>>>
>>> The 'enterprise' name is really awful - this is essentially a marketing
>>> term completely devoid of any useful meaning.
>>>
>>> You had previously called this "sbsa" which IIUC was related to a real
>>> world hardware specification that it was based on. IOW, I think this ol=
d
>>> name was preferrable to calling it "enterprise".
>>>
>>
>> I couldn't agree more. However, IIUC this change was made at the
>> request of one of the reviewers, although I wasn't part of the
>> discussion at that point, so I'm not sure who it was.
>>
>> Hongbo, could you please share a link to that discussion?
>>
>> Thanks,
>> Ard.
>>
>
> V1 discussion here:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg545775.html
>

So who asked for the sbsa -> enterprise change?

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fiGKm-0001R8-BH
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fiGKj-0007al-DJ
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:43:52 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:45569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1fiGKj-0007aQ-6d
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:43:49 -0400
Received: by mail-io0-x242.google.com with SMTP id k16-v6so5789614iom.12
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 02:43:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180725091837.GB12855@redhat.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<20180725084824.GA12855@redhat.com>
	<CAHmQWvDtNQsPDy1tCnsy9JbGzMxLAik5S0bBfpCj_0ig8=iZdA@mail.gmail.com>
	<20180725091837.GB12855@redhat.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Wed, 25 Jul 2018 17:43:47 +0800
Message-ID: <CAHmQWvCNBgZatR4hdn4yunKn6+ocHith7ZQ86Re2jQ9xE4iwGA@mail.gmail.com>
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
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On 25 July 2018 at 17:18, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wro=
te:
> On Wed, Jul 25, 2018 at 05:05:06PM +0800, Hongbo Zhang wrote:
>> On 25 July 2018 at 16:48, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>> > On Wed, Jul 25, 2018 at 01:30:52PM +0800, Hongbo Zhang wrote:
>> >> For the Aarch64, there is one machine 'virt', it is primarily meant t=
o
>> >> run on KVM and execute virtualization workloads, but we need an
>> >> environment as faithful as possible to physical hardware, for support=
ing
>> >> firmware and OS development for pysical Aarch64 machines.
>> >>
>> >> This patch introduces new machine type 'Enterprise' with main feature=
s:
>> >
>> > The 'enterprise' name is really awful - this is essentially a marketin=
g
>> > term completely devoid of any useful meaning.
>> >
>> > You had previously called this "sbsa" which IIUC was related to a real
>> > world hardware specification that it was based on. IOW, I think this o=
ld
>> > name was preferrable to calling it "enterprise".
>> >
>> Thanks for your comments.
>> Frankly, I myself prefer to 'sbsa' too, in fact, at the early stage of
>> developing, we called this 'enterprise', but later I changed it to
>> 'sbsa' until I sent out v1 patch.
>>
>> The work Arm TF and EDK2 porting to this platform needs this name to
>> be defined finally.
>
> Why should EDK2 care what the QEMU machine type name is. The machine type
> name is purely a QEMU internal tag and shouldn't be visible in the guest
> ABI at all IIUC.
>
For example, in EDK2, ArmVirtPkg/ArmVirtQemuSBSA.dsc and
ArmVirtPkg/ArmVirtQemuSBSA.fdf are created for porting to the new
platform, similar situation for Arm TF, so the name is needed.

>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

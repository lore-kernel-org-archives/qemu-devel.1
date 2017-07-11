Received: from eggs.gnu.org ([2001:4830:134:3::10]:53218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUy4i-0003Co-Jk
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:31:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUy4h-0007Jm-QW
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:31:48 -0400
References: <20170711025703.24194-1-f4bug@amsat.org>
	<20170711025703.24194-2-f4bug@amsat.org>
	<446cc0e3-dd49-e088-85f1-0caf1d42fbf8@amsat.org>
	<87iniz9byq.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <82ed455a-8fbe-0270-b3aa-5290dc40e653@redhat.com>
Date: Tue, 11 Jul 2017 18:31:36 +0200
MIME-Version: 1.0
In-Reply-To: <87iniz9byq.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] configure: disable Xen PCI
 Passthrough on !x86 archs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, qemu-arm@nongnu.org, Anthony Perard <anthony.perard@citrix.com>, Marcelo Tosatti <mtosatti@redhat.com>, xen-arm@lists.xen.org, Anoob Soman <anoob.soman@citrix.com>, Juergen Gross <jgross@suse.com>, Anthony Xu <anthony.xu@intel.com>, Paul Durrant <paul.durrant@citrix.com>

On 11/07/2017 18:26, Alex Benn=C3=A9e wrote:
>> It seems our minds crossed at the same time since Alex/Pablo fixed it
>> and got merged in master as b5ed2e11ef39 "build: disable Xen on ARM"
>> so this patch is no more necessary.
>>
>> Alex/Pablo, any thought on patch 2 regarding xen-mapcache.h?
>=20
> Pass, I know little of Xen on ARM other than I think it doesn't need
> QEMU for device emulation. IIRC the use of QEMU on x86 is to handle the
> weird set of devices you can get on a PC without bloating the
> hypervisor. ARM is a lot simpler in that regard.

Yes, my understanding is that Xen on ARM doesn't need the mapcache.

Another thing being discussed a few years ago was the creation of
qemu-system-xenpv (aka xenpv-softmmu), where the same code would run on
x86 or ARM.  It would never support TCG, so the --disable-tcg patches
would be a prerequisite for that.

Paolo

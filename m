Received: from eggs.gnu.org ([2001:4830:134:3::10]:52586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hahn@univention.de>) id 1cqFi5-0001k5-Rh
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:04:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hahn@univention.de>) id 1cqFi2-0003QJ-OX
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:04:09 -0400
Received: from mail.univention.de ([82.198.197.8]:33231)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hahn@univention.de>) id 1cqFi2-0003O9-IN
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:04:06 -0400
References: <cover.1352938305.git.mtosatti@redhat.com>
	<b0b873a07872f7ab7f66f259c73fb9dd42aa66a9.1352938305.git.mtosatti@redhat.com>
	<f8f0ebb7-0c79-8570-3210-dc45c3effda8@univention.de>
	<20170320232032.GA28018@amt.cnet>
From: Philipp Hahn <hahn@univention.de>
Message-ID: <89e44b58-a7f8-dbe8-02cf-74b42ba2e9b5@univention.de>
Date: Tue, 21 Mar 2017 10:03:53 +0100
MIME-Version: 1.0
In-Reply-To: <20170320232032.GA28018@amt.cnet>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] acpi_piix4: fix migration of gpe fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <anthony@codemonkey.ws>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org

Hello Marcelo,

Am 21.03.2017 um 00:20 schrieb Marcelo Tosatti:
> On Mon, Mar 20, 2017 at 01:02:10PM +0100, Philipp Hahn wrote:
>> Hello Marcelo, cc:qemu,
>>
>> Sorry for re-using this old thread, but I have a problem loading some
>> saved state from qemu-kvm-1.1.2, which fails for piix4_pm.
>>
>> You following patch was committed as
>> <http://git.qemu-project.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Db0b873a0=
7872f7ab7f66f259c73fb9dd42aa66a9>:
>>
>> Am 15.11.2012 um 01:11 schrieb Marcelo Tosatti:
>>> Migrate 16 bytes for en/sts fields (which is the correct size),
>>> increase version to 3, and document how to support incoming
>>> migration from qemu-kvm 1.2.
>>
>> I my case qemu-kvm-1.1.2/hw/acpi_piix4.c:284
>> | VMSTATE_STRUCT(ar.gpe, PIIX4PMState, 2, vmstate_gpe, ACPIGPE),
>> only saves 4 bytes, not 16 bytes.
>=20
> IIRC qemu-1.1.2 saved 16 bytes, which is the correct size, not 4 bytes.

I found 23910d3f669d46073b403876e30a7314599633af in qemu, which changed
"gpe" to be an array[4] instead of single "struct gpe_regs" without
changing the version number. So the incompatibility was introduced there.

> So while merging from qemu-kvm -> qemu, it was decided to maintain
> backwards compability with qemu, and not qemu-kvm.
>=20
> Is there any way to differentiate between the two (qemu vs qemu-kvm,=20
> perhaps via some other field not in the VMState of ACPI PIIX4), so
> your patch can be integrated upstream?

I had a look and haven't found any reliable indicator to distinguish
between "qemu" and "qemu-kvm" yet. I'll have another look if my time
permits, but as I know "qemu-kvm" was used in my case, I will hard code
that knowledge for now in my private build.

Thank you four sharing your knowledge.

Philipp

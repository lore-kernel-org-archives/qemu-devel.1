Received: from eggs.gnu.org ([2001:4830:134:3::10]:55440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f8oL0-0002Vf-Mn
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f8oKv-0005R4-SJ
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:45:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34448 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f8oKv-0005Qn-Ni
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:45:29 -0400
References: <20180418060243.iafg4wj5gwsruop5@sirius.home.kraxel.org>
	<b9c7d767-39c4-065f-f487-34c0c682bd85@redhat.com>
	<20180418090457.dqg5gxnzobdofkao@sirius.home.kraxel.org>
	<b3298c44-4cdf-1936-fb69-32d308ff3a25@redhat.com>
	<20180418122312.ebmd2nrtvk2h5e45@sirius.home.kraxel.org>
	<f8c3945f-d2e7-e4a4-2b38-2736acd99e7c@redhat.com>
	<20180418130619.cmyyyl7fj2wfum7k@sirius.home.kraxel.org>
	<0545cc73-d821-c2d9-e4ab-938e58c34c2b@redhat.com>
	<20180418135344.GQ27579@redhat.com>
	<9b760289-a92e-4ec0-ce3b-f13665b5799b@redhat.com>
	<20180418140609.GT27579@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <bf0f4afc-a538-100c-3026-44860977cf02@redhat.com>
Date: Wed, 18 Apr 2018 16:45:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180418140609.GT27579@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On 04/18/18 16:06, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Apr 18, 2018 at 04:03:03PM +0200, Laszlo Ersek wrote:

>> - Would you like me to capture the directory paths in the firmware.jso=
n
>>   file, or in the commit message for the patch?
>=20
> Should be in whatever file ends up in the docs/specs directory eventual=
ly.
>=20
>>
>> - Should we keep @secure-boot-enrolled-keys (or, as Gerd suggests,
>>   @enrolled-keys) in the schema, as a feature enum constant, but remov=
e
>>   the documentation of the actual certificates? (I.e., say "an
>>   unspecified set of certificates has been enrolled and SB mode has be=
en
>>   enabled".)
>=20
> I think it is worth keeping the feature flag - we simply don't need
> to say /what/ keys.

All clear, thanks.
Laszlo

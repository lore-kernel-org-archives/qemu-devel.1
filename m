Received: from eggs.gnu.org ([2001:4830:134:3::10]:38807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5rhJ-0002SQ-TN
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f5rhF-0004TS-W4
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:44:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34626 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f5rhF-0004TA-Rg
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:44:21 -0400
References: <20180407000117.25640-1-lersek@redhat.com>
	<20180409084940.GE18283@redhat.com>
	<3381bdf1-62ea-9da7-c654-032c0c11fb4e@redhat.com>
	<20180410091832.GG5155@redhat.com>
	<dbb6c144-d8ce-3525-1c9c-7d45b47cc7bc@redhat.com>
	<20180410113444.GR5155@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ef36367f-0a5c-2982-ded8-dfa6234f453d@redhat.com>
Date: Tue, 10 Apr 2018 13:44:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180410113444.GR5155@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu RFC] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On 04/10/18 13:34, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Apr 10, 2018 at 01:27:18PM +0200, Laszlo Ersek wrote:
>=20
>> Please go through the rest of the emails in this thread, and advise:
>> - if the firmware descriptor schema may perhaps live in the libvirt tr=
ee,
>> - accordingly, if the schema could be expressed as an XSD (and firmwar=
e
>> packages should provide the descriptor documents as XMLs)
>> - if you agree that the descriptor document can uniquely reference
>> mapping methods implemented in libvirtd by simple enum constants (with
>> necessary parameters provided).
>=20
> No to all three. This is the responsibility of QEMU to define, because
> this information is relevant to anything managing QEMU not just libvirt=
.

In that case, how do you suggest we describe the QEMU command line
options that are (a) necessary, (b) "discoverable" to the management
application? Should we provide verbatim command line fragments (option
templates)? Is this feature meant to replace the cmdline generation
logic that already exists in libvirtd?

Thanks
Laszlo

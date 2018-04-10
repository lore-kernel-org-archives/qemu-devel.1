Received: from eggs.gnu.org ([2001:4830:134:3::10]:36910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f5qI5-0007iA-9n
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:14:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f5qI0-0007nw-9M
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:14:17 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:39926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f5qI0-0007nJ-2A
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 06:14:12 -0400
Received: by mail-wr0-f171.google.com with SMTP id c24so12220264wrc.6
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 03:14:11 -0700 (PDT)
References: <20180407000117.25640-1-lersek@redhat.com>
	<979bd720-cdb3-6468-1fbd-e8ec1c6c6c8d@redhat.com>
	<8ddd0a2f-b9b1-08c0-0f4d-62e7aea7e96a@redhat.com>
	<20180410062754.eohou7i7chf6w65j@sirius.home.kraxel.org>
	<dc439111-4161-96e6-5b45-4dcee886427d@redhat.com>
	<20180410092342.GH5155@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a552c213-4d89-fc17-b89c-8cbaf1e0331a@redhat.com>
Date: Tue, 10 Apr 2018 12:09:43 +0200
MIME-Version: 1.0
In-Reply-To: <20180410092342.GH5155@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu RFC] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Michal Privoznik <mprivozn@redhat.com>, David Gibson <dgibson@redhat.com>

On 10/04/2018 11:23, Daniel P. Berrangé wrote:
>> And, really, this seems to reinforce my point that the schema should
>> live in the libvirtd tree, not in the QEMU tree. In that case, perhaps
>> it would be a better fit to work with an XSD, and firmware packages
>> should install XML files? Personally I'm a lot more attracted to
>> XML/XSD; I think the tooling is better too. I just don't see how QEMU is
>> involved.
>
> This is defining a set of metadata that is required to use various firmware
> files in combination with QEMU, along with defining a mapping to QEMU command
> line arguments and/or features. Essentially, while I wish everyone used
> libvirt, libvirt is not the only thing that manages QEMU. This information is
> relevant to anyone managing QEMU, so it doesn't belong in libvirt's realm,
> it is clear QEMU is best placed to declare this information.

QEMU is best placed to _standardize_ how to provide this information
(and where in the file system to place it), but really it's up to
firmware packages to provide it.

We can of course define the schema in QAPI terms for ease of validation
(machine-readable specs are nice to have), but really this should just
be a file in docs/interop/.  No code is needed in QEMU.

Paolo

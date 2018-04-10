Received: from eggs.gnu.org ([2001:4830:134:3::10]:33007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5rYE-0005qy-AC
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5rY9-0007bJ-Td
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:35:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33136 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f5rY9-0007b5-Ox
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:34:57 -0400
Date: Tue, 10 Apr 2018 12:34:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180410113444.GR5155@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180407000117.25640-1-lersek@redhat.com>
	<20180409084940.GE18283@redhat.com>
	<3381bdf1-62ea-9da7-c654-032c0c11fb4e@redhat.com>
	<20180410091832.GG5155@redhat.com>
	<dbb6c144-d8ce-3525-1c9c-7d45b47cc7bc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dbb6c144-d8ce-3525-1c9c-7d45b47cc7bc@redhat.com>
Subject: Re: [Qemu-devel] [qemu RFC] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

On Tue, Apr 10, 2018 at 01:27:18PM +0200, Laszlo Ersek wrote:

> Please go through the rest of the emails in this thread, and advise:
> - if the firmware descriptor schema may perhaps live in the libvirt tree,
> - accordingly, if the schema could be expressed as an XSD (and firmware
> packages should provide the descriptor documents as XMLs)
> - if you agree that the descriptor document can uniquely reference
> mapping methods implemented in libvirtd by simple enum constants (with
> necessary parameters provided).

No to all three. This is the responsibility of QEMU to define, because
this information is relevant to anything managing QEMU not just libvirt.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

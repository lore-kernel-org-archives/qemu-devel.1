Received: from eggs.gnu.org ([2001:4830:134:3::10]:42915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5ml5-0000SV-Tu
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 02:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5ml2-0003kf-Ql
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 02:27:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39470 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f5ml2-0003kN-Lp
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 02:27:56 -0400
Date: Tue, 10 Apr 2018 08:27:54 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180410062754.eohou7i7chf6w65j@sirius.home.kraxel.org>
References: <20180407000117.25640-1-lersek@redhat.com>
	<979bd720-cdb3-6468-1fbd-e8ec1c6c6c8d@redhat.com>
	<8ddd0a2f-b9b1-08c0-0f4d-62e7aea7e96a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ddd0a2f-b9b1-08c0-0f4d-62e7aea7e96a@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

  Hi,

> - I considered adding wildcards (say, blacklist "all" i440fx machtypes,
> present and future, for SMM-requiring OVMF builds), but then you get
> into version sorting and similar mess. I considered fnmatch() --
> basically simple ? and * wildcards -- but that's not expressive enough.

I'd suggest whitelist with wildcards.  So the smm builds would get
"pc-q35-*".

libvirt knows about aliases, so it should be able to handle the "q35"
shortcut like "pc-q35-${latest}".

Or do you see another issue?

cheers,
  Gerd

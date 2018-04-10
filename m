Received: from eggs.gnu.org ([2001:4830:134:3::10]:34858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5rb7-00079n-OL
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:38:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5rb3-00015J-OJ
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:38:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38808 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f5rb3-000155-K6
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:37:57 -0400
Date: Tue, 10 Apr 2018 13:37:53 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180410113753.kuf7pmzxddm3rimb@sirius.home.kraxel.org>
References: <20180407000117.25640-1-lersek@redhat.com>
	<20180410102033.GL5155@redhat.com>
	<20180410110357.GP5155@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410110357.GP5155@redhat.com>
Subject: Re: [Qemu-devel] [qemu RFC] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Gary Ching-Pang Lin <glin@suse.com>, Michal Privoznik <mprivozn@redhat.com>, David Gibson <dgibson@redhat.com>

  Hi,

> It occurs to me that we are actually over-thinking things, by making it
> possible to list a choice of vars files per firmware. We could remove this
> special case by just having separate tpo level firmware entries and a main
> feature flag to say if it is enrolled or not - see below example

That would also make it easier to implement something like ...

    qemu -firmware json=/path/to/firmware/spec.json

... because you simply have two files for the enrolled/non-enrolled
variants.

cheers,
  Gerd

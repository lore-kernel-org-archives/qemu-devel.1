Received: from eggs.gnu.org ([2001:4830:134:3::10]:44514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f8mE5-0008Bc-PU
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f8mE2-0002EO-KA
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:30:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34444 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f8mE2-0002EB-CY
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:30:14 -0400
Date: Wed, 18 Apr 2018 14:30:02 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180418123002.7hiu2hr6rdxvab5u@sirius.home.kraxel.org>
References: <20180417224054.26363-1-lersek@redhat.com>
	<20180418060243.iafg4wj5gwsruop5@sirius.home.kraxel.org>
	<b9c7d767-39c4-065f-f487-34c0c682bd85@redhat.com>
	<20180418090457.dqg5gxnzobdofkao@sirius.home.kraxel.org>
	<b3298c44-4cdf-1936-fb69-32d308ff3a25@redhat.com>
	<20180418115734.GG27579@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418115734.GG27579@redhat.com>
Subject: Re: [Qemu-devel] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

  Hi,

> So now the question is should this string be declared to be
> glob format, or regex format. Regex is more flexible, but
> regex syntax is ill-defined because every regex engine is
> slightly different.

I'd go for glob.  It's good enough for the version number and
most likely we don't need anything else.

And the machine types are a list, so there is still the option
to just have multiple entries in case it turns out we need
something glob can't cover with a single entry.

cheers,
  Gerd

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f8mn6-000477-9q
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f8mn3-0006Bo-3i
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:06:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60626 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f8mn2-0006BN-TU
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 09:06:25 -0400
Date: Wed, 18 Apr 2018 15:06:19 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180418130619.cmyyyl7fj2wfum7k@sirius.home.kraxel.org>
References: <20180417224054.26363-1-lersek@redhat.com>
	<20180418060243.iafg4wj5gwsruop5@sirius.home.kraxel.org>
	<b9c7d767-39c4-065f-f487-34c0c682bd85@redhat.com>
	<20180418090457.dqg5gxnzobdofkao@sirius.home.kraxel.org>
	<b3298c44-4cdf-1936-fb69-32d308ff3a25@redhat.com>
	<20180418122312.ebmd2nrtvk2h5e45@sirius.home.kraxel.org>
	<f8c3945f-d2e7-e4a4-2b38-2736acd99e7c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8c3945f-d2e7-e4a4-2b38-2736acd99e7c@redhat.com>
Subject: Re: [Qemu-devel] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

> > Other question:  Do we want allow to specify which certs/keys are
> > enrolled?  Which would probably mean to drop "enrolled-keys" from
> > features and make it an optional string instead,
> 
> Not an enum? "Microsoft" below should be an enum constant, shouldn't it?

I don't think so.  If we want allow other certificate providers (not
sure it makes sense as all physical hardware actually runs with the
microsoft certificates), then we don't want a fixed list here.  So any
CA can be listed, be it microsoft, redhat, canonical, verisign or
kraxel.org ;)

cheers,
  Gerd

Received: from eggs.gnu.org ([2001:4830:134:3::10]:41196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f8m7T-0004wv-35
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f8m7Q-0007qT-0K
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:23:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56584 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f8m7P-0007q7-Ri
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 08:23:23 -0400
Date: Wed, 18 Apr 2018 14:23:12 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180418122312.ebmd2nrtvk2h5e45@sirius.home.kraxel.org>
References: <20180417224054.26363-1-lersek@redhat.com>
	<20180418060243.iafg4wj5gwsruop5@sirius.home.kraxel.org>
	<b9c7d767-39c4-065f-f487-34c0c682bd85@redhat.com>
	<20180418090457.dqg5gxnzobdofkao@sirius.home.kraxel.org>
	<b3298c44-4cdf-1936-fb69-32d308ff3a25@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3298c44-4cdf-1936-fb69-32d308ff3a25@redhat.com>
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

  Hi,

> Hmmm, I'm not sure I agree. One use case is that you want a domain
> config in which well-known OS-es, signed by the MS UEFI certs, just boot
> with SB enabled. (Some of our internal folks really want this.)
> 
> Another use case is that you want a domain in which SB *can* be enabled,
> but your installer is signed with a different certificate chain (or it
> is unsigned), and with *just* the MS certs enrolled, it wouldn't boot at
> all. So you want the SB *feature*, but definitely not the initial
> enrollment / SB *operational mode*.

So "secure-boot-enrolled-keys" also has SB turned on.

> For me to understand you better, are you suggesting merely that I:
> 
> - rename @secure-boot-enrolled-keys to @enrolled-keys, and
> 
> - drop the reference to @secure-boot from the end of the @enrolled-keys
>   documentation paragraph? (Namely, "@secure-boot-enrolled-keys is only
>   valid if the firmware also supports @secure-boot").

Yes.  So "secure-boot" specifies "firmware binary supports secure-boot"
and "enrolled-keys" specifies "firmware nvram template has keys enrolled
(and SB enabled).

Other question:  Do we want allow to specify which certs/keys are
enrolled?  Which would probably mean to drop "enrolled-keys" from
features and make it an optional string instead, then specify
"'enrolled-keys' : 'Microsoft'" in the json file.

cheers,
  Gerd

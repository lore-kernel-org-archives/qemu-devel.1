Received: from eggs.gnu.org ([2001:4830:134:3::10]:58839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gUeFs-0007qX-Ir
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gUeFr-00022E-TX
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:58:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gUeFr-0001yS-LQ
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:58:47 -0500
Date: Wed, 5 Dec 2018 15:58:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181205155739-mutt-send-email-mst@kernel.org>
References: <20181025140631.634922-1-sameeh@daynix.com>
	<20181205171818.GA1136@redhat.com>
	<154404147264.6063.14869520867110106084@sif>
	<154404267804.6063.6272296350458255377@sif>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154404267804.6063.6272296350458255377@sif>
Subject: Re: [Qemu-devel] [RFC 0/2] Attempt to implement the standby feature
 for assigned network devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Sameeh Jubran <sameeh@daynix.com>, Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Dec 05, 2018 at 02:44:38PM -0600, Michael Roth wrote:
> > So how important is it that setting F_STANDBY cap doesn't break older
> > guests? If the idea is to support live migration with VFs then aren't
> > we still dead in the water if the guest boots okay but doesn't have
> > the requisite functionality to be migrated later? Shouldn't that all
> 
> Well, I guess that's not really the scenario with this approach. Instead
> they'd run with degraded network performance but could still at least be
> migrated.

Thanks, that's a good summary. And instead of degraded we call it
un-accelerated.

-- 
MST

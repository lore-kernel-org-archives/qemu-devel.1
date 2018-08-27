Received: from eggs.gnu.org ([2001:4830:134:3::10]:37300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuFNa-0001Ch-SH
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuF9C-00067D-NU
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:53:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45898 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fuF9C-000678-Ij
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:53:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3831240216E9
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 10:53:26 +0000 (UTC)
Date: Mon, 27 Aug 2018 12:53:21 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180827105321.5qeclqhsopqtutjv@sirius.home.kraxel.org>
References: <20180822095421.11765-1-quintela@redhat.com>
	<20180822095421.11765-8-quintela@redhat.com>
	<0d3a215b-4916-b0a6-5654-5d64fcf6c996@redhat.com>
	<87y3cyo4ax.fsf@trasno.org>
	<20180823074321.wx7wix7jwsfrcbk5@sirius.home.kraxel.org>
	<9cb5f027-e49c-d943-7ffa-9e744537f174@redhat.com>
	<20180823094850.zycuwtjndmztgcm4@sirius.home.kraxel.org>
	<20180823095359.GH23703@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823095359.GH23703@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/10] check: Only test boot-serial when
 sga is compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, lvivier@redhat.com, Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

  Hi,

> The only way we can stop using "-device sga" is if we either have
> something explicit in the XML saying whether to use it or not, or
> alternatively have some indicator associated with the next versioned
> machine type that we can hook off.

How does libvirt query the machine type properties?

thanks,
  Gerd

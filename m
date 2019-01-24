Received: from eggs.gnu.org ([209.51.188.92]:43882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmcY8-0007ev-T8
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:47:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmcY8-0002XC-1m
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:47:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmcY7-0002Ts-Ry
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:47:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 815A2398A
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 10:47:54 +0000 (UTC)
Date: Thu, 24 Jan 2019 11:47:45 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190124104745.2fifiixokjys6xj6@sirius.home.kraxel.org>
References: <20190118122210.505-1-kraxel@redhat.com>
	<2f82c614-882d-549d-be23-4a65d6e0d876@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f82c614-882d-549d-be23-4a65d6e0d876@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] audio: fix pc speaker init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org

> > +static int pcspk_audio_init(ISABus *bus)
> > +{
> > +    isa_create_simple (bus, TYPE_PC_SPEAKER);
> > +    return 0;
> 
> Previously we had soundhw_init() calling pcspk_audio_init() and ignore
> failures. Now since you use isa_create_simple() which calls
> qdev_init_nofail(), failure will directly exit(1).
> Is it the expected behavior?

The change wasn't intentional, but I think it is better to throw an
error instead of silently ignoring the problem.

In practice it probably doesn't make much of a difference, there isn't
much why isa_create_simple could fail ...

cheers,
  Gerd

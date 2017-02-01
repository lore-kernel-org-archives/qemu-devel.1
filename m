Received: from eggs.gnu.org ([2001:4830:134:3::10]:52321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cYvh9-0001bn-4E
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 09:15:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cYvh5-00046z-QO
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 09:15:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cYvh5-00046V-KU
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 09:15:31 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 77F3780F6B
	for <qemu-devel@nongnu.org>; Wed,  1 Feb 2017 14:15:31 +0000 (UTC)
Message-ID: <1485958527.3484.15.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 01 Feb 2017 15:15:27 +0100
In-Reply-To: <0a4ea84b-56da-4069-e0d5-19d98dfe86f0@redhat.com>
References: <1485788877-3823-1-git-send-email-abologna@redhat.com>
	<1485894840.1076.45.camel@redhat.com>
	<0a4ea84b-56da-4069-e0d5-19d98dfe86f0@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] q35: Provide improved sample configurations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: drjones@redhat.com, qemu-devel@nongnu.org

On Tue, 2017-01-31 at 15:03 -0600, Eric Blake wrote:
> > Note that you can specify -readconfig multiple times, so you can spli=
t
> > out common stuff and ask people to run "qemu -readconfig
> > q35-paravirt-base.cfg -readconfig q35-paravirt-$style.cfg"
>=C2=A0
> Can we add #include-like semantics, so that one .cfg file can
> automatically pull in pre-requisites without having to document a
> command-line use of multiple -readconfig?

That would be neat! But in the short term calling -readconfig
multiple times does the trick ;) We can update the sample
configurations if and when #include is implemented.

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization

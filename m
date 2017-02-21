Received: from eggs.gnu.org ([2001:4830:134:3::10]:34064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgJR8-0002PS-6u
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 18:01:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgJR5-0001ga-6J
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 18:01:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cgJR5-0001gL-0I
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 18:01:31 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F07993D941
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 23:01:30 +0000 (UTC)
Message-ID: <1487718088.20449.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 22 Feb 2017 00:01:28 +0100
In-Reply-To: <20170221141451.28305-27-marcandre.lureau@redhat.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-27-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 26/30] tests: allows to run single test
 in usb-hcd-ehci-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

On Di, 2017-02-21 at 18:14 +0400, Marc-Andr=C3=A9 Lureau wrote:
> pci_init() shouldn't be a test function, but instead called before any
> test. This allows to run a single test with -p /x86_64/ehci/....

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

/me assumes you'll go send a pull request for the whole series?
Or do you want me cherry-pick the usb patches into the usb queue?

cheers,
  Gerd

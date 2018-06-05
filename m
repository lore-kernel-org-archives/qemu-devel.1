Received: from eggs.gnu.org ([2001:4830:134:3::10]:59757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fQ8AM-0006jP-1x
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fQ8AI-0007Gk-UB
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:22:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53758 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fQ8AI-0007AQ-MW
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:22:06 -0400
Date: Tue, 5 Jun 2018 11:21:58 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180605092158.ccdboal2fpvb3rpw@sirius.home.kraxel.org>
References: <20180604151421.23385-1-f4bug@amsat.org>
	<20180604151421.23385-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604151421.23385-4-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] usb/dev-mtp: Fix use of
 uninitialized values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org

> +    for (i = c->argc; i < ARRAY_SIZE(c->argv); i++) {
> +        c->argv[i] = 0;
> +    }

I think the code filling c->argv (in usb_mtp_handle_data) should so
that.  Or just memset(0) cmd in usb_mtp_handle_data ...

cheers,
  Gerd

PS: the other patches are fine.

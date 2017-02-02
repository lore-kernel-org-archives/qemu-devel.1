Received: from eggs.gnu.org ([2001:4830:134:3::10]:40479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZInJ-0007TW-Vm
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:55:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZInG-0005hc-3A
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:55:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cZInF-0005hW-Tj
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:55:26 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F69480465
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 14:55:25 +0000 (UTC)
Message-ID: <1486047322.20628.42.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 02 Feb 2017 15:55:22 +0100
In-Reply-To: <1486046738-26059-1-git-send-email-abologna@redhat.com>
References: <1486046738-26059-1-git-send-email-abologna@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3] q35: Improve sample configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, drjones@redhat.com

  Hi,

> +++ b/docs/q35-emulated.cfg

> +#   00:01.0 VGA compatible controller

> +[device "video"]
> +  driver =3D "VGA"
> +  bus =3D "pcie.0"
> +  addr =3D "02.0"

Here is a address mismatch ;)

Otherwise looks all fine to me.

cheers,
  Gerd

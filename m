Received: from eggs.gnu.org ([2001:4830:134:3::10]:34009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cWqxH-0003yC-EO
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 15:47:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cWqxE-0004F7-OL
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 15:47:38 -0500
Received: from mail-vk0-x230.google.com ([2607:f8b0:400c:c05::230]:33334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cWqxE-0004Ex-Jm
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 15:47:36 -0500
Received: by mail-vk0-x230.google.com with SMTP id k127so162690627vke.0
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 12:47:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1701261017370.2884@sstabellini-ThinkPad-X260>
References: <20170124164253.jiva4zvk6fxewtsk@dhcp-3-221.uk.xensource.com>
	<alpine.DEB.2.10.1701241315310.10192@sstabellini-ThinkPad-X260>
	<alpine.DEB.2.10.1701241326560.10192@sstabellini-ThinkPad-X260>
	<20170125110529.5rgu7xrh3gkoadog@dhcp-3-221.uk.xensource.com>
	<20170126154509.rxi5sy4bcob2ioen@dhcp-3-221.uk.xensource.com>
	<alpine.DEB.2.10.1701261017370.2884@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Jan 2017 20:47:15 +0000
Message-ID: <CAFEAcA__2S3jTKEFy3Ue=Vvw+tuE1Du573PQp-VYOa6jBRpWCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Xen-devel] Commit 3a6c9 breaks QEMU on FreeBSD/Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org, QEMU Developers <qemu-devel@nongnu.org>

On 26 January 2017 at 19:36, Stefano Stabellini <sstabellini@kernel.org> wrote:
> It should be just a matter of replacing qdev_init_nofail with something
> that can fail. I couldn't find a regular qdev_init that can return
> error, so maybe we would need to add it.

That's just
    object_property_set_bool(OBJECT(whatever), true, "realized", &err);

ie "please realize the device".

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:53806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZ1P8-00011M-7B
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:21:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZ1P5-0007qs-F7
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:21:20 -0500
Received: from mail-ua0-x22d.google.com ([2607:f8b0:400c:c08::22d]:34966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZ1P5-0007qY-9r
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:21:19 -0500
Received: by mail-ua0-x22d.google.com with SMTP id y9so306518462uae.2
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 12:21:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1702011134020.17946@sstabellini-ThinkPad-X260>
References: <20170201065202.7746-1-jgross@suse.com>
	<alpine.DEB.2.10.1702011134020.17946@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Feb 2017 20:20:57 +0000
Message-ID: <CAFEAcA_ZxP8iq-vcuBHUzVa7EmjCtqyZ6t8Meu1ypyusnJYACA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] xen: use qdev_unplug() instead of
 g_free() in xen_pv_find_xendev()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, xen-devel@lists.xenproject.org, Anthony PERARD <anthony.perard@citrix.com>, Gerd Hoffmann <kraxel@redhat.com>, Juergen Gross <jgross@suse.com>

On 1 February 2017 at 19:37, Stefano Stabellini <sstabellini@kernel.org> wrote:
> Hi Peter,
>
> do you think this is acceptable?

The set of operations here is basically what I suggested
in review of v1, so I think it is the right thing.
OTOH this is a bit of an odd corner of the QOM model
so it might be worth doing some testing to make sure
the reference counts are doing what you (I) expect and
that the object does get correctly freed both in the
error-handling path here and when the device is
unplugged via xen_pv_del_xendev().

thanks
-- PMM

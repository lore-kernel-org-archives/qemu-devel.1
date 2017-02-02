Received: from eggs.gnu.org ([2001:4830:134:3::10]:44235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1cZEX0-00029L-Bd
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 05:22:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1cZEWx-0004nI-8b
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 05:22:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:35869)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1cZEWx-0004mn-2n
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 05:22:19 -0500
References: <20170201065202.7746-1-jgross@suse.com>
	<alpine.DEB.2.10.1702011134020.17946@sstabellini-ThinkPad-X260>
	<CAFEAcA_ZxP8iq-vcuBHUzVa7EmjCtqyZ6t8Meu1ypyusnJYACA@mail.gmail.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <e5bbae6e-fff6-c05c-a151-deb592769680@suse.com>
Date: Thu, 2 Feb 2017 11:22:14 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ZxP8iq-vcuBHUzVa7EmjCtqyZ6t8Meu1ypyusnJYACA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, xen-devel@lists.xenproject.org, Anthony PERARD <anthony.perard@citrix.com>, Gerd Hoffmann <kraxel@redhat.com>

On 01/02/17 21:20, Peter Maydell wrote:
> On 1 February 2017 at 19:37, Stefano Stabellini <sstabellini@kernel.org> wrote:
>> Hi Peter,
>>
>> do you think this is acceptable?
> 
> The set of operations here is basically what I suggested
> in review of v1, so I think it is the right thing.
> OTOH this is a bit of an odd corner of the QOM model
> so it might be worth doing some testing to make sure
> the reference counts are doing what you (I) expect and
> that the object does get correctly freed both in the
> error-handling path here and when the device is
> unplugged via xen_pv_del_xendev().

I've used my_g_free() printing a log message when called instead of
g_free() in a test. I could verify it has been called when the
device was unplugged. This test covered xen_pv_del_xendev() and
an error handling path.


Juergen

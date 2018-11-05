Received: from eggs.gnu.org ([2001:4830:134:3::10]:58115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gJdqS-0001fr-Th
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:19:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gJdqN-0002RF-Uf
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:19:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lhrazky@redhat.com>) id 1gJdqN-0002KG-LB
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:18:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id u1-v6so9301871wrn.0
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 04:18:59 -0800 (PST)
Message-ID: <1541420337.16655.496.camel@redhat.com>
From: =?UTF-8?Q?Luk=C3=A1=C5=A1_Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>
Date: Mon, 05 Nov 2018 13:18:57 +0100
In-Reply-To: <20181105065258.4mpdv5w4rp3eui5p@sirius.home.kraxel.org>
References: <20181017143604.5194-1-lhrazky@redhat.com>
	<20181017143604.5194-2-lhrazky@redhat.com>
	<1506037511.34884353.1539846969311.JavaMail.zimbra@redhat.com>
	<1540208764.16655.240.camel@redhat.com>
	<1541087251.16655.419.camel@redhat.com>
	<20181105065258.4mpdv5w4rp3eui5p@sirius.home.kraxel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH spice v2 1/2] QXL interface: add
 functions to identify monitors in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Frediano Ziglio <fziglio@redhat.com>, spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

On Mon, 2018-11-05 at 07:52 +0100, Gerd Hoffmann wrote:
> > 2. Have a single function as follows:
> > 
> > void spice_qxl_set_device_info(QXLInstance *instance,
> >                                const char *device_address,
> >                                uint32_t device_display_id_start,
> >                                uint32_t device_display_id_count);
> 
> How about:
> 
> void spice_qxl_set_device_info(QXLInstance *instance,
>                                const char *device_address,
>                                uint32_t device_display_id);
> 
> I don't think we need start+count:
> 
>  * For single-head devices device_display_id will be zero.
>  * For one-channel-per-head multihead devices (i.e. virtio-gpu)
>    device_display_id will enumerate the heads (so everybody can figure
>    which channel is which head).
>  * For one-channel-per-device multihead devices (i.e. qxl/linux)
>    device_display_id will be zero too.  Number of heads is set via
>    spice_qxl_set_max_monitors().

That requires nontrivial and unexpected logic for the one-channel-per-
device multihead devices case. The API should be doing what it says and
 the dumber the better, this seems too smart to me...

That said, I don't find it significantly worse than the other options
(none of which seems great), so I'd just like we reached some consesus
and be done with it...

Cheers,
Lukas

> cheers,
>   Gerd
> 

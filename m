Received: from eggs.gnu.org ([2001:4830:134:3::10]:35546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gKhBt-0004E3-P2
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:05:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gKhBf-0007Lr-5q
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:05:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lhrazky@redhat.com>) id 1gKhBc-0007EP-Iw
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:05:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id z13-v6so18181996wrs.3
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 02:05:13 -0800 (PST)
Message-ID: <1541671510.16655.506.camel@redhat.com>
From: =?UTF-8?Q?Luk=C3=A1=C5=A1_Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>
Date: Thu, 08 Nov 2018 11:05:10 +0100
In-Reply-To: <20181108064927.i6llxv4kgcrdon7n@sirius.home.kraxel.org>
References: <20181107104921.20536-1-lhrazky@redhat.com>
	<20181107104921.20536-2-lhrazky@redhat.com>
	<20181108064927.i6llxv4kgcrdon7n@sirius.home.kraxel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH spice v3 1/3] QXL interface: add a
 function to identify monitors in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

Hello,

On Thu, 2018-11-08 at 07:49 +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > + * The device_display_id_{start,count} denotes the sequence of device display
> > + * IDs that map to the zero-based sequence of monitor IDs provided by monitors
> > + * config on this interface. For example with device_display_id_start = 2 and
> > + * device_display_id_count = 3 you get the following mapping:
> > + * monitor_id  ->  device_display_id
> > + *          0  ->  2
> > + *          1  ->  3
> > + *          2  ->  4
> > + *
> > + * Note this example is unsupported in practice. The only supported cases are
> > + * either a single device display ID (count = 1) or multiple device display IDs
> > + * in a sequence starting from 0.
> 
> This is confusing.  The usage of this api in the qemu counterpart looks
> sane though.

Not sure what you find confusing in particular... The example? Using an
example and then saying it's not supported? (I wated to use a
nontrivial example that will show the concept...) Suggestions for
improvement?

Thanks,
Lukas

> cheers,
>   Gerd
> 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:40587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gKe8e-0002wg-F8
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 01:50:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gKe8a-0006yy-Am
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 01:50:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gKe8Y-00067d-9v
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 01:49:56 -0500
Date: Thu, 8 Nov 2018 07:49:27 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181108064927.i6llxv4kgcrdon7n@sirius.home.kraxel.org>
References: <20181107104921.20536-1-lhrazky@redhat.com>
	<20181107104921.20536-2-lhrazky@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107104921.20536-2-lhrazky@redhat.com>
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
To: =?utf-8?B?THVrw6HFoSBIcsOhemvDvQ==?= <lhrazky@redhat.com>
Cc: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

  Hi,

> + * The device_display_id_{start,count} denotes the sequence of device display
> + * IDs that map to the zero-based sequence of monitor IDs provided by monitors
> + * config on this interface. For example with device_display_id_start = 2 and
> + * device_display_id_count = 3 you get the following mapping:
> + * monitor_id  ->  device_display_id
> + *          0  ->  2
> + *          1  ->  3
> + *          2  ->  4
> + *
> + * Note this example is unsupported in practice. The only supported cases are
> + * either a single device display ID (count = 1) or multiple device display IDs
> + * in a sequence starting from 0.

This is confusing.  The usage of this api in the qemu counterpart looks
sane though.

cheers,
  Gerd

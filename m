Received: from eggs.gnu.org ([2001:4830:134:3::10]:51378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cagF6-0004fY-Ep
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:09:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cagF3-0002oy-N9
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:09:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cagF3-0002oo-Ha
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:09:49 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D6D2D7E9D5
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 10:09:48 +0000 (UTC)
References: <1485244958-25911-1-git-send-email-thuth@redhat.com>
	<20170203111045.4367eb34@t450s.home>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <725c680a-f92d-3e64-439c-66cff5b5551c@redhat.com>
Date: Mon, 6 Feb 2017 11:09:45 +0100
MIME-Version: 1.0
In-Reply-To: <20170203111045.4367eb34@t450s.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/vfio/pci-quirks: Set category of the
 "vfio-pci-igd-lpc-bridge" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org

On 03.02.2017 19:10, Alex Williamson wrote:
> On Tue, 24 Jan 2017 09:02:38 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> The device has "bridge" in its name, so it should obviously be in
>> the category DEVICE_CATEGORY_BRIDGE.
> 
> Well, physical device is a bridge, but this is really just a stub.
> Does that count?  It doesn't create a subordinate bus that can actually
> host devices.

The device category is only used for sorting the device into a category
in the help output when the user runs QEMU with "-device ?". The
DEVICE_CATEGORY_BRIDGE is title there "Controller/Bridge/Hub devices",
so IMHO that should be fine for this device. Otherwise it should maybe
go into DEVICE_CATEGORY_MISC instead - but at least it should not stay
uncategorized, all devices that show up in the "-device ?" help text
should eventually get a category.

 Thomas

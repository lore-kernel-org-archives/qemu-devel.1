Received: from eggs.gnu.org ([2001:4830:134:3::10]:34998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cK33M-0002Vz-1u
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 08:05:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cK33I-0006uA-29
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 08:05:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cK33H-0006tm-SI
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 08:04:55 -0500
Date: Thu, 22 Dec 2016 14:04:51 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20161222140451.4fa67eac@nial.brq.redhat.com>
In-Reply-To: <20161222094029.GA1571@vader>
References: <20161222094029.GA1571@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] CPU hotplug on Windows 2016 as guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <eduardo.otubo@profitbricks.com>
Cc: qemu-devel@nongnu.org

On Thu, 22 Dec 2016 10:40:29 +0100
Eduardo Otubo <eduardo.otubo@profitbricks.com> wrote:

> Hi guys,
> 
> I'm just trying Qemu 2.7 and 2.8 and Windows 2016 as guest and cpu
> hotplug doesn't seem to be working. CPU appears on qemu device tree, but
> doesn't appear inside the guest (nor control panel, performance monitor
> or device manager)
> 
> Anyone going through this?
> 

It's MS regression we've found in September,
workaround is to remove wrong driver bindings in the guest
see: https://bugzilla.redhat.com/show_bug.cgi?id=1377155#c17

And complain to MS support so that they'd fix it.

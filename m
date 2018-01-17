Received: from eggs.gnu.org ([2001:4830:134:3::10]:51969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ebl7l-0007wO-VU
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:39:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ebl7f-0001qM-Gb
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:39:17 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:43497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ebl7f-0001pC-34
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:39:11 -0500
Received: by mail-wr0-f175.google.com with SMTP id t16so4669967wrc.10
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 02:39:10 -0800 (PST)
References: <20180116231824.27114-1-shaun.reitan@ndchost.com>
	<20180117103148.GE19227@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <39294893-a458-9f40-dc9c-bcac14d8be5e@redhat.com>
Date: Wed, 17 Jan 2018 11:39:06 +0100
MIME-Version: 1.0
In-Reply-To: <20180117103148.GE19227@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Add ability to provide ifname when using
 netdev bridge or tap helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Shaun Reitan <shaun.reitan@ndchost.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 17/01/2018 11:31, Daniel P. Berrange wrote:
> 
> eg consider the user asks for a tap device called  eth1. To the
> sysadmin the user's tap device now looks like a physical NIC.
> This can be even worse if the host does physical NIC hotplug,
> or uses SRIOV. eg consider the host as eth0 -> eth7 for SRIOV
> NICs, and eth3 is given to a guest. Now a user uses the setuid
> helper to ask for a TAP called eth3. When the SRIOV device is
> later released by the guest it will end up called eth8, as the
> TAP device occupies eth3. In bad cases this could even cause
> the host mgmt layer to configure bogus addresses on the eth3
> TAP device instead of the SRIOV device.
> 
> If we want to allow ifname to be set via the setuid helper, then IMHO,
> the config file for the helper *must* whitelist the various permitted
> naming patterns.

Indeed, a similar patch has been proposed several times, and always the
response was the same as Daniel's. :)

Paolo

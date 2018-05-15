Received: from eggs.gnu.org ([2001:4830:134:3::10]:57535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIbad-0002Ep-Ap
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIbaY-0008MI-RX
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:10:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46330 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fIbaY-0008Lh-Mu
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:10:06 -0400
References: <1526284560-20266-1-git-send-email-jasowang@redhat.com>
	<1526284560-20266-3-git-send-email-jasowang@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8e7bd278-eb4b-a142-2f57-7481a165ac3f@redhat.com>
Date: Tue, 15 May 2018 10:10:05 -0500
MIME-Version: 1.0
In-Reply-To: <1526284560-20266-3-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 2/4] net: Remove the deprecated "vlan"
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Thomas Huth <thuth@redhat.com>

On 05/14/2018 02:55 AM, Jason Wang wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> It's been marked as deprecated since QEMU v2.9.0, so that should have
> been enough time for everybody to either just drop unnecessary "vlan=0"
> parameters, to switch to the modern -device + -netdev syntax for connecting
> guest NICs with host network backends, or to switch to the "hubport" netdev
> in case hubs are really wanted instead.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/658904
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---

> @@ -499,10 +497,11 @@
>   # @opts: device type specific properties (legacy)
>   #
>   # Since: 1.2
> +#
> +# 'vlan' - removed with 2.12

Shouldn't this be 2.13?  Also, while the phrase 'removed with XXX' 
already appears for NetClientDriver::dump, it sounds awkward; better 
would be matching the way we document things for BlockDeviceInfo:

NetClientDriver
2.12: dropped 'dump'
...
NetLegacy
2.13: dropped 'vlan'

or the way we do it for QKeyCode:

NetClientDriver
dump: dropped in 2.12
...
NetLegacy
vlan: dropped in 2.13

As this is already in a pull request, and as NetClientDriver also needs 
a cleanup, that can be a followup patch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebInH-0008QN-Rl
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:24:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebInE-0003zP-Or
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:24:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebInE-0003zB-Ha
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:24:12 -0500
Date: Tue, 16 Jan 2018 06:24:04 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180116062059-mutt-send-email-mst@kernel.org>
References: <1514623933-25568-1-git-send-email-jianjay.zhou@huawei.com>
	<1514623933-25568-4-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1514623933-25568-4-git-send-email-jianjay.zhou@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] cryptodev-vhost-user: add crypto
 session handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jay Zhou <jianjay.zhou@huawei.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, weidong.huang@huawei.com, stefanha@redhat.com, pasic@linux.vnet.ibm.com, longpeng2@huawei.com, xin.zeng@intel.com, roy.fan.zhang@intel.com, arei.gonglei@huawei.com

On Sat, Dec 30, 2017 at 04:52:12PM +0800, Jay Zhou wrote:
> diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> index 954771d..f43c63d 100644
> --- a/docs/interop/vhost-user.txt
> +++ b/docs/interop/vhost-user.txt
> @@ -596,6 +596,25 @@ Master message types
>        and expect this message once (per VQ) during device configuration
>        (ie. before the master starts the VQ).
>  
> + * VHOST_USER_CREATE_CRYPTO_SESSION
> +
> +      Id: 23
> +      Equivalent ioctl: N/A
> +      Master payload: crypto session description
> +      Slave payload: crypto session description
> +
> +      Create a session for crypto operation. The server side must return the
> +      session id, 0 or positive for success, negative for failure.
> +
> + * VHOST_USER_CLOSE_CRYPTO_SESSION
> +
> +      Id: 24
> +      Equivalent ioctl: N/A
> +      Master payload: u64
> +
> +      Close a session for crypto operation which was previously
> +      created by VHOST_USER_CREATE_CRYPTO_SESSION.
> +
>  Slave message types
>  -------------------
>  


Sorry about a delayed response.
So an issue with this patchset is that you are adding
new messages unconditionally.

You must add a protocol bit whenever you add new messages.
If appropriate, you can document that it's a required feature for crypto
devices.


-- 
MST

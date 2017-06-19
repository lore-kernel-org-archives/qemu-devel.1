Received: from eggs.gnu.org ([2001:4830:134:3::10]:55200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dMr67-00014X-JP
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 03:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dMr66-0004u8-Sx
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 03:27:43 -0400
Date: Mon, 19 Jun 2017 09:27:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170619072727.GA6113@noname.redhat.com>
References: <7ec58051-d835-a485-7578-2022351c9712@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ec58051-d835-a485-7578-2022351c9712@gmail.com>
Subject: Re: [Qemu-devel] [Question] How can we confirm hot-plug disk
 succesfully?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xie Changlong <xiechanglong.d@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

Am 18.06.2017 um 09:21 hat Xie Changlong geschrieben:
> In device hot-remove scenario, if we don't probe acpiphp module on
> the guest, 'device_del' will never emit DEVICE_DELETED event(because
> guest will not write to __EJ0) . So we can confirm that hot-remove
> failed. But IIUC, there is no event such as DEVICE_ADDED, so
> 1) How can we confirm hotplug('device_add') successfully?
> 2) It seems when hot-plug disk, we don't care acpiphp module status
> on the guest, am I right?
> 3) Why there is no DEVICE_ADDED like event?

device_add doesn't need guest cooperation, so it is immediately
completed when the QMP command returns success.

Kevin

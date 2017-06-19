Received: from eggs.gnu.org ([2001:4830:134:3::10]:53983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiechanglong.d@gmail.com>) id 1dMo0S-0008M4-VK
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 00:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiechanglong.d@gmail.com>) id 1dMo0S-0000eG-5U
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 00:09:40 -0400
From: Xie Changlong <xiechanglong.d@gmail.com>
References: <7ec58051-d835-a485-7578-2022351c9712@gmail.com>
Message-ID: <bb530763-3eb9-cd2f-c5d8-a2ef67db1a7c@gmail.com>
Date: Mon, 19 Jun 2017 12:09:21 +0800
MIME-Version: 1.0
In-Reply-To: <7ec58051-d835-a485-7578-2022351c9712@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

Resend

在 6/18/2017 3:21 PM, Xie Changlong 写道:
> Hi all
> 
> In device hot-remove scenario, if we don't probe acpiphp module on the 
> guest, 'device_del' will never emit DEVICE_DELETED event(because guest 
> will not write to __EJ0) . So we can confirm that hot-remove failed. But 
> IIUC, there is no event such as DEVICE_ADDED, so
> 1) How can we confirm hotplug('device_add') successfully?
> 2) It seems when hot-plug disk, we don't care acpiphp module status on 
> the guest, am I right?
> 3) Why there is no DEVICE_ADDED like event?
> 
> Any answer would be appreciated, thanks.
> 

-- 
Thanks
     -Xie

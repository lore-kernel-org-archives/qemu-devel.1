Received: from eggs.gnu.org ([2001:4830:134:3::10]:60230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSpRz-0002Zh-7Q
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSpRy-0005Oz-8a
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 15:31:47 -0500
References: <20181130151712.2312-1-peter.maydell@linaro.org>
	<20181130151712.2312-9-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <808823a3-f808-27bd-9d8e-d8020ec08ac7@redhat.com>
Date: Fri, 30 Nov 2018 14:31:21 -0600
MIME-Version: 1.0
In-Reply-To: <20181130151712.2312-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/10] device_tree.c: Don't use load_image()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Philip Li <philip.li@intel.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org, qemu-ppc@nongnu.org

On 11/30/18 9:17 AM, Peter Maydell wrote:
> The load_image() function is deprecated, as it does not let the
> caller specify how large the buffer to read the file into is.
> Instead use load_image_size().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   device_tree.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

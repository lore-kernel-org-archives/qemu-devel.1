Received: from eggs.gnu.org ([2001:4830:134:3::10]:43583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e7G11-00033L-TZ
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 03:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e7G11-0001wh-4g
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 03:22:15 -0400
References: <BC29A004BA570342A4CC0044A3845572CFCE4DB9@H3CMLB12-EX.srv.huawei-3com.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <93ce91e1-d1cf-5781-c995-a2d82f5d515a@redhat.com>
Date: Wed, 25 Oct 2017 09:22:04 +0200
MIME-Version: 1.0
In-Reply-To: <BC29A004BA570342A4CC0044A3845572CFCE4DB9@H3CMLB12-EX.srv.huawei-3com.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-img crash when resize a qcow2 file created
 with preallocation=full/falloc .
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changlimin <changlimin@h3c.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 24.10.2017 05:28, Changlimin wrote:
> Hi,
> I am glad to see that qcow2 file created with preallocation=full/falloc can be resized. But when I test it, qemu-img crashs.
> qemu-img: block/qcow2-refcount.c:530: qcow2_refcount_area: Assertion `!(start_offset % s->cluster_size)' failed.
> 
> These are commands:
> qemu-img create -f qcow2 -o preallocation=full full.img 1G
> qemu-img resize --preallocation=full full.img +1G

Which version of qemu-img are you using? v2.10 or the latest git master
branch?

 Thomas

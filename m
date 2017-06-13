Received: from eggs.gnu.org ([2001:4830:134:3::10]:43533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dKdN9-0002qI-Eq
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 00:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dKdN8-0003Qp-Nf
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 00:24:07 -0400
Date: Tue, 13 Jun 2017 12:23:49 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170613042349.GC11751@pxdev.xzpeter.org>
References: <1497023553-18411-1-git-send-email-eric.auger@redhat.com>
	<1497023553-18411-2-git-send-email-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1497023553-18411-2-git-send-email-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/4] kvm-all: Pass an error object to
 kvm_device_access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, vijay.kilari@gmail.com, Vijaya.Kumar@cavium.com, drjones@redhat.com, quintela@redhat.com, dgilbert@redhat.com, christoffer.dall@linaro.org, zhaoshenglong@huawei.com, wei@redhat.com

On Fri, Jun 09, 2017 at 05:52:30PM +0200, Eric Auger wrote:
> In some circumstances, we don't want to abort if the
> kvm_device_access fails. This will be the case during ITS
> migration, in case the ITS table save/restore fails because
> the guest did not program the vITS correctly. So let's pass an
> error object to the function and return the ioctl value. New
> callers will be able to make a decision upon this returned
> value.
> 
> Existing callers pass &error_abort which will cause the
> function to abort on failure.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

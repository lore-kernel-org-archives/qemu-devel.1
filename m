Received: from eggs.gnu.org ([2001:4830:134:3::10]:33419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKIlg-00085p-Ln
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 02:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKIlf-0003U6-U7
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 02:24:04 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1497023553-18411-2-git-send-email-eric.auger@redhat.com> (Eric
	Auger's message of "Fri, 9 Jun 2017 17:52:30 +0200")
References: <1497023553-18411-1-git-send-email-eric.auger@redhat.com>
	<1497023553-18411-2-git-send-email-eric.auger@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 12 Jun 2017 08:23:50 +0200
Message-ID: <87r2yplo5l.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: eric.auger.pro@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, vijay.kilari@gmail.com, Vijaya.Kumar@cavium.com, drjones@redhat.com, peterx@redhat.com, dgilbert@redhat.com, christoffer.dall@linaro.org, zhaoshenglong@huawei.com, wei@redhat.com

Eric Auger <eric.auger@redhat.com> wrote:
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

Reviewed-by: Juan Quintela <quintela@redhat.com>

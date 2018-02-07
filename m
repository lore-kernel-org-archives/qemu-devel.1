Received: from eggs.gnu.org ([2001:4830:134:3::10]:38451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNhn-000476-WD
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:16:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNhj-00050k-33
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:15:59 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejNhi-00050G-S4
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:15:55 -0500
Received: by mail-wm0-f41.google.com with SMTP id f3so2589623wmc.1
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 03:15:54 -0800 (PST)
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-28-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e6efa53a-3a65-e15d-9ee2-89dcaded1b22@redhat.com>
Date: Wed, 7 Feb 2018 12:15:50 +0100
MIME-Version: 1.0
In-Reply-To: <20180206203048.11096-28-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 27/34] tests: hv-scsi: add start-stop
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Ben Warren <ben@skyportsystems.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Vadim Rozenfeld <vrozenfe@redhat.com>, "Denis V. Lunev" <den@openvz.org>, si-wei liu <si-wei.liu@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>

On 06/02/2018 21:30, Roman Kagan wrote:
> +    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
> +        g_printerr("Hyper-V / VMBus are only available on x86\n");
> +        exit(EXIT_FAILURE);
> +    }

This shouldn't be needed.

> +
> +    if (access("/dev/kvm", R_OK | W_OK)) {

Maybe try opening it too?  In theory you could have a /dev/kvm device
that triggers loading the kvm module (see
https://github.com/systemd/systemd/pull/7795 for gory details).

Paolo

> +        g_printerr("Hyper-V / VMBus can only be used with KVM\n");
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    return qtest_pc_boot(cmd, extra_opts ? : "");

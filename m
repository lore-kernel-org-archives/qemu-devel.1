Received: from eggs.gnu.org ([2001:4830:134:3::10]:42539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dId29-0004fO-MN
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dId28-0005uF-84
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:38:09 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:36572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dId28-0005tl-1E
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:38:08 -0400
Received: by mail-wr0-x22a.google.com with SMTP id v111so7851415wrc.3
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 08:38:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170607152825.12081-2-pbonzini@redhat.com>
References: <20170607152825.12081-1-pbonzini@redhat.com>
	<20170607152825.12081-2-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Jun 2017 16:37:46 +0100
Message-ID: <CAFEAcA8CppP6YEPkGxVEyLnO=Kk1qirpGk2sh0bXedscxct8Jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 18/33] vhost-user-scsi: Introduce
 vhost-user-scsi host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Felipe Franciosi <felipe@nutanix.com>

On 7 June 2017 at 16:28, Paolo Bonzini <pbonzini@redhat.com> wrote:
> From: Felipe Franciosi <felipe@nutanix.com>
>
> This commit introduces a vhost-user device for SCSI. This is based
> on the existing vhost-scsi implementation, but done over vhost-user
> instead. It also uses a chardev to connect to the backend. Unlike
> vhost-scsi (today), VMs using vhost-user-scsi can be live migrated.
>
> To use it, start Qemu with a command line equivalent to:
>
> qemu-system-x86_64 \
>        -chardev socket,id=vus0,path=/tmp/vus.sock \
>        -device vhost-user-scsi-pci,chardev=vus0,bus=pci.0,addr=...
>
> A separate commit presents a sample application linked with libiscsi to
> provide a backend for vhost-user-scsi.
>
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> Message-Id: <1488479153-21203-4-git-send-email-felipe@nutanix.com>
> [Disable migration for now, since it does not support bdrv_drain. - Paolo]

I was expecting this to mean a VMStateDescription with a
".unmigratable = 1" field, but it doesn't seem to have one.
Does it disable migration some other way?

thanks
-- PMM

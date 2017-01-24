Received: from eggs.gnu.org ([2001:4830:134:3::10]:41790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW5Mz-00036r-1T
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:59:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW5My-0006u5-8F
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:59:01 -0500
Received: from mail-ua0-x22f.google.com ([2607:f8b0:400c:c08::22f]:33824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cW5My-0006tm-4V
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:59:00 -0500
Received: by mail-ua0-x22f.google.com with SMTP id 35so139857930uak.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:58:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6d55bfe0-20f3-d153-910b-7c28fd74f6ab@redhat.com>
References: <1485164923-17736-1-git-send-email-armbru@redhat.com>
	<1485164923-17736-7-git-send-email-armbru@redhat.com>
	<2fd376cd-e88a-b6da-d648-b80d35e74c7a@redhat.com>
	<877f5l1tak.fsf@dusky.pond.sub.org>
	<3512807d-d04e-50fa-9fcf-d1d5ba8ac350@redhat.com>
	<87r33saa6p.fsf@dusky.pond.sub.org>
	<4cd45561-60e9-2cd2-e317-880ba9eb2f86@redhat.com>
	<87fuk82x48.fsf@dusky.pond.sub.org>
	<CAFEAcA_oBmrMGsuT8=a51eOkBDQ-Rrr4tAhi5oMGxMzb-PiVwg@mail.gmail.com>
	<6d55bfe0-20f3-d153-910b-7c28fd74f6ab@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 17:58:38 +0000
Message-ID: <CAFEAcA_Ugd+4C8yoaWbK7nR+U3NOzJPHQKmg_47kC40qdq9qgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 6/6] hw/i386/i386: Stop auto-creating
 lsi53c895a SCSI HBAs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 24 January 2017 at 17:40, Paolo Bonzini <pbonzini@redhat.com> wrote:
> But is really lsi53c895a the best we can provide for
> versatilepb/versatileab/realview-eb/realview-eb-mpcore? Could virtio-pci
> work well too?...

I assume that people will still have legacy kernel images
which include the LSI drivers but not the virtio-pci drivers.
versatilepb in particular is pretty widely used as an example
ARM QEMU system (it was the sanest one before virt came along),
so there's a good chance of breaking a bunch of tutorials
and old images if you stop creating LSI devices.

More generally, I'd rather not spend any time at all messing
about with these old board models if they're not actually broken.

thanks
-- PMM

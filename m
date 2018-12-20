Received: from eggs.gnu.org ([2001:4830:134:3::10]:45161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZzh8-0005d9-Um
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:53:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZzh8-0005bY-6x
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:53:02 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gZzh7-0005as-V2
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:53:02 -0500
Received: by mail-oi1-x244.google.com with SMTP id u18so2049126oie.10
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 06:53:01 -0800 (PST)
MIME-Version: 1.0
References: <20181218161008.3882-1-mst@redhat.com>
	<CAFEAcA-mzqQ+tt+43LVnruBj9Mgf2q7MaCgV5o2BPz3GJT+i+A@mail.gmail.com>
	<20181220154959.4a598d84@Igors-MacBook-Pro.local>
In-Reply-To: <20181220154959.4a598d84@Igors-MacBook-Pro.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Dec 2018 14:52:49 +0000
Message-ID: <CAFEAcA8-R16eHcPKcYw==PCdA7mwf8+V57aKX=SUdcX1zWqDsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/30] pci, pc, virtio: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 20 Dec 2018 at 14:50, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Wed, 19 Dec 2018 19:15:26 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
> > Hi; I'm afraid I get conflicts in some files which look
> > too complicated for me to want to try to resolve at this end:
> > Auto-merging tests/vmgenid-test.c
> > CONFLICT (content): Merge conflict in tests/vmgenid-test.c
> > Auto-merging tests/bios-tables-test.c
> > CONFLICT (content): Merge conflict in tests/bios-tables-test.c
> > Auto-merging tests/acpi-utils.h
> > CONFLICT (content): Merge conflict in tests/acpi-utils.h
> > Auto-merging tests/acpi-utils.c
> > CONFLICT (content): Merge conflict in tests/acpi-utils.c
> > Removing include/hw/smbios/ipmi.h
>
> I'm working on fixing conflicts due to 29/30 and will include conflicting patch in my acpi tests cleanup on respin
>
> Meanwhile could you drop 29/30 and apply the rest of pull request (which applies just fine)?

I can't apply a partial pull request -- MST will need to
drop those patches and send a v2.

thanks
-- PMM

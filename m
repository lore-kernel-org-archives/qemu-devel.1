Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629F9C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:34:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E983216C8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E983216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiAVD-0003gm-Hc
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 00:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41633)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hiAA4-0008BQ-5i
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 00:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hiAA1-0005I2-5O
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 00:12:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53026)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hiAA0-0005BJ-BX; Tue, 02 Jul 2019 00:12:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E41F22E97C8;
 Tue,  2 Jul 2019 04:12:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-102.ams2.redhat.com
 [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A3665C28D;
 Tue,  2 Jul 2019 04:12:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AFFC4111BD5C; Tue,  2 Jul 2019 06:12:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190627152011.18686-1-palmer@sifive.com>
 <20190627152011.18686-34-palmer@sifive.com>
 <CAFEAcA8sscJQ2GCwL1gM+EcRtfHQb1v0BwORt6ncH54x51TCVg@mail.gmail.com>
 <5896113812cd914308e5b617377f8e8205224cfe.camel@wdc.com>
 <CAFEAcA_-h6b_f1fuWh7NkGo+FT0xSyCDXgd3b4pwEvNDN8HcJw@mail.gmail.com>
Date: Tue, 02 Jul 2019 06:12:38 +0200
In-Reply-To: <CAFEAcA_-h6b_f1fuWh7NkGo+FT0xSyCDXgd3b4pwEvNDN8HcJw@mail.gmail.com>
 (Peter Maydell's message of "Mon, 1 Jul 2019 19:01:12 +0100")
Message-ID: <87a7dxqdl5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 02 Jul 2019 04:12:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 33/34] roms: Add OpenSBI version 0.3
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Jeff Cody <codyprime@gmail.com>, "palmer@sifive.com" <palmer@sifive.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 1 Jul 2019 at 18:50, Alistair Francis <Alistair.Francis@wdc.com> wrote:
>>
>> On Mon, 2019-07-01 at 17:54 +0100, Peter Maydell wrote:
>> > On Thu, 27 Jun 2019 at 16:24, Palmer Dabbelt <palmer@sifive.com>
>> > wrote:
>> > > From: Alistair Francis <alistair.francis@wdc.com>
>> > >
>> > > Add OpenSBI version 0.3 as a git submodule and as a prebult binary.
>> > >
>> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> > > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
>> > > Tested-by: Bin Meng <bmeng.cn@gmail.com>
>> > > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>> > > ---
>> > >  .gitmodules                                  |   3 ++
>> > >  Makefile                                     |   5 +-
>> > >  pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 0 -> 28848
>> > > bytes
>> > >  pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 0 -> 28904
>> > > bytes
>> > >  pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 0 -> 28904
>> > > bytes
>> > >  roms/Makefile                                |  48 ++++++++++++++-
>> > > ----
>> > >  roms/opensbi                                 |   1 +
>> > >  7 files changed, 44 insertions(+), 13 deletions(-)
>> > >  create mode 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
>> > >  create mode 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
>> > >  create mode 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin
>> > >  create mode 160000 roms/opensbi
>> > >
>> > > diff --git a/.gitmodules b/.gitmodules
>> > > index 2857eec76377..7a10e72e09cd 100644
>> > > --- a/.gitmodules
>> > > +++ b/.gitmodules
>> > > @@ -55,3 +55,6 @@
>> > >  [submodule "slirp"]
>> > >         path = slirp
>> > >         url = https://git.qemu.org/git/libslirp.git
>> > > +[submodule "roms/opensbi"]
>> > > +       path = roms/opensbi
>> > > +       url = https://github.com/riscv/opensbi.git
>> >
>> > It would be nice to state the license for new blobs we're
>> > adding to the source tree... In particular, I find the
>> > readme at https://github.com/riscv/opensbi a bit confusing
>> > because it says it's 2-BSD but also that some parts are Apache-2.0;
>> > the latter is *not* GPL-2.0 compatible. That makes it not completely
>> > obvious to me that we can ship this with QEMU.
>>
>> Ah, I didn't realise there is Apache-2.0 code in there.
>>
>> In this case all of the code we are using (we aren't using the Kendryte
>> code with QEMU) is BSD-2-Clause. Even then though does it matter if it
>> is GPL compatible? This isn't being linked with QEMU it is just being
>> included with QEMU.
>
> Yeah, if we're not building the apache-2.0 parts then I think
> we're OK, and as you say there's the question of whether QEMU's
> GPL affects what we ship as mere bios blobs to run as guest
> code anyway. But it's sufficiently not a "really obviously ok"
> that I'd like a second opinion; cc'd some people who might have
> second opinions.

You need an expert opinion.

My non-expert opinion: we can't distribute anything that's not
compatible with GPLv2, at least as long as LICENSE makes the following
claims:

    1) QEMU as a whole is released under the GNU General Public License,
    version 2.

    2) Parts of QEMU have specific licenses which are compatible with the
    GNU General Public License, version 2. Hence each source file contains
    its own licensing information.  Source files with no licensing information
    are released under the GNU General Public License, version 2 or (at your
    option) any later version.

    As of July 2013, contributions under version 2 of the GNU General Public
    License (and no later version) are only accepted for the following files
    or directories: bsd-user/, linux-user/, hw/vfio/, hw/xen/xen_pt*.

    3) The Tiny Code Generator (TCG) is released under the BSD license
       (see license headers in files).

Complicating things further just to distribute a firmware blob would be
a mistake.  Our licensing situation is already complex enough for me to
call it a mistake.

[...]


Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCCDC04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2367D21019
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2367D21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48132 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsC4-0005ka-CG
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 02:36:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hVs8I-00030w-Ua
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:32:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hVs8H-0006V5-Bn
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:32:18 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:54767)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hVs8F-0006UD-Pr
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:32:16 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1M9nAB-1hZSbB16nd-005qRZ; Wed, 29 May 2019 08:30:20 +0200
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <87lfyqla7r.fsf@dusky.pond.sub.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <31aacc13-8d1b-8a4c-5a9d-0b615321e0ed@vivier.eu>
Date: Wed, 29 May 2019 08:30:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87lfyqla7r.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:hW47ejWM1Xq98d15JxS7Al0o8pQafdhQqApfb8+hDdEiNshNfKD
	BplFDXGI0k/ZCihBs6qQUix7T0kG/J9w21Ew+CFttLxz5lkWiACKdOibDFn93R82MEaZpn9
	0ITzz84VlH7CvCVBtZ3Eel+vTeLNMYGV12BG65+ZqvzKi0mmap1hbFS2pCYCihsioIdG2QE
	RwLxUoOfbbbmnokbzxJIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qNatheslna4=:ybEqr9LyECRihsaCujaYwq
	7RcrgDpzdZKF3AibQw5pHp+fpEnm+Nsvct1QBLerDyAp8cgwugQ2p+qHzj5yJBOk4kOs3EavQ
	We+oa4mvH842OEs8tqSniP6BUmkx7MVOl8qc3uUhd3a2OsISbTWbIZJOfMwqsHQh7ZrfOYnCS
	7GzGHyo4gywoQzDYb4VMhpeiOx1d5Hq46lycDDTFJQxBP8c6K0Kg1m1gFUTZusF2mkoEhetti
	1od2OGYXiLoM+PFv4vLWHRiaT1qTsstTVIwjKQb+0CYff2IoOFJ3OHtyNomfDlN7IY/MTg+jG
	chBSiqTsHvi90JOKH9tGDEqR1GqPGUzjfSit7Ru+4jgzQzJEbeFVH5W6OJlsj+6JUdkcVr7rp
	/6V3uKH7iD8W50B7WudfLb/4wIUMfp3dMl5TD80dtQuqxBeRuwe+qgVMEdJGhWK0yrSMwwhZA
	T8SwDGPxM1cx7NE7zXv+3HvXUzhKdNvjlrqYKED45wey0SqI22QzynKgzr4mSxXe4Ls+LJrh8
	xOvcNmd6T+1hh/tlyF4bI44M2FrshAC9WfEHYGuegX81pOh5mgp/sGVEO/2VfuCKonRfesci2
	3yTbVmlZaaXbTqySEsg3PYsWyQoxj5ejn+OpORRBcsvLd/ld2NsB4+J4euborm5Dr+NVxOyzx
	Wg/eUbD9GLn/Xg2jRf3aZM5ZrvLTEJfAEx3DVc9r+vkADnuvx0MCV8g4tgVbh0QtszOhEF5XY
	/cGmkxdAsFnL0XRUqOinyGRkxBfgjEOm48CsQcOHCuchotxHCRy2goUjcLk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
Subject: Re: [Qemu-devel] Headers without multiple inclusion guards
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>, James Hogan <jhogan@kernel.org>,
	Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
	"Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Anthony Perard <anthony.perard@citrix.com>,
	Richard Henderson <rth@twiddle.net>, Jason Wang <jasowang@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Eric Auger <eric.auger@redhat.com>, Paul Durrant <paul.durrant@citrix.com>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	"Daniel P. Berrange" <berrange@redhat.com>,
	Claudio Fontana <claudio.fontana@gmail.com>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Cornelia Huck <cohuck@redhat.com>,
	Claudio Fontana <claudio.fontana@huawei.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/05/2019 20:12, Markus Armbruster wrote:
...
> Linux user
> M: Riku Voipio <riku.voipio@iki.fi>
> R: Laurent Vivier <laurent@vivier.eu>

Unintentionnal:

linux-user/errno_defs.h
linux-user/flat.h
linux-user/hppa/sockbits.h
linux-user/socket.h
linux-user/aarch64/syscall_nr.h
linux-user/alpha/syscall_nr.h
linux-user/arm/syscall_nr.h
linux-user/cris/syscall_nr.h
linux-user/hppa/syscall_nr.h
linux-user/i386/syscall_nr.h
linux-user/m68k/syscall_nr.h
linux-user/microblaze/syscall_nr.h
linux-user/mips/syscall_nr.h
linux-user/mips64/syscall_nr.h
linux-user/nios2/syscall_nr.h
linux-user/openrisc/syscall_nr.h
linux-user/ppc/syscall_nr.h
linux-user/riscv/syscall_nr.h
linux-user/s390x/syscall_nr.h
linux-user/sh4/syscall_nr.h
linux-user/sparc/syscall_nr.h
linux-user/sparc64/syscall_nr.h
linux-user/x86_64/syscall_nr.h
linux-user/target_flat.h
linux-user/xtensa/target_flat.h
linux-user/riscv/target_syscall.h
linux-user/aarch64/termbits.h
linux-user/alpha/termbits.h
linux-user/arm/termbits.h
linux-user/cris/termbits.h
linux-user/hppa/termbits.h
linux-user/i386/termbits.h
linux-user/m68k/termbits.h
linux-user/microblaze/termbits.h
linux-user/mips/termbits.h
linux-user/nios2/termbits.h
linux-user/openrisc/termbits.h
linux-user/ppc/termbits.h
linux-user/riscv/termbits.h
linux-user/s390x/termbits.h
linux-user/sh4/termbits.h
linux-user/sparc/termbits.h
linux-user/sparc64/termbits.h
linux-user/x86_64/termbits.h

Intentionnal:

linux-user/ioctls.h
linux-user/aarch64/sockbits.h
linux-user/arm/sockbits.h
linux-user/cris/sockbits.h
linux-user/i386/sockbits.h
linux-user/m68k/sockbits.h
linux-user/microblaze/sockbits.h
linux-user/mips64/sockbits.h
linux-user/nios2/sockbits.h
linux-user/openrisc/sockbits.h
linux-user/riscv/sockbits.h
linux-user/s390x/sockbits.h
linux-user/sh4/sockbits.h
linux-user/sparc64/sockbits.h
linux-user/tilegx/sockbits.h
linux-user/x86_64/sockbits.h
linux-user/xtensa/sockbits.h
linux-user/syscall_types.h
linux-user/mips64/target_cpu.h
linux-user/sparc64/target_cpu.h
linux-user/x86_64/target_cpu.h
linux-user/mips64/target_fcntl.h
linux-user/sparc64/target_fcntl.h
linux-user/sparc64/target_signal.h
linux-user/mips64/target_structs.h
linux-user/mips64/termbits.h

Thanks,
Laurent



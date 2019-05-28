Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFF8C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF6DD20717
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6DD20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41444 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVhjM-0007rx-Vp
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:25:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hVhia-0007UD-Cd
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hVhiR-0004MH-W8
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:25:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hVhiM-0003hn-6V
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:24:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB9166378;
	Tue, 28 May 2019 19:23:44 +0000 (UTC)
Received: from localhost (ovpn-116-11.gru2.redhat.com [10.97.116.11])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4B2D85DD61;
	Tue, 28 May 2019 19:23:19 +0000 (UTC)
Date: Tue, 28 May 2019 16:23:17 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190528192317.GG22103@habkost.net>
References: <87lfyqla7r.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfyqla7r.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 28 May 2019 19:24:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
	qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>,
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
	Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Eric Auger <eric.auger@redhat.com>, Paul Durrant <paul.durrant@citrix.com>,
	Stafford Horne <shorne@gmail.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	"Daniel P. Berrange" <berrange@redhat.com>,
	Claudio Fontana <claudio.fontana@gmail.com>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Cornelia Huck <cohuck@redhat.com>,
	Claudio Fontana <claudio.fontana@huawei.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 28, 2019 at 08:12:24PM +0200, Markus Armbruster wrote:
> We have a bunch of headers without multiple inclusion guards.  Some are
> clearly intentional, some look accidental.  Too many for me to find out
> by examining each of them, so I'm asking their maintainers.
> 
> Why do I ask?  I'd like to mark the intentional ones and fix the
> accidental ones, so they don't flunk "make check-headers" from "[RFC v4
> 0/7] Baby steps towards saner headers" just because they lack multiple
> inclusion guards.
> 
> Just in case: what's a multiple inclusion guard?  It's
> 
>     #ifndef UNIQUE_GUARD_SYMBOL_H
>     #define UNIQUE_GUARD_SYMBOL_H
>     ...
>     #endif
> 
> with nothing but comments outside the conditional, so that the header
> can safely be included more than once.
> 
> I append the alphabetical list of headers without multiple inclusion
> guards (as reported by scripts/clean-header-guards -nv), followed by the
> same list sorted into maintainer buckets.  If you're cc'ed, please find
> your bucket(s), and tell me which headers intentionally lack guards.
> 
[...]
> X86
> M: Paolo Bonzini <pbonzini@redhat.com>
> M: Richard Henderson <rth@twiddle.net>
> M: Eduardo Habkost <ehabkost@redhat.com>
> target/i386/cc_helper_template.h

Intentional.  See usage at target/i386/cc_helper.c.

> target/i386/helper.h

I believe helper.h intentionally lack guards on all
architectures.  See helper-proto.h, helper-tcg.h,
helper-gen.h.

> target/i386/ops_sse.h

Intentional, see usage at target/i386/fpu_helper.c.

> target/i386/ops_sse_header.h

Intentional, see usage at target/i386/helper.h.

> target/i386/shift_helper_template.h

Intentional, see usage at target/i386/int_helper.c.

> target/i386/whp-dispatch.h

Seems unintentional.

[...]
> Guest CPU Cores (KVM):
> ----------------------
> 
> Overall
> M: Paolo Bonzini <pbonzini@redhat.com>
> include/hw/kvm/clock.h

Seems unintentional.

[...]
> Guest CPU Cores (Xen):
> ----------------------
> 
> X86
> M: Stefano Stabellini <sstabellini@kernel.org>
> M: Anthony Perard <anthony.perard@citrix.com>
> M: Paul Durrant <paul.durrant@citrix.com>
> include/hw/xen/io/ring.h

I see a __XEN_PUBLIC_IO_RING_H__ guard there.  Probably
clean-header-guards.pl is confused by the comments at the end of
the file?

> [...]

-- 
Eduardo


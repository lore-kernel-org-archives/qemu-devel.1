Received: from eggs.gnu.org ([2001:4830:134:3::10]:59807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gaMAG-00014h-87
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:52:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1gaMAB-00035v-QF
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:52:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1gaMA6-0002zz-Q5
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:52:29 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
In-Reply-To: <20181221140321.7750-1-vkuznets@redhat.com>
References: <20181221140321.7750-1-vkuznets@redhat.com>
Date: Fri, 21 Dec 2018 15:52:20 +0100
Message-ID: <87va3n3paz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC] i386: Enable NPT and NRIPSAVE for Epyc
 CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Epyc CPUs support NPT and NRIPSAVE features and KVM exposes these when
> present. Add them to EPYC and EPYC-IBPB cpu models.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> - RFC part: I'm not sure when these features first appeared, we may want to
>   modify some Opteron_* models too.

According to http://instlatx64.atw.hu/ data (thanks to Radim!) NRIPSAVE
apeared somewhere in Opteron_G3 lifetime (e.g. QuadCore AMD Opteron 2378
has is, QuadCore AMD Opteron HE 2344 doesn't), NPT was introduced a bit
earlier.

To be on the safe side we can probably add NPT and NRIPSAVE to
Opteron_G4 and Opteron_G5 too and leave Opteron_G3 as it is.

-- 
Vitaly

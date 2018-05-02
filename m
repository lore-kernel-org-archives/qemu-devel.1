Received: from eggs.gnu.org ([2001:4830:134:3::10]:48103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1fDmHX-0006Go-Jp
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1fDmHT-00024o-Kr
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:34:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40716 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1fDmHT-000244-FO
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:34:27 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20180411115036.31832-1-vkuznets@redhat.com>
Date: Wed, 02 May 2018 09:34:19 +0200
In-Reply-To: <20180411115036.31832-1-vkuznets@redhat.com> (Vitaly Kuznetsov's
	message of "Wed, 11 Apr 2018 13:50:35 +0200")
Message-ID: <877eomtssk.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 0/1] i386/kvm: TSC page clocksource for
 Hyper-V-on-KVM fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Changes since v4:
> - Rebase on top of Roman's patches.
> - Drop PATCH2 as it is no longer needed (after adding explicit
>   hv_frequencies).
>
> Previously, Ladi was working on enabling TSC page clocksource for nested
> Hyper-V-on-KVM workloads. He found out that if Hyper-V frequency MSRs are
> exposed to L1 as well as INVTSC flag Hyper-V enables TSC page clocksource
> to its guests. Qemu doesn't pass INVTSC by default as it is a migration
> blocker.
>
> I found out there's a different way to make Hyper-V like us: expose
> Reenlightenment MSRs to it. KVM doesn't fully support the feature as
> we're still unable to migrate nested environments but rudimentary support
> we have there is enough.
>
> Enable Hyper-V reenlightenment MSRs to make things work.
>

Gentle ping :-)

With Roman's Reviewed-by:, is there anything else needed from me to get
this accepted?

Thanks!

-- 
  Vitaly

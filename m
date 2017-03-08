Received: from eggs.gnu.org ([2001:4830:134:3::10]:40042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clcce-0006xN-Pd
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 09:31:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clccd-0007dh-Pt
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 09:31:24 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:36422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1clccd-0007dA-J2
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 09:31:23 -0500
Received: by mail-wr0-x22e.google.com with SMTP id u108so24529412wrb.3
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 06:31:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170303145807.GC11509@thinpad.lan.raisama.net>
References: <1485868319-16151-1-git-send-email-thuth@redhat.com>
	<1485868319-16151-3-git-send-email-thuth@redhat.com>
	<20170303145807.GC11509@thinpad.lan.raisama.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Mar 2017 15:31:01 +0100
Message-ID: <CAFEAcA8VV-UW7M+W=KcN=XycPUS=FmFJmVhd0DpruzaoKEVjuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 2/2] vl: Print CPU help after we've
 registered the CPU accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 3 March 2017 at 15:58, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Tue, Jan 31, 2017 at 02:11:59PM +0100, Thomas Huth wrote:
>> When running with KVM on POWER, we register some CPU types during
>> the initialization function of the ppc64 KVM code (which unfortunately
>> also can not be done via a type_init() like it is done on x86).
>
> Can you elaborate why it can't be done via type_init()? If the
> QOM type hierarchy depends on any runtime data unavailable at
> type_init(), we should fix that.

On ARM we (currently) have the KVM-only 'host' CPU type be
added to the type hierarchy only at runtime in kvm_init(),
but we deal with the '-help' problem by having arm_cpu_list() do

#ifdef CONFIG_KVM
    /* The 'host' CPU type is dynamically registered only if KVM is
     * enabled, so we have to special-case it here:
     */
    (*cpu_fprintf)(f, "  host (only available in KVM mode)\n");
#endif

thanks
-- PMM

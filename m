Received: from eggs.gnu.org ([209.51.188.92]:60635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEwAQ-00043O-IA
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 09:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEwAP-0002oe-CF
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 09:24:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hEwAP-0002oE-1c
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 09:24:29 -0400
Date: Fri, 12 Apr 2019 14:24:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190412132420.GM25308@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1555072669-20441-1-git-send-email-puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1555072669-20441-1-git-send-email-puwen@hygon.cn>
Subject: Re: [Qemu-devel] [PATCH RFC] i386: Add new Hygon 'Dhyana' and
 'Dhyana-IBPB' CPU models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pu Wen <puwen@hygon.cn>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net

On Fri, Apr 12, 2019 at 08:37:49PM +0800, Pu Wen wrote:
> Add two new base CPU models called 'Dhyana' and 'Dhyana-IBPB' to model
> processors from Hygon Dhyana (family 18h), which derived from AMD EPYC
> (family 17h). 'Dhyana-IBPB' is a copy of the 'Dhyana' CPU model with
> just CPUID_8000_0008_EBX_IBPB added.

Do we really need to support both CPU variants ?

The IBPB feature is the Spectre fix which dates from January 2018.
Having both made (limited) sense for EPYC as EPYC CPUs existed
already, so there would be a mix of EPYC CPUs with and without the
microcode that adds IBPB.

The Google results I see suggest that Dhyana CPUs started to become
available in July 2018, so surely they would come with microcode
that has the IBPB right from day 1 ?

Am I missing anything that means there will be a compelling need
to support Dhyana /without/ IBPB ?

If not, then we only need 1 CPU model and that would include IBPB.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

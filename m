Received: from eggs.gnu.org ([2001:4830:134:3::10]:35217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ejoyW-000656-4G
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:23:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ejoyS-0004Ak-3n
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:23:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46392 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ejoyR-0004AY-Vl
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:23:00 -0500
Date: Thu, 8 Feb 2018 16:22:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180208162233.GN20703@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180129174132.108925-1-brijesh.singh@amd.com>
	<20180129174132.108925-19-brijesh.singh@amd.com>
	<20180130200838.GB2319@work-vm>
	<0abe3fee-a970-dc82-fd92-ad923bfa863a@amd.com>
	<20180201172709.GJ2457@work-vm>
	<07d86670-e960-db04-52a9-5e6ecee18bc3@amd.com>
	<20180202151616.GM15403@redhat.com>
	<CA+HCGMYbZ9ATosB29Oy9kELc78yQ0jGX7YrFDG2SzT2_Py-xAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+HCGMYbZ9ATosB29Oy9kELc78yQ0jGX7YrFDG2SzT2_Py-xAQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 18/23] sev: emit the SEV_MEASUREMENT
 event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.ksingh@gmail.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, Tom Lendacky <Thomas.Lendacky@amd.com>, "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Feb 08, 2018 at 10:17:28AM -0600, Brijesh Singh wrote:
> 
> Anyway, the main issue is event emitted before "qmp_capabilities" are
> dropped silently , see [1] . In our case, the measurement event is emitted
> during the machine creation time, libvirt was still waiting to reconnect
> the monitor when event was emitted hence libvirt never gets the event.
> Because of this, I am not able to see any strong reason to emit the event.
> Do you see any issue with libvirt issuing a  'query-sev-launch-measure' to
> get the measurement on reconnect ?

Hmm, yes, I see so there can be a race between SEV emitting the event and
libvirtd making the initial monitor connection. In that case, we definitely
to have a QMP command to let libvirt explicitly query it. 


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

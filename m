Received: from eggs.gnu.org ([2001:4830:134:3::10]:47781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cUGml-0001wh-GP
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:46:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cUGmk-0001uR-He
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:46:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cUGmk-0001tc-Bu
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:46:06 -0500
Date: Thu, 19 Jan 2017 17:45:59 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170119174559.GI16641@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170117010204.4909-1-ehabkost@redhat.com>
	<309bd499-204d-df07-aa99-9a999cfecabc@linux.vnet.ibm.com>
	<20170118170049.GB3491@thinpad.lan.raisama.net>
	<45e82b29-1ebe-3f34-0cc1-35d60c6044da@linux.vnet.ibm.com>
	<20170118173406.GF3491@thinpad.lan.raisama.net>
	<fd9074e6-8b39-9139-415e-cec2a8970a5e@redhat.com>
	<20170119104837.GL3491@thinpad.lan.raisama.net>
	<c0d8a827-5999-51b5-73fc-aa781b77fe8f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0d8a827-5999-51b5-73fc-aa781b77fe8f@redhat.com>
Subject: Re: [Qemu-devel] [libvirt] [PATCH 0/9] i386:
 query-cpu-model-expansion test script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Jan 19, 2017 at 06:21:22PM +0100, David Hildenbrand wrote:
> 
> >> Also think about "query-cpu-model-expansion model=host type=static",
> >> which will primarily be used by libvirt on s390x. There is no way to
> >> expand this into a static cpu model. Faking anything will just hide errors.
> > 
> > Yes, static expansion of host model must always return an error
> > if it's not possible to expand.
> > 
> >>
> >> If "host" can't be expanded, QEMU has to be treated like there is no CPU
> >> model support (as for older QEMU versions).
> > 
> > OK. I will propose a patch updating the query-cpu-model-expansion
> > documentation to be more explicit about it.
> 
> The only real alternative I see would be disabling the query-cpu-model-*
> interface completely if KVM support is not available.
> 
> This would however mean, that the same QEMU binary would have the
> interface when running under TCG, but not when running under KVM on an
> old KVM version.
> 
> That also doesn't really feel right, or what do you think?

Yeah that really isn't good.  query-cpu-model-* needs to work on TCG
and *not* have a dependancy on KVM in that case, since you can be
running TCG s390 on a x86_64 host, so the host CPU is totally irrelevant
for TCG

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

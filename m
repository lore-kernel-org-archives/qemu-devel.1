Received: from eggs.gnu.org ([2001:4830:134:3::10]:41491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eriNY-0008KG-VZ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:57:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eriNU-00006X-Ti
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:57:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35354 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eriNU-00006O-Ph
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 05:57:28 -0500
Date: Fri, 2 Mar 2018 10:57:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180302105709.GD26972@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180302083720.25137-1-idgar@virtualoco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180302083720.25137-1-idgar@virtualoco.com>
Subject: Re: [Qemu-devel] [PATCH v3] vmgenid: allow VM Generation ID
 modification via QMP/HMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Or Idgar <idgar@virtualoco.com>
Cc: ben@skyportsystems.com, dgilbert@redhat.com, mst@redhat.com, imammedo@redhat.com, eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, ghammer@redhat.com, Or Idgar <oridgar@gmail.com>

On Fri, Mar 02, 2018 at 10:37:20AM +0200, Or Idgar wrote:
> From: Or Idgar <oridgar@gmail.com>
> 
> This patch allow changing the Virtual Machine Generation
> ID through QMP/HMP while the vm guest is running.
> the spec (http://go.microsoft.com/fwlink/?LinkId=260709)
> mentions that "when the generation ID changes, execute an
> ACPI Notify operation on the generation ID device".
> To test it we need the ability to set the generation ID
> online. QMP/HMP allows that.

If we want to test vmgenid, why don't we simply trigger one of
the mgmt actions that are required to change vmgenid. eg do a
savevm, followed by a loadvm to restore from snapshot. This would
be better testing of the real world usage of this feature.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

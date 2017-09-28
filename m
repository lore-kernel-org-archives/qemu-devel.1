Received: from eggs.gnu.org ([2001:4830:134:3::10]:39067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxXEg-0003c0-IX
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 07:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxXEd-0006Kv-CA
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 07:44:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxXEd-0006Kh-4j
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 07:44:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1CD88C6F74
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 11:44:06 +0000 (UTC)
Date: Thu, 28 Sep 2017 12:44:01 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170928114401.GK12919@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170927203225.30896-1-ehabkost@redhat.com>
	<20170927203225.30896-2-ehabkost@redhat.com>
	<20170928114202.GJ12919@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170928114202.GJ12919@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] vl: Eliminate defconfig variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Thu, Sep 28, 2017 at 12:42:02PM +0100, Daniel P. Berrange wrote:
> On Wed, Sep 27, 2017 at 05:32:24PM -0300, Eduardo Habkost wrote:
> > Both -nodefconfig and -no-user-config options do the same thing
> > today, we only need one variable to keep track of them.
> 
> What reason for picking -nodefconfig instead of -no-user-config to
> deprecate ?  -nodefconfig predates -no-user-config by a few years,
> and is what libvirt has historically used. So from libvirt POV
> we'd have a slight preference to deprecate -no-user-config instead
> and keep -nodefconfig, simply to avoid need to add conditional
> logic to libvirt to pick which to use.

Actually never mind, I just noticed libvirt actually supports
both options and dynamically detects their existance.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

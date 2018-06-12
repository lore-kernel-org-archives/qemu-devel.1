Received: from eggs.gnu.org ([2001:4830:134:3::10]:45427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fSeBc-0002JA-5t
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fSeBY-0007c3-7x
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:57:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33072 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fSeBY-0007br-3r
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 03:57:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 72DBD818BAED
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 07:57:47 +0000 (UTC)
Date: Tue, 12 Jun 2018 08:57:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180612075739.GB23739@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180608130846.22234-1-dgilbert@redhat.com>
	<20180608130846.22234-6-dgilbert@redhat.com>
	<87y3flilan.fsf@dusky.pond.sub.org>
	<20180611184016.GR7451@localhost.localdomain>
	<20180611233342.36a35911@igors-macbook-pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180611233342.36a35911@igors-macbook-pro.local>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] hmp: Add info commands for preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Michal Privoznik <mprivozn@redhat.com>, eblake@redhat.com, pkrempa@redhat.com

On Mon, Jun 11, 2018 at 11:33:42PM +0200, Igor Mammedov wrote:
> On Mon, 11 Jun 2018 15:40:16 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Mon, Jun 11, 2018 at 02:01:52PM +0200, Markus Armbruster wrote:
> > > * Eduardo, why does "info numa" have no QMP equivalent?
> > 
> > Nobody ever asked for one, which seems to qualify as "only for
> > human users".
> > 
> > Should we add an equivalent QMP command even if we don't expect
> > anybody to use it?
> 
> we inderectly can fetch numa info via QMP, using 
>   query-hotpluggable-cpus
> for CPU mapping and
>   query-memory-devices
> for (NV|PC)-dimm devices, however there is no QMP way for getting
> for numa mapping of initial RAM nor configured numa nodes
> (not counting querying CLI options).
> 
> So perhaps we need info 'numa' equivalent for QMP which would give
> the same amount of information as HMP in one query.
> 
> Maybe libvirt side as actual users know better if it's really needed (CCed)

Libvirt knows the numa config it used to spawn the guest with, so there's
no immediate compelling reason to query it back, as QEMU doesn't change
it later.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

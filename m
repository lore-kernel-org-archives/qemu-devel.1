Received: from eggs.gnu.org ([2001:4830:134:3::10]:60088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gBzFH-00040w-FN
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gBzFG-0000Nn-ER
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:33:03 -0400
Date: Mon, 15 Oct 2018 10:32:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181015093243.GE6785@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181013050227.17022-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181013050227.17022-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [RFC] Require Python 3 for building QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

On Sat, Oct 13, 2018 at 02:02:27AM -0300, Eduardo Habkost wrote:
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> I'd like to do this in QEMU 3.1.  I think it's time to drop
> support for old systems that have only Python 2.
>
> We still have a few scripts that are not required for building
> QEMU that still work only with Python 2 (iotests being the most
> relevant set).  Requiring Python 3 for building QEMU won't
> prevent people from using those scripts with Python 2 until they
> are finally ported.

I think it is premature & unecessary to do this. We just got QEMU building
with dual Python2/3 in 3.0 to give people leeway in the migration path to
a fully v3 future. The code to support building 2/3 in parallel is not
imposing a unreasonable maint burden. Dropping py2 suport would have
negligible impact on the code, as there's no v3-only features we have
used. IOW, I don't think there's a compelling reason to rush into forcing
users onto v3.

If we want to drop py2, we should give people a warning of such a planned
change, especially since some of our targetted host OS[1] don't even
include a py3 as standard without acquiring extra add-on repos. Devs in
a typical corporate env will not have the freedom to install such extra
repos on their machines.

Regards,
Daniel

[1] https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platforms
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

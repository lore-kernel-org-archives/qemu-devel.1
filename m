Received: from eggs.gnu.org ([2001:4830:134:3::10]:51768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhYdh-00010y-63
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dhYdd-0007u9-Cd
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:59:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dhYdd-0007u1-6K
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:59:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD6087EAA0
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 09:59:51 +0000 (UTC)
Date: Tue, 15 Aug 2017 10:59:44 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170815095944.GG9674@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170808203935.30021-1-ehabkost@redhat.com>
	<20170808203935.30021-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170808203935.30021-2-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 v2 1/5] qmp-shell: Use optparse
 module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

On Tue, Aug 08, 2017 at 05:39:31PM -0300, Eduardo Habkost wrote:
> It makes command-line parsing and generation of help text much
> simpler.
> 
> The optparse module is deprecated since Python 2.7, but argparse
> is not available in Python 2.6 (the minimum Python version
> required for building QEMU).
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * Use optparse module, as the minimum Python version for building
>   QEMU is 2.6
>   * Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
>   * Suggested-by: "Daniel P. Berrange" <berrange@redhat.com>

I no longer suggest this approach :-)

I'd prefer if we just bundled a copy of 'argparse.py' in the
local scripts/thirdparty directory, and add that to the
python import path, if the system python lacks argparse.

eg if we had $QEMU-GIT/scripts/thirdparty/argparse.py you can
use:

try:
    import argparse
except:
    import os, sys
    sys.path.append(os.path.join(os.path.dirname(__file__), "../thirdparty"))
    import argparse

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfQkz-0000PY-Iw
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfQkw-0003so-ES
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:10:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dfQkw-0003rJ-7a
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:10:38 -0400
Date: Wed, 9 Aug 2017 14:10:32 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170809131032.GH24723@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAJSP0QVrCm6TfgU0dsXbudaW3gmGo0YQTTWbNypx6st6mKcSKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJSP0QVrCm6TfgU0dsXbudaW3gmGo0YQTTWbNypx6st6mKcSKA@mail.gmail.com>
Subject: Re: [Qemu-devel] Making QEMU build with Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, ross@burtonini.com

On Wed, Aug 09, 2017 at 11:16:58AM +0100, Stefan Hajnoczi wrote:
> Ross created a bug to track Python 3 support:
> 
>   https://bugs.launchpad.net/qemu/+bug/1708462
> 
> Currently most Python code in QEMU is for Python 2.6+ only.  There
> have only been a few patches adding Python 3 support to certain
> scripts so far.
> 
> In this email I want to highlight the most important scripts that need
> Python 3 support.  Volunteers are welcome!
> 
> Python scripts needed to build QEMU are the highest priority.  They
> are invoked by ./configure or make.  I've identified the following:
> 
> scripts/signrom.py
> scripts/qapi*.py
> scripts/modules/module_block.py
> scripts/tracetool*

> I have tracetool on my todo list and hope to add Python 3 support in QEMU 2.11.

AFAICT tracetool seems to already work - i hacked rules.mak to
run tracetool via python3 and nothing obvious broke

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

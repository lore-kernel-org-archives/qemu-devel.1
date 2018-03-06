Received: from eggs.gnu.org ([2001:4830:134:3::10]:34512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etFKZ-0003uK-ON
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etFKW-0002hp-Ka
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:20:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33214 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1etFKW-0002hb-G3
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:20:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA1FA4023ECC
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 16:20:40 +0000 (UTC)
Date: Tue, 6 Mar 2018 16:20:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180306162034.GQ6163@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180306154625.23910-1-berrange@redhat.com>
	<152035231744.1395.14112582467019213006@bdbb90650ae5>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <152035231744.1395.14112582467019213006@bdbb90650ae5>
Subject: Re: [Qemu-devel] [PATCH] trace: only permit standard C types and
 fixed size integer types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com

On Tue, Mar 06, 2018 at 08:05:18AM -0800, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> Type: series
> Message-id: 20180306154625.23910-1-berrange@redhat.com
> Subject: [Qemu-devel] [PATCH] trace: only permit standard C types and fixed size integer types
> 
> Traceback (most recent call last):
>   File "/tmp/qemu-test/src/scripts/tracetool.py", line 154, in <module>
>     main(sys.argv)
>   File "/tmp/qemu-test/src/scripts/tracetool.py", line 145, in main
>     events.extend(tracetool.read_events(fh))
>   File "/tmp/qemu-test/src/scripts/tracetool/__init__.py", line 358, in read_events
>     event = Event.build(line)
>   File "/tmp/qemu-test/src/scripts/tracetool/__init__.py", line 280, in build
>     args = Arguments.build(groups["args"])
>   File "/tmp/qemu-test/src/scripts/tracetool/__init__.py", line 134, in build
>     validate_type(arg_type)
>   File "/tmp/qemu-test/src/scripts/tracetool/__init__.py", line 87, in validate_type
>     "declared as 'void *'" % name)
> ValueError: Error on line 95: Argument type 'hwaddr' is not in whitelist. Only standard C types and fixed size integer types should be used. struct, union, and other complex pointer types should be declared as 'void *'


This nicely illustrates this patch working as documented !

The fix for the "hwaddr" mistake was just merged in QEMU git master, so
if patchew can be re-run, applying to latest master it should pass.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

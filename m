Received: from eggs.gnu.org ([2001:4830:134:3::10]:39750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfqoV-0000ZJ-Sd
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 13:00:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dfqoS-0002WV-7e
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 13:00:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dfqoS-0002W5-1A
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 13:00:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C977211520
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 16:59:58 +0000 (UTC)
Date: Thu, 10 Aug 2017 17:59:50 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170810165950.GA29997@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170810155522.31099-1-berrange@redhat.com>
	<150238145088.69.341704419311348024@dd743fd916bd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <150238145088.69.341704419311348024@dd743fd916bd>
Subject: Re: [Qemu-devel] [PATCH 00/15] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, kraxel@redhat.com

On Thu, Aug 10, 2017 at 09:10:51AM -0700, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed build test on s390x host. Please find the details below.
> 
> Subject: [Qemu-devel] [PATCH 00/15] Convert over to use keycodemapdb
> Type: series
> Message-id: 20170810155522.31099-1-berrange@redhat.com
> 
>   GEN     trace/generated-helpers.h
>   GEN     trace/generated-helpers-wrappers.h
>   GEN     trace/generated-tcg-tracers.h
>   GEN     trace/generated-helpers.c
> make: *** No rule to make target 'ui/input-keymap-atset12qcode.c', needed by 'Makefile'.  Stop.
> make: *** Waiting for unfinished jobs....

Opps, failure due to me not testing non-srcdir builds.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

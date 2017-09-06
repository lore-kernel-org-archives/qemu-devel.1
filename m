Received: from eggs.gnu.org ([2001:4830:134:3::10]:60145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpWGO-0006cF-8Y
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 05:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpWGN-0003Vt-7d
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 05:04:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpWGN-0003VE-18
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 05:04:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 032B74E33B
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 09:04:45 +0000 (UTC)
Date: Wed, 6 Sep 2017 10:04:42 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170906090442.GJ15510@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.1504688205.git.mprivozn@redhat.com>
	<5defe9fcfacaae68ebbdb76b3ec4b565bf4e7d1c.1504688205.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5defe9fcfacaae68ebbdb76b3ec4b565bf4e7d1c.1504688205.git.mprivozn@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] watchdog: Allow setting action on
 the fly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

On Wed, Sep 06, 2017 at 10:58:54AM +0200, Michal Privoznik wrote:
> Currently, the only time that users can set watchdog action is at
> the start as all we expose is this -watchdog-action command line
> argument. This is suboptimal when users want to plug the device
> later via monitor. Alternatively, they might want to change the
> action for already existing device on the fly.
> 
> At the same time, drop local redefinition of the actions enum in
> watchdog.h in favour of the ones defined in schema and thus kills
> code duplication.

Nit-pick - I'd suggest 2 separat patches - one that drops the enum
redefinition, and the second which adds the new monitor command.
That way you separate no-op refactoring, from new features.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZYxO-0007za-Qj
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 05:20:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZYxN-0003ud-LO
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 05:20:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gZYxN-0003tY-D2
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 05:20:01 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50CB43DE04
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 10:19:59 +0000 (UTC)
Date: Wed, 19 Dec 2018 11:19:57 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181219101957.yonihjoa2a5crpr6@sirius.home.kraxel.org>
References: <20181218142629.15943-1-berrange@redhat.com>
	<20181218142629.15943-2-berrange@redhat.com>
	<20181219072023.2hbaoqrfp6r2ihog@sirius.home.kraxel.org>
	<20181219100325.GC20465@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219100325.GC20465@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] ui: install logo icons to
 $prefix/share/icons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

  Hi,

> > How did you create the png files?
> > Can you drop a script or Makefile for that into the ui/icons directory?
> 
> I used GIMP so that it created high quality antialiased pngs.

Ok, so that'll be hardly scriptable.
A short README will do then I guess.

> > Should we commit them to git, or generate at build time?
> > Is the tool used something we can expect to be installed?
> 
> I tried using ImageMagick to convert SVG to PNG but the results
> were really poor compared to GIMP - very fuzzy. Running with
> -verbose I can see it is invoking inkscape to atually do the
> conversion, and it tells inkscape to export a small image which
> it then resizes, hence the quality loss.

Tried to call inkscape directly?
Having something scriptable would be nice.
But I'm fine with a README saying gimp gives good results too.

> The icons are small enough that we shouldn't really worry about
> having pre-rendered icons in GIT IMHO. They're not ever going to
> change unless we replace our logo again.

And inkscape as package build dependency wouldn't be nice either.

cheers,
  Gerd

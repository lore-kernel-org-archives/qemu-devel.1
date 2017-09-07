Received: from eggs.gnu.org ([2001:4830:134:3::10]:46480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpxPw-0004tJ-M5
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpxPs-0003bu-4r
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:04:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpxPr-0003bH-VI
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:04:24 -0400
Date: Thu, 7 Sep 2017 22:04:20 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170907140420.GE25123@lemon.lan>
References: <20170907081158.4063-1-famz@redhat.com>
	<20170907081158.4063-3-famz@redhat.com>
	<c839e15b-c486-fd7b-f3f6-deb1b7eb85f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c839e15b-c486-fd7b-f3f6-deb1b7eb85f1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] docker: Enable features explicitly in
 test-full
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Thu, 09/07 08:37, Eric Blake wrote:
> On 09/07/2017 03:11 AM, Fam Zheng wrote:
> > Also avoid "set -e".
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  tests/docker/test-full | 80 ++++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 75 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tests/docker/test-full b/tests/docker/test-full
> > index 05f0d491d1..bd095ad91b 100755
> > --- a/tests/docker/test-full
> > +++ b/tests/docker/test-full
> > @@ -1,8 +1,8 @@
> > -#!/bin/bash -e
> > +#!/bin/bash
> 
> When you drop 'set -e'...
> 
> >  #
> > -# Compile all the targets.
> > +# Compile all the targets with as many features enabled as possible
> >  #
> > -# Copyright (c) 2016 Red Hat Inc.
> > +# Copyright 2016, 2017 Red Hat Inc.
> >  #
> >  # Authors:
> >  #  Fam Zheng <famz@redhat.com>
> > @@ -15,5 +15,75 @@
> >  
> >  cd "$BUILD_DIR"
> 
> ...then you should explicitly check for failure after commands where you
> really do not want to continue execution if they failed.  I'd write this:

We can probably tolerate the failure of cd, but it might be better if we are
strict on that. Will update.

Fam

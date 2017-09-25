Received: from eggs.gnu.org ([2001:4830:134:3::10]:42861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dwJHC-0005Lu-B6
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 22:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dwJH9-0004f7-94
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 22:37:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dwJH9-0004ek-2i
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 22:37:39 -0400
Date: Mon, 25 Sep 2017 10:37:33 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170925023733.GB22980@lemon.lan>
References: <20170921170209.9101-1-ehabkost@redhat.com>
	<7ad0e182-536b-42d8-5b80-bfcd03612a00@redhat.com>
	<20170922033026.GE1397@lemon.lan>
	<3f6252b9-0e25-e8d7-aa6e-cc54497a96f9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f6252b9-0e25-e8d7-aa6e-cc54497a96f9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Fix subsystem name for "Build
 and test automation"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

On Fri, 09/22 16:02, Eric Blake wrote:
> On 09/21/2017 10:30 PM, Fam Zheng wrote:
> 
> >>>  Build and test automation
> >>>  -------------------------
> >>> +Build and test automation
> >>
> >> Would it make sense to use something more specific here? Like "Travis
> >> and Docker" or so? ... in case we add other subsections in the future?
> > 
> > Unless we are to split off (i.e. more people volunteering maintaining a certain
> > subset), the list will just go on and on in this line. For not it's already
> > going to be "Travis, Shippable, Docker and VM test".. so I think a generic
> > description here is okay, though the duplication is a bit odd (but I don't have
> > a better idea).
> 
> Or we could make a generic section of "Build, Tests, and Documentation",
> and merge in the "Build system architecture" of the
> immediately-subsequent "Documentation" section, as well as possibly any
> future sections for someone to maintain top-level build-related files
> (including MAINTAINERS itself...), so that we have just one larger
> section with multiple sub-sections, instead of two sections each with
> one sub-section.

That sounds okay, but actually most of the files under docs/ don't have a
maintainer, so in the hope that one day they will, the "Documentation" section
may be a good place to host more entries.

Fam

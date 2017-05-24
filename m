Received: from eggs.gnu.org ([2001:4830:134:3::10]:57729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDOwL-0003j3-Qd
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDOwI-0006CT-NJ
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:34:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dDOwI-0006By-Gv
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:34:30 -0400
Date: Wed, 24 May 2017 13:34:25 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170524053425.GM12279@lemon.lan>
References: <20170521032956.27446-1-f4bug@amsat.org>
	<20170521032956.27446-3-f4bug@amsat.org>
	<20170524052123.GJ12279@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170524052123.GJ12279@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH v3 02/24] docker: add --include-files
 argument to 'build' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On Wed, 05/24 13:21, Fam Zheng wrote:
> > diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> > index 6ddc6e4c2a..68cca25f89 100755
> > --- a/tests/docker/docker.py
> > +++ b/tests/docker/docker.py
> > @@ -237,6 +237,11 @@ class BuildCommand(SubCommand):
> >                              help="""Specify a binary that will be copied to the
> >                              container together with all its dependent
> >                              libraries""")
> > +        parser.add_argument("--extra-files", "-f", nargs='*',
> > +                            help="""Specify files that will be sent to the
> > +                            Docker daemon. The daemon will copy those files into
> > +                            the built image. The ADD directive of the Dockerfile
> > +                            specify where a file is placed into the image""")
> 
> Or more precisely, "The daemon will copy these files into the docker build
> directory, which can be copied to the built image with ADD directives in
> Dockerfile"?

Hmm, not copied by daemon, maybe "The files will be sent...". But you have the
idea.

Fam

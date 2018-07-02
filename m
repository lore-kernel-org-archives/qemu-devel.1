Received: from eggs.gnu.org ([2001:4830:134:3::10]:33966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joe@perches.com>) id 1fa05K-00015J-80
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:45:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joe@perches.com>) id 1fa05F-0000Xp-Bn
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:45:46 -0400
Received: from smtprelay0105.hostedemail.com ([216.40.44.105]:44219
	helo=smtprelay.hostedemail.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joe@perches.com>) id 1fa05E-0000X9-UZ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:45:41 -0400
Message-ID: <b3902b72dae86bd724e41913b92449ee0734473b.camel@perches.com>
From: Joe Perches <joe@perches.com>
Date: Mon, 02 Jul 2018 07:45:35 -0700
In-Reply-To: <57f942b9-9d49-1006-52fa-50b9f4461ff9@redhat.com>
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-5-f4bug@amsat.org>
	<9a30c2d7-b6b7-c6e9-1c70-0fd4a90bca0c@redhat.com>
	<9376a63ed1790a79dadaaf0aac72455f6e7e2942.camel@perches.com>
	<57f942b9-9d49-1006-52fa-50b9f4461ff9@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 04/46] checkpatch: Recognize IEC binary
 prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Su Hang <suhang16@mails.ucas.ac.cn>, Pasi Savanainen <pasi.savanainen@nixu.com>, =?ISO-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org

On Mon, 2018-07-02 at 14:37 +0200, Paolo Bonzini wrote:
> On 29/06/2018 23:46, Joe Perches wrote:
> > > >      ERROR: "foo * bar" should be "foo *bar"
> > > >      #310: FILE: hw/ppc/ppc440_uc.c:564:
> > > >      +        size = 8 * MiB * sh;
> > > >      total: 1 errors, 0 warnings, 433 lines checked
> > 
> > Does the linux kernel use these?
> > I don't believe so.
> > 
> No, I'm not sure why you were CCed. :)

Me neither but I am the kernel MAINTAINERS file as
checkpatch maintainer.

My guess is some MAINTAINERS file has me in it or qemu
uses git history for unmaintained files and qemu pulls
in the kernel checkpatch changes.

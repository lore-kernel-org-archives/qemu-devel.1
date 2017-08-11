Received: from eggs.gnu.org ([2001:4830:134:3::10]:56520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1dgBy2-0004Rc-3I
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 11:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1dgBy0-0003Lp-Tt
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 11:35:18 -0400
Received: from mail-yw0-x236.google.com ([2607:f8b0:4002:c05::236]:35816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
	id 1dgBy0-0003KH-Mf
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 11:35:16 -0400
Received: by mail-yw0-x236.google.com with SMTP id l82so24307906ywc.2
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 08:35:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170811123716.GD4162@localhost.localdomain>
References: <CAATJJ0Jgyak9c=wYknret5y=yjfzcjiVw3221wX=SB2+am8H4A@mail.gmail.com>
	<20170811120435.GB23309@lemon.lan>
	<20170811123716.GD4162@localhost.localdomain>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Fri, 11 Aug 2017 17:34:45 +0200
Message-ID: <CAATJJ0+R-S8F4FhYUXCRjPrduK4szwFMrj+LTUFPuyPzmauuNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] migration issue with qemu 2.10-rc2: QEMU command
 'nbd-server-add': Block node is read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Fri, Aug 11, 2017 at 2:37 PM, Kevin Wolf <kwolf@redhat.com> wrote:

> Am 11.08.2017 um 14:04 hat Fam Zheng geschrieben:
> > On Fri, 08/11 13:07, Christian Ehrhardt wrote:
> > > Simplifying that to a smaller test:
> > >
>
[...]

> > > Block node is read-only
>
[...]

> >
> > This is actually caused by
> >
> > commit 9c5e6594f15b7364624a3ad40306c396c93a2145
> > Author: Kevin Wolf <kwolf@redhat.com>
> > Date:   Thu May 4 18:52:40 2017 +0200
> >
> >     block: Fix write/resize permissions for inactive images
> >
>

Yeah in the meantime an automated bisect run is through an agrees.
Thanks for pointing out the right change triggering that so early!

Thanks Kevin for all the suggestions already, I quickly looked at the code
but I'm lost there without taking much more time.
Is anybody experienced in that area looking at fixing that?
Because IMHO that is kind of a block bug for 2.10 by breaking formerly
working behavior (even as Kevin identified it seems to have done it wrong
all the time).

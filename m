Received: from eggs.gnu.org ([2001:4830:134:3::10]:42969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fQSta-0002CG-4v
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 03:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fQStW-0000pe-Pm
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 03:30:14 -0400
Received: from mail.ispras.ru ([83.149.199.45]:45490)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fQStW-0000nQ-H9
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 03:30:10 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
	<152819516132.30857.1700667353240369481.stgit@pasha-ThinkPad-T60>
	<aac4626c-c379-13b6-f505-e6ea12fea1a1@redhat.com>
In-Reply-To: <aac4626c-c379-13b6-f505-e6ea12fea1a1@redhat.com>
Date: Wed, 6 Jun 2018 10:30:10 +0300
Message-ID: <000a01d3fd68$33d85cc0$9b891640$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/7] tcg: add headers for non-target
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Thomas Huth' <thuth@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, maria.klimushenkova@ispras.ru, pbonzini@redhat.com, vilanova@ac.upc.edu

> From: Thomas Huth [mailto:thuth@redhat.com]
> On 05.06.2018 12:39, Pavel Dovgalyuk wrote:
> > From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
> >
> > This patch adds functions and headers for adding the helpers from
> > the modules other than the target translators.
> >
> > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> > ---
> >  include/exec/helper-register.h |   53 ++++++++++++++++++++++++++++++++++++++++
> >  tcg/tcg.c                      |   12 +++++++++
> >  tcg/tcg.h                      |    3 ++
> >  3 files changed, 68 insertions(+)
> >  create mode 100644 include/exec/helper-register.h
> >
> > diff --git a/include/exec/helper-register.h b/include/exec/helper-register.h
> > new file mode 100644
> > index 0000000..aeface9
> > --- /dev/null
> > +++ b/include/exec/helper-register.h
> > @@ -0,0 +1,53 @@
> > +#ifndef HELPER_REGISTER_H
> > +#define HELPER_REGISTER_H
> > +
> > +#include "exec/helper-head.h"
> > +
> > +/* Need one more level of indirection before stringification
> > +   to get all the macros expanded first.  */
> > +#define str(s) #s
> 
> Could you use tostring() from include/qemu/compiler.h instead?


Thanks, fixed.

BTW, this was a copy-paste from helper-tcg.h

Pavel Dovgalyuk

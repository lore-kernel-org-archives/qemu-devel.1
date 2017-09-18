Received: from eggs.gnu.org ([2001:4830:134:3::10]:50229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtq5P-0006x4-9L
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtq5J-0002pl-GE
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:03:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dtq5J-0002p4-9L
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 03:03:13 -0400
Date: Mon, 18 Sep 2017 15:03:07 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170918070307.GH15551@lemon.lan>
References: <20170901112829.2571-1-apahim@redhat.com>
	<20170901112829.2571-5-apahim@redhat.com>
	<20170905030255.GH22515@lemon.lan>
	<20170918051858.GA31915@localhost.localdomain>
	<20170918053913.GD15551@lemon.lan>
	<20170918064439.GB31915@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170918064439.GB31915@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v8 04/13] qemu.py: improve message on
 negative exit code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: ldoktor@redhat.com, ehabkost@redhat.com, stefanha@gmail.com, Amador Pahim <apahim@redhat.com>, armbru@redhat.com, qemu-devel@nongnu.org, crosa@redhat.com, mreitz@redhat.com

On Mon, 09/18 08:44, Kevin Wolf wrote:
> > > > > +            self._qemu_full_args = (self._wrapper + [self._binary] +
> > > > > +                                    self._base_args() + self._args)
> > > > 
> > > > The parentheses seem superfluous. With those removed:
> > > > 
> > > > Reviewed-by: Fam Zheng <famz@redhat.com>
> > > 
> > > Congratulations, with this advice you just killed all Python-based
> > > qemu-iotests and filled up my inbox with CI failure messages. :-)
> > 
> > Oops. Why doesn't python understand such multi line expressions
> > impllied by "+" just like in "[,]"?
> 
> To be honest, I didn't know that either until now. But apparently the
> different kinds of brackets (including those around function arguments)
> are the only things that allow multiline expressions in Python.

Yes, and now I read that PEP recommends using brackets for multilines compared
to backslashes. I was totally wrong with this advice.

Fam

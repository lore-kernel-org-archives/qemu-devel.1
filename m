Received: from eggs.gnu.org ([2001:4830:134:3::10]:43458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVhOk-0003jC-UI
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 11:23:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVhOg-0005SA-Su
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 11:23:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cVhOg-0005Rz-Mg
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 11:23:10 -0500
Date: Mon, 23 Jan 2017 14:23:07 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170123162307.GX3491@thinpad.lan.raisama.net>
References: <CAFEAcA8bVVwdLAuF-wV4_mYCL0XvN6-jdnmnPgQR765xaAc1hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8bVVwdLAuF-wV4_mYCL0XvN6-jdnmnPgQR765xaAc1hg@mail.gmail.com>
Subject: Re: [Qemu-devel] what is the syntax and meaning of -numa
 cpus=foo-bar ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Jan 23, 2017 at 03:14:28PM +0000, Peter Maydell wrote:
> Hi; something we noticed recently is that some versions of
> makeinfo gripe about the -numa option syntax in qemu-options.hx:
> 
> qemu-options.texi:60: warning: unlikely character [ in @var.
> qemu-options.texi:60: warning: unlikely character ] in @var.
> qemu-options.texi:61: warning: unlikely character [ in @var.
> qemu-options.texi:61: warning: unlikely character ] in @var.
> 
> This is provoked by qemu-options.hx having:
> 
> @item -numa node[,mem=@var{size}][,cpus=@var{cpu[-cpu]}][,nodeid=@var{node}]
> @itemx -numa node[,memdev=@var{id}][,cpus=@var{cpu[-cpu]}][,nodeid=@var{node}]
> 
> The obvious simple syntax fix is to change it to
> "cpus=@var{cpu}[-@var{cpu}]" (ie the @var{} covers only
> the metasyntactic variables the user has to fill in,
> not the '-' which is I think a literal and the [] which
> are indicating that the second part is optional).

Makes sense to me.

> 
> However, this leaves me still rather in the dark as a user of
> the documentation about what the option actually does. The
> text below doesn't explain what the two 'cpu' fields I
> can fill in do, or what values they can take. They should
> probably be different names as well (eg "start-end", or
> whatever makes sense for the semantics) so that the text
> can refer to them usefully.
> 

Yes, "start-end" would make it clearer. The "cpus" option can
also appear multiple times if the list of CPUs is a
non-contiguous range.

> Would somebody who understands the -numa option like to
> propose a few lines of text to clarify things?

I will take a look and propose a patch. Thanks for the report!

-- 
Eduardo

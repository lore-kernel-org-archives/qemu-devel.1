Received: from eggs.gnu.org ([209.51.188.92]:43940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmn3T-0004Tw-IY
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 17:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmmxJ-0005Vj-D9
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 16:54:38 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:41547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmmxI-0005UM-NP
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 16:54:37 -0500
Received: by mail-wr1-f45.google.com with SMTP id x10so8144449wrs.8
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 13:54:33 -0800 (PST)
References: <CAFEAcA-4r8_K0=WTaK+A_KvO93ni+3==+a5FRvGTFJ3av0GPFw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0e9cc6c1-010b-9f6d-b6b4-dc1757880463@redhat.com>
Date: Thu, 24 Jan 2019 22:54:30 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-4r8_K0=WTaK+A_KvO93ni+3==+a5FRvGTFJ3av0GPFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] building rst docs with sphinx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi Peter,

On 1/24/19 7:56 PM, Peter Maydell wrote:
> I had another look this afternoon at building our rST docs
> with sphinx-build. In particular, we currently have some
> docs in rst format, but we're not building them into HTML
> or shipping them. (Predictably, this means a few errors and
> warnings have crept in...)

Are you talking about the files in docs/ such docs/devel/testing.rst?

Or about documention within the source files?
If so, is that the format you are talking about?

https://www.sphinx-doc.org/en/master/usage/restructuredtext/domains.html#the-c-domain

'''
The C domain (name c) is suited for documentation of C API.

.. c:function:: function prototype

    Describes a C function. The signature should be given as in C, e.g.:

    .. c:function:: PyObject* PyType_GenericAlloc(PyTypeObject *type,
Py_ssize_t nitems)
'''

> 
> I had a play about with adding some makefile runes, but
> I'm not sure entirely what I should be aiming for.
> 
> (1) configure: My thought is that we should just make
> sphinx-build a requirement for the existing --enable-docs
> switch (as texinfo and pod2man are currently). The
> disadvantage is that we won't support a "build the half
> of the docs you have the tools for and leave the others"
> setup. The advantage, which I think is significant, is that
> distros will naturally be directed to the missing build
> dependency (either they're building with --enable-docs
> and will get the configure message, or they aren't and
> then their build will fail later because of missing docs
> files when they try to put the built files into the package).
> 
> (2) What do we actually want to ship?
> That is, what do we want 'make install-doc' to copy into
> the installation directory?
> https://wiki.qemu.org/Features/Documentation
> has a good suggested breakdown of docs for where we
> eventually want to be. I think we probably don't want
> to install the "developer's guide" (docs/devel) on
> end-user systems. The others are presumably OK.
> Currently, we seem to only install manpages and a
> few other things in the 'install-doc' makefile target
> (we don't install a bunch of plain-text user-facing
> docs) so this would be a significant expansion.
> 
> (3) Indexes, table-of-contents pages, etc
> Are we aiming to ship these?
> I think that we probably want to have what from
> Sphinx's point of view are multiple separate documents,
> so that they each get their own ToC and index. This
> means we can for instance ship the ToC/index for
> the user docs but not have it contain index entries
> for developer docs.
> 
> Overall what I'm hoping for is to be able to get some
> basic structure/building commands into master so we
> have a framework and something we can iterate on to
> move forward.
> 
> thanks
> -- PMM
> 

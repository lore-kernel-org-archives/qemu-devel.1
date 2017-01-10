Received: from eggs.gnu.org ([2001:4830:134:3::10]:45657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cR0UE-0003Mc-Cf
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:45:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cR0UA-0006Gf-G4
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:45:30 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cR0UA-0006G3-AY
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 12:45:26 -0500
Received: by mail-wm0-x244.google.com with SMTP id c85so31227801wmi.1
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:45:26 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-3-berrange@redhat.com>
	<20170110163713.GA19869@stefanha-x1.localdomain>
	<20170110165105.GR27720@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <80b19297-00c4-f109-dd4f-9d2b41ee618c@redhat.com>
Date: Tue, 10 Jan 2017 18:45:23 +0100
MIME-Version: 1.0
In-Reply-To: <20170110165105.GR27720@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/47] trace: switch io/ directory to
 modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org



On 10/01/2017 17:51, Daniel P. Berrange wrote:
> It doesn't work with builddir != srcdir builds, because -I. is resolved
> to the srcdir, but the trace.h is in builddir.

This is a bug then.  The toplevel builddir (or for that matter srcdir)
is not meant to be in the search path: only the toplevel include/, the
subdirectory builddir, and the subdirectory srcdir.

> In the end I thought it would be clearer to be explicit about the
> subdir we're pulling trace.h from anyway, since it is fairly common
> practice  in QEMU to have the <subdir> in the #include filename.

Hmm, I don't think so.  The idea is that all includes are nested, so
that a local directory #include has no subdir while one from #include/
has one.

Paolo

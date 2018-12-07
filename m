Received: from eggs.gnu.org ([2001:4830:134:3::10]:41573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gV9QE-0004fl-8r
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 01:15:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gV9Q9-0002jM-Fo
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 01:15:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gV9Q9-0002ix-7M
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 01:15:29 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F8D43002DB4
	for <qemu-devel@nongnu.org>; Fri,  7 Dec 2018 06:15:28 +0000 (UTC)
References: <20181206215026.7716-1-pbonzini@redhat.com>
	<20181206215026.7716-3-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <59857e6b-1c82-98dc-6564-0d1219de611d@redhat.com>
Date: Fri, 7 Dec 2018 07:15:26 +0100
MIME-Version: 1.0
In-Reply-To: <20181206215026.7716-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] test: replace gtester with a TAP driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 2018-12-06 22:50, Paolo Bonzini wrote:
> gtester is deprecated by upstream glib (see for example the announcement
> at https://blog.gtk.org/2018/07/11/news-from-glib-2-58/) and it does
> not support tests that call g_test_skip in some glib stable releases.
> 
> glib suggests instead using Automake's TAP support, which gtest itself
> supports since version 2.38 (QEMU's minimum requirement is 2.40).
> We do not support Automake, but we can use Automake's code to beautify
> the TAP output.  I chose to use the Perl copy rather than the shell/awk
> one, with some changes so that it can accept TAP through stdin, in order
> to reuse Perl's TAP parsing package.  This also avoids duplicating the
> parser between tap-driver.pl and tap-merge.pl.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> v1->v2: show failures even in non-verbose mode
>         show executable name next to PASS/FAIL
>         tweak colored output
>         improved support for "make -k check"
>         switch license blurb to https
>         support TAP version line
>         removed Eamcs epilogs

I gave it a quick try, and it seems to work fine. And I guess it's also
the best self-contained option that we currently have, so:

Acked-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>

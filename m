Received: from eggs.gnu.org ([2001:4830:134:3::10]:38670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g822f-0004km-8Z
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g822a-00065B-6R
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:43:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g822Z-000637-Q7
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:43:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8FA24308124B
	for <qemu-devel@nongnu.org>; Thu,  4 Oct 2018 11:43:33 +0000 (UTC)
References: <1538650419-7995-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <548e06b9-dac6-812d-9347-fc600ac4f559@redhat.com>
Date: Thu, 4 Oct 2018 13:43:29 +0200
MIME-Version: 1.0
In-Reply-To: <1538650419-7995-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] MAINTAINERS: Add an entry for
 qemu-options* files in main directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

On 04/10/2018 12:53, Thomas Huth wrote:
> The file "qemu-options.h", "qemu-options.hx" and "qemu-options-wrapper.h"
> in the main directory are currently without maintainer according to our
> get_maintainers.pl script. Considering that the command line options are
> a public interface and thus quite important, this is quite a bad state.
> Add an entry for these files which is maintained by Paolo, since the
> option handling is tightly coupled with the code in vl.c (that Paolo
> already handles via the "Main loop" entry).
> 
> And since I'm interested in the command line interface of QEMU, add
> myself (and also Markus) as reviewer here.

Sometimes, a file is really only touched as part of changes to other
files.  Command line options can be changed by block device patches,
vl.c patches, or something else.  I think changes to qemu-options* alone
are quite rare, and I'd rather not have more stuff added to my misc tree
(and my inbox)...

Paolo

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Create a separate entry
> 
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3275cc6..66c13f2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1522,6 +1522,14 @@ F: tests/test-qemu-opts.c
>  F: util/keyval.c
>  F: util/qemu-option.c
>  
> +Generic command line options
> +M: Paolo Bonzini <pbonzini@redhat.com>
> +R: Markus Armbruster <armbru@redhat.com>
> +R: Thomas Huth <thuth@redhat.com>
> +S: Maintained
> +F: qemu-options*
> +F: vl.c
> +
>  Coverity model
>  M: Markus Armbruster <armbru@redhat.com>
>  S: Supported
> 

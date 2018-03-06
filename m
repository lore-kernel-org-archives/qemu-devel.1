Received: from eggs.gnu.org ([2001:4830:134:3::10]:44841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etEHw-0007LU-NQ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:14:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1etEHt-0001en-Bf
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:14:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39234 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1etEHt-0001eT-6X
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:13:57 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1334404084A
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 15:13:56 +0000 (UTC)
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
	<1520342370-123606-8-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f264b47a-d5cc-74b7-eab3-a0693f549ee4@redhat.com>
Date: Tue, 6 Mar 2018 16:13:54 +0100
MIME-Version: 1.0
In-Reply-To: <1520342370-123606-8-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 07/34] Document --rtc-td-hack,
 --localtime and --startdate as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 06.03.2018 14:19, Paolo Bonzini wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> These options have been marked in a comment in qemu-options.hx as
> deprecated in 2009 already (see commit 1ed2fc1fa35fadc0d6), but we
> never informed the users about these deprecations. Let's catch up
> on that omission now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <1519138892-12836-1-git-send-email-thuth@redhat.com>
> [Fix messages. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  qemu-doc.texi | 16 +++++++++++-----
>  vl.c          |  5 +++++
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index fb6fac5..589519a 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2723,12 +2723,18 @@ filesystem test suite. Also it requires the CAP_DAC_READ_SEARCH capability,
>  which is not the recommended way to run QEMU. This backend should not be
>  used and it will be removed with no replacement.
>  
> -@subsection -no-frame (since 2.12.0)
> +@subsection -rtc-td-hack (since 2.12.0)
>  
> -The ``-no-frame'' argument works with SDL 1.2 only.  SDL 2.0 lacks
> -support for frameless windows, and the other user interfaces never
> -implemented this in the first place.  So this will be removed together
> -with SDL 1.2 support.

No, this should not be removed. Looks like an accident when resolving a
conflict?

 Thomas

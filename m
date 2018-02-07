Received: from eggs.gnu.org ([2001:4830:134:3::10]:35431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejR9R-0003me-CT
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:56:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejR9O-0001rT-8T
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:56:45 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35412 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejR9O-0001rN-3Q
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 09:56:42 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9AB09E44B5
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 14:56:35 +0000 (UTC)
References: <20180123164718.12714-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d0806ca9-6c26-a8d6-0f7c-1a0bc09c869b@redhat.com>
Date: Wed, 7 Feb 2018 15:56:27 +0100
MIME-Version: 1.0
In-Reply-To: <20180123164718.12714-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/2] Two fixes to make rules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 23/01/2018 17:47, Daniel P. Berrange wrote:
> The primary goal of this was to fix the recent regression that made
> everything done by make completely silent, causing things like
> "make install" to emit no output. In doing so I noticed a small mistake
> in the help text.
> 
> Daniel P. Berrange (2):
>   Revert "build-sys: silence make by default or V=0"
>   make: fix help message reference to bogus V=0 variable
> 
>  Makefile  | 5 +++--
>  rules.mak | 2 --
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 

Queued, thanks.

Paolo

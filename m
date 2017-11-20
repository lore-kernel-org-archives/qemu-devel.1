Received: from eggs.gnu.org ([2001:4830:134:3::10]:36225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGn21-0002q5-Bx
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:26:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGn1x-0002iY-IH
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:26:41 -0500
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:38434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eGn1x-0002iJ-Bc
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:26:37 -0500
Received: by mail-wr0-x229.google.com with SMTP id z75so6897550wrc.5
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 06:26:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171120142248.16432-2-stefanha@redhat.com>
References: <20171120142248.16432-1-stefanha@redhat.com>
	<20171120142248.16432-2-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2017 14:26:15 +0000
Message-ID: <CAFEAcA-A4T_q5+AMuAmEAGCHA+BXaXXUqLiu2tvK6MOCiniZBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] Use qemu.org domain name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Daniel Berrange <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 20 November 2017 at 14:22, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The owner of qemu.org has delegated authority to modify DNS records to
> the QEMU Project.  This has allowed us to use the domain name without
> worries about IP address changes or technical issues disrupting service.
> The issues described in commit 859389810910f232188675d2f10b15f1aad77660
> ("Use qemu-project.org domain name") have therefore been mitigated.
>
> This patch switches back to consistently using qemu.org instead of
> qemu-project.org.
>
> Note that git-submodule(1) does not detect URL changes.  The following
> commands clean up all submodules to ensure you will use the latest URLs:
>
>   $ git submodule deinit . # you'll be warned if you have local changes
>   $ rm -rf .git/modules    # also clear cached .git/ directories

Are we really sure we want to do this in the middle of
a release? I'd be rather happier if we fixed the documentation
now and saved messing around with .gitmodules until afterwards...

thanks
-- PMM

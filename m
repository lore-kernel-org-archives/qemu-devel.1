Received: from eggs.gnu.org ([2001:4830:134:3::10]:45868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYISU-0004G8-JS
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 16:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYIST-0008LS-N6
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 16:54:06 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYIST-0008KW-HA
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 16:54:05 -0400
Received: by mail-wm0-x231.google.com with SMTP id w191so37002354wmw.1
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 13:54:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <eec67af4-3f8e-bb85-0854-61f4d450f627@redhat.com>
References: <1500568341-8389-1-git-send-email-peter.maydell@linaro.org>
	<eec67af4-3f8e-bb85-0854-61f4d450f627@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2017 21:53:43 +0100
Message-ID: <CAFEAcA9M0jeER9Ygg74_kQXv4CeW2_PMns7=t=Jw6sxkYhANpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.10] util/oslib-posix.c: Avoid warning
 on NetBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>, "patches@linaro.org" <patches@linaro.org>

On 20 July 2017 at 19:26, Eric Blake <eblake@redhat.com> wrote:
> On 07/20/2017 11:32 AM, Peter Maydell wrote:
>> On NetBSD the compiler warns:
>> util/oslib-posix.c: In function 'sigaction_invoke':
>> util/oslib-posix.c:589:5: warning: missing braces around initializer [-Wmissing-braces]
>>      siginfo_t si = { 0 };
>>      ^
>
> Uggh. That is a broken compiler.  C99 declares that 'anything = {0}' is
> supposed to be a valid way to zero-initialize anything.

Looks like maybe it was https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53119

thanks
-- PMM

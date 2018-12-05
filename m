Received: from eggs.gnu.org ([2001:4830:134:3::10]:46352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gUb0H-0006Nq-Jo
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:30:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gUb0D-0000J3-FI
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:30:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gUb0B-0000EL-EO
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:30:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so20536986wrx.9
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 09:30:18 -0800 (PST)
References: <1543845937-300-1-git-send-email-thuth@redhat.com>
	<1543845937-300-2-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <31b42ffd-40bb-47c8-4ad4-e8e696596473@redhat.com>
Date: Wed, 5 Dec 2018 18:30:15 +0100
MIME-Version: 1.0
In-Reply-To: <1543845937-300-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 1/7] configure: Add a test for the
 minimum compiler version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>

On 12/3/18 3:05 PM, Thomas Huth wrote:
> So far we only had implicit requirements for the minimum compiler version,
> e.g. we require at least GCC 4.1 for the support of atomics. However,
> such old compiler versions are not tested anymore by the developers, so
> they are not really supported anymore. Since we recently declared explicitly
> what platforms we intend to support, we can also get more explicit on the
> compiler version now. The supported distributions use the following version
> of GCC:
> 
>       RHEL-7: 4.8.5
>       Debian (Stretch): 6.3.0
>       Debian (Jessie): 4.8.4
>       OpenBSD (ports): 4.9.4
>       FreeBSD (ports): 8.2.0
>       OpenSUSE Leap 15: 7.3.1
>       Ubuntu (Xenial): 5.3.1
>       macOS (Homebrew): 8.2.0

I'd like to track this in a machine parsable format, but sure where it
better fits however, I'd prefer the git repo, and having the wiki
pointing to the git repo.

[...]

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fFjYJ-0006e6-BZ
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fFjYG-0007n9-86
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:55 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fFjYG-0007mF-2G
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:52 -0400
Received: by mail-wr0-f196.google.com with SMTP id v60-v6so29485012wrc.7
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 10:03:51 -0700 (PDT)
References: <20180415230522.24404-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dec7aa26-4e0a-2ae2-c8f5-08ebbdfe270c@redhat.com>
Date: Mon, 7 May 2018 19:03:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180415230522.24404-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/4] build: fix failure when host provides
 too old libfdt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: YunQiang Su <syq@debian.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 16/04/2018 01:05, Philippe Mathieu-Daudé wrote:
> Hi, I already hit this problem on Shippable and tried to resolve it for 2.10;
> and shamefully hit it again yesterday on a Debian 8 host with distrib libfdt
> installed. I wondered how to fix this without root access and realized my
> previous Shippable kludge wasn't the best fix :)
> 
> Here we go adding the QEMU_LDFLAGS to enforce local libfdt in library path
> before the system one.
> This time it looks like the correct fix, also scalable for other libraries.
> 
> It would be great to have QEMU 2.12 buildable in Debian<9, but nobody
> complained since 2.10 so this can wait 2.13 (this is not a regression neither).
> 
> Regards,
> 
> Phil.
> 
> Jan Kiszka (1):
>   build: Silence dtc directory creation
> 
> Philippe Mathieu-Daudé (3):
>   configure: Really use local libfdt if the system one is too old
>   configure: Display if libfdt is from system or git
>   shippable: Remove Debian 8 libfdt kludge
> 
>  configure      | 15 +++++++++------
>  Makefile       |  2 +-
>  rules.mak      |  2 +-
>  .shippable.yml |  8 --------
>  4 files changed, 11 insertions(+), 16 deletions(-)
> 

Queued all four, thanks!

Paolo

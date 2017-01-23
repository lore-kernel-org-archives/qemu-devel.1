Received: from eggs.gnu.org ([2001:4830:134:3::10]:48341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVft6-0004fc-TY
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:46:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVft6-0003Hr-4T
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:46:28 -0500
Received: from mail-vk0-x231.google.com ([2607:f8b0:400c:c05::231]:35756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cVft5-0003Hn-UG
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:46:28 -0500
Received: by mail-vk0-x231.google.com with SMTP id x75so91681348vke.2
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 06:46:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170123142629.11110-1-berrange@redhat.com>
References: <20170123142629.11110-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jan 2017 14:46:06 +0000
Message-ID: <CAFEAcA_NSRk3wj3iZvhTbR5hxyUVe_4V_dgow=-dPb7KPFCeLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v1 0/8] Merge io/ 2017-01-23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 January 2017 at 14:26, Daniel P. Berrange <berrange@redhat.com> wrote:
> The following changes since commit 598cf1c805271564686f2d732b36f50c3c40dcdd:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-01-20 16:42:07 +0000)
>
> are available in the git repository at:
>
>   git://github.com/berrange/qemu tags/pull-qio-2017-01-23-1
>
> for you to fetch changes up to 19f3cc22d364b57315e171090ee2e499b58775b4:
>
>   io: introduce a DNS resolver API (2017-01-23 11:28:09 +0000)
>
> ----------------------------------------------------------------
> Merge io/ 2017-01-23
>
> Daniel P. Berrange (8):
>   sockets: add ability to disable DNS resolution for InetSocketAddress
>   io: stop incrementing reference in qio_task_get_source
>   io: fix typo in docs for QIOTask
>   io: add ability to associate an opaque "result" with with a task
>   io: add ability to associate an error with a task
>   io: change the QIOTask callback signature
>   io: remove Error parameter from QIOTask thread worker
>   io: introduce a DNS resolver API

Fails to build, OSX:

/Users/pm215/src/qemu-for-merges/io/dns-resolver.c:30:39: error: use
of undeclared identifier 'PTHREAD_ONCE_INIT'
static pthread_once_t instance_init = PTHREAD_ONCE_INIT;
                                      ^
/Users/pm215/src/qemu-for-merges/io/dns-resolver.c:39:5: error:
implicit declaration of function 'pthread_once' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
    pthread_once(&instance_init, qio_dns_resolve_init_instance);
    ^
/Users/pm215/src/qemu-for-merges/io/dns-resolver.c:39:5: note: did you
mean 'pthread_kill'?
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk/usr/include/signal.h:82:5:
note: 'pthread_kill' declared here
int     pthread_kill(pthread_t, int);
        ^
2 errors generated.

OSX does have pthread_once(), but you need to actually include
pthread.h (either directly or more likely via qemu/thread.h)
to get it.

thanks
-- PMM

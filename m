Received: from eggs.gnu.org ([2001:4830:134:3::10]:32980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRnAy-0005am-2Q
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 18:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRnAx-0000uw-DO
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 18:53:56 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:38046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gRnAx-0000um-8r
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 18:53:55 -0500
Received: by mail-ot1-x331.google.com with SMTP id e12so17593368otl.5
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 15:53:55 -0800 (PST)
MIME-Version: 1.0
References: <1543343886-816-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543343886-816-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Nov 2018 23:53:42 +0000
Message-ID: <CAFEAcA89chrHhitrFMmCzPuAHCJ1QLLy7udCtCgHESaspRc7Cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v3 00/14] Misc patches for QEMU 3.1.0-rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 27 Nov 2018 at 19:00, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 4822f1ee9efa8df56e29db0a68323b484bdb03=
35:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/fixes-31-20181127-pul=
l-request' into staging (2018-11-27 11:21:38 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 3fe2199833c47652a7e5dbf8b347d873820104b8:
>
>   hostmem: no need to check for host_memory_backend_mr_inited() in alloc(=
) (2018-11-27 19:36:22 +0100)
>
> ----------------------------------------------------------------
> * lsi HBA reselection fix (George)
> * Small cleanups (Li Qiang)
> * bugfixes for vhost-user-bridge and hostmem (Marc-Andr=C3=A9)
> * single-thread TCG fix (me)
> * VMX migration blocker (me)
> * target/i386 fix for LOCK (Richard)
> * MAINTAINERS update (Philippe, Thomas)
>
> ---------------------------------------------------------------


This still has the problem with backends/hostmem-file.c that
means it doesn't build on the BSDs...

backends/hostmem-file.c: In function 'file_backend_memory_alloc':
backends/hostmem-file.c:61:5: error: 'path' undeclared (first use in
this function)
     path =3D object_get_canonical_path(OBJECT(backend));
     ^
backends/hostmem-file.c:61:5: note: each undeclared identifier is
reported only once for each function it appears in

(mismatch in #ifdef choice between declaration and use of variable)

thanks
-- PMM

Received: from eggs.gnu.org ([2001:4830:134:3::10]:40662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dXp2t-0002ER-OU
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:29:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dXp2o-00014o-OX
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:29:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dXp2o-000148-HH
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:29:38 -0400
Date: Wed, 19 Jul 2017 09:29:35 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <806154869.55582011.1500470975500.JavaMail.zimbra@redhat.com>
In-Reply-To: <1b58cb8.a133.15d5adc3290.Coremail.indiffpig@126.com>
References: <1500031677-2362-1-git-send-email-indiffPig@126.com>
	<1b58cb8.a133.15d5adc3290.Coremail.indiffpig@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] dvs services stop then qemu may be accesse
 null address case core
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: indiffpig <indiffpig@126.com>
Cc: indiffPig@126.com, pbonzini@redhat.com, qemu-devel@nongnu.org

Hi

----- Original Message -----
> 
> No one replied to my mail. Someone might think I was talking nonsense. When
> the DVS service stopped, all our QEMU processes exited. DVS users complain
> that even if their DVS services are stopped, vhost-user networks should not
> be blocked, but virtual machines should not be allowed to exit. I found the
> segdefault error in the host's log about QEMU, and all errors are pointing
> to the null pointer referred to in the patch. What does open source
> maintenance staff think about?
> 

You don't explain well how the crash happen. I don't even know what dvs service is.

Could you provide a description of how to reproduce the crash?

When there is a crash, it's good to also provide the backtrace.

Your patch may solve your problem, but there might be different (better) solutions, and we should try to cover this case in our tests.

thanks

> 
> At 2017-07-14 19:27:57, indiffPig@126.com wrote:
> >From: "yin.zuowei" <indiffPig@126.com>
> >
> >Signed-off-by: yin.zuowei <indiffPig@126.com>
> >---
> > chardev/char-fe.c | 8 +++++++-
> > 1 file changed, 7 insertions(+), 1 deletion(-)
> >
> >diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> >index 3f90f05..82f7e2b 100644
> >--- a/chardev/char-fe.c
> >+++ b/chardev/char-fe.c
> >@@ -353,7 +353,13 @@ guint qemu_chr_fe_add_watch(CharBackend *be,
> >GIOCondition cond,
> > 
> > void qemu_chr_fe_disconnect(CharBackend *be)
> > {
> >-    Chardev *chr = be->chr;
> >+    Chardev *chr = NULL;
> >+
> >+    if (be) {
> >+        chr = be->chr;
> >+    } else {
> >+        return ;
> >+    }
> > 
> >     if (chr && CHARDEV_GET_CLASS(chr)->chr_disconnect) {
> >         CHARDEV_GET_CLASS(chr)->chr_disconnect(chr);
> >--
> >1.8.3.1
> >
> 

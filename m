Received: from eggs.gnu.org ([2001:4830:134:3::10]:56060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dX2r4-0003Gb-Jq
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:02:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dX2r1-00088G-FO
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:02:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dX2r1-00087a-5Q
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:02:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B49017A169
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 10:02:13 +0000 (UTC)
Date: Mon, 17 Jul 2017 11:02:06 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170717100206.GF3640@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170717063521.GA7393@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170717063521.GA7393@lemon>
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Jul 17, 2017 at 02:35:21PM +0800, Fam Zheng wrote:
> Hi all,
> 
> Today I've included a fourth type of the automatic patchew replies: FreeBSD.
> 
> So far we have these tests running by patchew on each patch series:
> 
>   * Docker tests
>     Basically it is
>         make docker-test-quick@centos6 \
>              docker-test-build@min-glib \
>              docker-test-mingw@fedora"
> 
>   * checkpatch.pl
>     Each patch is fed to ./scripts/checkpatch.pl and all errors are reported.
> 
>   * s390x
>     It runs on a machine shared by Fedora team, basically only "./configure and
>     make", because "make check" hanging is tricky to deal with from an
>     automation perspective. (Ideas?)
> 
>   * FreeBSD
>     Like s390x.
> 
> Q1: In the worst case, you get four individual auto replies from patchew. Is
> that too many? Do you prefer one reply with all the results concatenated into
> one?

The risk with combining everything into one reply is that if only one of the
four test systems fails / hangs / gets very backlogged, you're going to
delay reporting of failures from all four systems. Personally, I would like
to see any failure reported as soon as it happens, without waiting to see
if other things fail or pass.

> Q2: Some think the full log in the mail body is more than necessary. Is it
> better or worse if it is a "tail -n 200" of the log in the body and the full log
> attached?

The mails are rather large alredy. It is common with Jenkins to only report
the tail of the logs, and then provide a hyperlink to a web site with the
complete log. This avoids bloating everyone's INBOXs with many 100 KB of
logs.

> Q3: What other tests do maintainers want? Different hosts? Different configure
> combinations?
> 
> Q4: Any other improvements/features you want? (E.g. some documentation? :)

Sometimes the test system seems to get pretty backlogged and there's no
way of knowing this, as its indistinguishable from the situation where
it doesn't send results because everything passed.

I'd like to see a web page that provides a list of all mail threads that
the test system has queued, with status of which jobs and running, and
once completed, provides the full logs.

That way we can quickly check whether patchw has started processing a
particular series or not.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

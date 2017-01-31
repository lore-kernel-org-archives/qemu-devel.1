Received: from eggs.gnu.org ([2001:4830:134:3::10]:36094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYWWO-0006dF-8h
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYWWL-00083N-5h
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:22:48 -0500
Received: from smtp3.mundo-r.com ([212.51.32.191]:65403 helo=smtp4.mundo-r.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYWWK-000832-W5
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:22:45 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170131100945.8189-1-kwolf@redhat.com>
References: <20170131100945.8189-1-kwolf@redhat.com>
Date: Tue, 31 Jan 2017 12:22:42 +0100
Message-ID: <w51mve7o4n1.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] gtk: Hardcode LC_CTYPE as C.utf-8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, kraxel@redhat.com, mfabian@redhat.com

On Tue 31 Jan 2017 11:09:45 AM CET, Kevin Wolf <kwolf@redhat.com> wrote:

> Recently, however, glibc introduced a new locale "C.utf-8" that just
> uses UTF-8 as its charset, but otherwise leaves the semantics alone.
> Just setting the right character set is enough for our use case, so we
> can just hardcode this one without having to be afraid of nasty side
> effects.

>     setlocale(LC_MESSAGES, "");
> +   setlocale(LC_CTYPE, "C.utf-8");
>     bindtextdomain("qemu", CONFIG_QEMU_LOCALEDIR);

A couple of quick questions:

- Is it C.utf-8 or C.UTF-8 ? 'locale -a' shows only the latter in my
  system.

- When was this added? This bug seems to be still open:
  https://sourceware.org/bugzilla/show_bug.cgi?id=17318

Berto

Received: from eggs.gnu.org ([209.51.188.92]:36449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghwkH-0004WT-Ns
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:21:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ghwkH-0001Hp-8v
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:21:09 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1547132561.git.berto@igalia.com>
Date: Fri, 11 Jan 2019 14:20:59 +0100
In-Reply-To: <cover.1547132561.git.berto@igalia.com> (Alberto Garcia's message
	of "Thu, 10 Jan 2019 17:03:34 +0200")
Message-ID: <87imyv49fo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/6] Acquire the AioContext during
 _realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

For what it's worth, this series seems to fix assertion failures related
to AioContext acquire/release I've seen.

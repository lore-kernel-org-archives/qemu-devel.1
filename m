Received: from eggs.gnu.org ([2001:4830:134:3::10]:56971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCpZj-0000ql-PO
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 13:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCpZg-0006p5-8A
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 13:25:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gCpZf-0006mo-W4
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 13:25:36 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181017151738.20299-1-berto@igalia.com>
Date: Wed, 17 Oct 2018 19:25:32 +0200
In-Reply-To: <20181017151738.20299-1-berto@igalia.com> (Alberto Garcia's
	message of "Wed, 17 Oct 2018 18:17:38 +0300")
Message-ID: <87d0s8o583.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] scripts: Remove check-qerror.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org

Alberto Garcia <berto@igalia.com> writes:

> qerror.h contains leftovers from the now-defunct QError API.
>
> There's only a handful of string macros left, and no one is supposed
> to add anything else. The check-qerror.sh script was used to make sure
> that all definitions on the qerror.c and qerror.h files were sorted
> alphabetically. The former was removed three years ago, and the latter
> is now in a different location, so the script doesn't even work (as
> a matter of fact the alphabetical order was broken last time someone
> added a macro -also in 2015- and no one seemed to notice).
>
> There's no point in fixing this script so let's just remove it.
> The rogue macro is also moved to its correct location.
>
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Queued, thanks!

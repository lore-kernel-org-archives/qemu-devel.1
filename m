Received: from eggs.gnu.org ([2001:4830:134:3::10]:53066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSyYg-0005z7-A4
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 01:43:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSyYd-0007Ef-2R
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 01:43:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33672 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fSyYc-0007ET-Te
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 01:42:58 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1528861711-23200-1-git-send-email-keno@juliacomputing.com>
Date: Wed, 13 Jun 2018 07:42:57 +0200
In-Reply-To: <1528861711-23200-1-git-send-email-keno@juliacomputing.com> (Keno
	Fischer's message of "Tue, 12 Jun 2018 23:48:31 -0400")
Message-ID: <87y3fjkzry.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5] cutils: Provide strchrnul
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keno Fischer <keno@juliacomputing.com>
Cc: qemu-devel@nongnu.org, groug@kaod.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

Keno Fischer <keno@juliacomputing.com> writes:

> strchrnul is a GNU extension and thus unavailable on a number of targets.
> In the review for a commit removing strchrnul from 9p, I was asked to
> create a qemu_strchrnul helper to factor out this functionality.
> Do so, and use it in a number of other places in the code base that inlined
> the replacement pattern in a place where strchrnul could be used.
>
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> Acked-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Markus Armbruster <armbru@redhat.com>

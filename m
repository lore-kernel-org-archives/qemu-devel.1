Received: from eggs.gnu.org ([2001:4830:134:3::10]:43302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eqfiL-0007Po-QF
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:54:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eqfiK-0005Ly-TT
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:54:41 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180224154033.29559-3-mreitz@redhat.com>
References: <20180224154033.29559-1-mreitz@redhat.com>
	<20180224154033.29559-3-mreitz@redhat.com>
Date: Tue, 27 Feb 2018 14:45:39 +0100
Message-ID: <w51371m4kcc.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/7] qapi: Add qobject_to()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Sat 24 Feb 2018 04:40:28 PM CET, Max Reitz wrote:
> This is a dynamic casting macro that, given a QObject type, returns an
> object as that type or NULL if the object is of a different type (or
> NULL itself).
>
> The macro uses lower-case letters because:
> 1. There does not seem to be a hard rule on whether qemu macros have to
>    be upper-cased,
> 2. The current situation in qapi/qmp is inconsistent (compare e.g.
>    QINCREF() vs. qdict_put()),
> 3. qobject_to() will evaluate its @obj parameter only once, thus it is
>    generally not important to the caller whether it is a macro or not,
> 4. I prefer it aesthetically.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

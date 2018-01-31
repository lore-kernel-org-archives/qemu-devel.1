Received: from eggs.gnu.org ([2001:4830:134:3::10]:41991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eguqr-0007Eb-5R
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:03:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eguql-0005yC-Kd
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:03:09 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180120154412.9990-2-mreitz@redhat.com>
References: <20180120154412.9990-1-mreitz@redhat.com>
	<20180120154412.9990-2-mreitz@redhat.com>
Date: Wed, 31 Jan 2018 17:02:52 +0100
Message-ID: <w51vafixbgz.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/6] qapi: Add qobject_to()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Sat 20 Jan 2018 04:44:07 PM CET, Max Reitz wrote:
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

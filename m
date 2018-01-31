Received: from eggs.gnu.org ([2001:4830:134:3::10]:42859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1egutN-0000ZI-HO
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:05:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1egutE-0007xB-0X
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:05:45 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180120154412.9990-3-mreitz@redhat.com>
References: <20180120154412.9990-1-mreitz@redhat.com>
	<20180120154412.9990-3-mreitz@redhat.com>
Date: Wed, 31 Jan 2018 17:05:18 +0100
Message-ID: <w51shamxbcx.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/6] qapi: Replace qobject_to_X(o) by
 qobject_to(o, X)
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

On Sat 20 Jan 2018 04:44:08 PM CET, Max Reitz wrote:
> This patch was generated using the following Coccinelle script:
>
> @@
> expression Obj;
> @@
> (
> - qobject_to_qnum(Obj)
> + qobject_to(Obj, QNum)
> |
> - qobject_to_qstring(Obj)
> + qobject_to(Obj, QString)
> |
> - qobject_to_qdict(Obj)
> + qobject_to(Obj, QDict)
> |
> - qobject_to_qlist(Obj)
> + qobject_to(Obj, QList)
> |
> - qobject_to_qbool(Obj)
> + qobject_to(Obj, QBool)
> )
>
> and a bit of manual fix-up for overly long lines and three places in
> tests/check-qjson.c that Coccinelle did not find.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

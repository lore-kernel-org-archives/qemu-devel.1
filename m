Received: from eggs.gnu.org ([2001:4830:134:3::10]:49520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVKRN-0003rn-As
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 13:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVKRM-0002E9-KY
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 13:01:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gVKRM-00029x-DO
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 13:01:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 17A533C2CCC
	for <qemu-devel@nongnu.org>; Fri,  7 Dec 2018 18:01:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181207161447.31314-1-philmd@redhat.com>
Date: Fri, 07 Dec 2018 19:01:23 +0100
In-Reply-To: <20181207161447.31314-1-philmd@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 7 Dec 2018 17:14:47
	+0100")
Message-ID: <87r2etp66k.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] util/error: Remove an unnecessary NULL
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: "Daniel P . =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> This NULL check was required while introduced in 680d16dcb79f.
> Later refactor added a NULL check in error_setv(), so this check
> is now redundant.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>

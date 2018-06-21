Received: from eggs.gnu.org ([2001:4830:134:3::10]:44972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fW2k9-0003yh-JB
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fW2k8-0003ef-O3
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57884 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fW2k8-0003eJ-JE
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 233B18163C40
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 16:47:32 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
Date: Thu, 21 Jun 2018 18:47:29 +0200
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 21 Mar 2018 12:51:22 +0100")
Message-ID: <87y3f8hyse.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/49] qapi: add #if pre-processor
 conditions to generated code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

I think we can bite off a digestible part of this series:
target-independent top-level conditionals.  I think that's PATCH
01-14,31 and applicable parts of 35-37.  The idea is to merge that part
quickly, then deal with the (less daunting) remainder.  Marc-Andr=C3=A9, if
you agree with that plan, please respin just that part.  I can continue
review of the remainder without a rebase.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:35872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diDhZ-0001te-NX
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 01:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diDhU-0003io-MU
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 01:50:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1diDhU-0003iF-CO
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 01:50:36 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-8-marcandre.lureau@redhat.com>
	<87mv6z4ix5.fsf@dusky.pond.sub.org>
Date: Thu, 17 Aug 2017 07:50:30 +0200
In-Reply-To: <87mv6z4ix5.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Wed, 16 Aug 2017 17:43:50 +0200")
Message-ID: <8760dmspy1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 07/26] qapi: add 'if' condition on
 top-level schema elements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Markus Armbruster <armbru@redhat.com> writes:

[...]
> Out of review brainpower for today.  Hope to resume tomorrow.
>
> [...]

Nope, I'm giving up on this one.  Please split it for reviewability.
Suggested split:

1. Preparatory refactoring for step 2, step by step

2. Frontend part: accept and check 'if', step by step

   The accepted conditions should be visible in
   tests/qapi-schema/qapi-schema-test.out.

3. Preparatory refactoring for step 4, step by step

4. Backend part: generate the ifdeffery, step by step

   You already split off qapi2texi steps [PATCH 12-15].  Good.  Perhaps
   that's all that can be split off, perhaps not.

PATCH 08-11 may well profit from the same treatment.

Moving on to PATCH 16.

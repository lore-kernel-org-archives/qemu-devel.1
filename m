Received: from eggs.gnu.org ([209.51.188.92]:47163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmg77-0002TG-To
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:36:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmg75-00024B-Rt
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:36:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gmg75-00021S-Gp
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:36:15 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3DF689AD1
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 14:36:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181218182234.28876-1-armbru@redhat.com>
Date: Thu, 24 Jan 2019 15:36:09 +0100
In-Reply-To: <20181218182234.28876-1-armbru@redhat.com> (Markus Armbruster's
	message of "Tue, 18 Dec 2018 19:22:19 +0100")
Message-ID: <87k1iudsx2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/15] qapi: add #if pre-processor
 conditions to generated code (part 3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com

Markus Armbruster <armbru@redhat.com> writes:

> Marc-Andr=C3=A9 posted v1 that relies on a QAPI schema language extension
> 'top-unit' to permit splitting the generated code.  Here is his cover
> letter:
>
>     The thrid and last part (of "[PATCH v2 00/54] qapi: add #if
>     pre-processor conditions to generated code") is about adding schema
>     conditions based on the target.
>
>     For now, the qapi code is compiled in common objects (common to all
>     targets). This makes it impossible to add #if TARGET_ARM for example.
>
>     The patch "RFC: qapi: learn to split the schema by 'top-unit'"
>     proposes to split the schema by "top-unit", so that generated code can
>     be built either in common objects or per-target. That patch is a bit
>     rough, I would like to get some feedback about the approach before
>     trying to improve it. The following patches demonstrate usage of
>     target-based #if conditions, and getting rid of the
>     qmp_unregister_command() hack.
>
> We already have a way to split generated code: QAPI modules.  I took
> the liberty to rework Marc-Andr=C3=A9's series to use a target module
> instead.  Less code, no change to the QAPI language.
>
> One of the patches (marked WIP) is a total hack.  Fixable, but I want
> to get this out for discussion first.

PATCH 01-02 make sense on their own; queued.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehcic-0000Va-25
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:53:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ehciX-000893-L3
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:53:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ehciX-00088o-G5
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:53:29 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
Date: Fri, 02 Feb 2018 15:52:54 +0100
In-Reply-To: <20180202130336.24719-1-armbru@redhat.com> (Markus Armbruster's
	message of "Fri, 2 Feb 2018 14:03:15 +0100")
Message-ID: <87y3kbjveh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 00/21] Modularize generated QAPI code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Markus Armbruster <armbru@redhat.com> writes:

> Our qapi-schema.json is composed of modules connected by include
> directives, but the generated code is monolithic all the same: one
> qapi-types.h with all the types, one qapi-visit.h with all the
> visitors, and so forth.  These monolithic headers get included all
> over the place.  In my "build everyhing" tree, adding a QAPI type
> recompiles about 4500 out of 4800 objects.
>
> Nobody would write such monolithic headers by hand.  It stands to
> reason that one shouldn't generate them, either.
>
> This series' basic idea is to split up generated headers to mirror the
> schema's modular structure: one header per module.  That way, you can
> include just what you need.
>
> The series is RFC for a number of reasons:
>
> * The split is implemented only for qapi-types.h.  That one should
>   provide the biggest benefits, though.
>
> * There's a bit of code duplication.
>
> * I haven't re-read my patches, yet.

And of course

  * Needs a doc update

[...]

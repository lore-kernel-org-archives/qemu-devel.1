Received: from eggs.gnu.org ([2001:4830:134:3::10]:45950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRKD4-00010P-3g
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:58:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRKD2-0007Av-NM
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:58:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gRKD2-0007AX-Ga
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:58:08 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66F2930820F4
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 16:58:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181122071613.2889-1-kraxel@redhat.com>
	<87h8g4lyyh.fsf@dusky.pond.sub.org>
	<20181126151325.2pfues2q7vuqin4y@sirius.home.kraxel.org>
Date: Mon, 26 Nov 2018 17:58:00 +0100
In-Reply-To: <20181126151325.2pfues2q7vuqin4y@sirius.home.kraxel.org> (Gerd
	Hoffmann's message of "Mon, 26 Nov 2018 16:13:25 +0100")
Message-ID: <87zhtvixnr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3] qapi: add query-display-options command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Gerd Hoffmann <kraxel@redhat.com> writes:

> On Mon, Nov 26, 2018 at 03:01:42PM +0100, Markus Armbruster wrote:
>> Gerd Hoffmann <kraxel@redhat.com> writes:
>> 
>> > Add query-display-options command, which allows querying the qemu
>> > display configuration, and -- as an intentional side effect -- makes
>> > DisplayOptions discoverable via query-qmp-schema so libvirt can go
>> > figure which display options are supported.
>> >
>> > Use case: commit d4dc4ab1 added rendernode parameter for egl-headless.
>> 
>> I understand why exposing DisplayOptions in query-qmp-schema is useful.
>> But can you think of a use for the new command?
>> 
>> If not, then this is a workaround for lack of CLI introspection.
>> That's okay, ball's in my court on that.  But I'd like to have the
>> "workaroundness" spelled out in the commit message then.
>
> Sure.  I assumed the "intentional side effect" message is clear enough
> though.
>
> The command itself isn't that helpful, you should know how you have
> started qemu ...

If it's not too much trouble, please tweak the commit message to be a
bit more explicit.  Perhaps:

    Add query-display-options command, which allows querying the qemu
    display configuration.  This isn't particularly useful, except it
    exposes QAPI type DisplayOptions in query-qmp-schema, so that
    libvirt can discover recently added -display parameter rendernode
    (commit d4dc4ab133b).  Works around lack of sufficiently powerful
    command line introspection.

This should give me a fighting chance to remember deprecating the
command once we got sufficiently powerful command line introspection.

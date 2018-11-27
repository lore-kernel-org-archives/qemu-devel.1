Received: from eggs.gnu.org ([208.118.235.92]:48597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRZIy-0008Uw-UC
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:05:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRZIv-000107-3M
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:05:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43531)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gRZIu-0000wq-RG
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:05:13 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D4DB7804F0
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 09:05:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181122071613.2889-1-kraxel@redhat.com>
	<87h8g4lyyh.fsf@dusky.pond.sub.org>
	<20181126151325.2pfues2q7vuqin4y@sirius.home.kraxel.org>
	<87zhtvixnr.fsf@dusky.pond.sub.org>
	<20181127065808.ph7pv6brnaeuyqix@sirius.home.kraxel.org>
Date: Tue, 27 Nov 2018 10:05:03 +0100
In-Reply-To: <20181127065808.ph7pv6brnaeuyqix@sirius.home.kraxel.org> (Gerd
	Hoffmann's message of "Tue, 27 Nov 2018 07:58:08 +0100")
Message-ID: <87d0qquc00.fsf@dusky.pond.sub.org>
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

>   Hi,
>
>> If it's not too much trouble, please tweak the commit message to be a
>> bit more explicit.  Perhaps:
>> 
>>     Add query-display-options command, which allows querying the qemu
>>     display configuration.  This isn't particularly useful, except it
>>     exposes QAPI type DisplayOptions in query-qmp-schema, so that
>>     libvirt can discover recently added -display parameter rendernode
>>     (commit d4dc4ab133b).  Works around lack of sufficiently powerful
>>     command line introspection.
>
> Done, pull req with this and other 3.1 fixes sent.
>
>> This should give me a fighting chance to remember deprecating the
>> command once we got sufficiently powerful command line introspection.
>
> I'm wondering how difficuilt it would be to add that when limiting that
> to the command line switches which already use qapi parsers (-blockdev
> and -display as far I know).  Might increase the motivation of others to
> help moving parsers from whatever they do today (QemuOpts, ...) to qapi
> to get introspection support ;)

I like the idea.  The clean way to do it would be a partial QAPIfication
of the command line.  I'm wary of partial "we'll finish this eventually"
conversions.  That said, the complete job may well be too large to
tackle in one go, giving us no choice.

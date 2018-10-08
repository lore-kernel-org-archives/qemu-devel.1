Received: from eggs.gnu.org ([2001:4830:134:3::10]:35376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9VbG-0004QJ-1z
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 09:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1g9VbB-0005AO-JR
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 09:29:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1g9Vb9-000593-Qf
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 09:29:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2DEF7307C700
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 13:29:19 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180925160248.30801-1-kchamart@redhat.com>
	<20180925160248.30801-2-kchamart@redhat.com>
	<07ccc2c0-10e2-3456-3124-5aa2d87158f0@redhat.com>
	<20181001124039.GF25720@paraplu>
Date: Mon, 08 Oct 2018 15:29:10 +0200
In-Reply-To: <20181001124039.GF25720@paraplu> (Kashyap Chamarthy's message of
	"Mon, 1 Oct 2018 14:40:39 +0200")
Message-ID: <87ftxg36u1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Deprecate QMP `cpu-add`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, imammedo@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com, armbru@redhat.com

Kashyap Chamarthy <kchamart@redhat.com> writes:

> On Mon, Oct 01, 2018 at 11:28:17AM +0200, Thomas Huth wrote:
>> On 2018-09-25 18:02, Kashyap Chamarthy wrote:
>
> [...]
>
>> > +++ b/qapi/misc.json
>> > @@ -1104,7 +1104,11 @@
>> >  ##
>> >  # @cpu-add:
>> >  #
>> > -# Adds CPU with specified ID
>> > +# Adds CPU with specified ID.
>> > +#
>> > +# Notes: This command is deprecated.  The `device_add` command should be
>> 
>> s/Notes/Note/ ?
>
> Yeah, first I wrote the singular.  But went with plural as I saw it as
> it was the 'majority' pattern:
>
>     $> git grep "Note:" qapi/misc.json | wc -l
>     13
>     $> git grep "Notes:" qapi/misc.json | wc -l
>     18

Not exactly overwhelming majority :)

> Maybe people use the plural, "Notes", as they can add multiple entries.

For what it's worth, our doc generator recognizes both.

[...]

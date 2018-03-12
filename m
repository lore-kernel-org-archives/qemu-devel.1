Received: from eggs.gnu.org ([2001:4830:134:3::10]:47195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evOwH-0003FC-DQ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evOwD-0000Az-4J
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:00:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33238 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evOwD-0000A1-0E
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:00:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 85475EBFE2
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 15:00:28 +0000 (UTC)
References: <1520267868-31778-1-git-send-email-thuth@redhat.com>
	<2eb04741-4dcd-1f57-4786-ca8328502b79@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f4c8a7a8-9b2b-1dbc-0cd4-005c8784df0f@redhat.com>
Date: Mon, 12 Mar 2018 10:00:23 -0500
MIME-Version: 1.0
In-Reply-To: <2eb04741-4dcd-1f57-4786-ca8328502b79@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] qapi: Add device ID and head parameters
 to screendump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Jiri Denemark <jdenemar@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 03/10/2018 09:05 PM, Eric Blake wrote:
> On 03/05/2018 10:37 AM, Thomas Huth wrote:
>> QEMU's screendump command can only take dumps from the primary display=
.
>> When using multiple VGA cards, there is no way to get a dump from a
>> secondary card or other display heads yet. So let's add an 'device' an=
d
>> a 'head' parameter to the HMP and QMP commands to be able to specify
>> alternative devices and heads with the screendump command, too.
>>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> =C2=A0 v4:
>> =C2=A0 - Improved the documentation of the parameters in ui.json a lit=
tle bit
>> =C2=A0=C2=A0=C2=A0 (according to the suggestions from Eric)
>=20
> We're getting close to soft freeze; I'll include this in my QAPI tree,=20
> since I have an upcoming pull request, rather than figuring out if Gerd=
=20
> is also doing one more pull (but of course, if he does, it doesn't hurt=
;=20
> git handles patches on multiple merge branches just fine, or I can=20
> rebase it out of mine if Gerd's tree goes in first).
>=20
> Queued:
>=20
> git://repo.or.cz/qemu/ericb.git qapi
> http://repo.or.cz/qemu/ericb.git/shortlog/refs/heads/qapi

Removed from my QAPI queue; Gerd picked it up in his PR:
https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg03266.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

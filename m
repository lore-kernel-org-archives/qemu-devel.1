Received: from eggs.gnu.org ([2001:4830:134:3::10]:47492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1et8TK-0006Sp-BJ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:01:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1et8TE-0004yZ-Rp
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:01:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55640 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1et8TE-0004yH-Nw
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 04:01:16 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4965D4023150
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 09:01:16 +0000 (UTC)
References: <1520267868-31778-1-git-send-email-thuth@redhat.com>
	<710eb2ec-8585-900f-6829-67765c188252@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6a10a395-1a5f-060e-9e17-e77250c333b2@redhat.com>
Date: Tue, 6 Mar 2018 10:01:11 +0100
MIME-Version: 1.0
In-Reply-To: <710eb2ec-8585-900f-6829-67765c188252@redhat.com>
Content-Type: text/plain; charset=utf-8
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
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Jiri Denemark <jdenemar@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 05.03.2018 17:50, Eric Blake wrote:
> On 03/05/2018 10:37 AM, Thomas Huth wrote:
>> QEMU's screendump command can only take dumps from the primary display=
.
>> When using multiple VGA cards, there is no way to get a dump from a
>> secondary card or other display heads yet. So let's add an 'device' an=
d
>=20
> s/an/a/

Gerd, could you please fix that up when picking up the patch? Thanks!

>> a 'head' parameter to the HMP and QMP commands to be able to specify
>> alternative devices and heads with the screendump command, too.
>>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks for the reviews!

 Thomas

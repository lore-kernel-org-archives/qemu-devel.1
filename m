Received: from eggs.gnu.org ([2001:4830:134:3::10]:56650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1cOQyk-0006dP-5h
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1cOQyh-00060I-2T
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:26:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:58656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <afaerber@suse.de>) id 1cOQyg-0005zs-SS
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:26:19 -0500
References: <1483371890-289981-1-git-send-email-imammedo@redhat.com>
	<1483371890-289981-2-git-send-email-imammedo@redhat.com>
	<1c69ec6e-e8e9-d544-f2c5-52ace0acf2bb@redhat.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <dc14b54f-db61-c14c-7963-51d9b322a2a1@suse.de>
Date: Tue, 3 Jan 2017 16:26:16 +0100
MIME-Version: 1.0
In-Reply-To: <1c69ec6e-e8e9-d544-f2c5-52ace0acf2bb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] cleanup: remove not used header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, ehabkost@redhat.com, armbru@redhat.com, dgilbert@redhat.com

Am 03.01.2017 um 16:25 schrieb Eric Blake:
> On 01/02/2017 09:44 AM, Igor Mammedov wrote:
>=20
> perhaps s/not used/unused/ in the subject

... and qom: instead of cleanup: if this gets re-spun.

Andreas

>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>>  qom/object_interfaces.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
>> index ded4d84..4b880d0 100644
>> --- a/qom/object_interfaces.c
>> +++ b/qom/object_interfaces.c
>> @@ -3,7 +3,6 @@
>>  #include "qom/object_interfaces.h"
>>  #include "qemu/module.h"
>>  #include "qapi-visit.h"
>> -#include "qapi/qobject-output-visitor.h"
>>  #include "qapi/opts-visitor.h"
>> =20
>>  void user_creatable_complete(Object *obj, Error **errp)
>>
>=20


--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=C3=BCrnberg)

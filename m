Received: from eggs.gnu.org ([209.51.188.92]:42736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hIzoR-0005Q4-Lq
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hIzoE-0003jC-UX
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 14:06:31 -0400
References: <20190422221714.7630-1-jsnow@redhat.com>
	<20190422221714.7630-2-jsnow@redhat.com>
	<eaa73eb3-a84f-a263-13b2-e25588f00fd7@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <91bbd108-4ac4-7e07-6d7f-03efb536ba14@redhat.com>
Date: Tue, 23 Apr 2019 14:06:02 -0400
MIME-Version: 1.0
In-Reply-To: <eaa73eb3-a84f-a263-13b2-e25588f00fd7@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Makefile: add nit-picky mode to
 sphinx-build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aliang@redhat.com" <aliang@redhat.com>, "kchamart@redhat.com" <kchamart@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Fam Zheng <fam@euphon.net>, "nsoffer@redhat.com" <nsoffer@redhat.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>



On 4/23/19 2:03 PM, Vladimir Sementsov-Ogievskiy wrote:
> 23.04.2019 1:17, John Snow wrote:
>> If we add references that don't resolve (or accidentally remove them),
>> it will be helpful to have an error message alerting us to that.
>=20
> accordingly to docs I've found, not error but warning.
>=20
Oh, true. I have to revise the document anyway, so I'll change my
phrasing here -- it won't cause the build to fail, but you will be able
to see the error when you build. I think it's helpful to have as a
mechanical check -- especially if we succeed in building generated ReST
documentation (eventually?...)

>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
>> ---
>>   Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 04a0d45050..ff9ce2ed4c 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -899,7 +899,7 @@ docs/version.texi: $(SRC_PATH)/VERSION
>>   sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html $(MANUAL_BUILDDIR)/i=
nterop/index.html
>>  =20
>>   # Canned command to build a single manual
>> -build-manual =3D $(call quiet-command,sphinx-build $(if $(V),,-q) -b =
html -D version=3D$(VERSION) -D release=3D"$(FULL_VERSION)" -d .doctrees/=
$1 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR=
)/$1")
>> +build-manual =3D $(call quiet-command,sphinx-build $(if $(V),,-q) -n =
-b html -D version=3D$(VERSION) -D release=3D"$(FULL_VERSION)" -d .doctre=
es/$1 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILD=
DIR)/$1")
>>   # We assume all RST files in the manual's directory are used in it
>>   manual-deps =3D $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(SRC_PATH)/do=
cs/$1/conf.py $(SRC_PATH)/docs/conf.py
>>  =20
>>
>=20
>=20

--=20
=E2=80=94js

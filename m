Received: from eggs.gnu.org ([2001:4830:134:3::10]:35632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duKMg-00008X-5t
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duKMe-0002I2-BE
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:23:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1duKMd-0002Gu-Oc
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:23:08 -0400
References: <1505328054-23805-1-git-send-email-thuth@redhat.com>
	<f09b7bd0-2055-9f1c-4bb8-ab5f2bbf6837@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d8375329-3c52-1932-df65-1fbfea488a66@redhat.com>
Date: Tue, 19 Sep 2017 17:22:44 +0200
MIME-Version: 1.0
In-Reply-To: <f09b7bd0-2055-9f1c-4bb8-ab5f2bbf6837@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="fBxBVo9pRejnBXQ7JaC6DfRKDEvUnrcOC"
Subject: Re: [Qemu-devel] [PATCH v2] tests: Introduce generic device
 hot-plug/hot-unplug functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Cc: Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fBxBVo9pRejnBXQ7JaC6DfRKDEvUnrcOC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.09.2017 15:38, Eric Blake wrote:
> On 09/13/2017 01:40 PM, Thomas Huth wrote:
>> A lot of tests provide code for adding and removing a device via the
>> device_add and device_del QMP commands. Maintaining this code in so ma=
ny
>> places is cumbersome and error-prone (some of the code parts check the=

>> responses for device deletion in an incorrect way, for example, we've =
got
>> to deal with both, error code and DEVICE_DEL event here). So let's pro=
vide
>> some proper generic functions for adding and removing a device instead=
=2E
>>
>> The code for correctly unplugging a device has been taken from a patch=

>> from Peter Xu.
[...]
>> +void qtest_qmp_device_del(const char *id)
>> +{
>> +    QDict *response1, *response2, *event =3D NULL;
>> +    char *cmd;
>> +
>> +    cmd =3D g_strdup_printf("{'execute': 'device_del',"
>> +                          " 'arguments': { 'id': '%s' }}", id);
>> +    response1 =3D qmp(cmd);
>> +    g_free(cmd);
>> +    g_assert(response1);
>> +    g_assert(!qdict_haskey(response1, "error"));
>> +
>> +    response2 =3D qmp("");
>=20
> Hmm, this new use of qmp("") means I get to rebase the efforts to remov=
e
> the empty qmp command usage from the testsuite efforts.

Sorry about that :-/ I hope it's not too much of a hassle!

Maybe we should finally also add some assert(strlen(fmt) > 0) to that
function to avoid that the problem sneaks in again?

 Thomas



--fBxBVo9pRejnBXQ7JaC6DfRKDEvUnrcOC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZwTZJAAoJEC7Z13T+cC21R0MP/1pCMPyVKKRJ8thfAmij+HhW
TDfWT8ZXxIDz5TvWKPO0bfyLOD9/ymZB7nN1WCzOhjxNi3lVMZHJqh1epXjzEUAn
bHVspD6s61A2/nEkBxhEam/9qwIdW16b5F3MmqVqtWSV8N73aHpT8hSdM0LFZ552
+XEDPJs7qpAdDBK7To9hoJ6aLveqe06zE8vu3yqS3KSkypy55Ap1gKosnpX4nbXg
GlVm/UKwYDFrBmdfQX9HfCX4nWYzxdqZ6kPTG+KkuVNZL7h472WZkhwIUoOHXNfx
iYmMdu6uqcszDyBVdo11Ovo+EqC9OxAS+MVPDSjr99E5tOn9obn4ddTuFPJgkp4J
nalj/ov2NQ5dDGO0BKCyxjyvqyQ3hA+uk29jnSXZpAo2VEAtOfOVIeS+3Q09cOjz
r8VkvoXH6RFyWIz69C0AHa5yyqp64d/NCImvOgVM3AsdV6Znz6jKbTNnGyv4jbAY
5EQ+GN+wEl+Hjc1NEANFv1+LertwejnWntnjBSlIQUMusj+X2Riv82V4xNXrPKNe
/87CsYrWS0OWIHX9AhVQKBRB4gyN9TsKZ6GEDZdUmnEZ70GRlD1270Zt5DLJjZ7n
V2iF/ZtUEWYn0xbt4wIWBCjHrMnVU36RY8NtEMYPzQO2dSArkeVYK+mO4BxaX8XX
H/aqDcZMnL+XBiUpUnDK
=qsri
-----END PGP SIGNATURE-----

--fBxBVo9pRejnBXQ7JaC6DfRKDEvUnrcOC--

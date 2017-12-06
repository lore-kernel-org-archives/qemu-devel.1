Received: from eggs.gnu.org ([2001:4830:134:3::10]:49546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eMXHk-0007za-OU
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eMXHg-00055g-I4
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:50:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eMXHg-00055P-9d
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:50:36 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6An8DB041400
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 05:50:33 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2epef4t6cg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 05:50:33 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 6 Dec 2017 10:50:29 -0000
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
	<20171201143136.62497-3-pasic@linux.vnet.ibm.com>
	<20171204121511.0abe9ca2.cohuck@redhat.com>
	<f237126d-0815-8433-6ef7-1c1ba2e5a956@linux.vnet.ibm.com>
	<27f5a0c3-755a-bd1b-11b5-d7a73808d1de@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 6 Dec 2017 11:50:26 +0100
MIME-Version: 1.0
In-Reply-To: <27f5a0c3-755a-bd1b-11b5-d7a73808d1de@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <6d454b8d-04ec-807a-9e08-dc133fee6c5b@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] s390x/css: advertise unrestricted
 cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>



On 12/05/2017 06:28 PM, Shalini Chellathurai Saroja wrote:
>=20
>=20
> On 12/04/2017 04:07 PM, Halil Pasic wrote:
>>
>> On 12/04/2017 12:15 PM, Cornelia Huck wrote:
>>> On Fri,=C2=A0 1 Dec 2017 15:31:35 +0100
>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>>
>>>> Let us advertise the changes introduced by "s390x/css: unrestrict cs=
sids"
>>>> to the management software (so it can tell are cssids unrestricted o=
r
>>>> restricted).
>>>>
>>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>>> ---
>>>>
>>>> Boris says having the property on the virtual-css-bridge is good for=
m
>>>> Libvirt PoV. @Shalini: could you verify that things work out fine
>>>> (provided we get at least a preliminary blessing from Connie).
>>>>
>>>> Consider squashing into "s390x/css: unrestrict cssids".
>>>> ---
>>>> =C2=A0 hw/s390x/css-bridge.c | 11 +++++++++++
>>>> =C2=A0 1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
>>>> index c4a9735d71..c7e8998680 100644
>>>> --- a/hw/s390x/css-bridge.c
>>>> +++ b/hw/s390x/css-bridge.c
>>>> @@ -123,6 +123,11 @@ static Property virtual_css_bridge_properties[]=
 =3D {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_END_OF_LIST(),
>>>> =C2=A0 };
>>>> =C2=A0 +static bool prop_get_true(Object *obj, Error **errp)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 return true;
>>>> +}
>>>> +
>>>> =C2=A0 static void virtual_css_bridge_class_init(ObjectClass *klass,=
 void *data)
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HotplugHandlerClass *hc =3D HOTPLUG_H=
ANDLER_CLASS(klass);
>>>> @@ -131,6 +136,12 @@ static void virtual_css_bridge_class_init(Objec=
tClass *klass, void *data)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hc->unplug =3D ccw_device_unplug;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(DEVICE_CATEGORY_BRIDGE, dc->c=
ategories);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dc->props =3D virtual_css_bridge_prop=
erties;
>>>> +=C2=A0=C2=A0=C2=A0 object_class_property_add_bool(klass, "cssid-unr=
estricted",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prop_get_tru=
e, NULL, NULL);
>>>> +=C2=A0=C2=A0=C2=A0 object_class_property_set_description(klass, "cs=
sid-unrestricted",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
"A css device can use any=C2=A0 cssid, regardless whether virtual"
>>> extra space -----------------------------^
>>>
>> Nod.
>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
" or not (read only, always true)",
>> Do we need "." here ----------------------------^ ?
>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
NULL);
>>>> =C2=A0 }
>>>> =C2=A0 =C2=A0 static const TypeInfo virtual_css_bridge_info =3D {
>>> Looks reasonable. If this works as expected, I'll squash it into the
>>> previous patch.
>>>
>> I've just asked Shalini to verify the libvirt perspective.
>=20
> Verified. The patch works as expected.
>=20

Many thanks! I intend to address the remaining issues of the series and
spin a v2 today.

Halil

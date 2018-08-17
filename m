Received: from eggs.gnu.org ([2001:4830:134:3::10]:34099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqbhI-00009d-UR
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqbWJ-0006hP-R5
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 05:58:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46612 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fqbWI-0006dL-IR
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 05:58:14 -0400
References: <1534491213-24748-1-git-send-email-thuth@redhat.com>
	<20180817094819.GE11124@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <adc83475-3772-ca87-8498-3b5df1ddf046@redhat.com>
Date: Fri, 17 Aug 2018 11:58:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180817094819.GE11124@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] qom: Rename object_new_with_props to
 object_new_child
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 08/17/2018 11:48 AM, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Aug 17, 2018 at 09:33:33AM +0200, Thomas Huth wrote:
>> While adding the object_initialize_child() function, Paolo suggested
>> to rename the similar object_new_with_props() function accordingly:
>>
>> http://marc.info/?i=3De034610d-9a1d-a8a5-ee92-b2e3f0ba2891@redhat.com
>>
>> This way it is more obvious that this function creates a new object
>> as a child of another object.
>=20
> I'd expect 'object_new_with_child' to be the same as 'object_new',
> but with only 'parent' & 'id' args added, which isn't the case here.
>=20
> If we want the full & consistent design then we should have
>=20
>   object_new(typename)
>   object_new_with_child(typename, parent, id)
>   object_new_props(typename, ...)
>   object_new_propv(typename, va_arg props)
>   object_new_with_child_props(typename, parent, id, ...)
>   object_new_with_child_propv(typename, parent, id, va_arg props)

"new_with_child" sounds wrong, too, since the parent is not created
here, but the child. Anyway, I guess the naming of these functions is
too much subject to bikeshedding, so never mind, let's keep it as it
currently is.

 Thomas

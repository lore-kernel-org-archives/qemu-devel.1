Received: from eggs.gnu.org ([2001:4830:134:3::10]:46770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duyox-0001cS-Pl
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 06:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duyot-0001Du-QQ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 06:35:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duyot-0001BS-KK
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 06:34:59 -0400
References: <20170920145025.19403-1-david@redhat.com>
	<1505976596.7353.0.camel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <059a4497-affa-23b7-2875-42efa82c65de@redhat.com>
Date: Thu, 21 Sep 2017 12:34:50 +0200
MIME-Version: 1.0
In-Reply-To: <1505976596.7353.0.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] kvm: drop wrong assertion creating
 problems with pflash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, kvm@vger.kernel.org

On 21/09/2017 08:49, Gerd Hoffmann wrote:
> On Wed, 2017-09-20 at 16:50 +0200, David Hildenbrand wrote:
>> pflash toggles mr->romd_mode. So this assert does not always hold.
>>
>> 1) a device was added with !mr->romd_mode, therefore effectively not
>> =C2=A0=C2=A0=C2=A0creating a kvm slot as we want to trap every access =
(add =3D false).
>> 2) mr->romd_mode was toggled on before remove it. There is now
>> =C2=A0=C2=A0=C2=A0actually no slot to remove and the asser is wrong.
>>
>> So let's just drop the assert.
>=20
> Works without any obvious bad side effects.
>=20
> Tested-by: Gerd Hoffmann <kraxel@redhat.com>

Queued, thanks.

Paolo

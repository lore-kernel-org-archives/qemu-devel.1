Received: from eggs.gnu.org ([2001:4830:134:3::10]:35706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNPdj-0000p1-Pc
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 16:57:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNPdY-0005ih-0V
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 16:57:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gNPdX-0005iL-Py
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 16:57:19 -0500
References: <20181115140501.7872-1-david@redhat.com>
	<20181115140501.7872-2-david@redhat.com>
	<5e2769ed-f017-d684-da9e-115d31c3189b@redhat.com>
	<874lcicntp.fsf@dusky.pond.sub.org>
	<2464ddd5-24b3-396b-7ea7-c3e9cf36ffc9@redhat.com>
	<b47def2f-4c4c-4639-3337-3005a0548b94@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c62aa9cf-6998-63ec-659b-7545872a9d77@redhat.com>
Date: Thu, 15 Nov 2018 22:57:15 +0100
MIME-Version: 1.0
In-Reply-To: <b47def2f-4c4c-4639-3337-3005a0548b94@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/9] cutils: add qemu_strtod() and
 qemu_strtod_finite()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 15.11.18 19:02, Eric Blake wrote:
> If the conversion underflows, store =C2=B10.0 in @result, depending on =
the=20
> sign, and return -ERANGE.

Will do! Thanks!

--=20

Thanks,

David / dhildenb

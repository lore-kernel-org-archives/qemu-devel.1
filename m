Received: from eggs.gnu.org ([2001:4830:134:3::10]:32959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1cjVDA-000264-1T
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:12:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1cjVD6-0005uk-SG
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:12:20 -0500
Received: from mail-by2nam03on0104.outbound.protection.outlook.com
	([104.47.42.104]:64858
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1cjVD6-0005su-E1
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:12:16 -0500
From: Felipe Franciosi <felipe@nutanix.com>
Date: Thu, 2 Mar 2017 18:12:13 +0000
Message-ID: <335E580F-96E0-4C75-9F5D-220ED9193D6A@nutanix.com>
References: <1488472983-9108-1-git-send-email-felipe@nutanix.com>
	<148847375468.285.999031041241417996@0e2666bad730>
	<F9FA9F92-B44C-401D-A892-D73D36777B47@nutanix.com>
	<20170302171721.GG11445@redhat.com>
	<3FB730F1-6067-4FD4-8D3F-19C648472B1B@nutanix.com>
	<20170302173214.GH11445@redhat.com>
	<76385409-F13F-41AE-8BA4-18AA3406E58F@nutanix.com>
	<5a788026-eae6-f7f9-badf-3c235d8d49f2@redhat.com>
In-Reply-To: <5a788026-eae6-f7f9-badf-3c235d8d49f2@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A3196E4777BA164EAD65B7F54D668BC1@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 0/3] Introduce vhost-user-scsi and
 sample application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com" <stefanha@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>


> On 2 Mar 2017, at 18:08, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
>=20
>=20
> On 02/03/2017 18:39, Felipe Franciosi wrote:
>>> Yeah, it wasn't previously noticed since these files weren't compiled
>>> by default. Since you've added make rules to enable build, I'm afraid
>>> you've got the unfortunate job of cleaning up pre-existing build
>>> problems. I'd suggest just doing the conversion to g_strdup_vprintf()
>>> in the first patch your series.
>>=20
>> That's ok. I'll wait to see if Paolo has any other comments on v4 and th=
en I'll send a v5 which includes this change.
>=20
> Just a note that this has missed 2.9 now, so I'll look at it but not
> right now. :(
>=20

Oh dang. I thought I still had a few days in March to get this sorted. :(
Been super busy so couldn't send it before. Sorry for that.

Appreciate you looking when you have the chance. :)

Maybe I'll just send a v5 now with the extra patch to fix the build with li=
bvhost-user.

Felipe


> Paolo

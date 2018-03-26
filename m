Received: from eggs.gnu.org ([2001:4830:134:3::10]:37667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0Y1k-0006vt-Jh
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:43:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0Y1j-0006om-Jf
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:43:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47806 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0Y1j-0006o1-Fo
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:43:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0EAFFBD95
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 19:43:31 +0000 (UTC)
References: <20180326063901.27425-1-peterx@redhat.com>
	<20180326063901.27425-5-peterx@redhat.com>
	<CAMxuvaxd8__zgt4RKATHmpv4QL19K=DtLdAtS1C4omobSU_TsQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a226ddba-e7bb-c8c5-2929-4db6e9ad53a5@redhat.com>
Date: Mon, 26 Mar 2018 14:43:22 -0500
MIME-Version: 1.0
In-Reply-To: <CAMxuvaxd8__zgt4RKATHmpv4QL19K=DtLdAtS1C4omobSU_TsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 4/8] qapi: restrict allow-oob
 value to be "true"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 03/26/2018 04:11 AM, Marc-Andr=C3=A9 Lureau wrote:
> On Mon, Mar 26, 2018 at 8:38 AM, Peter Xu <peterx@redhat.com> wrote:
>> It was missed in the first version of OOB series.  We should check thi=
s
>> to make sure we throw the right error when fault value is passed in.
>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>=20
> Not exactly required imho, but why not:
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Not technically required, but does add some consistency to the QAPI parse=
r.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

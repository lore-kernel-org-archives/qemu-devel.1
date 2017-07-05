Received: from eggs.gnu.org ([2001:4830:134:3::10]:40786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSkbC-0003LY-Dd
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSkb6-0006ue-Bn
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:44:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dSkb6-0006uM-5W
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 09:44:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0EFCC7CE09
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 13:44:03 +0000 (UTC)
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-5-marcandre.lureau@redhat.com>
	<f00c4251-ad8d-475b-5c3c-653835791552@redhat.com>
	<1631360003.47097808.1499261940413.JavaMail.zimbra@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e97a39e4-b1d0-4e35-4dec-f338722a7695@redhat.com>
Date: Wed, 5 Jul 2017 15:43:56 +0200
MIME-Version: 1.0
In-Reply-To: <1631360003.47097808.1499261940413.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/35] coroutine: remove coroutine_fn from
 qemu_coroutine_self()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 05/07/2017 15:39, Marc-Andr=C3=A9 Lureau wrote:
>>> The function may be safely called from non-coroutine context.
>>>=20
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> It can, but it shouldn't...  What are the callers?
>
> There is aio_co_enter() & qemu_aio_coroutine_enter() that call it
> without coroutine context, but they are probably safe and can be
> manually tagged as coroutine-section.

Yes, they are.  One is under qemu_in_coroutine (patch 2), the other is
part of the runtime (patch 1 maybe).

Awesome work by the way.

Paolo

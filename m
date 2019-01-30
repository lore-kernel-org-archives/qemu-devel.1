Received: from eggs.gnu.org ([209.51.188.92]:58691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gofxb-0002D4-5H
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 21:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gofxV-0007sh-Jn
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 21:50:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gofxU-0007rY-PZ
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 21:50:36 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12E981393FC
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 02:50:34 +0000 (UTC)
Date: Wed, 30 Jan 2019 10:50:26 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190130025026.GA27390@xz-x1>
References: <20190129051432.22023-1-peterx@redhat.com>
	<cd92ce4d-e78f-1ad2-18d0-f50a0343e990@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd92ce4d-e78f-1ad2-18d0-f50a0343e990@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] iothread: fix iothread hang when stop too
 soon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Jan 29, 2019 at 03:44:05PM +0100, Thomas Huth wrote:

[...]

> I ran this on s390x with Luk=C3=A1=C5=A1' reproducer for a while now, a=
nd so far I
> haven't seen any hangs anymore. Thus this seems to fix the issue as far
> as I can see, thanks!
>=20
> Tested-by: Thomas Huth <thuth@redhat.com>

Thanks for the quick follow up, Thomas!

--=20
Peter Xu

Received: from eggs.gnu.org ([2001:4830:134:3::10]:50990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1epE97-0002Ly-GY
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:16:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1epE92-0003Le-FU
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:16:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46664 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1epE92-0003LG-A1
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:16:16 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DEDBA4072467
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 14:16:11 +0000 (UTC)
References: <20180215212552.26997-1-marcandre.lureau@redhat.com>
	<20180215212552.26997-5-marcandre.lureau@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <13ace88e-b813-1992-767b-f7cc76392bb9@redhat.com>
Date: Fri, 23 Feb 2018 15:16:05 +0100
MIME-Version: 1.0
In-Reply-To: <20180215212552.26997-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/6] vhost-user-test: do not hang if
 chardev creation failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com



On 02/15/2018 10:25 PM, Marc-Andr=C3=A9 Lureau wrote:
> Before the chardev name fix, the following error may happen: "attempt
> to add duplicate property 'chr-test' to object (type 'container')",
> due to races.
>=20
> Sadly, error_vprintf() uses g_test_message(), so you have to use
> read the cryptic --debug-log to see it. Later, it would make sense to
> use g_critical() instead, and catch errors with
> g_test_expect_message() (in glib 2.34).
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/vhost-user-test.c | 1 +
>   1 file changed, 1 insertion(+)
Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

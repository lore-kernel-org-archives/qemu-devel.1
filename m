Received: from eggs.gnu.org ([2001:4830:134:3::10]:55260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRiWd-0006JA-0c
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:55:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRiWZ-0002hY-RT
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:55:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gRiWZ-0002hL-K9
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:55:55 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 17D203082133
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 18:55:55 +0000 (UTC)
References: <1543343726-53531-1-git-send-email-pbonzini@redhat.com>
	<CAMxuvawT9NgS6N769gmZ+kzSzefBcp1eYpa_h_OWJ2S12b_O=g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7d95c907-c3da-d992-8133-e4b65a17370c@redhat.com>
Date: Tue, 27 Nov 2018 19:55:51 +0100
MIME-Version: 1.0
In-Reply-To: <CAMxuvawT9NgS6N769gmZ+kzSzefBcp1eYpa_h_OWJ2S12b_O=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] glib-compat: work around g_test_message
 bug with subprocess tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 27/11/18 19:49, Marc-Andr=C3=A9 Lureau wrote:
> good catch! makes me wonder if g_test_message() is supposed to be
> usable in a subprocess.. Let see the review comments on upstream bug.
> At least, documentation should be updated.
>=20
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Considering that GLib goes to great lengths to pass the test log fd as
--GTestFD, it definitely should.  So the alternative is not that that
documentation should be updated, the test log file descriptor should not
be passed.

Paolo

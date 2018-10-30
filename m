Received: from eggs.gnu.org ([2001:4830:134:3::10]:55462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHT1n-00022r-9x
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHT1h-0006AQ-LP
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:21:47 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHT1h-00061J-4i
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:21:41 -0400
Received: by mail-wm1-x342.google.com with SMTP id r63-v6so11554623wma.4
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 05:21:28 -0700 (PDT)
References: <20180209104546.29401-1-pbonzini@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180209104546.29401-1-pbonzini@redhat.com>
Date: Tue, 30 Oct 2018 12:21:25 +0000
Message-ID: <87va5j8w1m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] tcg: fix dirty bitmap race with MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com


Paolo Bonzini <pbonzini@redhat.com> writes:

> This is a race that can happen when migrating TCG guests under load.
> It was introduced by the change to run vCPUs outside the big QEMU
> lock.

Did this ever get re-spun?

--
Alex Benn=C3=A9e

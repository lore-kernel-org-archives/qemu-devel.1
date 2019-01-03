Received: from eggs.gnu.org ([208.118.235.92]:59079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gfCAR-0000QK-Cw
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 18:12:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gfCAK-0003IK-4q
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 18:12:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1gfCAJ-0003HN-VD
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 18:12:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so30612260wmj.1
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 15:12:39 -0800 (PST)
MIME-Version: 1.0
References: <20190103150951.17592-1-philmd@redhat.com>
In-Reply-To: <20190103150951.17592-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 4 Jan 2019 00:12:27 +0100
Message-ID: <CAP+75-W-niBu3OWOM+J+0eATs6cck3mrLw00YjeasiknGhvUKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/2] buildsys: Disable qht-bench
 parallel test when using gprof
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>

On Thu, Jan 3, 2019 at 4:10 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> Disable test-qht-par when using gprof, as this break Travis CI.

Success on Travis CI:
https://travis-ci.org/philmd/qemu/builds/474894411

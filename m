Received: from eggs.gnu.org ([2001:4830:134:3::10]:32781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f9QQB-0007WB-Uz
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f9QQB-0007TG-2f
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:25:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59534 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f9QQA-0007T5-Tr
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:25:26 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180419212727.26095-1-f4bug@amsat.org>
	<20180419212727.26095-5-f4bug@amsat.org>
Date: Fri, 20 Apr 2018 09:25:25 +0200
In-Reply-To: <20180419212727.26095-5-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu,
	19 Apr 2018 18:27:27 -0300")
Message-ID: <87vacm1gre.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/4] qdev: Remove DeviceClass::exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Since no devices use it, we can safely remove it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Markus Armbruster <armbru@redhat.com>

However, I'd reshuffle PATCH 3+4 a bit as explained in my review of
PATCH 3.

Received: from eggs.gnu.org ([2001:4830:134:3::10]:32962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPM6P-000063-5W
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 00:58:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPM6O-0005Zy-9o
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 00:58:21 -0400
Received: from mail-it0-x231.google.com ([2607:f8b0:4001:c0b::231]:37193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPM6O-0005Yc-4n
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 00:58:20 -0400
Received: by mail-it0-x231.google.com with SMTP id m84so17743766ita.0
	for <qemu-devel@nongnu.org>; Sun, 25 Jun 2017 21:58:19 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20170625192950.17677-1-f4bug@amsat.org>
References: <20170625192950.17677-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 26 Jun 2017 01:58:18 -0300
Message-ID: <CAAdtpL6gKuirET7zo2xv=qO+yONgjPcV4jp2tK=LRQ8RruUwLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/4] travis: run all coccinelle scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

> Patch 4 is the travis job: it calls the previous script. To respect travi=
s time
> limit timeout, each script is limited to <10min. If any commit were
> generated, they are pushed to my gh-repo

Initially I wanted to use git format-patch/send-email to send to the
list as a series but it seems too verbose and Travis doesn't seem to
allow to send mails. Another possibility is to send to a S3 bucket or
gh-page. The push-to-repo way involves deploy ssh key but is easier to
manage with regular git commands, I can fetch this repo and
cherry-pick/rework/amend commits.

I also plan to add Marc-Andr=C3=A9 Lureau clang-tidy work:
http://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg05034.html

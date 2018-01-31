Received: from eggs.gnu.org ([2001:4830:134:3::10]:57917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1egiwz-0007oz-Eg
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 22:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1egiwu-0000py-Ll
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 22:20:41 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:35222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1egiwu-0000oH-57
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 22:20:36 -0500
Received: by mail-wr0-f181.google.com with SMTP id w50so13426461wrc.2
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 19:20:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87wp01x87e.fsf@linaro.org>
References: <20180129033133.31288-1-famz@redhat.com>
	<87wp01x87e.fsf@linaro.org>
From: Fam Zheng <famz@redhat.com>
Date: Wed, 31 Jan 2018 11:20:04 +0800
Message-ID: <CAK1Eb9=DgHdVV-ZegENj44pJkos+S_ZrgTSmciSARN6AX9puUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs: Add docs/devel/testing.rst
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, Jan 29, 2018 at 6:36 PM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> Fam Zheng <famz@redhat.com> writes:
>> +Prerequisites
>> +-------------
>> +
>> +Install "docker" with the system package manager and start the Docker s=
ervice
>> +on your development machine, then make sure you have the privilege to r=
un
>> +Docker commands. Typically it means setting up passwordless ``sudo dock=
er``
>> +command or login as root.
>
> The third option (which I run) is using group permissions so you can add
> users to the docker group and make the socket group accessible via the
> daemon.
>
> It should be pointed out that both the sudo and group methods do open up
> your machine to being exploited via docker's ability to bind mount
> stuff. That is to say it's fine for developers on their own machine but
> you might not want to do that on shared servers.

Thanks, Alex, very good I've added that paragraph!

Fam

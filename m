Received: from eggs.gnu.org ([2001:4830:134:3::10]:53911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmgJi-00062q-Nw
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 09:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmgJf-0000LC-Fu
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 09:12:30 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <9c225c3c-e21c-48ad-ac36-e472c6dec84a@amsat.org>
References: <20170829120836.16091-1-berto@igalia.com>
	<9c225c3c-e21c-48ad-ac36-e472c6dec84a@amsat.org>
Date: Tue, 29 Aug 2017 15:12:24 +0200
Message-ID: <w51pobefrgn.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] misc: Remove unused Error variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue 29 Aug 2017 02:31:35 PM CEST, Philippe Mathieu-Daud=C3=A9 wrote:

>> There's a few cases which we're passing an Error pointer to a function
>> only to discard it immediately afterwards without checking it. In
>> these cases we can simply remove the variable and pass NULL instead.
>
> How did you notice?

I noticed it while I was working on something else. It's also not the
first time I see something like this (see e.g. 026ac1586bdbd184e240).

Berto

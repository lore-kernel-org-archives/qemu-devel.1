Received: from eggs.gnu.org ([209.51.188.92]:52583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtc4D-0000rf-8p
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:41:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtc4B-0006CB-4x
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:41:57 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 12 Feb 2019 17:41:39 +0000
Message-ID: <e940cea7-33dd-f6d9-95ac-602b938eca56@virtuozzo.com>
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
	<20190211060457.GK18083@stefanha-x1.localdomain>
In-Reply-To: <20190211060457.GK18083@stefanha-x1.localdomain>
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-ID: <5436472528074947B9132F29653A4BA6@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 00/17] block: local qiov helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>, "fam@euphon.net" <fam@euphon.net>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>

=0A=
=0A=
On 11.02.2019 6:04, Stefan Hajnoczi wrote:=0A=
> On Thu, Feb 07, 2019 at 01:24:28PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:=0A=
>> v3:=0A=
> =0A=
> Will you send a v4 based on Eric's comments or do you want to keep the=0A=
> series as it is?=0A=
> =0A=
=0A=
I don't really want to resend, and I don't think that open-coding in 16 =0A=
is a good practice. With my helper we at least have and assertion. I'd be=
=0A=
grateful if tiny improvements of 01 are applied in-flight. Anyway, I don't=
=0A=
strongly against other Eric's suggestions to be applied, and can resend if=
=0A=
it needed.=0A=

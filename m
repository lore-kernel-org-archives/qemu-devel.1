Received: from eggs.gnu.org ([2001:4830:134:3::10]:59511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXSDZ-0005FT-BP
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:44:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXSDV-0006UF-ID
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:44:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXSDV-0006Ro-5o
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:43:57 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1544666977-4816-1-git-send-email-liq3ea@gmail.com>
	<20181213101940.GC5171@redhat.com>
	<CAFEAcA_rBakXJZuPGgcsvC9m75oeTbg=q-=mOCFJuungF-VR8g@mail.gmail.com>
	<87o99pa9w8.fsf@dusky.pond.sub.org> <20181213123908.GI5171@redhat.com>
Date: Thu, 13 Dec 2018 15:43:51 +0100
In-Reply-To: <20181213123908.GI5171@redhat.com> ("Daniel P. =?utf-8?Q?Berr?=
	=?utf-8?Q?ang=C3=A9=22's?=
	message of "Thu, 13 Dec 2018 12:39:08 +0000")
Message-ID: <87va3xo5aw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] util: check the return value of fcntl in
 qemu_set_{block, noblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

[...]
> Honestly I'd probably prefer these methods to take an "Error **errp"
> and propagate to the caller but that's alot more work.

I'd rather return 0 on success, -errno on failure in these cases.

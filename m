Received: from eggs.gnu.org ([2001:4830:134:3::10]:54523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dwqKJ-0001BE-Ow
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:55:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dwqKI-0000Ln-Vf
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:55:07 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dwqKI-0000LW-RL
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:55:06 -0400
Received: by mail-oi0-x243.google.com with SMTP id z73so6243679oia.0
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 06:55:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506432594.5843.107.camel@intel.com>
References: <1506083624-20621-1-git-send-email-amarnath.valluri@intel.com>
	<1506083624-20621-9-git-send-email-amarnath.valluri@intel.com>
	<CAJ+F1CKrNWcJhpsyxa8ENKfJzaSi=wz5-s+LV06K8o7xUsgdeA@mail.gmail.com>
	<1506427596.5843.104.camel@intel.com>
	<CAJ+F1CK_XRQG3W5A7tST5R1criUO3piohvMXNGyM348fTD7BhQ@mail.gmail.com>
	<1506432594.5843.107.camel@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 26 Sep 2017 15:55:05 +0200
Message-ID: <CAJ+F1CLv6PVPwx7UwSMf74-1RxMbbES3+2jnuN=hyXiSHuEWzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 8/8] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Valluri, Amarnath" <amarnath.valluri@intel.com>
Cc: "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>

Hi

On Tue, Sep 26, 2017 at 3:28 PM, Valluri, Amarnath
<amarnath.valluri@intel.com> wrote:
> On Tue, 2017-09-26 at 14:24 +0200, Marc-Andr=C3=A9 Lureau wrote:
>> > > close fds[1] ?
>> > I guess we are not supposed to close the other end of the
>> > socketpair/pipe, as it is not forked process.
>> You will close this end, not the other end.
> fds[1] is handed over to other end, fds[0] is used by qemu, so we
> cannot close unless error case i guess.

You should be able to close fds[1] in qemu, and keep the communication
working between the two processes. If you don't close, it will leak a
fd in qemu.

--=20
Marc-Andr=C3=A9 Lureau

Received: from eggs.gnu.org ([2001:4830:134:3::10]:58511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eQufY-0005ex-NE
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:37:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eQufU-0007Jz-Qs
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:37:20 -0500
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:38382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eQufU-0007J3-Kt
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:37:16 -0500
Received: by mail-wr0-x22b.google.com with SMTP id o2so13890091wro.5
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 04:37:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218133538.398b77de.cohuck@redhat.com>
References: <20171218121635.25494-1-cohuck@redhat.com>
	<deba612d-e6f0-7181-6328-7eec81f68034@redhat.com>
	<20171218133538.398b77de.cohuck@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 18 Dec 2017 13:37:14 +0100
Message-ID: <CAJ+F1CJpJQZKGRzfXm5PQH8P1WjbjHdN8dF_XxCMo41hnseLjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tpm: add stubs for qdev-prop-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On Mon, Dec 18, 2017 at 1:35 PM, Cornelia Huck <cohuck@redhat.com> wrote:
> On Mon, 18 Dec 2017 13:27:09 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>> On 18/12/2017 13:16, Cornelia Huck wrote:
>> > Building with --disable-tpm yields
>> >
>> > ../hw/core/qdev-properties-system.o: In function `set_tpm':
>> > /home/cohuck/git/qemu/hw/core/qdev-properties-system.c:274: undefined =
reference to `qemu_find_tpm_be'
>> > /home/cohuck/git/qemu/hw/core/qdev-properties-system.c:278: undefined =
reference to `tpm_backend_init'
>> > ../hw/core/qdev-properties-system.o: In function `release_tpm':
>> > /home/cohuck/git/qemu/hw/core/qdev-properties-system.c:291: undefined =
reference to `tpm_backend_reset'
>> >
>> > Add some proper stubs for those functions.
>> >
>> > Fixes: 493b78303532 ("qdev: add DEFINE_PROP_TPMBE")
>> > Reported-by: Thomas Huth <thuth@redhat.com>
>> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>
>> Maybe all the new code can be moved from qdev-properties-system.c to
>> hw/tpm/qdev.c instead?  (Adding stubs should be the last resort,
>> especially if the stubs are never used outside system emulation).
>
> Probably hw/tpm/tpm-tis.c?

Rather hw/tpm/tpm_util.c (the PROP is going to be shared by various
devices soon)

thanks



--=20
Marc-Andr=C3=A9 Lureau

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewqBy-0008HX-MH
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewqBv-0006Lt-IS
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:18:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42102 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ewqBv-0006LP-Ds
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:18:43 -0400
Date: Fri, 16 Mar 2018 14:18:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180316141830.GL3066@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA-6vww4nUWmq1je1xq1HsAcQ08+AD_kccOCPjLTQjG7xw@mail.gmail.com>
	<CAFEAcA_M5rD_mrkEPwyyaNah=YJvn8QSKiWs6ExKVynB0Whc-Q@mail.gmail.com>
	<20180316132754.GJ3066@redhat.com>
	<CAJ+F1CJZ8s9yL1LrsJkyoGKkaP61WJjUWsNetyt4SNsN6moytw@mail.gmail.com>
	<CAJ+F1CK+hHVXQ2EVKvVjrEkAJ0aTkzvagVuOX7Tq_3CQaZGjqg@mail.gmail.com>
	<e971a441-2118-e07a-ee77-56758ccf41af@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e971a441-2118-e07a-ee77-56758ccf41af@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] tpm-tis-test and tpm-crb-test crash on OSX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Mar 16, 2018 at 09:45:59AM -0400, Stefan Berger wrote:
> On 03/16/2018 09:41 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >=20
> > On Fri, Mar 16, 2018 at 2:37 PM, Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@gmail.com> wrote:
> > > Hi
> > >=20
> > > On Fri, Mar 16, 2018 at 2:27 PM, Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
> > > > At least the tpm_emu_tpm_thread() there is only something in the =
test
> > > > suite, so the real system emulator code isn't at risk of crashing=
.
> > > >=20
> > > > Feels like the thread simply should *not* use error_abort, and in=
stead
> > > > have a more graceful way to exit when the socket closes
> > > >=20
> > > The code expects the read() to return 0 on disconnect, not an error=
.
> > > Apparently this works on !osx. Should we adapt qio-channel-socket t=
o
> > > return 0 in this case on osx too?
> > Oh I see, it calls close() on the same end, that's not correct. I
> > wonder if shutdown would be better. Other suggestions?
> >=20
> We could send the thread a special message, like 0xff ff ff ff, and tha=
t
> terminates it...

If there's no resource cleanup in this test suite thread to worry about
could just  pthread_cancel() it

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ossman@cendio.se>) id 1cGnHP-0008IN-7e
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:38:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ossman@cendio.se>) id 1cGnHO-0004nD-Ao
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:38:03 -0500
Received: from lists.cendio.se ([2a00:801:107:f000::b]:45606
	helo=mail.cendio.se)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ossman@cendio.se>) id 1cGnHO-0004ms-46
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:38:02 -0500
References: <f460049b-211e-194b-d4c3-a3cc34e4d289@cendio.se>
	<1481616362.27088.74.camel@redhat.com>
	<7ba29954-e3ad-529c-9978-b10d2788f9e4@cendio.se>
	<20161213131553.GJ28416@redhat.com>
From: Pierre Ossman <ossman@cendio.se>
Message-ID: <d397d4f9-acc3-f60f-e849-67fb668975c0@cendio.se>
Date: Tue, 13 Dec 2016 14:37:59 +0100
MIME-Version: 1.0
In-Reply-To: <20161213131553.GJ28416@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] VNC LED state buggy, interop issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 13/12/16 14:15, Daniel P. Berrange wrote:
>>
>> Btw, is there any client that implements this extension yet? I couldn'=
t find
>> anything.
>
> gtk-vnc implements the LED state extension.
>

Not enough to actually do anything useful AFAICT. That would be up to=20
the application using gtk-vnc. And I couldn't see Vinagre using this=20
feature. Any other frontend I should look at?

> IIRC, there have been bug reports about it being mostly useless with
> QEMU, since it only reflects LED changes initiated by the guest,
> and not those initiated by virtual key presses sent by GTK-VNC.

That sounds like this bug. It does respect the virtual keys sent, just=20
that it doesn't inform the client properly. So my patch should help.

Regards
--=20
Pierre Ossman           Software Development
Cendio AB		http://cendio.com
Teknikringen 8		http://twitter.com/ThinLinc
583 30 Link=C3=B6ping	http://facebook.com/ThinLinc
Phone: +46-13-214600	http://plus.google.com/+CendioThinLinc

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

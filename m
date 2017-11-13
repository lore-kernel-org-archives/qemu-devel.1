Received: from eggs.gnu.org ([2001:4830:134:3::10]:41063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eEGX3-0003fj-UW
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eEGX3-0008VY-03
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:20:17 -0500
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:54576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eEGX2-0008Uo-RO
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:20:16 -0500
Received: by mail-ua0-x241.google.com with SMTP id j14so11605025uag.11
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 07:20:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171113145041.GI18828@redhat.com>
References: <03123F70-98FA-439A-868C-855E63916259@gmail.com>
	<20171113145041.GI18828@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 13 Nov 2017 16:20:15 +0100
Message-ID: <CAJ+F1CLxYBq7zfzMSrhnxb+9Np7ZDnrbLqf+e=FoZyC=bZFA+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Command-line option to change ungrab key(s)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Programmingkid <programmingkidx@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi

On Mon, Nov 13, 2017 at 3:50 PM, Daniel P. Berrange <berrange@redhat.com> w=
rote:
> On Mon, Nov 13, 2017 at 09:29:25AM -0500, Programmingkid wrote:
>> Would you accept a patch that allows the user to change the mouse ungrab=
 key(s) in QEMU?
>>
>> It would look something like this:
>>
>> -ungrab <key>
>>
>> or
>>
>> -ungrab <key>,<key>,...
>>
>> If the user wanted the F19 key to be the ungrab key, this is what would =
be sent to QEMU:
>>
>> -ungrab F19
>>
>> If the user wanted F16 and F17 held down to ungrab the mouse, this is wh=
at would be sent to QEMU:
>>
>> -ungrab F16,F17
>>
>>
>> Would this feature be something you would consider adding to QEMU?
>
> As context, virt-manager allows customization for the ungrab sequence, an=
d
> so do spice-gtk/gtk-vnc at the API level. So conceptually I think it is
> reasonable for any UI console that is intended as more than just a toy.

Would it make sense to share the virt-viewer/remote-viewer --hotkeys
option format ? (see man remote-viewer / virt-viewer)



--=20
Marc-Andr=C3=A9 Lureau

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbPh2-0001aU-PC
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbPh1-000717-Uc
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:18:32 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:39112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fbPh1-000712-PZ
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:18:31 -0400
Received: by mail-oi0-x243.google.com with SMTP id d189-v6so23056499oib.6
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 05:18:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8XWcJfjgeNRg4j7yMwPx2fNmjxL3qEgnkX8qJrUHQb5g@mail.gmail.com>
References: <20180312091405.19610-1-kraxel@redhat.com>
	<20180312091405.19610-14-kraxel@redhat.com>
	<CAFEAcA8XWcJfjgeNRg4j7yMwPx2fNmjxL3qEgnkX8qJrUHQb5g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jul 2018 12:54:05 +0100
Message-ID: <CAFEAcA_N0vUgGJTvDyh+aL=R4j7ozNqgJgAtHtH_Oj0tkZazuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 13/14] spice: add cursor_dmabuf support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 27 April 2018 at 14:16, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 12 March 2018 at 09:14, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> Add support for cursor dmabufs.  qemu has to render the cursor for
>> that, so in case a cursor is present qemu allocates a new dmabuf, blits
>> the scanout, blends in the pointer and passes on the new dmabuf to
>> spice-server.  Without cursor qemu continues to simply pass on the
>> scanout dmabuf as-is.
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Message-id: 20180308090618.30147-4-kraxel@redhat.com
>> +static void qemu_spice_gl_cursor_position(DisplayChangeListener *dcl,
>> +                                          uint32_t pos_x, uint32_t pos_=
y)
>> +{
>> +    SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, d=
cl);
>> +
>> +    ssd->ptr_x =3D pos_x;
>> +    ssd->ptr_y =3D pos_y;
>
> Is it safe to write to these fields of ssd without holding
> ssd->lock ? Coverity thinks it might not be (CID 1390631) because
> we do take the lock to update them in display_mouse_set().

Ping for opinions on this coverity issue?

thanks
-- PMM

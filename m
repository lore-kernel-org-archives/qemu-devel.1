Received: from eggs.gnu.org ([2001:4830:134:3::10]:34684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e2e40-0006Nz-76
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:02:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1e2e3w-0001PZ-BQ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:02:16 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:56887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1e2e3w-0001PR-5y
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:02:12 -0400
Received: by mail-oi0-x230.google.com with SMTP id v9so8635339oif.13
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 07:02:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507814955.24675.1.camel@redhat.com>
References: <20171012112157.15647-1-marcandre.lureau@redhat.com>
	<1507814955.24675.1.camel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 12 Oct 2017 16:02:10 +0200
Message-ID: <CAJ+F1CKjV_bNcT7n9bK+CYbd+si7VzW=Bcv8cQ2MuvWgrPuRVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] usb-ccid: remove needless migration state
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Thu, Oct 12, 2017 at 3:29 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Thu, 2017-10-12 at 13:21 +0200, Marc-Andr=C3=A9 Lureau wrote:
>> This code appears to be unused since its introduction. It should be
>> safe to remove from VMState.
>
> Well, almost:
>
>> @@ -1452,7 +1431,6 @@ static VMStateDescription ccid_vmstate =3D {
>>          VMSTATE_STRUCT_ARRAY(pending_answers, USBCCIDState,
>>                          PENDING_ANSWERS_NUM, 1, answer_vmstate,
>> Answer),
>>          VMSTATE_UINT32(pending_answers_num, USBCCIDState),
>> -        VMSTATE_UINT8(migration_state, USBCCIDState),
>>          VMSTATE_UINT32(state_vmstate, USBCCIDState),
>>          VMSTATE_END_OF_LIST()
>>      }
>
> We have to keep this (or some placeholder) so the vmstate format
> doesn't change.

I did a simple migration test from a state file with the field to a
state file without, and the other way around and it seemed to work. I
probably screwed up the test.

Looking at vmstate code, it obviously changes the wire format. So
let's keep the field. (I was wondering how/if the vmdesc was able to
match field names/version, probably not)

I was looking for some documentation regarding VMState versionning, it
doesn't seem to be documented when you need to bump version, and how
to do it (struct vs version fields, compatibility with older version
etc).

I'll send v2
thanks


--=20
Marc-Andr=C3=A9 Lureau

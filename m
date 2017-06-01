Received: from eggs.gnu.org ([2001:4830:134:3::10]:43044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1dGRMs-0002ib-NX
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:46:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1dGRMr-00013H-P9
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:46:30 -0400
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:35084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1dGRMr-00012r-JG
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:46:29 -0400
Received: by mail-oi0-x234.google.com with SMTP id l18so56549368oig.2
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 07:46:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Ben Warren <ben@skyportsystems.com>
In-Reply-To: <20170601172020-mutt-send-email-mst@kernel.org>
Date: Thu, 1 Jun 2017 07:46:24 -0700
Content-Transfer-Encoding: quoted-printable
Message-Id: <A14BEB28-9F8C-4E37-BCB1-EC7ED7FFB8E6@skyportsystems.com>
References: <20170529151047.85390-1-ben@skyportsystems.com>
	<CAJ+F1C+QFS5YDw7He-p0eEObYbGcq6ra3wwVMVdEu88C0tRqQQ@mail.gmail.com>
	<20170601172020-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH] tests: Add unit tests for the VM
 Generation ID feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>, qemu devel list <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>


> On Jun 1, 2017, at 7:21 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Thu, Jun 01, 2017 at 08:10:27AM +0000, Marc-Andr=C3=A9 Lureau =
wrote:
>> Hi
>>=20
>> On Mon, May 29, 2017 at 7:18 PM Ben Warren via Qemu-devel <
>> qemu-devel@nongnu.org> wrote:
>>=20
>>    From: Ben Warren <ben@skyportsystems.com>
>>=20
>>    The following tests are implemented:
>>    * test that a GUID passed in by command line is propagated to the =
guest.
>>      Read the GUID from guest memory
>>    * test that the "auto" argument to the GUID generates a valid =
GUID, as
>>      seen by the guest.
>>    * test that a GUID passed in can be queried from the monitor
>>=20
>>      This patch is loosely based on a previous patch from:
>>      Gal Hammer <ghammer@redhat.com>  and Igor Mammedov =
<imammedo@redhat.com>
>>=20
>>    Signed-off-by: Ben Warren <ben@skyportsystems.com>
>>    Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>>    ---
>=20
> What happened to indentation here?
>=20
I don=E2=80=99t know, this is unchanged from the patch that passed =
through the gauntlet earlier this year, other than rebasing.  If you can =
please clarify exactly what you see that is wrong, that=E2=80=99ll be =
helpful.

>>    +             * in order to implement the "OVMF SDT Header probe
>>    suppressor"
>>    +             * see docs/specs/vmgenid.txt for more details
>>    +             */
>>    +            return vgid_table.vgia_val + VMGENID_GUID_OFFSET;
>>    +        }
>>=20
>>=20
>> It leaks tables
>> =20
>> Other than that:
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Ben, are you going to post a version that doesn't leak?
Yes, I=E2=80=99ll try to get to it today.

=E2=80=94Ben

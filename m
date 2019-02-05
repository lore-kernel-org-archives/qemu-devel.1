Received: from eggs.gnu.org ([209.51.188.92]:35865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gqzsF-000469-Me
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 07:30:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gqzsD-0001Bb-Sw
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 07:30:47 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190204211204.27321-1-philmd@redhat.com>
	<20190204211204.27321-4-philmd@redhat.com>
	<87a7jaag7q.fsf@dusky.pond.sub.org>
	<CAFEAcA8-YDTnszv7Mk+F+OAxGJSmdu4yEio1j-E477HNbh-SOQ@mail.gmail.com>
	<20190205110417.GF20321@redhat.com>
Date: Tue, 05 Feb 2019 13:30:16 +0100
In-Reply-To: <20190205110417.GF20321@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Tue, 5 Feb 2019 11:04:17 +0000")
Message-ID: <87bm3qto2v.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] util/cutils: Move function
 documentations to the header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefano Garzarella <sgarzare@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Feb 05, 2019 at 10:56:51AM +0000, Peter Maydell wrote:
>> On Tue, 5 Feb 2019 at 06:44, Markus Armbruster <armbru@redhat.com> wrote:
>> > There are two justifiable function comment placement styles: (1) next =
to
>> > definition, and (2) next to declaration if it's in a header, else next
>> > to definition.
>> >
>> > The rationale for the latter is having the headers do double-duty as
>> > interface documentation.
>> >
>> > The rationale for the former is consistently placing the function
>> > comments close to the code gives them a fighting chance to actually
>> > match the code.
>> >
>> > I'm in the "next to definition" camp.  If you want concise interface
>> > specification, use something like Sphinx.
>>=20
>> I'm in the "next to declaration" camp. I don't want to have
>> to wade into your implementation to find out what it does:
>> document it for me in the interface, please.
>
> I'm already looking at the header file to identify the function signature,
> having the explanation / docs at the same place is desirable, especially
> when the C file name is completely different from the header file name
> forcing me to go grepping the code base to find where it is implemented.

If going to a definition of takes you more than a few keystrokes, your
editor is grossly deficient.

> The .c files are already volumous in size so not amenable to browsing
> for the purpose of reading the docs.
>
> Regards,
> Daniel

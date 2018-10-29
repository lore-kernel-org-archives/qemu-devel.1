Received: from eggs.gnu.org ([2001:4830:134:3::10]:39568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gH34J-0000sB-6t
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 04:38:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gH34G-0001zc-0Y
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 04:38:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gH34F-0001wn-QK
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 04:38:35 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1535704738-8986-1-git-send-email-thuth@redhat.com>
	<1535704738-8986-9-git-send-email-thuth@redhat.com>
	<87efeerbcu.fsf@dusky.pond.sub.org>
	<593af39a-cc9b-d4e8-7e6c-efdbbe169096@redhat.com>
	<CAJ+F1CLX15g+QOCyjaBHJN1n0oLtQCH390RivRQkTcyptWf+cw@mail.gmail.com>
	<5b4cef8c-084c-5a2b-1fb6-210388054d38@redhat.com>
	<87va7qli3f.fsf@dusky.pond.sub.org>
	<87y3b7rs2b.fsf@dusky.pond.sub.org>
	<CAJ+F1CJfan6r47fG8PpvT+xh1UZa+z=LBchyJ6zML_8AZ=uxVg@mail.gmail.com>
Date: Mon, 29 Oct 2018 09:38:29 +0100
In-Reply-To: <CAJ+F1CJfan6r47fG8PpvT+xh1UZa+z=LBchyJ6zML_8AZ=uxVg@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 29 Oct 2018
	10:49:03 +0400")
Message-ID: <87tvl5qha2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 8/9] tests: add qmp/qom-set-without-value
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Tue, Oct 9, 2018 at 8:41 PM Markus Armbruster <armbru@redhat.com> wrot=
e:
>>
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>> > Thomas Huth <thuth@redhat.com> writes:
>> >
>> >> On 2018-08-31 15:24, Marc-Andr=C3=A9 Lureau wrote:
[...]
>> >>> Tbh, I don't care so much about the naming of the test, but (for onc=
e)
>> >>> I respectfully don't think Markus suggestion is better.
>> >>>
>> >>> The function checks "qom-set" without 'value' argument:
>> >>> "qom-set-without-value", no brainer..
>> >
>> > Nope, that's not what it tests.  It tests the visitor, the marshalling
>> > code generator, and the QMP core handle a certain kind of invalid
>> > arguments correctly.  It does not test qom-set.  I explained all that
>> > already.
>> >
>> >>> Naming it "invalid-arg" is so generic that I wouldn't be able what i=
t does.
>> >
>> > I can accept "missing-any" or "missing-any-arg".  I object to any name
>> > involving qom-set, because the test is not about qom-set at all.
>> >
>> > If it was, then putting it in qmp-test.c would be wrong.
>> >
>> >> Ok, then let's keep it this way. As I said, IMHO the current naming is
>> >> not really bad, and I also don't have any suggestions for a perfect n=
ame
>> >> right now.
>> >
>> > We don't need a perfect name.  We need one that's not actively
>> > misleading.
>>
>> Marc-Andr=C3=A9, would "qmp/missing-any-arg" and test_missing_any_arg() =
work
>> for you?
>
> Yes, do you want me to update the patch?

Yes, please.

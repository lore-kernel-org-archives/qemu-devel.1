Received: from eggs.gnu.org ([2001:4830:134:3::10]:33616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fwnxk-0007r6-CR
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fwnxf-0001ir-LM
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:28:11 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:39184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1fwnxf-0001iX-ET
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:28:07 -0400
Received: by mail-ed1-x541.google.com with SMTP id h4-v6so656186edi.6
	for <qemu-devel@nongnu.org>; Mon, 03 Sep 2018 05:28:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8HATZQqawAX3=OPmas6uzp0UAciK7QXo=uuRbCfvUjaQ@mail.gmail.com>
References: <20180830142708.14311-1-sameeh@daynix.com>
	<20180830142708.14311-2-sameeh@daynix.com>
	<20180903115926.GB14377@redhat.com>
	<CAFEAcA8HATZQqawAX3=OPmas6uzp0UAciK7QXo=uuRbCfvUjaQ@mail.gmail.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Mon, 3 Sep 2018 15:28:05 +0300
Message-ID: <CAKPgXcEdD9uJVYK8rFLEs_g1=+tNW_LiSy9p4wySkhsnC_rZCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 1/6] Add bpf support to qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Sep 3, 2018 at 3:24 PM, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> On 3 September 2018 at 12:59, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
>>>  ##########################################
>>> +# check for usable bpf system call
>>> +if test "$bpf" =3D "yes"; then
>>
>> if test "x$bpf" !=3D "xno"; then
>
> We don't use the leading-x thingy elsewhere in configure,
> why is this condition special?
> (We can assume we don't have a broken shell, and we
> know that $bpf won't be a string starting with a hyphen.)
That's what Daniel suggested and I though it should be good for the
reasons above. You have good points as well. Both approaches are okay
with me :)
>
> thanks
> -- PMM



--=20
Respectfully,
Sameeh Jubran
Linkedin
Software Engineer @ Daynix.

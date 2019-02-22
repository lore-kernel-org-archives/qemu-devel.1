Received: from eggs.gnu.org ([209.51.188.92]:53983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <davidkiarie4@gmail.com>) id 1gxCqw-0004wS-Jf
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <davidkiarie4@gmail.com>) id 1gxCqv-0006bZ-OL
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:35:06 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:44881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <davidkiarie4@gmail.com>)
	id 1gxCqv-0006Ba-DK
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:35:05 -0500
Received: by mail-ot1-x334.google.com with SMTP id g1so2155790otj.11
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 07:34:52 -0800 (PST)
MIME-Version: 1.0
References: <CACQB2UxS6a2LbnOsdLt6q1=9xN4NoGBQNwVNZe-vGQjWdus_KQ@mail.gmail.com>
	<CABdVeAAvoXr5oG+G8NYJDiNO4Tdgu2QNhR4dVzd_wZ=W2GhgPg@mail.gmail.com>
	<20190218082217.GA9040@xz-x1>
	<CABdVeAB9Z=rnZVEoj3zFLW7R15yhXfsDxruA640OhkuyN2TDjw@mail.gmail.com>
In-Reply-To: <CABdVeAB9Z=rnZVEoj3zFLW7R15yhXfsDxruA640OhkuyN2TDjw@mail.gmail.com>
From: David Kiarie <davidkiarie4@gmail.com>
Date: Fri, 22 Feb 2019 18:34:08 +0300
Message-ID: <CABdVeAB4g9A26F+nFaMru+x0-Es=Aa6Cjc2djvu28K5=nP_y9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Fwd: QEMU: AMD IOMMU implementation bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Alexandro_S=C3=A1nchez_Bach?= <alexaltea123@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>, QEMU Developers <qemu-devel@nongnu.org>, Valentine Sinitsyn <valentine.sinitsyn@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, rkrcmar@redhat.com

On Mon, Feb 18, 2019 at 9:59 PM David Kiarie <davidkiarie4@gmail.com> wrote:

>
>
>> >
>> > 3. And this might be something specific to my AMD IOMMU (1022:1437,
>> Family
>> > 16h), but the PS4 OS is checks the entire word stored in these registers
>> > and computes the expression as:
>> > config[AMDVI_CAPAB_BAR_LOW] | cap[AMDVI_CAPAB_BAR_HIGH] << 32
>> > So just storing half words should be wrong.
>> >
>>
>
> also,  as much as try, i cannot exactly figure out what you're talking
> about here and i'm under the impression i could not be the only person.
>
> would you mind elaborating? :-)
>

i can't express how grateful i am about your report.

having being the author of the culprit code, it's a fair bit of
irresponsibility on my side for me to leave issue unresolved, though it
does look easy to fix. it was probably not as easy to "dig" out the bugs.

on the other hand, Mr Alexandro, it does look like Peter(who most probably
still actively works on the Qemu IOMMUs, both Intel and AMD)will be
positively considering any IOMMU issues from you in the future.

4 days has been a wait long enough and i had better be out.

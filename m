Received: from eggs.gnu.org ([2001:4830:134:3::10]:49003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wlfightup@gmail.com>) id 1e9rkJ-0004vm-77
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 08:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wlfightup@gmail.com>) id 1e9rkF-0001Em-9u
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 08:03:47 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:53053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wlfightup@gmail.com>) id 1e9rkF-0001EW-4Q
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 08:03:43 -0400
Received: by mail-oi0-x230.google.com with SMTP id c202so3148374oih.9
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 05:03:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADak6y485_OSHrzji4Wq7_3vOrK+ch6Vm1FW1RMidSzoO3U-kQ@mail.gmail.com>
References: <CADak6y5eSo9=C2FJx+cTdqxArWeQqNDAvVgY+vS7H-9yGeuZvw@mail.gmail.com>
	<20171101094537.GA2786@work-vm>
	<CADak6y485_OSHrzji4Wq7_3vOrK+ch6Vm1FW1RMidSzoO3U-kQ@mail.gmail.com>
From: Paul Schlacter <wlfightup@gmail.com>
Date: Wed, 1 Nov 2017 20:03:41 +0800
Message-ID: <CADak6y5mfPnDfQbQSBjY-iGXsFEAmRX6cd=Cv-z-kD5VArKA9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] qemu disk use writeback don't take effect in
 centos 7.2 1511
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

Hi David:
     yes, with the same qemu,  centos 7.2 guest cache is writeback and
none, the disk io almost, writeback feeling no effect.
      but 7.1/7.3/7.4  cache is writeback was significantly faster than
none model

On Wed, Nov 1, 2017 at 8:02 PM, Paul Schlacter <wlfightup@gmail.com> wrote:

> Hi David:
>      yes, with the same qemu,  centos 7.2 guest cache is writeback and
> none, the disk io almost, writeback feeling no effect.
>       but 7.1/7.3/7.4  cache is writeback was significantly faster than
> none model
>
> On Wed, Nov 1, 2017 at 5:45 PM, Dr. David Alan Gilbert <
> dgilbert@redhat.com> wrote:
>
>> * Paul Schlacter (wlfightup@gmail.com) wrote:
>> > qemu version:  2.9.0
>> > image: centos 7.2 1511 raw
>> > cache mode: writeback
>> >
>> >
>> > In centos7.2 time, the use of writeback and none, the result of dd disk
>> is
>> > the same io, no change
>> >
>> > But I replaced centos7.1 centos7.3 centos7.4 when writeback was
>> > significantly faster than none
>> >
>> > Would like to ask what is going on, how to solve ?
>>
>> Hi Paul,
>>   Can you just clarify your setup please;  do you mean that
>> with the same qemu setup but a 7.2 guest rather than a 7.1/7.3 guest
>> the behaviour changes?
>>
>> Dave
>>
>> --
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>
>
>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rndfax@yandex.ru>) id 1eopcv-00087Q-8I
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:05:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rndfax@yandex.ru>) id 1eopcu-00026g-2V
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:05:29 -0500
Received: from forward104p.mail.yandex.net
	([2a02:6b8:0:1472:2741:0:8b7:107]:38636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rndfax@yandex.ru>) id 1eopct-00016c-Hd
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 07:05:27 -0500
From: Aleksey Kuleshov <rndfax@yandex.ru>
In-Reply-To: <20180222114536.GF9323@redhat.com>
References: <52841519299484@web28j.yandex.ru>
	<20180222114536.GF9323@redhat.com>
MIME-Version: 1.0
Message-Id: <340261519301018@web58j.yandex.ru>
Date: Thu, 22 Feb 2018 15:03:38 +0300
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Patch 9894dc0cdcc broke something
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

I'm using 2.11.0.=20

22.02.2018, 14:45, "Daniel P. Berrang=C3=A9" <berrange@redhat.com>:
> On Thu, Feb 22, 2018 at 02:38:04PM +0300, Aleksey Kuleshov wrote:
>> =C2=A0Hello!
>>
>> =C2=A0I hit unexpected disconnections because of this patch:
>>
>> =C2=A0commit 9894dc0cdcc397ee5b26370bc53da6d360a363c2
>> =C2=A0Author: Daniel P. Berrange <berrange@redhat.com>
>> =C2=A0Date: Tue Jan 19 11:14:29 2016 +0000
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char: convert from GIOChannel to QIOChan=
nel
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0In preparation for introducing TLS suppo=
rt to the TCP chardev
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0backend, convert existing chardev code f=
rom using GIOChannel
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0to QIOChannel. This simplifies the chard=
ev code by removing
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0most of the OS platform conditional code=
 for dealing with
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0file descriptor passing.
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Daniel P. Berrange <berra=
nge@redhat.com>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Message-Id: <1453202071-10289-3-git-send=
-email-berrange@redhat.com>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Paolo Bonzini <pbonzini@r=
edhat.com>
>>
>> =C2=A0breaks tcp_chr_read:
>
> What version of QEMU are you using ?
>
> Regards,
> Daniel
> --
> |: https://berrange.com -o- https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org -o- https://fstop138.berrange.com :|
> |: https://entangle-photo.org -o- https://www.instagram.com/dberrange :=
|

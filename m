Received: from eggs.gnu.org ([2001:4830:134:3::10]:50388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dahru-0008Nv-SX
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dahrr-0001kv-OO
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:26:18 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dahrr-0001ja-Ig
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:26:15 -0400
Received: by mail-wm0-f42.google.com with SMTP id t138so2428448wmt.1
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 05:26:15 -0700 (PDT)
References: <CAGCz3vu5x59+mKg8011=DRyZQKbuBV2F20ZpPnG1TOCxsOb+mQ@mail.gmail.com>
	<CAGCz3vvBDC0cYY_kmgoCn1D1j9RLAda646n_NTuVq6PQF1qNmw@mail.gmail.com>
	<9767baed-582d-8aab-f9a6-0d04d7ec9d23@redhat.com>
	<165445ef-c2fb-f49e-8185-2a8af0e27bf2@redhat.com>
	<a92581c5-87b8-26d0-15d3-33ea6e87d442@redhat.com>
	<20170725220150.GA2891@morn.lan>
	<8ce79be9-5512-148d-f2d4-3bb8c04d6eda@redhat.com>
	<20170726191252.GA8769@morn.lan>
	<1419439438.19249924.1501100483485.JavaMail.zimbra@redhat.com>
	<1501144750.27172.1.camel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c6a21247-5d09-84fd-b6c5-bf5dc9b47e6e@redhat.com>
Date: Thu, 27 Jul 2017 14:26:08 +0200
MIME-Version: 1.0
In-Reply-To: <1501144750.27172.1.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [SeaBIOS] Commit
 77af8a2b95b79699de650965d5228772743efe84 breaks Windows 2000 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Kevin O'Connor <kevin@koconnor.net>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, seabios@seabios.org, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Programmingkid <programmingkidx@gmail.com>, Phil Dennis-Jordan <lists@philjordan.eu>, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>

On 27/07/2017 10:39, Gerd Hoffmann wrote:
>>> C - We'd be introducing "shared ownership" of the acpi
>>> tables.  Some
>>>     of the tables would be produced by QEMU and some of them by
>>>     SeaBIOS.  Explaining when and why to future developers would be
>>> a
>>>     challenge.
>>
>> The advantage is that the same shared ownership is already present in
>> OVMF.  The RSDP/RSDT/XSDT are entirely created by the firmware in
>> OVMF.
> 
> Hmm, seabios could do the same then, and we would not need a lockstep
> update?

That's fine by me too.  I'll try to make a patch.

Paolo

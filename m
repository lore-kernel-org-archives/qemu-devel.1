Received: from eggs.gnu.org ([2001:4830:134:3::10]:60112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8zwb-0005vg-M7
	for qemu-devel@nongnu.org; Thu, 11 May 2017 22:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8zwa-000157-N8
	for qemu-devel@nongnu.org; Thu, 11 May 2017 22:04:37 -0400
Received: from mail-it0-x229.google.com ([2607:f8b0:4001:c0b::229]:36034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8zwa-000140-JA
	for qemu-devel@nongnu.org; Thu, 11 May 2017 22:04:36 -0400
Received: by mail-it0-x229.google.com with SMTP id o5so3344369ith.1
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 19:04:36 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <cc870909-1694-73a3-db66-2d113736c7d6@amsat.org>
References: <0f1f5bcd-815a-c070-5ba7-281f5a0ee146@twiddle.net>
	<20170510235204.9657-1-f4bug@amsat.org>
	<551f0d70-acdf-1a40-6aec-00b1dd40133d@amsat.org>
	<87efvvzrwo.fsf@dusky.pond.sub.org>
	<cc870909-1694-73a3-db66-2d113736c7d6@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 11 May 2017 23:04:35 -0300
Message-ID: <CAAdtpL6owR4iDxs9ND9FkJAhvQGVenuQ-B29Fu+ix+nzDQJVHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH v2] coccinelle: add a script to
 optimize tcg op using tcg_gen_extract()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

>> Is this script likely to be rerun in the future?  If yes, keeping it in
>> scripts/coccinelle/ is a good idea.  If no, I recommend to store it in
>> the commit message instead.
>
>
> It is unlikely to be rerun in the future, at least for this specific pattern. But it can be easily adapted for another TCG optimization.
>
> I could not find much documentation about how to do a such script using Python, except on a thread [1]. If it is documented enough I think it is worth to keep it.
>
> About putting it in each commit message, it is now 3 times bigger than the patch it generates!
>
> Regards,
>
> Phil.

I missed this thread ref:

[1] https://github.com/coccinelle/coccinelle/issues/86

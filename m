Received: from eggs.gnu.org ([2001:4830:134:3::10]:41877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQxoO-00030I-Rh
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:58:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQxoO-0002fq-91
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:58:40 -0500
Received: from mail-io0-x22e.google.com ([2607:f8b0:4001:c06::22e]:38986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQxoO-0002fM-54
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:58:40 -0500
Received: by mail-io0-x22e.google.com with SMTP id h12so10292929iof.6
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 07:58:39 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <deba612d-e6f0-7181-6328-7eec81f68034@redhat.com>
References: <20171218121635.25494-1-cohuck@redhat.com>
	<deba612d-e6f0-7181-6328-7eec81f68034@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 18 Dec 2017 12:58:38 -0300
Message-ID: <CAAdtpL4H6E=UDMnAgmnQ0fZyXMrEq0EUu=pO2fwEhOisrr9NAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tpm: add stubs for qdev-prop-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

>> Add some proper stubs for those functions.
>>
>> Fixes: 493b78303532 ("qdev: add DEFINE_PROP_TPMBE")
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>
> Maybe all the new code can be moved from qdev-properties-system.c to
> hw/tpm/qdev.c instead?  (Adding stubs should be the last resort,
> especially if the stubs are never used outside system emulation).

This is worth an entry in HACKING :)

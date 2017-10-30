Received: from eggs.gnu.org ([2001:4830:134:3::10]:45314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e99SK-0002Fk-30
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 08:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e99SH-0007LV-0r
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 08:46:16 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:45416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e99SG-0007L9-SK
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 08:46:12 -0400
Received: by mail-qk0-x243.google.com with SMTP id f199so15933827qke.2
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 05:46:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171030030553.21259-1-f4bug@amsat.org>
	<8051c92f-3e4d-c5b7-7fc3-3ee0816084a1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b7009984-4264-6cb2-74d8-5c476d63e772@amsat.org>
Date: Mon, 30 Oct 2017 09:46:03 -0300
MIME-Version: 1.0
In-Reply-To: <8051c92f-3e4d-c5b7-7fc3-3ee0816084a1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/5] build fixes for --disable-tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, Yang Zhong <yang.zhong@intel.com>
Cc: qemu-devel@nongnu.org

Hi Thomas,

On 10/30/2017 05:05 AM, Thomas Huth wrote:
> Compiling with --disable-tcg works fine for me with the latest master
> branch as of today, on both x86 and s390x. Are you sure that these
> patches are still required?

I guess I didn't pulled /master early enough so I missed Peter's merge.
Indeed a bug fix got applied so these patches are not required.

However they now allow less #ifdef'fery and might have value in git log
history, so I'll wait a bit for Eduardo and Paolo comments before
dropping it.

Regards,

Phil.

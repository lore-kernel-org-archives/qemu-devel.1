Received: from eggs.gnu.org ([2001:4830:134:3::10]:46950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fCnkq-0001ZL-85
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 10:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fCnkn-00079Y-7C
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 10:56:44 -0400
Received: from mail-io0-x22d.google.com ([2607:f8b0:4001:c06::22d]:43186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fCnkn-00079P-1f
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 10:56:41 -0400
Received: by mail-io0-x22d.google.com with SMTP id t23-v6so7598137ioc.10
	for <qemu-devel@nongnu.org>; Sun, 29 Apr 2018 07:56:40 -0700 (PDT)
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<d50e3a40-d7f3-4c9b-e930-4c2f4d6c8a53@redhat.com>
	<CAFEAcA8wJuJ9464LadgjJOo-7ttdGYcfDQWALbkxBRJCr_knkg@mail.gmail.com>
	<20180427210120.03d037b0@naga.suse.cz>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <70cb944b-269c-2969-4727-b889298ece30@linaro.org>
Date: Sun, 29 Apr 2018 09:56:37 -0500
MIME-Version: 1.0
In-Reply-To: <20180427210120.03d037b0@naga.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>, Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 04/27/2018 02:01 PM, Michal Suchánek wrote:
> Is there any reason why the 64bit emulator would not run on 32bit
> system? The emulated 64bit system is .. emulated after all.

It does run, but it requires that the 32-bit host perform double-word
arithmetic to emulate the 64-bit guest.  When the 64-bit guest is really a
32-bit guest in disguise, this carries a performance penalty.

If we ever stop caring about 32-bit hosts, the question becomes moot.


r~

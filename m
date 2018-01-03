Received: from eggs.gnu.org ([2001:4830:134:3::10]:38267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eWnDj-00010X-Qh
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 12:52:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eWnDj-0004nw-3T
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 12:52:55 -0500
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:40828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eWnDi-0004nD-VG
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 12:52:55 -0500
Received: by mail-oi0-x236.google.com with SMTP id w125so1452931oie.7
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 09:52:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bfe98eaa-bf87-dabe-ec63-7eae338495a2@redhat.com>
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-5-marcandre.lureau@redhat.com>
	<CAJ+F1CLxk6vC+ZB09BUBMnJj12RuaeYS=S5KwcBGhoHiYbCd5g@mail.gmail.com>
	<CAJ+F1CLHsFoRFYy825f0MxyAU4T+97YrjMQWfmu6Cni49zyZWQ@mail.gmail.com>
	<bfe98eaa-bf87-dabe-ec63-7eae338495a2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Jan 2018 17:52:33 +0000
Message-ID: <CAFEAcA96TDZR7O75q_NH_vOdLBYr3ygnx-qzoZrQaeRqfrHAkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 04/13] build-sys: add AddressSanitizer
 when --enable-debug if possible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Fam Zheng <famz@redhat.com>

On 2 January 2018 at 17:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
> 2) I think removing -O2 from --enable-debug should be removed at the
> same time.  That pretty much guarantees that nobody will use
> --enable-debug, and optimized builds are decently debuggable nowadays.
> The best would be to detect -Og, and add either -Og or -O1 depending on
> presence.

Hmm. I use --enable-debug all the time and one of the reasons
I use it is that the optimized build is usually more pain
to debug with...

thanks
-- PMM

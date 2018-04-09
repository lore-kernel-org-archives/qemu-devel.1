Received: from eggs.gnu.org ([2001:4830:134:3::10]:48552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f5ajS-0004D3-8U
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 13:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f5ajO-0000uQ-BP
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 13:37:30 -0400
Received: from mail-pl0-x230.google.com ([2607:f8b0:400e:c01::230]:37837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f5ajO-0000u8-5s
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 13:37:26 -0400
Received: by mail-pl0-x230.google.com with SMTP id v5-v6so5592660plo.4
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 10:37:26 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180409082323.29575-1-peterx@redhat.com>
	<20180409083154.GD18283@redhat.com>
	<CAFEAcA-VS=b31Z=WZEO3sDLntA97px81ErVRZbHcSTxRe1YNEA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5ff4301b-ffda-1b03-ef64-ec107572260f@redhat.com>
Date: Mon, 9 Apr 2018 19:37:11 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-VS=b31Z=WZEO3sDLntA97px81ErVRZbHcSTxRe1YNEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] configure: don't warn GTK if disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>

On 09/04/2018 11:24, Peter Maydell wrote:
> On 9 April 2018 at 09:31, Daniel P. Berrangé <berrange@redhat.com> wrote:
>> Feels to me that since we've deprecated 2.0, we could just *never* auto
>> detect - just do     test -z "$gtkabi" && gtkabi=3.0
>>
>> Anyone who wants gtk2 should have to use an explicit --with-gtkabi=2.0
>
> I think if we still work with gtk2 then we should go ahead and
> warn-but-use it.

Both are valid choices of course.  Since we have Peter (Xu)'s patch, I
think we should go for that and revisit in 2.13 whether to remove GTK+
2.0 support altogether, require an explicit configure argument, or leave
things as they are.

Paolo

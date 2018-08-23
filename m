Received: from eggs.gnu.org ([2001:4830:134:3::10]:32795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fssh3-0003T9-AC
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fssaH-0000oJ-09
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:35:46 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:40000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fssaE-0000mo-5i
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:35:43 -0400
Received: by mail-oi0-x244.google.com with SMTP id l202-v6so3438430oig.7
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 09:35:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <959d62e8-6a27-c115-01e7-88b0fbe5a7aa@redhat.com>
References: <20180823133540.12973-1-pbonzini@redhat.com>
	<CAFEAcA_GidqNpjz+xV0Rix7YbZToZT8t+=dQ-+UxBLo3cbbfMw@mail.gmail.com>
	<959d62e8-6a27-c115-01e7-88b0fbe5a7aa@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 17:35:19 +0100
Message-ID: <CAFEAcA_6=BfC54j7CLLXBTp_hDZRqYAOdY9mTZuAxEFxfGKitw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 00/69] Misc patches for 2018-08-21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 August 2018 at 17:25, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 23/08/2018 18:16, Peter Maydell wrote:
>>
>> tests/libqtest.c: In function 'qtest_is_old_versioned_machine':
>> tests/libqtest.c:1019:13: warning: array subscript has type 'char'
>> [-Wchar-subscripts]
>>              if (!isdigit(*chr) && *chr != '.') {
>>              ^
>>
>> Code should be using qemu_isdigit(). We don't enforce -Werror
>> on NetBSD, though, so we could let this through and fix it up
>> later...
>
> As you prefer.  I can send a v4 too.
>
>> Test failure on x86-64 Linux (debug build):

>> I'm just checking whether that fails consistently or if it's a random/
>> intermittent.
>
> That would be strange, since I'm not touching the block layer at all
> (not my turf!)...

It does seem to be intermittent.

If you're ok with doing a v4 for the isdigit thing that's
probably the cleanest way to do it.

thanks
-- PMM

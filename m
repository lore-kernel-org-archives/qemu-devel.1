Received: from eggs.gnu.org ([2001:4830:134:3::10]:37554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ecXla-0002EI-RA
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ecXlW-00045j-Ro
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:35:38 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ecXlW-00045X-ND
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:35:34 -0500
Received: by mail-qt0-f195.google.com with SMTP id s39so4234486qth.7
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 06:35:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_M7FazuMDpne5Fr=hQUmfp75BHqttYOWV+HJ9zinW6mA@mail.gmail.com>
References: <20180117144756.31049-1-marcandre.lureau@redhat.com>
	<595f00e6-d5ad-b7c6-29be-7c6e135f9d12@redhat.com>
	<CAFEAcA_M7FazuMDpne5Fr=hQUmfp75BHqttYOWV+HJ9zinW6mA@mail.gmail.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Fri, 19 Jan 2018 15:35:33 +0100
Message-ID: <CAMxuvazG-y3XpE09oBRCJtB1OcNSbOP4heyGXYFHpLMbFj7VnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/1] Dump patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi

On Fri, Jan 19, 2018 at 3:29 PM, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> On 17 January 2018 at 15:02, Eric Blake <eblake@redhat.com> wrote:
>> On 01/17/2018 08:47 AM, Marc-Andr=C3=A9 Lureau wrote:
>>> The following changes since commit 8e5dc9ba49743b46d955ec7dacb04e42ae7a=
da7c:
>>>
>>>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180116' int=
o staging (2018-01-16 17:36:39 +0000)
>>>
>>> are available in the Git repository at:
>>>
>>>   https://github.com/elmarco/qemu.git tags/dump-pull-request
>>>
>>> for you to fetch changes up to 48fb74965a8d8f2916da30d9c5b9945df25142af=
:
>>>
>>>   dump-guest-memory.py: fix python 2 support (2018-01-17 15:47:14 +0100=
)
>>>
>>
>> The commit says it works with python 2.7, but we still require support
>> for python 2.6.  Is this pull request premature?
>
> So should I apply this, or not?

I have not found how to translate a python 'buffer' to a bytes string
in 2.6. For now, I think we should go with this patch, it's already an
improvement..

Thanks

Received: from eggs.gnu.org ([2001:4830:134:3::10]:36978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1edu8J-000633-Li
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1edu8G-00019G-GD
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:40:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
	id 1edu8G-00018u-AD
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:40:40 -0500
Received: from mail-yb0-f197.google.com ([209.85.213.197])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1edu8F-0006mf-5G
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 08:40:39 +0000
Received: by mail-yb0-f197.google.com with SMTP id d13so8130861ybn.14
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 00:40:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_WdJnYnZUoABB1yWZUO81ag2cMMZRAw106VL_GFM6ZcQ@mail.gmail.com>
References: <20180118020157.25401-1-ehabkost@redhat.com>
	<CAFEAcA_WdJnYnZUoABB1yWZUO81ag2cMMZRAw106VL_GFM6ZcQ@mail.gmail.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Tue, 23 Jan 2018 09:40:07 +0100
Message-ID: <CAATJJ0Kwf=qMQ8Sax8d4ieFXfFrqaisd6wUSLTTLBxvSdgb5Jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] x86 queue, 2018-01-17
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Thu, Jan 18, 2018 at 2:51 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 18 January 2018 at 02:01, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> The following changes since commit 8e5dc9ba49743b46d955ec7dacb04e42ae7ada7c:
>>
>>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180116' into staging (2018-01-16 17:36:39 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/ehabkost/qemu.git tags/x86-pull-request
>>
>> for you to fetch changes up to 6cfbc54e8903a9bcc0346119949162d040c144c1:
>>
>>   i386: Add EPYC-IBPB CPU model (2018-01-17 23:54:39 -0200)
>>
>> ----------------------------------------------------------------
>> x86 queue, 2018-01-17
>>
>> Highlight: new CPU models that expose CPU features that guests
>> can use to mitigate CVE-2017-5715 (Spectre variant #2).
>>
>
> Applied, thanks.
>
> -- PMM
>

Hi,
I was kind of clinging to [1] so far and had the expectation that all
those would be wrapped up in 2.11.1 once ready.
I see that the s390x changes are targeted to qemu-stable (well to
admit I suggested so referring the article above).
So I'd expected to see this series to show up on qemu-stable as well
but haven't seen it so far.

Therefore I wanted to ask if there was a change of plans in that
regard or if it needs just a few days more to see (part of) this
series on qemu-stable and on its way into 2.11.1?

[1]: https://www.qemu.org/2018/01/04/spectre/

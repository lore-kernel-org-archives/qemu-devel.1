Received: from eggs.gnu.org ([209.51.188.92]:47012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtzaQ-0008Ot-Jt
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtzSn-0004zJ-Bv
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:40:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtzSg-0004fB-1t
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:40:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id q21so3525506wmc.5
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 10:40:41 -0800 (PST)
References: <20190212045721.28041-1-richard.henderson@linaro.org>
	<CAFEAcA_Oc4fTfcC-RFmV3zi7RnAbjDv=xWG8uPb_AT9buGnAcQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <46f22bec-d2ce-da2c-5aa0-c8572181f9ee@redhat.com>
Date: Wed, 13 Feb 2019 19:40:37 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Oc4fTfcC-RFmV3zi7RnAbjDv=xWG8uPb_AT9buGnAcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/24] target/hppa patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Hi Peter,

On 2/12/19 2:15 PM, Peter Maydell wrote:
> On Tue, 12 Feb 2019 at 04:57, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> The following changes since commit 22c5f446514a2a4bb0dbe1fea26713da92fc85fa:
>>
>>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190211' into staging (2019-02-11 17:04:57 +0000)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/rth7680/qemu.git tags/pull-hppa-20190211
>>
>> for you to fetch changes up to 23e76627deba013509b5f1a1e1c53e8e111145aa:
>>
>>   hw/hppa: forward requests to CPU HPA (2019-02-11 20:49:06 -0800)
>>
>> ----------------------------------------------------------------
>> Convert to decodetree.
>> Fix signed overflow conditions.
>> Fix dcor.
>> Add CPU MIE to PCI address space.
> 
> Hi -- clang compiles fail with:
> 
> In file included from
> /home/petmay01/linaro/qemu-for-merges/target/hppa/translate.c:337:
> target/hppa/decode.inc.c:471:16: error: redefinition of typedef
> 'arg_be' is a C11 feature [-Werror,-Wtypedef-redefinition]
> typedef arg_be arg_be;
>                ^
> target/hppa/decode.inc.c:9:3: note: previous definition is here
> } arg_be;
>   ^
> target/hppa/decode.inc.c:473:16: error: redefinition of typedef
> 'arg_bl' is a C11 feature [-Werror,-Wtypedef-redefinition]
> typedef arg_bl arg_bl;
>                ^
> target/hppa/decode.inc.c:15:3: note: previous definition is here
> } arg_bl;
>   ^

What Clang version is that?

I can not reproduce using:

clang version 7.0.1 (Fedora 7.0.1-1.fc29)

> 
> thanks
> -- PMM
> 

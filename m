Received: from eggs.gnu.org ([2001:4830:134:3::10]:51158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1du0GP-0006iQ-Uk
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1du0GM-00006p-UH
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:55:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1du0GM-00006Q-NJ
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:55:18 -0400
References: <20170916010330.10435-1-jsnow@redhat.com>
	<CAFEAcA8un6eescSDzd+P+jqEGuGkuQXgfjm+1=CPOydg6WQSnQ@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <fb54f008-2913-3cd2-df95-41b1fcf3f2ee@redhat.com>
Date: Mon, 18 Sep 2017 13:55:16 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8un6eescSDzd+P+jqEGuGkuQXgfjm+1=CPOydg6WQSnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/11] Ide patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>



On 09/16/2017 10:34 AM, Peter Maydell wrote:
> On 16 September 2017 at 02:03, John Snow <jsnow@redhat.com> wrote:
>> The following changes since commit 5faf2d376af3cb4eb92da44c2580e08d39832caa:
>>
>>   Merge remote-tracking branch 'remotes/huth/tags/check-20170915' into staging (2017-09-15 20:29:44 +0100)
>>
>> are available in the git repository at:
>>
>>   https://github.com/jnsnow/qemu.git tags/ide-pull-request
>>
>> for you to fetch changes up to 2a94e34d3ecef91727f467cc012587c632099d40:
>>
>>   AHCI: remove DPRINTF macro (2017-09-15 20:36:18 -0400)
>>
>> ----------------------------------------------------------------
>>
>> ----------------------------------------------------------------
> 
> Hi; I'm afraid this doesn't build with clang:
> 
> /home/petmay01/linaro/qemu-for-merges/hw/ide/core.c:70:15: error:
> comparison of unsigned enum expression >= 0 is always true
> [-Werror,-Wtautological-compare]
>     if (enval >= 0 && enval < IDE_DMA__COUNT) {
>         ~~~~~ ^  ~
> 1 error generated.
> 
> (It's impdef whether an enum with all positive values is
> a signed type or unsigned type, so just deleting the
> comparison against 0 would also be wrong...)
> 
> thanks
> -- PMM
> 

Huh, impdef in the general case, but is it undefined for gnu99? I'm
wondering why Clang can be so certain about this comparison being
useless. Is this a Clang "bug"?

--js

Received: from eggs.gnu.org ([2001:4830:134:3::10]:36222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fifJI-0000tk-JH
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 08:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fifJF-0002mv-JI
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 08:24:00 -0400
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<20180725095426.f7kv4ftngeje6pkx@kamzik.brq.redhat.com>
	<CAHmQWvDu+P26Y5CJfcQ=1_9C=hej_B8w7dLMbmuOmCV-+pYOJQ@mail.gmail.com>
	<20180725114404.6g335n3rfjt23hjc@kamzik.brq.redhat.com>
	<CAHmQWvC44mLchhEFPU0T0gKWVcjjozp95ZumaKK9EkPwpeehTA@mail.gmail.com>
	<20180726104636.aua3pjsqkqnkvggk@kamzik.brq.redhat.com>
	<CAFEAcA80549kHSO+8z334PYmoWshzz+EHJcPBxsmhBN_dk+0Rw@mail.gmail.com>
	<CAKv+Gu-m0=MmkaR0UGJ4mmYSNHmk9QQh06Wxx6k2wXWq+QF46w@mail.gmail.com>
	<20180726111354.flyqh2yo4xm5z6m7@kamzik.brq.redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d0eb219e-b3cb-d006-1857-a399a65376f8@redhat.com>
Date: Thu, 26 Jul 2018 14:23:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180726111354.flyqh2yo4xm5z6m7@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Hongbo Zhang <hongbo.zhang@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 07/26/18 13:13, Andrew Jones wrote:
> On Thu, Jul 26, 2018 at 12:56:22PM +0200, Ard Biesheuvel wrote:
>> On 26 July 2018 at 12:52, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On 26 July 2018 at 11:46, Andrew Jones <drjones@redhat.com> wrote:
>>>> i440fx and q35 are specific machine types. 'sbsa' is a generic machine
>>>> type that conforms to the SBSA specification. If you weren't trying to
>>>> memory map AHCI and EHCI controllers, or if memory mapped AHCI and EHCI
>>>> controllers were mandated in the SBSA spec, then there wouldn't be
>>>> anything to discuss. But that's not the case. You're attempting to
>>>> hard code one instance of a generic class of SBSA machines, but then
>>>> just call it 'sbsa'.
>>>
>>> Modelling a 'generic SBSA machine' is not the goal here (I'm
>>> not sure that's even possible or useful), so let's just
>>> stipulate that we'll call the machine type something else
>>> and move on ?
>>>
>>
>> Fine with me. Care to suggest a name? :-)
>>
> 
> Also fine by me, but I'm not going to suggest the name. I fear the
> backlash I'd receive after this mail thread!
> 

I suggest "showcase2018". (Dead serious.)

Laszlo

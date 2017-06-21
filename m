Received: from eggs.gnu.org ([2001:4830:134:3::10]:47492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dNaNH-0000nC-Mp
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 03:48:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dNaND-0001XA-Ps
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 03:48:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dNaND-0001Wn-Jj
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 03:48:23 -0400
References: <1497877149-19253-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497877149-19253-4-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170619142852.GS5016@thinpad.lan.raisama.net>
	<7d5904ae-e66c-5594-cfff-747578d91f4b@ilande.co.uk>
	<08da52ec-e4d2-d836-49bd-90baf21747fb@redhat.com>
	<1d8147a6-d55c-4951-68db-4c1cf502a4f3@ilande.co.uk>
	<9d24bf00-cf82-717a-eccd-f51e2c80dd6f@redhat.com>
	<eaa2cd40-0d64-6843-7e39-c0f94c7e797f@ilande.co.uk>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <48c8f007-f388-59f5-9af8-f5eefe033e2a@redhat.com>
Date: Wed, 21 Jun 2017 09:48:16 +0200
MIME-Version: 1.0
In-Reply-To: <eaa2cd40-0d64-6843-7e39-c0f94c7e797f@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv6 3/5] fw_cfg: move assert() and linking of
 fw_cfg device to the machine into instance_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>
Cc: peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, imammedo@redhat.com

On 06/21/17 08:58, Mark Cave-Ayland wrote:
> On 19/06/17 23:43, Laszlo Ersek wrote:
> 
>> It looks good to me, but please await Eduardo's reply as well.
>>
>> In particular, it should be confirmed that object_resolve_path_type()
>> matches instances of *subclasses* as well (as I expect it would). Your
>> test results confirm that; let's make sure it is intentional behavior.
>> Eduardo (or someone else on the CC list), can you please comment on that?
> 
> Thanks Laszlo. Eduardo, can you confirm this is the correct behaviour?
> 
> I now have a v7 patchset ready to go (currently hosted at
> https://github.com/mcayland/qemu/tree/fwcfg7 for the curious). Laszlo,
> I've currently left off your Tested-by tag since I'm not sure it's still
> valid for less-than-trivial changes - if you're happy for me to re-add
> it before I send the v7 patchset to the list, please let me know.

I intend to test v7 when you post it.

Thanks,
Laszlo

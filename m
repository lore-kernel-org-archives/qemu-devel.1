Received: from eggs.gnu.org ([2001:4830:134:3::10]:53649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPCBL-00034V-Rk
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:59:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gPCBH-00033g-QH
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:59:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gPCBH-00031e-Hk
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 14:59:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so3296536wrb.2
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 11:59:31 -0800 (PST)
References: <20181119154737.9840-1-liq3ea@163.com>
	<87bm6j8rvm.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8e31bbc2-20c9-86b7-97f9-d4cc8fd35656@redhat.com>
Date: Tue, 20 Nov 2018 20:59:28 +0100
MIME-Version: 1.0
In-Reply-To: <87bm6j8rvm.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] fw_cfg: fix boot bootsplash and
 reboot-timeout error checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Li Qiang <liq3ea@163.com>
Cc: pbonzini@redhat.com, kraxel@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org

Hi Markus, Li.

On 20/11/18 20:34, Markus Armbruster wrote:
> Li Qiang <liq3ea@163.com> writes:
> 
>> And also do some code cleanup.
>> A lot of thanks to Markus's review and advice.
>>
>> Li Qiang (3):
>>    fw_cfg: fix -boot bootsplash error checking
>>    fw_cfg: fix -boot reboot-timeout error checking
>>    fw_cfg: make qemu_extra_params_fw locally
>>
>>   hw/nvram/fw_cfg.c       | 68 ++++++++++++++++++-----------------------
>>   include/sysemu/sysemu.h |  1 -
>>   vl.c                    |  4 +--
>>   3 files changed, 32 insertions(+), 41 deletions(-)
> 
> fw_cfg.c has no maintainer.  Who would be willing to merge this?

I have various patches for fw_cfg waiting 4.0 to start, one add a 
MAINTAINERS entry covered by Laszlo, Gerd and myself.

This series was published way before soft freeze, but I am not sure it 
applies for hard freeze. If so, it might goes thru Paolo's Misc tree, 
else we'll take it for 4.0 (via fw_cfg-next).

Regards,

Phil.

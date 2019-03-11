Received: from eggs.gnu.org ([209.51.188.92]:38715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h3MYx-0006xo-HS
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1h3MYw-0000QN-U1
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:09:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1h3MYw-0000PQ-Mg
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:09:58 -0400
References: <20190214190603.25030-1-peter.maydell@linaro.org>
	<20190214190603.25030-12-peter.maydell@linaro.org>
	<72c526bd-6c30-5e7a-4ff0-da8473348d0a@redhat.com>
	<CAFEAcA9=oUk_W+pqYLkd=oBC7eENU1yYKbGzoOzgxXoOmg7_+A@mail.gmail.com>
	<85304416-5bd3-c957-b2c3-dd8e7c1aa071@redhat.com>
	<CAFEAcA8vdJyNa7KEAv5sOJDQUu_9x0pyXvixw4nT0Yq1KVosmA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <1a59692d-527c-9750-4bfa-6b5adbbab81a@redhat.com>
Date: Mon, 11 Mar 2019 16:09:54 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8vdJyNa7KEAv5sOJDQUu_9x0pyXvixw4nT0Yq1KVosmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 11/27] arm: Allow system registers for KVM
 guests to be changed by QEMU code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Peter,

On 3/11/19 3:55 PM, Peter Maydell wrote:
> On Mon, 11 Mar 2019 at 14:54, Auger Eric <eric.auger@redhat.com> wrote:
>> yes I hit the bug with your reduced command line:
>>
>> aarch64-softmmu/qemu-system-aarch64 -M virt,gic-version=host -cpu host
>> -smp 2 -m 4G -display none --enable-kvm  -serial stdio -bios
>> ~/VM/UEFI/QEMU_EFI_cbuild_debug_feb21_2019.fd
> 
> OK, that's good to know. What hardware are you using, and what host
> kernel version ?

I am using Cavium ThunderX 2 and 5.0 host

Thanks

Eric
> 
> thanks
> -- PMM
> 

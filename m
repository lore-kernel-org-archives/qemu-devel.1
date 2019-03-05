Received: from eggs.gnu.org ([209.51.188.92]:43657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1G17-0003aT-Kc
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:46:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h1G15-0001Mo-Rq
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:46:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:10864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h1G15-0000tb-Hf
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 14:46:19 -0500
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA8WZuAmNFQqCsvsN35UnFJk=sGcCJmF27v3SS++FnpXXQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <150efd5f-dea0-93bd-c74c-6d012f4ab7d1@redhat.com>
Date: Tue, 5 Mar 2019 20:45:58 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8WZuAmNFQqCsvsN35UnFJk=sGcCJmF27v3SS++FnpXXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/54] Kconfig conversion,
 excluding ARM and MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yang Zhong <yang.zhong@intel.com>

On 05/03/2019 10.32, Peter Maydell wrote:
> On Mon, 4 Mar 2019 at 19:25, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The following changes since commit 1ba530a4ecba6015d52d8f392fd327cfa07bc37a:
>>
>>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190304' into staging (2019-03-04 13:38:54 +0000)
>>
>> are available in the git repository at:
>>
>>
>>   git://github.com/bonzini/qemu.git tags/for-upstream-kconfig
>>
>> for you to fetch changes up to b1d8b9a6cc37e33dde1873379174de78957830ca:
>>
>>   kconfig: add documentation (2019-03-04 19:09:35 +0100)
>>
>> ----------------------------------------------------------------
>> Initial Kconfig work, excluding ARM and MIPS
> 
> Everything fails to build with errors like
> make: *** No rule to make target `config-all-devices.mak', needed by
> `subdir-aarch64-softmmu'.  Stop.
> 
> or
> make: *** No rule to make target
> `/home/pm215/qemu/default-configs/pci.mak', needed by
> `aarch64-softmmu/config-devices.mak'.  Stop.
> 
> If there are special instructions for what to do with
> build trees over the transition to kconfig, the pullreq
> cover letter would be a good place to mention them :-)

I think you've got to do a "make distclean" inbetween... that's the old
problem when a default-configs/*.mak file gets added or erased - we do
not properly re-generate the dependencies in that case.

 Thomas

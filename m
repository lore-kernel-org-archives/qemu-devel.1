Received: from eggs.gnu.org ([209.51.188.92]:50292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwVv6-0001nC-R1
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:44:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwVv2-0002T2-Mh
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:44:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:62119)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gwVv0-0002Qz-P1
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:44:27 -0500
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
	<1549562254-41157-6-git-send-email-pbonzini@redhat.com>
	<CAMo8BfJW6xg=K1Z+3K_Gckx=P5Vrbve2+rR52DygajoF5TJtnw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <69c3b817-f4d1-16e0-8f63-d6e1bbb21fcd@redhat.com>
Date: Wed, 20 Feb 2019 18:44:12 +0100
MIME-Version: 1.0
In-Reply-To: <CAMo8BfJW6xg=K1Z+3K_Gckx=P5Vrbve2+rR52DygajoF5TJtnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/51] kconfig: introduce kconfig files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Yang Zhong <yang.zhong@intel.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

On 20/02/19 17:55, Max Filippov wrote:
> On Thu, Feb 7, 2019 at 10:05 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>> diff --git a/hw/xtensa/Kconfig b/hw/xtensa/Kconfig
>> new file mode 100644
>> index 0000000..97543a9
>> --- /dev/null
>> +++ b/hw/xtensa/Kconfig
>> @@ -0,0 +1,5 @@
>> +config XTENSA_SIM
>> +    bool
>> +
>> +config XTENSA_FPGA
> 
> Can it please be called XTENSA_XTFPGA, as the corresponding
> source file and as it's called in other places (e.g. in linux)?

This is just matching the existing

    obj-$(CONFIG_XTENSA_FPGA) += xtfpga.o

but yes, I can rename it.

Paolo

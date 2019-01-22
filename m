Received: from eggs.gnu.org ([209.51.188.92]:55658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gm1FT-0005Fv-5H
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:58:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gm1FR-0003Hy-40
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:58:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gm1FP-0003Dw-6v
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:58:09 -0500
References: <20190116191950.94110-1-emaste@freefall.freebsd.org>
	<20190118144724.66914-1-emaste@freebsd.org>
	<8def73c9-23e5-9f87-81d1-dda0c7e6f7d9@redhat.com>
	<242e057a-0c35-93b1-1249-93799cdf1196@redhat.com>
	<CAPyFy2BLuGCYx0-GUdy5w8HD0u3hkvH3DGmCV+9OKYjtkr6rew@mail.gmail.com>
	<CAPyFy2DNJvE4GbXxtzFJe8bPiXQm+bOmp+D_zVSCtaJML18vzw@mail.gmail.com>
	<6272e5b7-477c-6a38-97cd-a16b94c209d5@redhat.com>
	<CAPyFy2DKo=pBrxhbawf5fJVSVwXnnjaXUHbdWFJ+-M5R_f7irQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3e1ff897-ddfe-8c83-e25d-24f0162ace11@redhat.com>
Date: Tue, 22 Jan 2019 15:09:23 +0100
MIME-Version: 1.0
In-Reply-To: <CAPyFy2DKo=pBrxhbawf5fJVSVwXnnjaXUHbdWFJ+-M5R_f7irQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] .cirrus.yml: basic compile and test for
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Maste <emaste@freebsd.org>
Cc: Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 2019-01-22 14:42, Ed Maste wrote:
> On Tue, 22 Jan 2019 at 04:40, Thomas Huth <thuth@redhat.com> wrote:
>>
>> Then I finally increased the CPUs back to 8 again, but stick with 8G of
>> RAM, and that indeed finished in time successfully:
>>
>>  https://cirrus-ci.com/build/6218565876187136
>>
>> So yes, looks like 8 CPUs should work indeed, but I think you should
>> decrease the amount of memory of the VM, to make sure that it does not
>> get killed so easily. 8 GB of RAM should also be enough to compile QEMU,
>> as far as I can tell.
> 
> Ok. I think Cirrus-CI might be having some growing pains.
> 
> I can submit a v4 patch with 8G for the VM and V=1 only on the tests,
> then after it gets merged keep an eye on results for a while before we
> consider enabling build notifications etc.

Sounds like a plan!

 Thanks,
  Thomas

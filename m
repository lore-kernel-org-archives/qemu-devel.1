Received: from eggs.gnu.org ([209.51.188.92]:54903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjlh8-0008Qg-59
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:57:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjlh4-0000oi-0K
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:57:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gjlh0-0000i8-2C
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:57:19 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-27-yang.zhong@intel.com>
	<6ce1a208-43b5-4def-f498-4ec7f98d05ed@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1ac9d186-1d68-6a66-a90a-6038229b6084@redhat.com>
Date: Wed, 16 Jan 2019 14:57:07 +0100
MIME-Version: 1.0
In-Reply-To: <6ce1a208-43b5-4def-f498-4ec7f98d05ed@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 26/37] scsi: express dependencies
 with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com

On 16/01/19 12:50, Thomas Huth wrote:
>> From: Paolo Bonzini <pbonzini@redhat.com>
>>
>> This lets you disable SCSI altogether with "CONFIG_SCSI=3Dn".
> Sorry for my ignorant question, but: Can we really disable SCSI if the
> Kconfig files use "select SCSI" all over the place? I'd rather expect
> that "CONFIG_SCSI=3Dn" only works if we only use "depends on SCSI" ever=
ywhere?

Right.  It would work if the controllers depended on SCSI, but you can
say instead "this automatically removes the SCSI subsystem from the
binary altogether if no controllers are selected".  Same for I2C, etc.

Paolo

> I'm fine if we use select SCSI in this patch, but maybe the commit
> message should be tweaked in case you can not really disable SCSI like
> this anymore?

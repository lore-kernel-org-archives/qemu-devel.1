Received: from eggs.gnu.org ([2001:4830:134:3::10]:58616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fdLXe-00042V-7G
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fdLXd-0002x4-Cp
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 16:16:50 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1531170180-21199-1-git-send-email-thuth@redhat.com>
	<ca91bffe-2bcf-78a2-02cd-8ae7cc48074c@redhat.com>
	<20180711183031.GM914@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce0b8bf9-b0e6-fe02-c685-5a6c3140a3ae@redhat.com>
Date: Wed, 11 Jul 2018 22:16:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180711183031.GM914@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm/bcm283x: Fix crash with device_add
 bcm2837 on unsupported machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 11/07/2018 20:30, Eduardo Habkost wrote:
>> The theoretical behavior should be:
> It's not clear below where you expect
>   qdev_set_parent_bus(..., sysbus_get_default())
> to be called (if it should be called at all).
> 
> I don't know where it should be called, but I'm absolutely sure
> instance_init is not the right place.

I think instance_init is fine to call qdev_set_parent_bus on contained
devices.  Why do you say it's not?

Thanks,

Paolo

Received: from eggs.gnu.org ([2001:4830:134:3::10]:55880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdWbq-0004Wx-VS
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 04:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdWbm-0002iY-1a
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 04:05:54 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fdWbl-0002i6-Rq
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 04:05:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id s13-v6so1410948wmc.1
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 01:05:49 -0700 (PDT)
References: <1531170180-21199-1-git-send-email-thuth@redhat.com>
	<ca91bffe-2bcf-78a2-02cd-8ae7cc48074c@redhat.com>
	<20180711183031.GM914@localhost.localdomain>
	<ce0b8bf9-b0e6-fe02-c685-5a6c3140a3ae@redhat.com>
	<20180711202351.GA31657@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <00130bb8-4dfc-3a76-3f51-9f4c6da891c0@redhat.com>
Date: Thu, 12 Jul 2018 10:05:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180711202351.GA31657@localhost.localdomain>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 11/07/2018 22:23, Eduardo Habkost wrote:
> On Wed, Jul 11, 2018 at 10:16:42PM +0200, Paolo Bonzini wrote:
>> On 11/07/2018 20:30, Eduardo Habkost wrote:
>>>> The theoretical behavior should be:
>>> It's not clear below where you expect
>>>   qdev_set_parent_bus(..., sysbus_get_default())
>>> to be called (if it should be called at all).
>>>
>>> I don't know where it should be called, but I'm absolutely sure
>>> instance_init is not the right place.
>>
>> I think instance_init is fine to call qdev_set_parent_bus on contained
>> devices.  Why do you say it's not?
> 
> Because object_unref(object_new(...)) is not supposed to affect
> QEMU global state at all.

It should not affect it.  Any changes to the global state done by
instance_init are immediately undone when object_unref destroys the
child properties of the object.

Thanks,

Paolo

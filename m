Received: from eggs.gnu.org ([2001:4830:134:3::10]:54719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDA7W-0000oW-8U
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDA7S-0000eb-99
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:49:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53352 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fDA7S-0000eF-42
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:49:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C378E4270959
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 14:49:29 +0000 (UTC)
References: <1524841523-95513-1-git-send-email-imammedo@redhat.com>
	<1524841523-95513-6-git-send-email-imammedo@redhat.com>
	<f62a4655-2d55-dfc7-e332-3da3ce379c56@redhat.com>
	<20180428035150.GA25938@xz-mi>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6bb87789-aebe-a8a5-d29c-5dfde2778076@redhat.com>
Date: Mon, 30 Apr 2018 09:49:24 -0500
MIME-Version: 1.0
In-Reply-To: <20180428035150.GA25938@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 05/11] qapi: introduce new cmd option
 "allowed-in-preconfig"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, ehabkost@redhat.com, pkrempa@redhat.com, armbru@redhat.com

On 04/27/2018 10:51 PM, Peter Xu wrote:

>>>       QTAILQ_INIT(&qmp_cap_negotiation_commands);
>>>       qmp_register_command(&qmp_cap_negotiation_commands, "qmp_capabilities",
>>> -                         qmp_marshal_qmp_capabilities, QCO_NO_OPTIONS);
>>> +                         qmp_marshal_qmp_capabilities,
>>> +                         QCO_ALLOWED_IN_PRECONFIG);
>>
>> ...why are we still special-casing the registration of qmp_capabilities
>> here...
> 

> My understanding is that we have two lists:
> 
>      QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
> 
> And here it only registers with qmp_commands list via:
> 
>      qmp_init_marshal(&qmp_commands);
> 
> But not for the other one, which is explicitly registered at [1].  So
> it seems that [1] is still needed?

Ah, that makes sense.  I overlooked the difference in list name in the 
first parameter to qmp_register_command(), since that line was not 
changed in the diff.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

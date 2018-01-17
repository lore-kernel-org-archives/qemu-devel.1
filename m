Received: from eggs.gnu.org ([2001:4830:134:3::10]:46246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebnm2-000228-5N
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:29:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebnlx-0000yT-9N
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:29:02 -0500
Received: from mail-qk0-x234.google.com ([2607:f8b0:400d:c09::234]:35146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebnlw-0000xr-Sw
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:28:57 -0500
Received: by mail-qk0-x234.google.com with SMTP id w1so25211121qka.2
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 05:28:56 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180116231824.27114-1-shaun.reitan@ndchost.com>
	<20180117103148.GE19227@redhat.com>
	<39294893-a458-9f40-dc9c-bcac14d8be5e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6fa6797b-c57f-5635-4c60-1a0714089638@amsat.org>
Date: Wed, 17 Jan 2018 10:28:52 -0300
MIME-Version: 1.0
In-Reply-To: <39294893-a458-9f40-dc9c-bcac14d8be5e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Add ability to provide ifname when using
 netdev bridge or tap helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Shaun Reitan <shaun.reitan@ndchost.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 01/17/2018 07:39 AM, Paolo Bonzini wrote:
> On 17/01/2018 11:31, Daniel P. Berrange wrote:
>>
>> eg consider the user asks for a tap device called  eth1. To the
>> sysadmin the user's tap device now looks like a physical NIC.
>> This can be even worse if the host does physical NIC hotplug,
>> or uses SRIOV. eg consider the host as eth0 -> eth7 for SRIOV
>> NICs, and eth3 is given to a guest. Now a user uses the setuid
>> helper to ask for a TAP called eth3. When the SRIOV device is
>> later released by the guest it will end up called eth8, as the
>> TAP device occupies eth3. In bad cases this could even cause
>> the host mgmt layer to configure bogus addresses on the eth3
>> TAP device instead of the SRIOV device.
>>
>> If we want to allow ifname to be set via the setuid helper, then IMHO,
>> the config file for the helper *must* whitelist the various permitted
>> naming patterns.
> 
> Indeed, a similar patch has been proposed several times, and always the
> response was the same as Daniel's. :)

Can this be added to docs/netdev-helpers.rst and with a comment
referencing this file in qemu-bridge-helper.c ?

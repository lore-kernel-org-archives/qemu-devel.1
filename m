Received: from eggs.gnu.org ([2001:4830:134:3::10]:35246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cqG4K-0000DQ-5w
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:27:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cqG4H-0005Ga-3A
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:27:08 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:8492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1cqG4G-0004sa-Qe
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:27:05 -0400
References: <1490015240-49118-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<20170320131703.GN3792@redhat.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <cf6a29f8-2dac-4246-8cd3-86790b52409b@huawei.com>
Date: Tue, 21 Mar 2017 10:25:31 +0100
MIME-Version: 1.0
In-Reply-To: <20170320131703.GN3792@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v0] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>, Jani Kokkonen <jani.kokkonen@huawei.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org


On 3/20/2017 2:17 PM, Daniel P. Berrange wrote:
> On Mon, Mar 20, 2017 at 09:07:20AM -0400, Pradeep Jagadeesh wrote:
>
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index 8819281..e4e3478 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -1637,6 +1637,34 @@ ETEXI
>>      },
>>
>>  STEXI
>> +@item 9p_passwd @var{device} @var{password}
>> +@findex 9p_passwd
>> +Set the encrypted device @var{device} password to @var{password}
>> +ETEXI
>> +
>> +    {
>> +        .name       = "fs9p_set_io_throttle",
>> +        .args_type  = "device:B,bps:l,bps_rd:l,bps_wr:l,iops:l,iops_rd:l,iops_wr:l",
>> +        .params     = "device bps bps_rd bps_wr iops iops_rd iops_wr",
>> +        .help       = "change I/O throttle limits for a block drive",
>> +        .cmd        = hmp_9pfs_set_io_throttle,
>> +    },
>> +
>> +STEXI
>> +@item fs9p_set_io_throttle @var{device} @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
>> +@findex 9pfs_set_io_throttle
>> +Change I/O throttle limits for a block drive to @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
>> +ETEXI
>> +
>> +    {
>> +        .name       = "set_password",
>> +        .args_type  = "protocol:s,password:s,connected:s?",
>> +        .params     = "protocol password action-if-connected",
>> +        .help       = "set spice/vnc password",
>> +        .cmd        = hmp_set_password,
>> +    },
>> +
>> +STEXI
>
> This looks all mangled wrt password related stuff
I did not understand the usage of the password.
Do we really need password here?.
I just followed how is it done in block devices.
>
>
>> diff --git a/qapi/9pfs.json b/qapi/9pfs.json
>> new file mode 100644
>> index 0000000..c068474
>> --- /dev/null
>> +++ b/qapi/9pfs.json
>> @@ -0,0 +1,169 @@
>> +# -*- Mode: Python -*-
>> +
>> +##
>> +# == QAPI 9p definitions
>> +##
>> +
>> +# QAPI common definitions
>> +{ 'include': 'common.json' }
>> +
>> +##
>> +# @fs9p_set_io_throttle:
>> +#
>> +# Change I/O limits for a 9p/fsdev device.
>> +#
>> +# Since QEMU 2.9, I/0 limits can be enabled on each  fsdev(9pfs) device
>
> Is this supposed to be generic for any fsdev impl, or specific to the
> 9p impl only ? Without knowing more, I'd expect us to really be designing
> something generic, and not tied to just the 9p impl. IOW,  having '9p' in
> the name of the QAPI commands feels wrong - use of 'fsdev' feels like the
> better naming. Same applies to the HMP commands.
Yes its for the fsdev. But other than 9p when the fsdev is used?
I will rename 9p to fsdev.

Regards,
Pradeep
>
>
> Regards,
> Daniel
>

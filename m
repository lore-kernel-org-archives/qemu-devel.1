Received: from eggs.gnu.org ([2001:4830:134:3::10]:48839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ebqkr-0004A9-Cc
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:40:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ebqkq-0003Fo-FZ
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:40:01 -0500
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<20171207155102.66622-4-vsementsov@virtuozzo.com>
	<74fa9031-25d8-df0f-0690-c03ff377c0d9@redhat.com>
	<7f7c46fe-c6e1-a597-c6d1-5212abc12212@virtuozzo.com>
	<d338d282-f264-3d39-2240-0cd5dbf0294e@redhat.com>
	<4e97de9a-bcdd-5e5d-275f-e6cac9473f0d@virtuozzo.com>
	<79e5851b-f35e-23ea-4842-cc3b1d1e30ee@virtuozzo.com>
	<1e2fd96e-5d07-3c52-33df-cf31490eb6ca@redhat.com>
	<eccba06f-3a5f-7926-7fb5-ce56f01e94c7@virtuozzo.com>
	<1298bc3d-c2bd-6fd5-5d3d-dabcae434874@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2e145d8b-855f-9060-1b81-feb515067293@virtuozzo.com>
Date: Wed, 17 Jan 2018 19:39:45 +0300
MIME-Version: 1.0
In-Reply-To: <1298bc3d-c2bd-6fd5-5d3d-dabcae434874@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 3/6] qapi: add nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>

17.01.2018 19:03, Eric Blake wrote:
> On 01/17/2018 09:51 AM, Vladimir Sementsov-Ogievskiy wrote:
>
>>>> I have a script (for managing libvirt guest, but it can be adopted for
>>>> qemu or even used for qemu monitor), which allows
>>>> me run qmp commands on vms as easy as:
>>>>
>>>> |qmp VMNAME query-block-jobs or qmp VMNAME nbd-server-remove name exp1
>>>> mode hard or even |
>>>>
>>>> |qmp VMNAME blockdev-add id disk driver qcow2 cache {writeback true
>>>> direct true} aio native discard unmap file {driver file filename
>>>> /tmp/somedisk} |||
>>> Yeah, there are various scripting solutions around QMP that can make it
>>> easier; but HMP is often still an easy front-line interface for
>>> experiments.
>>>
>> isn't it because these solutions are not available directly in monitor,
>> when HMP is?
> QMP can be directly accessed in a monitor; it just requires more typing.
>   If you are developing QMP commands, it may be easier to use
> ./scripts/qmp/qmp-shell (couple it with a readline wrapper, and you can
> even get tab-completion and history across sessions).  There's also
> things like libvirt's 'virsh qmp-monitor-command' for shell-scripting
> access to arbitrary QMP commands, provided your guest is run by libvirt.
>
>> may be, we need third type of monitor HQMP which is QMP with simplified
>> syntax? Or
>> allow qmp commands in simplified syntax directly in HMP?
> No, I don't think we need either thing.  Wrappers around existing
> monitors is better than bloating qemu proper with a third flavor of
> monitor.  And HMP is for humans, with no restrictions on back-compat
> changes, so if it doesn't do something you want for quick-and-dirty
> testing, you can either add a new HMP command, or just use QMP (or one
> of its wrappers, like qmp-shell) in the first place.  Ultimately, our
> long-term concern is only about the QMP interface; HMP is supposed to be
> convenient.  So if it starts costing too much time to port a QMP
> interface to HMP, then don't worry about it.
>

most of commands, ported to hmp are done in same style: they just call 
corresponding qmp command.
Isn't it better to provide common interface for calling qmp commands 
through HMP monitor, to never
create hmp versions of new commands? they will be available automatically.

-- 
Best regards,
Vladimir

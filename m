Received: from eggs.gnu.org ([2001:4830:134:3::10]:57189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsyRH-00050O-PW
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 17:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dsyRG-0006et-TD
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 17:46:19 -0400
References: <cover.1501827395.git.maozy.fnst@cn.fujitsu.com>
	<3702d1b07f96d8b6f51c14fc62a48f68a1646004.1501827395.git.maozy.fnst@cn.fujitsu.com>
	<3d9adc5b-0cc4-ed0a-521c-265d9e3e5cb4@redhat.com>
	<162e5e37-d90d-9f25-ed73-9a7e914324c0@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <73bfb1bd-a7f0-cf9a-eadb-a82f59471ced@redhat.com>
Date: Fri, 15 Sep 2017 17:46:09 -0400
MIME-Version: 1.0
In-Reply-To: <162e5e37-d90d-9f25-ed73-9a7e914324c0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/6] hw/ide: Convert DeviceClass init to
 realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>



On 09/15/2017 05:42 PM, Eric Blake wrote:
> On 09/15/2017 04:35 PM, John Snow wrote:
>>
>>
>> On 08/04/2017 06:26 AM, Mao Zhongyi wrote:
>>> Replace init with realize in IDEDeviceClass, which has errp
>>> as a parameter. So all the implementations now use error_setg
>>> instead of error_report for reporting error.
>>>
> 
>>> @@ -2398,7 +2399,7 @@ int ide_init_drive(IDEState *s, BlockBackend *blk, IDEDriveKind kind,
>>>                     const char *version, const char *serial, const char *model,
>>>                     uint64_t wwn,
>>>                     uint32_t cylinders, uint32_t heads, uint32_t secs,
>>> -                   int chs_trans)
>>> +                   int chs_trans, Error **errp)
>>
>> this function now requires an additional invariant, which is that we
>> must return -1 AND set errp. Probably wisest to just get rid of the
>> return code so that we don't accidentally goof this up in the future.
>>
>> I think Markus has had some guidance on this in the past, but admittedly
>> I can't remember his preference.
> 

[...]

> So these days, the preference is to KEEP the redundancy rather than
> eliminate it, due to ease-of-use concerns.
> 

OK, that's fine. I only want consistency with whatever the
paradigm-du-jour is for error handling. Thanks for the quick rebuttal.

--js

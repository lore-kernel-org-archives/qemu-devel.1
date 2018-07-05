Received: from eggs.gnu.org ([2001:4830:134:3::10]:37827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fb5Yx-0007PS-Qm
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fb5Yw-00022E-PM
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 10:48:51 -0400
References: <20180705092139.776069-1-vsementsov@virtuozzo.com>
	<20180705104622.GF3309@localhost.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <37451f0c-2ebc-8c06-2716-a6ead65e6e9c@virtuozzo.com>
Date: Thu, 5 Jul 2018 17:48:34 +0300
MIME-Version: 1.0
In-Reply-To: <20180705104622.GF3309@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3] qcow2: add overlap check for bitmap
 directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com, mreitz@redhat.com, den@openvz.org

05.07.2018 13:46, Kevin Wolf wrote:
> Am 05.07.2018 um 11:21 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> If it appropriate for 3.0, let's push it. If not - then for 3.1
>> with fixed "since". Should I cc stable?
>>
>> v3: - update Qcow2OverlapCheckFlags in qapi/block-core.json [Max]
>>
>> v2: - squash 02 (indentation fix) to 01
>>      - drop comment from qcow2_check_metadata_overlap()
>>      - set @ign to QCOW2_OL_BITMAP_DIRECTORY for in-place case in
>>        bitmap_list_store. I don't think non-inplace case should be changed,
>>        as it don't touch active bitmap directory.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   qapi/block-core.json   | 21 ++++++++++++---------
>>   block/qcow2.h          | 45 ++++++++++++++++++++++++---------------------
>>   block/qcow2-bitmap.c   |  7 ++++++-
>>   block/qcow2-refcount.c | 10 ++++++++++
>>   block/qcow2.c          | 22 ++++++++++++++--------
>>   5 files changed, 66 insertions(+), 39 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 90e554ed0f..e7393e0313 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2695,18 +2695,21 @@
>>   # @template: Specifies a template mode which can be adjusted using the other
>>   #            flags, defaults to 'cached'
>>   #
>> +# @bitmap-directory: since 3.0
>> +#
>>   # Since: 2.9
>>   ##
>>   { 'struct': 'Qcow2OverlapCheckFlags',
>> -  'data': { '*template':       'Qcow2OverlapCheckMode',
>> -            '*main-header':    'bool',
>> -            '*active-l1':      'bool',
>> -            '*active-l2':      'bool',
>> -            '*refcount-table': 'bool',
>> -            '*refcount-block': 'bool',
>> -            '*snapshot-table': 'bool',
>> -            '*inactive-l1':    'bool',
>> -            '*inactive-l2':    'bool' } }
>> +  'data': { '*template':        'Qcow2OverlapCheckMode',
>> +            '*main-header':     'bool',
>> +            '*active-l1':       'bool',
>> +            '*active-l2':       'bool',
>> +            '*refcount-table':  'bool',
>> +            '*refcount-block':  'bool',
>> +            '*snapshot-table':  'bool',
>> +            '*inactive-l1':     'bool',
>> +            '*inactive-l2':     'bool',
>> +            '*bitmap-directory': 'bool' } }
> Did you intend to add two spaces to each line? Because this still isn't
> aligned to the same column.
>
> Kevin

Aha, I forget to add '*', and added it late, after indentation.

-- 
Best regards,
Vladimir

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fPmor-0002Eq-3E
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fPmoq-0002Bn-BA
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:34:33 -0400
References: <20180426161958.2872-1-rkagan@virtuozzo.com>
	<20180426161958.2872-4-rkagan@virtuozzo.com>
	<87tvqjf28u.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3f5aaa32-5e43-542b-c657-3f1eec553e70@redhat.com>
Date: Mon, 4 Jun 2018 12:34:22 +0200
MIME-Version: 1.0
In-Reply-To: <87tvqjf28u.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/17] iotests: ask qemu for supported
 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 04.06.2018 09:18, Markus Armbruster wrote:
> Roman Kagan <rkagan@virtuozzo.com> writes:
> 
>> Add helper functions to query the block drivers actually supported by
>> QEMU using "-drive format=?".  This allows to skip certain tests that
>> require drivers not built in or whitelisted in QEMU.
>>
>> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
>> ---
>>  tests/qemu-iotests/common.rc  | 19 +++++++++++++++++++
>>  tests/qemu-iotests/iotests.py | 30 +++++++++++++++++++++++++++---
>>  2 files changed, 46 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
>> index 9a65a11026..fe5a4d1cfd 100644
>> --- a/tests/qemu-iotests/common.rc
>> +++ b/tests/qemu-iotests/common.rc
>> @@ -493,5 +493,24 @@ _require_command()
>>      [ -x "$c" ] || _notrun "$1 utility required, skipped this test"
>>  }
>>  
>> +# this test requires support for specific formats
>> +#
>> +_require_format()
>> +{
>> +    supported_formats=$($QEMU_PROG $QEMU_OPTIONS -drive format=\? 2>&1 | \
> 
> Use of '?' to get help is deprecated.  Please use 'format=help', and
> update your commit message accordingly.

Is it? Where did we document that?

 Thomas

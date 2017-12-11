Received: from eggs.gnu.org ([2001:4830:134:3::10]:48729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eORzH-0002sD-UP
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 12:35:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eORzH-0003Wi-3u
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 12:35:31 -0500
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-9-mreitz@redhat.com>
	<20171130031803.GL16237@lemon>
	<105361ec-21d2-e0dc-d480-ef3c9910dd12@redhat.com>
	<a514dad6-3d29-4a45-025e-ecd2f940747d@redhat.com>
	<d9365491-7cb8-2349-f068-35da000ea0bd@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4fa1b55d-5d01-e791-10c7-48acda2d71d5@redhat.com>
Date: Mon, 11 Dec 2017 12:35:22 -0500
MIME-Version: 1.0
In-Reply-To: <d9365491-7cb8-2349-f068-35da000ea0bd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/17] iotests: Skip 103 for refcount_bits=1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org



On 12/11/2017 12:17 PM, Max Reitz wrote:
> On 2017-12-09 02:36, John Snow wrote:
>>
>>
>> On 11/30/2017 08:23 AM, Max Reitz wrote:
>>> On 2017-11-30 04:18, Fam Zheng wrote:
>>>> On Thu, 11/23 03:08, Max Reitz wrote:
>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>> ---
>>>>>  tests/qemu-iotests/103 | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/tests/qemu-iotests/103 b/tests/qemu-iotests/103
>>>>> index ecbd8ebd71..d0cfab8844 100755
>>>>> --- a/tests/qemu-iotests/103
>>>>> +++ b/tests/qemu-iotests/103
>>>>> @@ -40,6 +40,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>>>>  _supported_fmt qcow2
>>>>>  _supported_proto file nfs
>>>>>  _supported_os Linux
>>>>> +# Internal snapshots are (currently) impossible with refcount_bits=1
>>>>> +_unsupported_imgopts 'refcount_bits=1[^0-9]'
>>>>
>>>> What is the "[^0-9]" part for?
>>>
>>> It's so you can specify refcount_bits=16, but not
>>> refcount_bits=1,compat=0.10 or just refcount_bits=1.
>>>
>>> Max
>>>
>>
>> Worth a comment?
> 
> There is a comment above it that says that refcount_bits=1 is the
> disallowed option. :-)
> 
> I could add a "(refcount_bits=16 is OK, though)" if that would have been
> enough for you (or any proposal of yours).
> 
> Max
> 

Not worth a re-spin.

The double negative of "unsupported" and "not 0-9" takes a hot second to
parse. Mentioning that you are looking to prohibit 1,[foo] specifically
helps.

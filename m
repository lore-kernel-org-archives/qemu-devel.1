Received: from eggs.gnu.org ([2001:4830:134:3::10]:44481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eM1ip-0007g6-G4
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 20:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eM1io-0005eT-Ly
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 20:08:31 -0500
References: <20171129224421.18192-1-jsnow@redhat.com>
	<20171201094538.GD23501@stefanha-x1.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <33772699-c3ba-1ec6-6e89-23bea645cd46@redhat.com>
Date: Mon, 4 Dec 2017 20:08:26 -0500
MIME-Version: 1.0
In-Reply-To: <20171201094538.GD23501@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] iotests: fix 197 for vpc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: kwolf@redhat.com, ldoktor@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com



On 12/01/2017 04:45 AM, Stefan Hajnoczi wrote:
> On Wed, Nov 29, 2017 at 05:44:21PM -0500, John Snow wrote:
>> VPC has some difficulty creating geometries of particular size.
>> However, we can indeed force it to use a literal one, so let's
>> do that for the sake of test 197, which is testing some specific
>> offsets.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  tests/qemu-iotests/197           | 3 +++
>>  tests/qemu-iotests/common.filter | 3 ++-
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/qemu-iotests/197 b/tests/qemu-iotests/197
>> index 887eb4f496..e1292689c1 100755
>> --- a/tests/qemu-iotests/197
>> +++ b/tests/qemu-iotests/197
>> @@ -60,6 +60,9 @@ echo '=== Copy-on-read ==='
>>  echo
>>  
>>  # Prep the images
>> +if [ "$IMGFMT" = "vpc" ]; then
>> +    IMGOPTS=$(_optstr_add "$IMGOPTS" "force_size")
>> +fi
> 
> It would be nice to include a comment in the code instead of the commit
> description so anyone reading knows why vpc is special-cased here.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 

OK, I re-spun it.
